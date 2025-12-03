\c :db

\ir ddl/index.sql


CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER registry_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'localhost', dbname 'registry', port '5432');

CREATE USER MAPPING FOR CURRENT_USER
    SERVER registry_server
    OPTIONS (user :'dbuser', password :'dbpass');

CREATE USER MAPPING FOR grafana_read
    SERVER registry_server
    OPTIONS (user :'dbuser', password :'dbpass');

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

GRANT USAGE ON SCHEMA public TO grafana_read;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO grafana_read;
