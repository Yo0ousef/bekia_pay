-- Serialize subscription changes per user and reject a second active/requested plan.
create or replace function public.enforce_one_current_subscription_per_user()
returns trigger
language plpgsql
security definer
set search_path = public, pg_temp
as $$
begin
  if new.status not in ('pending', 'active') then
    return new;
  end if;

  perform pg_advisory_xact_lock(hashtextextended(new.user_id::text, 0));

  if exists (
    select 1
    from public.user_subscriptions existing
    where existing.user_id = new.user_id
      and (
        existing.status = 'pending'
        or (existing.status = 'active' and existing.expires_at > now())
      )
      and existing.id is distinct from new.id
  ) then
    raise exception 'User already has a pending request or active subscription'
      using errcode = '23505';
  end if;

  return new;
end;
$$;

drop trigger if exists user_subscriptions_one_current_per_user
  on public.user_subscriptions;

create trigger user_subscriptions_one_current_per_user
before insert or update of user_id, status
on public.user_subscriptions
for each row
execute function public.enforce_one_current_subscription_per_user();
