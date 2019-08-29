select * from accounts
         join entries on accounts.id = entries.account_id
         join transactions on entries.transaction_id = transactions.id
        limit 1;
