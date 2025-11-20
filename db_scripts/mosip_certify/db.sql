
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.
-- -------------------------------------------------------------------------------------------------

DO $$
DECLARE
    dbname text := quote_literal(:'db')::text;
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_database WHERE datname = dbname
    ) THEN
        EXECUTE format('CREATE DATABASE %I', dbname);
    END IF;
END$$;

\c :db

CREATE SCHEMA IF NOT EXISTS certify;


ALTER DATABASE :db SET search_path TO certify,pg_catalog,public;
