create or replace type shard_helper_result_t force is object (
    instance_name varchar2(512),
    result_code   varchar2(32),
    description   varchar2(4096)
  );
/

create or replace type shard_helper_result_list_t is table of shard_helper_result_t;
/

create or replace package shard_helper_remote authid current_user
as

function execute_sql(link in varchar2, sqltext in varchar2) return integer;

function execute_at(dbs dbms_global_views.dblinklist_t, sqltext in varchar2)
    return shard_helper_result_list_t
        pipelined parallel_enable(partition dbs by hash(name));

function execute_at_shards(sqltext in varchar2, primaries_only integer default 0)
    return shard_helper_result_list_t;

end;
/
show errors;

create or replace package body shard_helper_remote
as

function execute_sql(link in varchar2, sqltext in varchar2) return integer
as
  ret     integer;
begin
  execute immediate
    'declare handle integer; result integer;' ||
    'begin ' ||
    '  handle := dbms_sql.open_cursor@' || link || ';' ||
    '  dbms_sql.parse@' || link || '(handle, :1, dbms_sql.native);' ||
    '  :2 := dbms_sql.execute@' || link || '(handle); ' ||
    '  dbms_sql.close_cursor@' || link || '(handle);' ||
    'end;'
      using sqltext, out ret;

  return ret;
end;

function execute_at(dbs dbms_global_views.dblinklist_t, sqltext in varchar2)
    return shard_helper_result_list_t
        pipelined parallel_enable(partition dbs by hash(name))
is
  db  dbms_global_views.dblink_t;
  val integer;
begin
  loop fetch dbs into db;
    exit when dbs%notfound;

    begin
      val := execute_sql(db.dbln, sqltext);
      pipe row(shard_helper_result_t(db.name, to_char(val), ''));
    exception
      when others then
        pipe row(shard_helper_result_t(db.name, sqlcode, sqlerrm));
    end;
  end loop;
  return;
end;

function execute_at_shards(sqltext in varchar2, primaries_only integer default 0)
    return shard_helper_result_list_t
is
  result shard_helper_result_list_t := shard_helper_result_list_t();
begin
  for i in (select * from sys.shard_helper_remote.execute_at(
    cursor(select /*+ parallel(t, 10) */ database_name, dblink_name from shard_dblink_list t
        where primaries_only = 0 or is_primary = 1), sqltext))
  loop

    result.extend;
    result(result.count) := shard_helper_result_t(i.instance_name, i.result_code, i.description);
  end loop;

  return result;
end;

end;
/
show errors;
