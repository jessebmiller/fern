---toml
purpose = "action"
---

begin;

with
  tx as (insert into transactions default values returning id),
  dt as (
     select
         :entry_type::entry_type as entry_type,
         :account_name as account_name,
         :balance_category::balance_category as balance_category,
         :amount_usd as amount_usd
         ),
  ac as (
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
-- TODO: add that as a check constraint on the tables

commit;
