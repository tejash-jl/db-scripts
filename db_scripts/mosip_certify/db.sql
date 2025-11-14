
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.
-- -------------------------------------------------------------------------------------------------
create database :db;
\c :db

CREATE SCHEMA IF NOT EXISTS certify;


ALTER DATABASE :db SET search_path TO certify,pg_catalog,public;

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER registry_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'localhost', dbname 'registry', port '5432');

CREATE USER MAPPING FOR CURRENT_USER
    SERVER registry_server
    OPTIONS (user 'postgres', password :'dbpass');

CREATE USER MAPPING FOR grafana_read
    SERVER registry_server
    OPTIONS (user 'postgres', password :'dbpass');

CREATE FOREIGN TABLE verification_counters (
    id          integer NOT NULL,
    created_at  timestamptz,
    updated_at  timestamptz,
    deleted_at  timestamptz,
    type        text,
    status      text,
    date        timestamptz
)
SERVER registry_server
OPTIONS (schema_name 'public', table_name 'verification_counters');


GRANT USAGE ON SCHEMA certify TO grafana_read;
GRANT SELECT ON ALL TABLES IN SCHEMA certify TO grafana_read;
