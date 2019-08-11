begin;


with tx as (insert into transactions default values returning id
  ), dt as (
  -- TODO: make this part parameterized!
  select
    'credit'::entry_type as entry_type, 'cash' as account_name, 'asset'::balance_category as balance_category, 200 as amount_usd
    union all select
    'debit'::entry_type as entry_type, 'loan' as account_name, 'liability'::balance_category as balance_category, 100 as amount_usd
    union all select
    'debit'::entry_type as entry_type, 'capital' as account_name, 'equity'::balance_category as balance_category, 100 as amount_usd
  ), ac as (
  insert into accounts
  (name, balance_category)
  select distinct account_name, balance_category from dt
  on conflict
  do nothing
  )
insert into entries (type, amount_usd, transaction_id, account_id)
select dt.entry_type
     , dt.amount_usd
     , (select id from tx) as transaction_id
     , accounts.id as account_id
  from dt join accounts on dt.account_name = accounts.name;

-- TODO: check for equality of credits and debits

commit;
