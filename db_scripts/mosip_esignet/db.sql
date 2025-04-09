
\c postgres psqladmin

CREATE SCHEMA esignet;

ALTER DATABASE postgres SET search_path TO esignet,pg_catalog,public;
