-- Clients submit only product IDs and quantities. The database locks products,
-- derives prices from final_price_points, and updates stock and points atomically.
create or replace function public.create_order(p_items jsonb)
returns uuid
language plpgsql
security definer
set search_path = ''
as $function$
declare
  v_order_id uuid;
  v_total_points bigint := 0;
  v_item jsonb;
  v_priced_item jsonb;
  v_priced_items jsonb := '[]'::jsonb;
  v_product_id uuid;
  v_quantity integer;
  v_quantity_numeric numeric;
  v_available integer;
  v_unit_points integer;
  v_in_stock boolean;
  v_user_id uuid := auth.uid();
  v_user_points integer;
begin
  if v_user_id is null then
    raise exception 'not authenticated';
  end if;

  if p_items is null or jsonb_typeof(p_items) <> 'array' then
    raise exception 'items must be a JSON array';
  end if;
  if jsonb_array_length(p_items) = 0 then
    raise exception 'order must contain at least one item';
  end if;

  -- Serialize orders for one user so simultaneous checkouts cannot overspend.
  select profile.points_balance
    into v_user_points
  from public.profiles as profile
  where profile.id = v_user_id
  for update;

  if not found or v_user_points is null then
    raise exception 'user profile not found';
  end if;

  -- Lock products in a stable order. Prices and stock come only from the DB.
  for v_item in
    select input.value
    from jsonb_array_elements(p_items) with ordinality as input(value, ordinal)
    order by input.value->>'product_id', input.ordinal
  loop
    if jsonb_typeof(v_item) <> 'object' then
      raise exception 'each item must be a JSON object';
    end if;

    if coalesce(v_item->>'product_id', '') = '' then
      raise exception 'product_id is required';
    end if;
    if jsonb_typeof(v_item->'quantity') is distinct from 'number' then
      raise exception 'quantity must be a positive whole number';
    end if;

    v_product_id := (v_item->>'product_id')::uuid;
    v_quantity_numeric := (v_item->>'quantity')::numeric;
    if v_quantity_numeric < 1
      or v_quantity_numeric > 2147483647
      or v_quantity_numeric <> trunc(v_quantity_numeric) then
      raise exception 'quantity must be a positive whole number';
    end if;
    v_quantity := v_quantity_numeric::integer;

    select
      product.quantity_available,
      product.final_price_points::integer,
      product.in_stock
    into v_available, v_unit_points, v_in_stock
    from public.products as product
    where product.id = v_product_id
    for update;

    if not found then
      raise exception 'product not found: %', v_product_id;
    end if;
    if v_available is null or v_available < v_quantity then
      raise exception 'insufficient stock for product %', v_product_id;
    end if;
    if v_in_stock is distinct from true then
      raise exception 'product is not available: %', v_product_id;
    end if;
    if v_unit_points is null or v_unit_points < 0 then
      raise exception 'product has an invalid price: %', v_product_id;
    end if;

    update public.products
    set quantity_available = quantity_available - v_quantity
    where id = v_product_id;

    v_total_points := v_total_points + (v_quantity::bigint * v_unit_points);
    if v_total_points > 2147483647 then
      raise exception 'order total exceeds the supported points limit';
    end if;

    v_priced_items := v_priced_items || jsonb_build_array(
      jsonb_build_object(
        'product_id', v_product_id,
        'quantity', v_quantity,
        'points_each', v_unit_points
      )
    );
  end loop;

  if v_user_points < v_total_points then
    raise exception 'insufficient points: have %, need %',
      v_user_points, v_total_points;
  end if;

  insert into public.orders (user_id, total_points, status)
  values (v_user_id, v_total_points::integer, 'confirmed')
  returning id into v_order_id;

  for v_priced_item in
    select priced.value
    from jsonb_array_elements(v_priced_items) as priced(value)
  loop
    insert into public.order_items (
      order_id,
      product_id,
      quantity,
      points_each
    )
    values (
      v_order_id,
      (v_priced_item->>'product_id')::uuid,
      (v_priced_item->>'quantity')::integer,
      (v_priced_item->>'points_each')::integer
    );
  end loop;

  update public.profiles
  set points_balance = points_balance - v_total_points::integer
  where id = v_user_id;

  return v_order_id;
end;
$function$;

alter function public.create_order(jsonb) owner to postgres;
revoke all on function public.create_order(jsonb) from public, anon;
grant execute on function public.create_order(jsonb) to authenticated;

-- The RPC is now the only client path that can create an order; it computes
-- total_points and order item prices from trusted product rows.
drop policy if exists "Users can insert orders" on public.orders;
