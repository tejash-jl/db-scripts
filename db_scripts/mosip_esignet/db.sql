
\c :db

CREATE SCHEMA esignet;

ALTER DATABASE :db SET search_path TO esignet,pg_catalog,public;
