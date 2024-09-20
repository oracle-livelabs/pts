alter session enable shard ddl;

create user app_schema identified by app_schema;
grant connect, resource, alter session to app_schema;

-- For demo app purposes
grant execute on sys.dbms_crypto to app_schema;

-- Bug Workaround. Normally, app_schema user does not need that.
grant create view, create database link,
    alter database link, create materialized view, create tablespace to app_schema;

grant unlimited tablespace to app_schema;
-- End Workaround

alter session disable shard ddl;
