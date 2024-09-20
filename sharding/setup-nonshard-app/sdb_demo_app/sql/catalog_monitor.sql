alter session enable shard ddl;

create role shard_monitor_role;

grant connect,
      alter session,
      select any dictionary,
      analyze any,
      select any table
    to shard_monitor_role;

grant select on gv_$session       to shard_monitor_role;
grant select on gv_$database      to shard_monitor_role;
grant select on gv_$servicemetric to shard_monitor_role;

alter session disable shard ddl;

@global_views.header.sql
/
show errors

@global_views.sql
/
show errors

exec dbms_global_views.install;

@shard_helpers.sql
/
show errors

grant execute on sys.dbms_global_views   to shard_monitor_role;
grant execute on sys.shard_helper_remote to shard_monitor_role;
grant gsmadmin_role to shard_monitor_role;

exec dbms_global_views.create_gv('session');
exec dbms_global_views.create_gv('database');
exec dbms_global_views.create_gv('servicemetric');
exec dbms_global_views.create_any_view('LOCAL_CHUNKS', 'LOCAL_CHUNKS', 'GLOBAL_CHUNKS');
-- exec dbms_global_views.create_dba_view('DBA_TAB_PARTITIONS');

