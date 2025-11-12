-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.
-- -------------------------------------------------------------------------------------------------
create database :db;
\c :db

CREATE SCHEMA IF NOT EXISTS certify;

GRANT USAGE ON SCHEMA certify TO grafana_read;
GRANT SELECT ON ALL TABLES IN SCHEMA certify TO grafana_read;

ALTER DATABASE :db SET search_path TO certify,pg_catalog,public;

