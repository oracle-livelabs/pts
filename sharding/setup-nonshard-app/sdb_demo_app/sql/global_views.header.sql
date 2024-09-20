create or replace package dbms_global_views is
  type dblink_t is record (
    name varchar2(32),
    dbln varchar2(32)
  );

  type dblinklist_t is ref cursor return dblink_t;

  procedure install;
  procedure create_all_database_links;
  procedure create_gv(gvn in varchar2);
  procedure create_dba_view(view_name in varchar2);

  procedure create_any_view(name in varchar2,
    remote_name in varchar2,
    new_name in varchar2,
    debug_flag in integer default 0,
    for_primary in integer default 0);

  procedure grant_view(new_name in varchar2, user_name in varchar2);
end dbms_global_views;
