-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-08-17 14:21:48.49

-- tables
-- Table: content
CREATE EXTENSION "uuid-ossp";;

CREATE TABLE content (
    id uuid  NOT NULL DEFAULT uuid_generate_v1mc(),
    parent varchar(256)  NOT NULL,
    stem varchar(32)  NOT NULL,
    suffix varchar(16)  NOT NULL,
    CONSTRAINT content_pk PRIMARY KEY (id)
);

-- Table: content_metadata
CREATE TABLE content_metadata (
    content_id uuid  NOT NULL,
    metadata_id uuid  NOT NULL,
    CONSTRAINT content_metadata_pk PRIMARY KEY (content_id,metadata_id)
);

-- Table: metadata
CREATE EXTENSION "uuid-ossp";;

CREATE TABLE metadata (
    id uuid  NOT NULL DEFAULT uuid_generate_v1mc(),
    key varchar(256)  NOT NULL,
    value varchar(256)  NOT NULL,
    CONSTRAINT metadata_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: content_metadata_content (table: content_metadata)
ALTER TABLE content_metadata ADD CONSTRAINT content_metadata_content
    FOREIGN KEY (content_id)
    REFERENCES content (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: content_metadata_metadata (table: content_metadata)
ALTER TABLE content_metadata ADD CONSTRAINT content_metadata_metadata
    FOREIGN KEY (metadata_id)
    REFERENCES metadata (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

