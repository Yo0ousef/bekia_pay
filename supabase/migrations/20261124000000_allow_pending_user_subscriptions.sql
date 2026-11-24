-- Cash-on-delivery subscriptions stay pending until payment is collected.
-- Preserve the statuses already accepted by the existing check constraint.
do $$
declare
  existing_check text;
begin
  select pg_get_expr(conbin, conrelid)
    into existing_check
  from pg_constraint
  where conrelid = 'public.user_subscriptions'::regclass
    and conname = 'user_subscriptions_status_check'
    and contype = 'c';

  if existing_check is null then
    raise exception 'Could not find check constraint user_subscriptions_status_check';
  end if;

  if position('pending' in lower(existing_check)) > 0 then
    return;
  end if;

  alter table public.user_subscriptions
    drop constraint user_subscriptions_status_check;

  execute format(
    'alter table public.user_subscriptions add constraint user_subscriptions_status_check check ((%s) or status = %L)',
    existing_check,
    'pending'
  );
end
$$;
