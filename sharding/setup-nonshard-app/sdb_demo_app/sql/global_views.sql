create or replace package body dbms_global_views as

procedure exec_wrapper(sqltext in varchar2) as
begin
  dbms_output.put_line(sqltext);
  execute immediate sqltext;
end exec_wrapper;

procedure silent_exec(sqltext in varchar2) as
begin
  begin
    exec_wrapper(sqltext);
  exception
    when others then null;
  end;
end silent_exec;

procedure install as
begin
  exec_wrapper('begin dbms_global_views.create_all_database_links; end;');

  exec_wrapper('create or replace trigger shard_dblink_update ' ||
    ' after insert on gsmadmin_internal.database ' ||
    ' begin dbms_global_views.create_all_database_links; end;');

  exec_wrapper('create or replace view shard_dblink_list as ' ||
   ' select name as database_name, name || ''.sgv_link'' as dblink_name, ' ||
   ' BITAND(flags, 2) / 2 as is_primary from gsmadmin_internal.database where BITAND(flags, 1) = 1');

  exec_wrapper('create or replace public synonym shard_dblink_list for shard_dblink_list');
  exec_wrapper('grant read on shard_dblink_list to public with grant option');
end;

procedure create_all_database_links
as
  cursor db_t is select name, connect_string from gsmadmin_internal.database;
begin
  for rec in db_t loop
    silent_exec('create public database link ' || rec.name || '.sgv_link' ||
        ' using ''' || rec.connect_string || '''');
  end loop;
end;

procedure create_gv(gvn in varchar2) as
begin
  create_any_view('GV_$' || upper(gvn), 'GV$' || upper(gvn), 'SGV$' || upper(gvn));
end create_gv;

procedure create_dba_view(view_name in varchar2) as
begin
  create_any_view(upper(view_name), upper(view_name), 'GLOBAL_' || upper(view_name));
end create_dba_view;

procedure create_any_view(name in varchar2, remote_name in varchar2, new_name in varchar2,
    debug_flag in integer default 0, for_primary in integer default 0)
as
  def     varchar2(4096);
  selname varchar2(4096);
  constr_list varchar2(4096);
  column_list varchar2(4096);
  select_list varchar2(4096);
  debug_def   varchar2(4096);
  dbsel_def   varchar2(4096);

  cursor dsc is select column_name, data_type, column_id, data_length
    from all_tab_columns where table_name = upper(name) order by column_id;
begin
  column_list := 'public_dbname varchar(64), executor_sid number, reporting_instance varchar(128), error_code varchar(32) ';
  constr_list := 'sgv_' || new_name || '_row(db.name, sid, NULL, 0';
  select_list := 'public_dbname';

  for x in dsc loop
    if x.data_type = 'LONG' then
      def := x.column_name || ' VARCHAR(4000)';
    elsif x.data_type = 'BLOB' then
      def := x.column_name || ' RAW(2000)';
    else
      def := x.column_name || ' ' || x.data_type;
    end if;

    if x.data_type = 'VARCHAR2' or x.data_type = 'RAW' then
      def := def || '(' || to_char(x.data_length) || ')';
    end if;

    column_list := column_list || ', '    || def;
    constr_list := constr_list || ', rv.' || x.column_name;
    select_list := select_list || ', '    || x.column_name;
  end loop;

  constr_list := constr_list || ')';
  select_list := select_list || ', executor_sid, reporting_instance, error_code';

  silent_exec('drop function sgv_' || new_name || '_get');
  silent_exec('drop type sgv_' || new_name || '_tab force');
  silent_exec('drop type sgv_' || new_name || '_row force');

  if debug_flag = 0 then
    debug_def := '    exception when others then null;';
  else
    debug_def := '';
  end if;

  exec_wrapper('create or replace type sgv_' || new_name || '_row as object (' || column_list || ')');
  exec_wrapper('create or replace type sgv_' || new_name || '_tab is table of sgv_' || new_name || '_row');
  exec_wrapper(
'create or replace function sgv_' || new_name || '_get(dbs dbms_global_views.dblinklist_t) ' ||
'  return sgv_' || new_name || '_tab ' ||
'    pipelined parallel_enable(partition dbs by hash(name)) authid CURRENT_USER ' ||
'as type view_cursor is ref cursor; vc view_cursor;' ||
'  sid number; db dbms_global_views.dblink_t;' ||
'  rv ' || remote_name || '%rowtype;' ||
'  x sgv_' || new_name || '_row;' ||
'begin loop fetch dbs into db; exit when dbs%notfound;' ||
'    select sys_context(''USERENV'',''SID'') into sid from dual;' ||
'    begin ' ||
'      open vc for ''select * from ' || remote_name || '@'' || db.dbln;' ||
'      loop fetch vc into rv; exit when vc%notfound;' ||
'        pipe row (' || constr_list || ');' ||
'      end loop; close vc;' || debug_def ||
'    end;' ||
'  end loop; return;' ||
'end;');

  dbsel_def := 'select /*+ parallel(t, 10) */ database_name, dblink_name from shard_dblink_list t';

  if for_primary = 1 then
    dbsel_def := dbsel_def || ' where is_primary = 1';
  end if;

  exec_wrapper('create or replace view ' || new_name || ' bequeath CURRENT_USER as ' ||
    ' select ' || select_list || ' from table(sys.sgv_' || new_name || '_get(cursor(' ||
      dbsel_def || ')))');

  exec_wrapper('create or replace public synonym ' || new_name || ' for ' || new_name || '');
  grant_view(new_name, 'shard_monitor_role');
end create_any_view;

procedure grant_view(new_name in varchar2, user_name in varchar2) as
begin
  exec_wrapper('grant execute on sys.sgv_' || new_name || '_get to ' || user_name);
  exec_wrapper('grant select on ' || new_name || ' to ' || user_name);
end grant_view;

end dbms_global_views;
