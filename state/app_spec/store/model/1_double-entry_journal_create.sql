-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-08-10 23:19:06.965

-- tables
-- Table: accounts
create type balance_category as enum ('asset', 'liability', 'equity');;

CREATE TABLE accounts (
    id int  NOT NULL,
    name varchar(256)  NOT NULL,
    balance_category balance_category  NOT NULL,
    CONSTRAINT accounts_pk PRIMARY KEY (id)
);

-- Table: entries
create type entry_type as enum ('credit', 'debit');;

CREATE TABLE entries (
    id int  NOT NULL,
    type entry_type  NOT NULL,
    amount_usd money  NOT NULL,
    transaction_id int  NOT NULL,
    account_id int  NOT NULL,
    CONSTRAINT entries_pk PRIMARY KEY (id)
);

-- Table: transactions
CREATE TABLE transactions (
    id int  NOT NULL,
    conducted_at timestamp  NOT NULL,
    CONSTRAINT transactions_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: entries_accounts (table: entries)
ALTER TABLE entries ADD CONSTRAINT entries_accounts
    FOREIGN KEY (account_id)
    REFERENCES accounts (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: entries_transactions (table: entries)
ALTER TABLE entries ADD CONSTRAINT entries_transactions
    FOREIGN KEY (transaction_id)
    REFERENCES transactions (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- End of file.

