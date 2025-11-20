
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.
-- -------------------------------------------------------------------------------------------------

SELECT format('CREATE DATABASE %I', :'db')
WHERE NOT EXISTS (
    SELECT FROM pg_database WHERE datname = :'db'
)\gexec


\c :db

CREATE SCHEMA IF NOT EXISTS certify;


ALTER DATABASE :db SET search_path TO certify,pg_catalog,public;
