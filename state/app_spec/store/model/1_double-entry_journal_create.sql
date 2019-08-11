CREATE EXTENSION "uuid-ossp";

begin;

-- tables
-- Table: accounts
create type balance_category as enum ('asset', 'liability', 'equity');;

CREATE TABLE accounts (
    id uuid  NOT NULL DEFAULT uuid_generate_v1mc(),
    name varchar(256) NOT NULL UNIQUE,
    balance_category balance_category  NOT NULL,
    CONSTRAINT accounts_pk PRIMARY KEY (id)
);

-- Table: entries
create type entry_type as enum ('credit', 'debit');;

CREATE TABLE entries (
    id uuid  NOT NULL DEFAULT uuid_generate_v1mc(),
    type entry_type NOT NULL,
    amount_usd money NOT NULL,
    transaction_id uuid NOT NULL,
    account_id uuid NOT NULL,
    CONSTRAINT entries_pk PRIMARY KEY (id)
);

-- Table: transactions
CREATE TABLE transactions (
    id uuid  NOT NULL DEFAULT uuid_generate_v1mc(),
    conducted_at timestamp NOT NULL default now(),
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

commit;
