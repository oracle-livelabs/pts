--------------------------------------------------------------------------------
-- Name: Vector Apex
-- Copyright (c) 2012, 2024 Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0
-- as shown at https://oss.oracle.com/licenses/upl/
--------------------------------------------------------------------------------
prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>9839696891078804
,p_default_application_id=>100
,p_default_id_offset=>10039937054097162
,p_default_owner=>'VECTOR'
);
end;
/
 
prompt APPLICATION 100 - Vector Apex
--
-- Application Export:
--   Application:     100
--   Name:            Vector Apex
--   Date and Time:   16:55 Monday July 29, 2024
--   Exported By:     VECTOR
--   Flashback:       0
--   Export Type:     Application Export
--     Pages:                     13
--       Items:                   39
--       Computations:             2
--       Validations:              2
--       Processes:               19
--       Regions:                 39
--       Buttons:                 21
--       Dynamic Actions:         20
--     Shared Components:
--       Logic:
--         Items:                  2
--         Processes:              2
--         Computations:           1
--       Navigation:
--         Lists:                  3
--         Breadcrumbs:            1
--           Entries:              8
--         NavBar Entries:         2
--       Security:
--         Authentication:         1
--       User Interface:
--         Themes:                 1
--         Templates:
--           Page:                10
--           Region:              22
--           Label:                7
--           List:                13
--           Popup LOV:            1
--           Calendar:             1
--           Breadcrumb:           1
--           Button:               3
--           Report:              12
--         LOVs:                   2
--         Shortcuts:              1
--         Plug-ins:               2
--       PWA:
--       Globalization:
--         Messages:               6
--       Reports:
--       E-Mail:
--     Supporting Objects:  Included
--       Install scripts:          5
--   Version:         24.1.0
--   Instance ID:     7439640259801186
--

prompt --application/delete_application
begin
wwv_flow_imp.remove_flow(wwv_flow.g_flow_id);
end;
/
prompt --application/create_application
begin
wwv_imp_workspace.create_flow(
 p_id=>wwv_flow.g_flow_id
,p_owner=>nvl(wwv_flow_application_install.get_schema,'VECTOR')
,p_name=>nvl(wwv_flow_application_install.get_application_name,'Vector Apex')
,p_alias=>nvl(wwv_flow_application_install.get_application_alias,'VECTOR-APPLICATION-UPLOAD-DOWNLOAD')
,p_application_group=>wwv_flow_imp.id(34255426356874145)
,p_application_group_name=>'Sample Apps'
,p_page_view_logging=>'YES'
,p_page_protection_enabled_y_n=>'N'
,p_checksum_salt=>'2EDFCEEF97914693074AD68ACB4B68B5F970399F2364CD39442C1110FE5064FD'
,p_checksum_salt_last_reset=>'20230511181235'
,p_bookmark_checksum_function=>'SH512'
,p_compatibility_mode=>'21.2'
,p_accessible_read_only=>'N'
,p_flow_language=>'en'
,p_flow_language_derived_from=>'FLOW_PRIMARY_LANGUAGE'
,p_direction_right_to_left=>'N'
,p_flow_image_prefix => nvl(wwv_flow_application_install.get_image_prefix,'')
,p_documentation_banner=>wwv_flow_string.join(wwv_flow_t_varchar2(
'1.0.5 -> 1.0.6: Added "SQL Source" show/hide regions to all pages.',
'1.0.6 -> 1.0.7: Changed Authentication scheme to use new "ORA_WWV_PACKAGED_APPLICATIONS" cookie'))
,p_authentication_id=>wwv_flow_imp.id(14835041091875770271)
,p_application_tab_set=>1
,p_logo_type=>'T'
,p_logo_text=>'RAG Application Using APEX And Oracle AI Vector Search On ADB'
,p_public_user=>'APEX_PUBLIC_USER'
,p_proxy_server=>nvl(wwv_flow_application_install.get_proxy,'')
,p_no_proxy_domains=>nvl(wwv_flow_application_install.get_no_proxy_domains,'')
,p_flow_version=>'23.2.0'
,p_flow_status=>'AVAILABLE_W_EDIT_LINK'
,p_flow_unavailable_text=>'This application is currently unavailable at this time.'
,p_exact_substitutions_only=>'Y'
,p_browser_cache=>'N'
,p_browser_frame=>'S'
,p_deep_linking=>'Y'
,p_runtime_api_usage=>'T'
,p_pass_ecid=>'N'
,p_authorize_public_pages_yn=>'Y'
,p_rejoin_existing_sessions=>'P'
,p_csv_encoding=>'Y'
,p_tokenize_row_search=>'N'
,p_substitution_string_01=>'APP_NAME'
,p_substitution_value_01=>'RAG APPLICATION USING APEX AND ORACLE AI VECTOR SEARCH ON ADB'
,p_substitution_string_02=>'GETTING_STARTED_URL'
,p_substitution_value_02=>'#'
,p_substitution_string_03=>'G_OCI_BASE_URL'
,p_substitution_value_03=>'https://objectstorage.us-phoenix-1.oraclecloud.com/p/6JrpVOcoG8OXJ-k7Ypv4jJsJrDz3JP-1IYGqMYwvj6HkwWLoBpLjQCUzw06mjh1-/n/oraclepartnersas/b/apex_file_storage'
,p_substitution_string_04=>'G_OCI_DEFAULT_BUCKET'
,p_substitution_value_04=>'vector'
,p_substitution_string_05=>'G_OCI_CREDENTIALS'
,p_substitution_value_05=>'OCI_API_ACCESS'
,p_substitution_string_06=>'BUCKET_PAR'
,p_substitution_value_06=>'https://oraclepartnersas.objectstorage.ap-tokyo-1.oci.customer-oci.com/p/0GQ7KXrQ0HPJTpK7Vjtb7ra8oB_RQhmuJ3htdtOzlrK3oJWg7nRqtgNKK8Wi8Sm5/n/oraclepartnersas/b/apex-file-storage/o/'
,p_file_prefix => nvl(wwv_flow_application_install.get_static_app_file_prefix,'')
,p_files_version=>4
,p_print_server_type=>'INSTANCE'
,p_file_storage=>'DB'
,p_is_pwa=>'N'
,p_copyright_banner=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Name: #APP_NAME#',
'Copyright (c) 2012, #YEAR# Oracle and/or its affiliates.',
'Licensed under the Universal Permissive License v 1.0',
'as shown at https://oss.oracle.com/licenses/upl/'))
);
end;
/
prompt --application/user_interfaces
begin
wwv_flow_imp_shared.create_user_interface(
 p_id=>wwv_flow_imp.id(100)
,p_theme_id=>42
,p_home_url=>'f?p=&APP_ID.:3:&SESSION.'
,p_theme_style_by_user_pref=>false
,p_global_page_id=>0
,p_navigation_list_id=>wwv_flow_imp.id(1949530650298267740)
,p_navigation_list_position=>'SIDE'
,p_navigation_list_template_id=>wwv_flow_imp.id(1949422988307220490)
,p_nav_list_template_options=>'#DEFAULT#:js-defaultCollapsed:js-navCollapsed--hidden:t-TreeNav--styleA'
,p_css_file_urls=>'#IMAGE_PREFIX#pkgapp_ui/css/5.0#MIN#.css'
,p_nav_bar_type=>'LIST'
,p_nav_bar_list_id=>wwv_flow_imp.id(1950399639192762161)
,p_nav_bar_list_template_id=>wwv_flow_imp.id(1949422808189220487)
);
end;
/
prompt --workspace/credentials/apex_oci_storage_credential
begin
wwv_imp_workspace.create_credential(
 p_id=>wwv_flow_imp.id(25515921778560906)
,p_name=>'APEX OCI STORAGE CREDENTIAL'
,p_static_id=>'APEX_OCI_STORAGE_CREDENTIAL'
,p_authentication_type=>'OCI'
,p_namespace=>'ocid1.tenancy.oc1..aaaaaaaafj37mytx22oquorcznlfuh77cd45int7tt7fo27tuejsfqbybzrq'
,p_prompt_on_install=>true
);
end;
/
prompt --workspace/credentials/oci_api_access
begin
wwv_imp_workspace.create_credential(
 p_id=>wwv_flow_imp.id(31321892225562288)
,p_name=>'OCI API Access'
,p_static_id=>'OCI_API_ACCESS'
,p_authentication_type=>'OCI'
,p_namespace=>'ocid1.tenancy.oc1..aaaaaaaafj37mytx22oquorcznlfuh77cd45int7tt7fo27tuejsfqbybzrq'
,p_prompt_on_install=>true
);
end;
/
prompt --workspace/remote_servers/oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u
begin
wwv_imp_workspace.create_remote_server(
 p_id=>wwv_flow_imp.id(25535595158934483)
,p_name=>'oraclepartnersas-objectstorage-us-phoenix-1-oci-customer-oci-com-p-gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz-nba8inbjdh2uwoia1-4f0u'
,p_static_id=>'oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u'
,p_base_url=>nvl(wwv_flow_application_install.get_remote_server_base_url('oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u'),'https://oraclepartnersas.objectstorage.us-phoenix-1.oci.customer-oci.com/p/gwR2qNSfLW0HNzL0y_lLZLTMUw1XEAJolHlEA6oPZ-NBa8INBjdh2UWOia1-4F0u/')
,p_https_host=>nvl(wwv_flow_application_install.get_remote_server_https_host('oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u'),'')
,p_server_type=>'WEB_SERVICE'
,p_ords_timezone=>nvl(wwv_flow_application_install.get_remote_server_ords_tz('oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u'),'')
,p_remote_sql_default_schema=>nvl(wwv_flow_application_install.get_remote_server_default_db('oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u'),'')
,p_mysql_sql_modes=>nvl(wwv_flow_application_install.get_remote_server_sql_mode('oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u'),'')
,p_prompt_on_install=>false
,p_ai_is_builder_service=>false
,p_ai_model_name=>nvl(wwv_flow_application_install.get_remote_server_ai_model('oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u'),'')
,p_ai_http_headers=>nvl(wwv_flow_application_install.get_remote_server_ai_headers('oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u'),'')
,p_ai_attributes=>nvl(wwv_flow_application_install.get_remote_server_ai_attrs('oraclepartnersas_objectstorage_us_phoenix_1_oci_customer_oci_com_p_gwr2qnsflw0hnzl0y_llzltmuw1xeajolhlea6opz_nba8inbjdh2uwoia1_4f0u'),'')
);
end;
/
prompt --workspace/remote_servers/apex_file_server_2
begin
wwv_imp_workspace.create_remote_server(
 p_id=>wwv_flow_imp.id(31326648920930806)
,p_name=>'apex-file-server-2'
,p_static_id=>'apex_file_server_2'
,p_base_url=>nvl(wwv_flow_application_install.get_remote_server_base_url('apex_file_server_2'),'https://oraclepartnersas.objectstorage.ap-tokyo-1.oci.customer-oci.com/p/0GQ7KXrQ0HPJTpK7Vjtb7ra8oB_RQhmuJ3htdtOzlrK3oJWg7nRqtgNKK8Wi8Sm5/n/oraclepartnersas')
,p_https_host=>nvl(wwv_flow_application_install.get_remote_server_https_host('apex_file_server_2'),'')
,p_server_type=>'WEB_SERVICE'
,p_ords_timezone=>nvl(wwv_flow_application_install.get_remote_server_ords_tz('apex_file_server_2'),'')
,p_remote_sql_default_schema=>nvl(wwv_flow_application_install.get_remote_server_default_db('apex_file_server_2'),'')
,p_mysql_sql_modes=>nvl(wwv_flow_application_install.get_remote_server_sql_mode('apex_file_server_2'),'')
,p_prompt_on_install=>false
,p_ai_is_builder_service=>false
,p_ai_model_name=>nvl(wwv_flow_application_install.get_remote_server_ai_model('apex_file_server_2'),'')
,p_ai_http_headers=>nvl(wwv_flow_application_install.get_remote_server_ai_headers('apex_file_server_2'),'')
,p_ai_attributes=>nvl(wwv_flow_application_install.get_remote_server_ai_attrs('apex_file_server_2'),'')
);
end;
/
prompt --workspace/remote_servers/apex_file_storage_1
begin
wwv_imp_workspace.create_remote_server(
 p_id=>wwv_flow_imp.id(33519502269520658)
,p_name=>'apex-file-storage-1'
,p_static_id=>'apex_file_storage_1'
,p_base_url=>nvl(wwv_flow_application_install.get_remote_server_base_url('apex_file_storage_1'),'https://oraclepartnersas.objectstorage.ap-tokyo-1.oci.customer-oci.com/p/0GQ7KXrQ0HPJTpK7Vjtb7ra8oB_RQhmuJ3htdtOzlrK3oJWg7nRqtgNKK8Wi8Sm5/n/oraclepartnersas')
,p_https_host=>nvl(wwv_flow_application_install.get_remote_server_https_host('apex_file_storage_1'),'')
,p_server_type=>'WEB_SERVICE'
,p_ords_timezone=>nvl(wwv_flow_application_install.get_remote_server_ords_tz('apex_file_storage_1'),'')
,p_remote_sql_default_schema=>nvl(wwv_flow_application_install.get_remote_server_default_db('apex_file_storage_1'),'')
,p_mysql_sql_modes=>nvl(wwv_flow_application_install.get_remote_server_sql_mode('apex_file_storage_1'),'')
,p_prompt_on_install=>false
,p_ai_is_builder_service=>false
,p_ai_model_name=>nvl(wwv_flow_application_install.get_remote_server_ai_model('apex_file_storage_1'),'')
,p_ai_http_headers=>nvl(wwv_flow_application_install.get_remote_server_ai_headers('apex_file_storage_1'),'')
,p_ai_attributes=>nvl(wwv_flow_application_install.get_remote_server_ai_attrs('apex_file_storage_1'),'')
);
end;
/
prompt --application/shared_components/data_profiles/bucket
begin
wwv_flow_imp_shared.create_data_profile(
 p_id=>wwv_flow_imp.id(33152817152042248)
,p_name=>'Bucket'
,p_format=>'JSON'
,p_row_selector=>'objects'
,p_use_raw_json_selectors=>false
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(33153002846042248)
,p_data_profile_id=>wwv_flow_imp.id(33152817152042248)
,p_name=>'NAME'
,p_sequence=>1
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'name'
);
end;
/
prompt --application/shared_components/data_profiles/bucket_v2
begin
wwv_flow_imp_shared.create_data_profile(
 p_id=>wwv_flow_imp.id(33159410771080739)
,p_name=>'Bucket v2'
,p_format=>'JSON'
,p_row_selector=>'objects'
,p_use_raw_json_selectors=>false
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(33159556007080739)
,p_data_profile_id=>wwv_flow_imp.id(33159410771080739)
,p_name=>'MD5'
,p_sequence=>1
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'md5'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(33159850108080739)
,p_data_profile_id=>wwv_flow_imp.id(33159410771080739)
,p_name=>'ETAG'
,p_sequence=>2
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'etag'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(33160130858080740)
,p_data_profile_id=>wwv_flow_imp.id(33159410771080739)
,p_name=>'NAME'
,p_sequence=>3
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'name'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(33160493542080740)
,p_data_profile_id=>wwv_flow_imp.id(33159410771080739)
,p_name=>'SIZE_'
,p_sequence=>4
,p_column_type=>'DATA'
,p_data_type=>'NUMBER'
,p_has_time_zone=>false
,p_selector=>'size'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(33160755280080740)
,p_data_profile_id=>wwv_flow_imp.id(33159410771080739)
,p_name=>'STORAGETIER'
,p_sequence=>5
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'storageTier'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(33161074576080740)
,p_data_profile_id=>wwv_flow_imp.id(33159410771080739)
,p_name=>'TIMECREATED'
,p_sequence=>6
,p_column_type=>'DATA'
,p_data_type=>'TIMESTAMP WITH TIME ZONE'
,p_format_mask=>'YYYY"-"MM"-"DD"T"HH24":"MI:SS.FF9TZR'
,p_has_time_zone=>true
,p_selector=>'timeCreated'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(33161398374080740)
,p_data_profile_id=>wwv_flow_imp.id(33159410771080739)
,p_name=>'TIMEMODIFIED'
,p_sequence=>7
,p_column_type=>'DATA'
,p_data_type=>'TIMESTAMP WITH TIME ZONE'
,p_format_mask=>'YYYY"-"MM"-"DD"T"HH24":"MI:SS.FF9TZR'
,p_has_time_zone=>true
,p_selector=>'timeModified'
);
end;
/
prompt --application/shared_components/data_profiles/list_buckets
begin
wwv_flow_imp_shared.create_data_profile(
 p_id=>wwv_flow_imp.id(38943784196038576)
,p_name=>'list_buckets'
,p_format=>'JSON'
,p_row_selector=>'objects'
,p_use_raw_json_selectors=>false
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(38944015803038582)
,p_data_profile_id=>wwv_flow_imp.id(38943784196038576)
,p_name=>'NAME'
,p_sequence=>1
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'name'
);
end;
/
prompt --application/shared_components/data_profiles/list_objects_in_bucket
begin
wwv_flow_imp_shared.create_data_profile(
 p_id=>wwv_flow_imp.id(38945914367065437)
,p_name=>'list_objects_in_bucket'
,p_format=>'JSON'
,p_row_selector=>'objects'
,p_use_raw_json_selectors=>false
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(38946107455065437)
,p_data_profile_id=>wwv_flow_imp.id(38945914367065437)
,p_name=>'MD5'
,p_sequence=>1
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'md5'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(38946419092065437)
,p_data_profile_id=>wwv_flow_imp.id(38945914367065437)
,p_name=>'NAME'
,p_sequence=>2
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'name'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(38946669905065438)
,p_data_profile_id=>wwv_flow_imp.id(38945914367065437)
,p_name=>'SIZE_'
,p_sequence=>3
,p_column_type=>'DATA'
,p_data_type=>'NUMBER'
,p_has_time_zone=>false
,p_selector=>'size'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(38946983316065438)
,p_data_profile_id=>wwv_flow_imp.id(38945914367065437)
,p_name=>'TIMECREATED'
,p_sequence=>4
,p_column_type=>'DATA'
,p_data_type=>'TIMESTAMP WITH TIME ZONE'
,p_format_mask=>'YYYY"-"MM"-"DD"T"HH24":"MI:SS.FF9TZR'
,p_has_time_zone=>true
,p_selector=>'timeCreated'
);
end;
/
prompt --application/shared_components/data_profiles/list_objects_sync
begin
wwv_flow_imp_shared.create_data_profile(
 p_id=>wwv_flow_imp.id(40933923280501948)
,p_name=>'list_objects_sync'
,p_format=>'JSON'
,p_has_header_row=>false
,p_row_selector=>'objects'
,p_use_raw_json_selectors=>false
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(40934033021501955)
,p_data_profile_id=>wwv_flow_imp.id(40933923280501948)
,p_name=>'MD5'
,p_sequence=>1
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'md5'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(40934408172501956)
,p_data_profile_id=>wwv_flow_imp.id(40933923280501948)
,p_name=>'NAME'
,p_sequence=>2
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'name'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(40934667470501956)
,p_data_profile_id=>wwv_flow_imp.id(40933923280501948)
,p_name=>'SIZE_'
,p_sequence=>3
,p_column_type=>'DATA'
,p_data_type=>'NUMBER'
,p_has_time_zone=>false
,p_selector=>'size'
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(40935019689501957)
,p_data_profile_id=>wwv_flow_imp.id(40933923280501948)
,p_name=>'TIMECREATED'
,p_sequence=>4
,p_column_type=>'DATA'
,p_data_type=>'TIMESTAMP WITH TIME ZONE'
,p_format_mask=>'YYYY"-"MM"-"DD"T"HH24":"MI:SS.FF9TZR'
,p_has_time_zone=>true
,p_selector=>'timeCreated'
);
end;
/
prompt --application/shared_components/data_profiles/bucketv3
begin
wwv_flow_imp_shared.create_data_profile(
 p_id=>wwv_flow_imp.id(41136657903628426)
,p_name=>'BucketV3'
,p_format=>'JSON'
,p_row_selector=>'objects'
,p_use_raw_json_selectors=>false
);
wwv_flow_imp_shared.create_data_profile_col(
 p_id=>wwv_flow_imp.id(41136839064628434)
,p_data_profile_id=>wwv_flow_imp.id(41136657903628426)
,p_name=>'NAME'
,p_sequence=>1
,p_column_type=>'DATA'
,p_data_type=>'VARCHAR2'
,p_max_length=>32767
,p_has_time_zone=>false
,p_selector=>'name'
);
end;
/
prompt --application/shared_components/web_sources/bucket
begin
wwv_flow_imp_shared.create_web_source_module(
 p_id=>wwv_flow_imp.id(33153252004042249)
,p_name=>'Bucket'
,p_static_id=>'bucket'
,p_web_source_type=>'NATIVE_OCI'
,p_data_profile_id=>wwv_flow_imp.id(33152817152042248)
,p_remote_server_id=>wwv_flow_imp.id(25535595158934483)
,p_url_path_prefix=>'/n/oraclepartnersas/b/vector/o/'
,p_credential_id=>wwv_flow_imp.id(25515921778560906)
,p_version_scn=>41609524351301
);
wwv_flow_imp_shared.create_web_source_operation(
 p_id=>wwv_flow_imp.id(33153480568042249)
,p_web_src_module_id=>wwv_flow_imp.id(33153252004042249)
,p_operation=>'GET'
,p_database_operation=>'FETCH_COLLECTION'
,p_url_pattern=>'.'
,p_force_error_for_http_404=>false
,p_allow_fetch_all_rows=>false
);
end;
/
prompt --application/shared_components/web_sources/bucket_v2
begin
wwv_flow_imp_shared.create_web_source_module(
 p_id=>wwv_flow_imp.id(33161710151080741)
,p_name=>'Bucket v2'
,p_static_id=>'bucket_v2'
,p_web_source_type=>'NATIVE_OCI'
,p_data_profile_id=>wwv_flow_imp.id(33159410771080739)
,p_remote_server_id=>wwv_flow_imp.id(25535595158934483)
,p_url_path_prefix=>'n/oraclepartnersas/b/vector/o/'
,p_credential_id=>wwv_flow_imp.id(25515921778560906)
,p_version_scn=>41609524351301
);
wwv_flow_imp_shared.create_web_source_param(
 p_id=>wwv_flow_imp.id(33162323402080741)
,p_web_src_module_id=>wwv_flow_imp.id(33161710151080741)
,p_name=>'fields'
,p_param_type=>'QUERY_STRING'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value=>'name,size,eTag,timeCreated,md5,timeModified,storageTier,archivalState'
,p_is_static=>true
);
wwv_flow_imp_shared.create_web_source_operation(
 p_id=>wwv_flow_imp.id(33161826939080741)
,p_web_src_module_id=>wwv_flow_imp.id(33161710151080741)
,p_operation=>'GET'
,p_database_operation=>'FETCH_COLLECTION'
,p_url_pattern=>'.'
,p_force_error_for_http_404=>false
,p_allow_fetch_all_rows=>false
);
end;
/
prompt --application/shared_components/web_sources/list_buckets
begin
wwv_flow_imp_shared.create_web_source_module(
 p_id=>wwv_flow_imp.id(38944248231038585)
,p_name=>'list_buckets'
,p_static_id=>'list_buckets'
,p_web_source_type=>'NATIVE_OCI'
,p_data_profile_id=>wwv_flow_imp.id(38943784196038576)
,p_remote_server_id=>wwv_flow_imp.id(31326648920930806)
,p_url_path_prefix=>'/b/apex-file-storage/o/'
,p_credential_id=>wwv_flow_imp.id(31321892225562288)
,p_version_scn=>41609525732278
);
wwv_flow_imp_shared.create_web_source_param(
 p_id=>wwv_flow_imp.id(38944870317038591)
,p_web_src_module_id=>wwv_flow_imp.id(38944248231038585)
,p_name=>'CompartmentId'
,p_param_type=>'QUERY_STRING'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value=>'ocid1.compartment.oc1..aaaaaaaaqdp7dblf6tb3gpzbuknvgfgkedtioysanp55qcsesrskxclb3yfa'
,p_is_static=>true
);
wwv_flow_imp_shared.create_web_source_operation(
 p_id=>wwv_flow_imp.id(38944482207038588)
,p_web_src_module_id=>wwv_flow_imp.id(38944248231038585)
,p_operation=>'GET'
,p_database_operation=>'FETCH_COLLECTION'
,p_url_pattern=>'.'
,p_force_error_for_http_404=>false
,p_allow_fetch_all_rows=>false
);
end;
/
prompt --application/shared_components/web_sources/list_objects_in_bucket
begin
wwv_flow_imp_shared.create_web_source_module(
 p_id=>wwv_flow_imp.id(38947239158065438)
,p_name=>'list_objects_in_bucket'
,p_static_id=>'list_objects_in_bucket'
,p_web_source_type=>'NATIVE_OCI'
,p_data_profile_id=>wwv_flow_imp.id(38945914367065437)
,p_remote_server_id=>wwv_flow_imp.id(31326648920930806)
,p_url_path_prefix=>'/b/apex-file-storage/o/'
,p_credential_id=>wwv_flow_imp.id(31321892225562288)
,p_version_scn=>41609525681519
);
wwv_flow_imp_shared.create_web_source_param(
 p_id=>wwv_flow_imp.id(38947848441065439)
,p_web_src_module_id=>wwv_flow_imp.id(38947239158065438)
,p_name=>'bucket_name'
,p_param_type=>'URL_PATTERN'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value=>'apex-file-storage'
);
wwv_flow_imp_shared.create_web_source_param(
 p_id=>wwv_flow_imp.id(38948291660065439)
,p_web_src_module_id=>wwv_flow_imp.id(38947239158065438)
,p_name=>'fields'
,p_param_type=>'QUERY_STRING'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value=>'name,size,timeCreated,md5'
,p_is_static=>true
);
wwv_flow_imp_shared.create_web_source_operation(
 p_id=>wwv_flow_imp.id(38947439731065439)
,p_web_src_module_id=>wwv_flow_imp.id(38947239158065438)
,p_operation=>'GET'
,p_database_operation=>'FETCH_COLLECTION'
,p_url_pattern=>'.'
,p_force_error_for_http_404=>false
,p_allow_fetch_all_rows=>false
);
end;
/
prompt --application/shared_components/web_sources/list_objects_sync
begin
wwv_flow_imp_shared.create_web_source_module(
 p_id=>wwv_flow_imp.id(40935312278501958)
,p_name=>'list_objects_sync'
,p_static_id=>'list_objects_sync'
,p_web_source_type=>'NATIVE_OCI'
,p_data_profile_id=>wwv_flow_imp.id(40933923280501948)
,p_remote_server_id=>wwv_flow_imp.id(31326648920930806)
,p_url_path_prefix=>'n/oraclepartnersas/b/apex_file_storage/o/'
,p_credential_id=>wwv_flow_imp.id(31321892225562288)
,p_sync_max_http_requests=>1000
,p_version_scn=>41609524351307
);
wwv_flow_imp_shared.create_web_source_param(
 p_id=>wwv_flow_imp.id(40935886977501971)
,p_web_src_module_id=>wwv_flow_imp.id(40935312278501958)
,p_name=>'bucket_name'
,p_param_type=>'URL_PATTERN'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value=>'apex_file_storage'
);
wwv_flow_imp_shared.create_web_source_param(
 p_id=>wwv_flow_imp.id(40936249199501972)
,p_web_src_module_id=>wwv_flow_imp.id(40935312278501958)
,p_name=>'fields'
,p_param_type=>'QUERY_STRING'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
,p_value=>'name,size,timeCreated,md5'
,p_is_static=>true
);
wwv_flow_imp_shared.create_web_source_operation(
 p_id=>wwv_flow_imp.id(40935430148501966)
,p_web_src_module_id=>wwv_flow_imp.id(40935312278501958)
,p_operation=>'GET'
,p_database_operation=>'FETCH_COLLECTION'
,p_url_pattern=>'.'
,p_force_error_for_http_404=>false
,p_allow_fetch_all_rows=>false
);
end;
/
prompt --application/shared_components/web_sources/bucketv3
begin
wwv_flow_imp_shared.create_web_source_module(
 p_id=>wwv_flow_imp.id(41137145174628438)
,p_name=>'BucketV3'
,p_static_id=>'bucketv3'
,p_web_source_type=>'NATIVE_OCI'
,p_data_profile_id=>wwv_flow_imp.id(41136657903628426)
,p_remote_server_id=>wwv_flow_imp.id(33519502269520658)
,p_url_path_prefix=>'/b/apex-file-storage/o/'
,p_credential_id=>wwv_flow_imp.id(31321892225562288)
,p_version_scn=>41609525870942
);
wwv_flow_imp_shared.create_web_source_operation(
 p_id=>wwv_flow_imp.id(41137341169628441)
,p_web_src_module_id=>wwv_flow_imp.id(41137145174628438)
,p_operation=>'GET'
,p_database_operation=>'FETCH_COLLECTION'
,p_url_pattern=>'.'
,p_force_error_for_http_404=>false
,p_allow_fetch_all_rows=>false
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_menu
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(1949530650298267740)
,p_name=>'Navigation Menu'
,p_list_status=>'PUBLIC'
,p_version_scn=>41609524351307
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(1949530896398267741)
,p_list_item_display_sequence=>3
,p_list_item_link_text=>'Files'
,p_list_item_link_target=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-files-o'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'3,12'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(1950386936788703266)
,p_list_item_display_sequence=>14
,p_list_item_link_text=>'Administration'
,p_list_item_link_target=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-gear'
,p_list_item_current_type=>'COLON_DELIMITED_PAGE_LIST'
,p_list_item_current_for_pages=>'7,10,11,12,13,6'
);
end;
/
prompt --application/shared_components/navigation/lists/navigation_bar
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(1950399639192762161)
,p_name=>'Navigation Bar'
,p_list_status=>'PUBLIC'
,p_version_scn=>41609524351307
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(1950399819752762163)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Help'
,p_list_item_link_target=>'f?p=&APP_ID.:HELP:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-question-circle-o'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(1950400248967762169)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'&APP_USER.'
,p_list_item_link_target=>'#'
,p_list_item_icon=>'fa-user'
,p_list_text_02=>'has-username'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(1950400657962762170)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Sign Out'
,p_list_item_link_target=>'&LOGOUT_URL.'
,p_parent_list_item_id=>wwv_flow_imp.id(1950400248967762169)
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/lists/administration
begin
wwv_flow_imp_shared.create_list(
 p_id=>wwv_flow_imp.id(3281817780688289680)
,p_name=>'administration'
,p_list_status=>'PUBLIC'
,p_version_scn=>41609524351309
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(3281817984025289683)
,p_list_item_display_sequence=>10
,p_list_item_link_text=>'Manage Sample Data'
,p_list_item_link_target=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-edit'
,p_list_text_01=>'Recreate example projects data in the EBA_DEMO_FILE_PROJECTS table.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(3281818294411289686)
,p_list_item_display_sequence=>20
,p_list_item_link_text=>'Delete Files'
,p_list_item_link_target=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-remove'
,p_list_text_01=>'Delete all rows from the EBA_DEMO_FILES table.'
,p_list_item_current_type=>'TARGET_PAGE'
);
wwv_flow_imp_shared.create_list_item(
 p_id=>wwv_flow_imp.id(2167767788482565490)
,p_list_item_display_sequence=>30
,p_list_item_link_text=>'Theme Style'
,p_list_item_link_target=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.::::'
,p_list_item_icon=>'fa-desktop'
,p_list_text_01=>'Change user interface theme style for all users.'
,p_list_item_current_type=>'TARGET_PAGE'
);
end;
/
prompt --application/shared_components/navigation/listentry
begin
null;
end;
/
prompt --application/shared_components/files/icons_app_icon_32_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7AF4000000017352474200AECE1CE9000001AD49444154584763FCBBD7EE3FC30002C651078C86C0A00F0126A78324E5918F8F8E30F0DEA9265A0FDE5CF0FF3F0303B33369';
wwv_flow_imp.g_varchar2_table(2) := '0E78F6E21503F7AF5B443B826036243504400E0001621D419603EEBCFDC5D0B2FF3D438DA320838A301B4A70C31C40AC23487600C8F2E6031F19DEFC606210E1F8C750EBC08FE1086417FDDB678F373D90E40098E5F54E820CB9DB3E324CF6E26768DCF7';
wwv_flow_imp.g_varchar2_table(3) := '1EAF23A8E60064CB95045918BC97BE65D81A2DCC70EFFD1FBC8EA09A0376DFF9CEA02CCCCA00B21C04600E00B1418EB8FBF63783AB0A27467053CD01E826233B005F24D3C501FD0FF73014CABB6075075D1CA07AA681E1B649037D1DB0F4D23786683D2E';
wwv_flow_imp.g_varchar2_table(4) := 'B0A503E20064EFD2DD01131EED6590661360089530C60881D52FCE323CFDF581A140CE192C479334F0E9EF0F86A8EBF319E245CCC08E808500C8F2856F4E312CD34C64E063E6A09D034026233BA2EAC9668636195F0CCB691602B0F88739E2E68F970CEA';
wwv_flow_imp.g_varchar2_table(5) := '1CE2283E87A9A1491420274090235A1FED60A896F380073BCD2A23A29B39480A691E02841C45B103BEFEF8CB006A9A910318191918B83998296B0F906331297A08364848318C1CB5A30E18F0100000F74D3410451A8D950000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(571583174222296068)
,p_file_name=>'icons/app-icon-32.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_192_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D49484452000000C0000000C0080600000052DC6C07000000017352474200AECE1CE900000DEC49444154785EED9D6D8C54D519C79F999DDD65975D4497055C5028054B9B0A8A96280222B4B6F625D85A8AC4366D5240BF14';
wwv_flow_imp.g_varchar2_table(2) := 'D29A4AAB40A9509AB5319A7E02A1698C3140695A8DC556238A144BA35601DB68815A11E46597857517D8B799B9CD99D9BB9D9DBD3373CF39CFBD77EE3DFF49F8C29CE7B9E7F93FFFDF3DE7CCCB4E2CB57BAE457840014315880100433B8FB2330A000018';
wwv_flow_imp.g_varchar2_table(3) := 'C168050080D1ED47F100001E305A01006074FB513C0080078C56000018DD7E140F00E001A315000046B71FC5030078C068050080D1ED47F100001E305A01006074FB513C0080078C56000018DD7E140F00E001A315000046B71FC5030078C068050080D1';
wwv_flow_imp.g_varchar2_table(4) := 'ED47F100001E305A01006074FB513C0080078C56000018DD7E140F00E001A315000046B71FC5030078C068050080D1ED47F100001E305A01006074FB513C0080078C56000018DD7E140F00E001A315000046B71FC5030078C068050080D1ED47F1910220';
wwv_flow_imp.g_varchar2_table(5) := '36F1DB141B7D1B51DD6474B65F818EE3FBA8EEC843D0A38002D100A0A689E2D39B896AAF46A3F3143879BA85EAFA0E0382280310BFE92998BF40830500E201089C050AFD0A90D9F64C5A863B7F09000041440188CFFC0DF6FC45F0B757007B085682C162';
wwv_flow_imp.g_varchar2_table(6) := '857E0588CF7F15777F0900B0120000A380C95F01B012000000D0AF00B64311F8A5786C818AF35C6805C04A905500678088AF07A50030FD4C00000080D1EF1300000030A0808967020000000629601A040000000C51C024080000007054C0140800000028';
wwv_flow_imp.g_varchar2_table(7) := 'A8800910000000505481A84300003C002099265AFBE2994CE6876F1F4389B807177199D2CDFB00A5524519020050AAFB92CFDBE67FEBA39E4CE48C71D58142C0014094DF2C030092062F363CDFFCF6D8202168397B8E92C9244B95515C0900008B3588F2';
wwv_flow_imp.g_varchar2_table(8) := 'CD1FAF1A96C99CEEED0E7425E8BC7091C43FAE47D42000000CCE70327F2C5E91C96CA5538143D072B68D92C91443A5D9145182000068DAA298F9EDD4F910ACFFE218AA88695E58223C994AD1B9F3ED80C04133002061A4FCA1298B68CD0B67C83EF08A6D';
wwv_flow_imp.g_varchar2_table(9) := '8F7DE7CF1F9B0BC1CCAB6BE8679F6FF41502311FB115EAEAEEC19920A7390040110061FE9FBFD44AAF7FD895C950CCFC4E2B41501028965B302CFDF2ADDC297DCD070014E456317F542100000A06E20CF1FB1B6143CC5F594DB18A845449562A49E9BEEC';
wwv_flow_imp.g_varchar2_table(10) := 'FB04615F09008054EBF907FB090087F907568288400000F83D2D95D14F00D6BDD44A7F3FD6BFE777B8F3DFD854496F9EEC739CBFD373B92BC1AC8935B47641A354EDE530180004DC053F00485B44C2FC03075E07F35F7F6525AD9B3782166E6B7354E4D9';
wwv_flow_imp.g_varchar2_table(11) := '250DB46E4F07BD7D6A3020B910DC32B1861E9ADF48711F5F22D56D1F00D0555033DE6B0084F97FF1722BBDF641E13BBF6D7EF1A1B7AF3CED0CC0AE7B1A32EF16470D0200A06960DD702F019035BFA8A51800E2F9A8410000741DAC19EF15006ECCFFB971';
wwv_flow_imp.g_varchar2_table(12) := '55B47A6EFDA08F3B9702C08660C3DE4E7AE3A3DE41D587713B0400340DAC1BEE05006ECDBFE6D6FA21EFE6BA0140D42C5E515AFF6AF8210000BA0ED68CE70640C7FC6EB640B9E5BA8560F5FC468A95E9C11800681A58379C13005DF3CB02E076259837A9';
wwv_flow_imp.g_varchar2_table(13) := '9656CD1B55961000005D076BC673016059441B4ABCDA73F35555F4D33943B73DB925B8DD02C9AE04E50A0100D034B06E380700C2FCCD7BCED29EF72F65A61377789D5F98FFC139F5255FA35701C05E097EF9D74EDA7FBCF0C1B81C210000BA0ED68CD705';
wwv_flow_imp.g_varchar2_table(14) := '80D3FC2A5BA0DCF2C5166C63C82000009A06D60DD70180DBFCBA0088F8B0410000741DAC19AF0A801BF3CF9D504D3FBEA5AEE4B647F70C902F816B086E1B4541BF380400340DAC1BAE02805BF33F30BB4EDA60AA67001508BE70CD70FAD19C06E939EA6A';
wwv_flow_imp.g_varchar2_table(15) := '3E68DB862FC470CA299F4B16008B889A5F297EE015777E15F3736C81F2CF04BF7AED02ED3D96FDEE80FDB0527D94EECB1E968386002B80BC6759235400F8F5BE36FAF3BF2F3ABEDAA3637E6E00443E01EC23FB0A4370C7A786D38AD9C1AD020080D5CEF2';
wwv_flow_imp.g_varchar2_table(16) := 'C96401B0AFB0E98D0E7AEEF0E08F262F98544D3FBC597EDBC37D06C857A110048B3E5345DFBBBE5E5E34C60800C028A64A2A5500C4B57EF7AF2E7AF240F6B57F0EF37BB1020C6C7BF25682E5370CA78553B37F7C2BC8070008527DF1A695E60F65EF3ADC';
wwv_flow_imp.g_varchar2_table(17) := '4D47CF2569E54D752C95701D820B4DE6B1FD1768EAA804DD312578F38B39020016DBA827D10540FDCACE915E03C03D5FDD7C00405741CD7800A029A0663800D01450371C00E82AA8170F00F4F4D38E0600DA126A2500005AF2E90703007D0D753200001D';
wwv_flow_imp.g_varchar2_table(18) := 'F51862010083881A29008086781CA100804345F51C00405D3B964800C022A3721200A02C1D4F2000E0D151350B0050558E290E003009A9980600280AC7151655003EB9F7414789FE33772397742C7900008B8CEA490080BA761C91008043458D1C004043';
wwv_flow_imp.g_varchar2_table(19) := '3C865000C020A24E8AA80230E5CD758EB21CB9D1F9FF7534D48905003AEA31C402000611355200000DF138420100878AEA390080BA762C9100804546E5240040593A9E4000C0A3A36A1600A0AA1C531C00601252310D0050148E2B0C007029A9960700A8';
wwv_flow_imp.g_varchar2_table(20) := 'E9C6160500D8A4544A04009464E30B02007C5AAA6402002AAA31C6941B005CA5E18D302E258BE789A576CF157F782CB40F00106CEBB00204ABBFF61FC60A78FA052F8F15C09FCE6005F04767E9AB000069C994020080926CDE070100EF3516570000FEE8';
wwv_flow_imp.g_varchar2_table(21) := '2C7D1500202D995200005092CDFB2000E0BDC65801FCD158E92A00404936E920AC00D292150EE84876D188440D4B46AF01E09A2B5E066569B77A9272781FC0228B56BCBB9DDEEF6AA5A7A72DA591895AF582FA23BD04A03D7989EE39B49526D78EA1C7A7';
wwv_flow_imp.g_varchar2_table(22) := '7E8B621A3FB30700B45BAD972068006CF33FDFFA4EA690C9C347D38EE9CBB521F00A0061FEC5079FA0A3175B32F3BD6BEC0C6ABEE62E650800809E7FB5A3830440987FE57BDB69574BD6FC148B1159160B045E0030C8FCFD73D5850000685B582F415000';
wwv_flow_imp.g_varchar2_table(23) := 'E4DFF963D5098AC56294EE49B240C00D40BEF9E3D509B22C8B2C315F8D950000E8F9573B3A4800EE7F6F273DDB728032E6AF88676B495B2C10700270AEEF222D39B425BBED89C548989FE2D9DF98B79269B27A93B470F475F4E8D445D25B2100A06D61BD';
wwv_flow_imp.g_varchar2_table(24) := '04410190310F59F4C0D13FD033EDFD5B20BB943C08B64D5B4657540E972A940B0061FE450737D30797CE0E31BF3DA13B475E4B8F4CFE86B4F933BCE397E2A5FACA3E3848006C0856FDF719FA63DBC1C1B5E54030B17614ED9C7EAF14041C00B831FFD71B';
wwv_flow_imp.g_varchar2_table(25) := 'A653F327EE54323F0060B7B37CC2A001F00A025D00FC303F0090F72B7B443900E005043A00B4F676D2DD87B614DDF62C6EBC81D64FF8AAF29D7F60B7872D10BBA7A512960B00DC10A80220CCFFCD839BE844D7F9827B7E61FE0D13BE26A573A1C13803B0';
wwv_flow_imp.g_varchar2_table(26) := 'C8A89EA49C00B0215873EC4FB4A3F51F45CF04DBA72DA3C6AAFA8285AB00E0B7F9B10552F72D5B64B9016017B6FAD8734521185F7339FD7EFA7D052190052008F30300361BAB272A570044453A10C80070BAE7635A7CE809DFB63DB9DDC21648DDBB2C91';
wwv_flow_imp.g_varchar2_table(27) := 'E50C800E046E0110E65F7460339DEC69F765CF9FDF3400C06263F524E50E802A046E0008DAFCD802A9FB962D320C00B88560C7B4E534B6FAB28C36A5007063FEEF8C9E496BAFFE329BD64E89B002782A6FE9E46101C00D044DD52369E775F766202806C0';
wwv_flow_imp.g_varchar2_table(28) := '899EF3B4E4C096FF6F7B865552FE47FAFD303F5680D2FEF47C44980010623CFCE1F3F454CBEB8375C9F9D8840DC19C771E73D4EE956B57D2A2B737534B6F4776CF1FA0F90180E7F62E7D81B001202ADA78FC05FAED99FD0521185773399D8A5D742CBE31';
wwv_flow_imp.g_varchar2_table(29) := '358CCEF4F49B3FE7539DF6E0EF8F99453FB9EAF6D2C2318DC016884948D5346104A0E04A6011A5BBFB32DF2788D756394A92BED45B16777E7B720040D5B94C716105A01404F19A4A6700BAFA02DFF6E44E0C00301959354D9801287626B0BFB0324417F1';
wwv_flow_imp.g_varchar2_table(30) := 'A78CB3DF6519782C1D3B8B568DF76FDB030054DDEA415CD8012808814BAD8234BF98225600978DF26A58140050852068F30300AF5C2D91372A00C842500EE607001246F56A689400101A359F7891B69EFE5B51B9CAC5FC00C02B574BE48D1A00A5202827';
wwv_flow_imp.g_varchar2_table(31) := 'F3030009A37A35348A001482A0DCCC0F00BC72B544DEA802900FC18AA679F483A67912CAF83314AF02F9A373C1AB4419001B8286441D89BB7F393E0040C05D893A0001CB5BF2F200A0A444DE0E0000DEEA5B2A3B0028A590C7CF03008F052E911E0004AB';
wwv_flow_imp.g_varchar2_table(32) := '7F647F273860595D5F1E00B896CA9B815801BCD1D56D5600E056298FC601008F8475991600B814CAAB6100C02B65DDE50500EE74F26C546AC656AA1C39C5B3FC485C5881BEF62354F1D6D2504B14FA9F49BD307A098DF8EC7DA16E425827DFF1CF4D54D7';
wwv_flow_imp.g_varchar2_table(33) := 'B22DACD3CFCC3BF4009C6AEBA5315FDA4E89FA09A16E44D8269FEC3C4667FE72375DD9E0FCDDE5B0D4137A00CE7EDC47D6B0266A98FD2820F0C975C2FC6DFBEEA758F7491A7599F377977D9A8AF665420FC085AE14755E4A6584A8FFF477A966FC029C09';
wwv_flow_imp.g_varchar2_table(34) := 'B46DE19C40ECF9BB4EECA6CE779FCCEA5D5B417535151E5DCD9FB4A10740C8D4DADE47C994F8B6381E7E2990A88851E3C870DFFD2371061045A4D2169DEB4802029FDC2FCC7FC5880455F4FFD4AA4F97F5E4329158016C65C476A8BB374D7D49AC065EB8';
wwv_flow_imp.g_varchar2_table(35) := 'A53211A36155F1D06F7B72B58914005E341D39A3AD000088767F515D090500002C62B40200C0E8F6A37800000F18AD000030BAFD281E00C003462B00008C6E3F8A0700F080D10A0000A3DB8FE201003C60B40200C0E8F6A37800000F18AD000030BAFD28';
wwv_flow_imp.g_varchar2_table(36) := '1E00C003462B00008C6E3F8A0700F080D10A0000A3DB8FE201003C60B40200C0E8F6A37800000F18AD000030BAFD281E00C003462B00008C6E3F8A0700F080D10A0000A3DB8FE201003C60B40200C0E8F6A37800000F18AD000030BAFD281E00C003462B';
wwv_flow_imp.g_varchar2_table(37) := '00008C6E3F8A0700F080D10AFC0FBD8137882C375A4A0000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(571583363362296084)
,p_file_name=>'icons/app-icon-192.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/shared_components/files/icons_app_icon_512_png
begin
wwv_flow_imp.g_varchar2_table := wwv_flow_imp.empty_varchar2_table;
wwv_flow_imp.g_varchar2_table(1) := '89504E470D0A1A0A0000000D4948445200000200000002000806000000F478D4FA000000017352474200AECE1CE90000200049444154785EED9D7B9065575587D7EDD7BC3A3393643249C0E0230942200982A44031620091444BB4048C68958A44A12CB5';
wwv_flow_imp.g_varchar2_table(2) := '84029280468140282C5F552241F0890A88162509A824A2524AA16812428924F141348F79CF647A66FA79ADD343273D9DDB7DCFB9FBB1F6DAEBEBFF28CED97BADEFB76EF6D7E7DEBED35BBCEDF2BEF00301084000021080802B023D04C055DE340B010840';
wwv_flow_imp.g_varchar2_table(3) := '000210582680003008108000042000018704100087A1D33204200001084000016006200001084000020E0920000E43A7650840000210800002C00C400002108000041C1240001C864ECB108000042000010480198000042000010838248000380C9D9621';
wwv_flow_imp.g_varchar2_table(4) := '000108400002080033000108400002107048000170183A2D4300021080000410006600021080000420E0900002E030745A860004200001082000CC00042000010840C0210104C061E8B40C010840000210400098010840000210808043020880C3D06919';
wwv_flow_imp.g_varchar2_table(5) := '02108000042080003003108000042000018704100087A1D33204200001084000016006200001084000020E0920000E43A7650840000210800002C00C400002108000041C1240001C864ECB108000042000010480198000042000010838248000380C9D96';
wwv_flow_imp.g_varchar2_table(6) := '21000108400002080033000108400002107048000170183A2D4300021080000410006600021080000420E0900002E030745A860004200001082000CC00042000010840C0210104C061E8B40C010840000210400098010840000210808043020880C3D069';
wwv_flow_imp.g_varchar2_table(7) := '1902108000042080003003108000042000018704100087A1D33204200001084000016006200001084000020E0920000E43A7650840000210800002C00C400002108000041C1240001C864ECB108000042000010480198000042000010838248000380C9D';
wwv_flow_imp.g_varchar2_table(8) := '9621000108400002080033000108400002107048000170183A2D4300021080000410006600021080000420E0900002E030745A860004200001082000CC00042000010840C0210104C061E8B40C010840000210400098010840000210808043020880C3D0';
wwv_flow_imp.g_varchar2_table(9) := '691902108000042080003003108000042000018704100087A1D33204200001084000016006200001084000020E0920000E43A7650840000210800002C00C400002108000041C1240001C864ECB108000042000010480198000042000010838248000380C';
wwv_flow_imp.g_varchar2_table(10) := '9D9621000108400002080033000108400002107048000170183A2D4300021080000410006600021080000420E0900002E030745A860004200001082000CC00042000010840C0210104C061E8B40C010840000210400098010840000210808043020880C3';
wwv_flow_imp.g_varchar2_table(11) := 'D0691902108000042080003003108000042000018704100087A1D33204200001084000016006200001084000020E0920000E43A7650840000210800002C00C400002108000041C1240001C864ECB10800004200001048019800004200001083824800038';
wwv_flow_imp.g_varchar2_table(12) := '0C9D9621000108400002080033000108400002107048000170183A2D4300021080000410006600021080000420E0900002E030745A860004200001082000CC00042000010840C0210104C061E8B40C010840000210400098010840000210808043020880';
wwv_flow_imp.g_varchar2_table(13) := 'C3D0691902108000042080003003108000042000018704100087A1D33204200001084000016006200001084000020E0920000E43A7650840000210800002C00C400002108000041C1240001C864ECB108000042000010480198000042000010838248000';
wwv_flow_imp.g_varchar2_table(14) := '380C9D9621000108400002080033000108400002107048000170183A2D4300021080000410006600021080000420E0900002E030745A860004200001082000CC00042000010840C0210104C061E8B40C01084000021040009881760436ED92DE99CF15D9';
wwv_flow_imp.g_varchar2_table(15) := '79A9F4A6BF4164F3D92213D3EDEEE52A08144AE0C8FD9F91E97BAE2FB43ACA82405A0208405ABEF657DF7E91F4CE7B99F4CEBEC27E2F74008135041E78688F4CCF7F190960325C1240005CC6DEA2E9DEB8F42EFC69E97DCDF7B7B8984B206093402300CD';
wwv_flow_imp.g_varchar2_table(16) := '0F1260333FAA0E23800084F1ABF3EEE9F365ECA2EB44A62FA8B33FBA82C05709AC080012C04878248000784C7DA39E775E2C6397DC2432B10D3210A89EC06A014002AA8F9B06D71040001889C70834BFF93FF33739FC99093704D60A0012E0267A1A1511';
wwv_flow_imp.g_varchar2_table(17) := '0480313849A0372E63CFBE99C7FECC832B0283040009703502AE9B45005CC7FF58F3BD27FF2C1FF86316DC11584F00900077A3E0B26104C065EC6B9ADE7E918C7DF37B200101770436120024C0DD38B86B18017017F9E31BEE3DED17F93B7FE6C0258161';
wwv_flow_imp.g_varchar2_table(18) := '028004B81C0B374D23006EA25EA7D14DBB64EC5B3FEA9D02FD3B25D046009000A7C3E1A06D04C041C81BB5D87BC2F748EF29AF774E81F6BD12682B004880D709A9BB6F04A0EE7C8776D7BBE8CDD23BE74543AFE30208D448A08B002001354E80EF9E1000';
wwv_flow_imp.g_varchar2_table(19) := 'DFF9CBD8651F10993EDF3905DAF74AA0AB0020015E27A5CEBE11803A736DDDD5D8E5B7F0AFFAB5A6C585B5111845009080DAA6C06F3F0880DFEC973B1FBBE2EF9C13A07DCF0446150024C0F3D4D4D33B02504F96237582008C848D9B2A21102200484025';
wwv_flow_imp.g_varchar2_table(20) := '43E0B80D04C071F83C01701E3EED4BA80020010C9165020880E5F422D4CE1380081059C22C8118028004988DDF7DE10880F31140009C0F80F3F663090012E07C908CB68F00180D2E56D908402C92AC6391404C0140022C4E80EF9A1100DFF9F35700CEF3';
wwv_flow_imp.g_varchar2_table(21) := 'F7DE7E6C014002BC4F94ADFE11005B7945AF962700D191B2A0210229040009303400CE4B45009C0F0002E07C009CB79F4A009000E78365A47D04C04850A9CA44005291655D0B04520A00126061027CD78800F8CE9FCF0038CFDF7BFBA9050009F03E6165';
wwv_flow_imp.g_varchar2_table(22) := 'F78F00949D4FF2EA7802901C311B144C2087002001050F80F3D21000E7038000381F00E7EDE7120024C0F9A015DA3E02506830B9CA42007291669F1209E4140024A0C409F05D1302E03B7F3E03E03C7FEFEDE7160024C0FBC495D53F0250561ED9ABE109';
wwv_flow_imp.g_varchar2_table(23) := '4076E46C5810010D0140020A1A00E7A52000CE070001703E00CEDBD7120024C0F9E015D23E025048105A6520005AE4D9B704029A028004943001BE6B40007CE7CF67009CE7EFBD7D6D014002BC4FA06EFF08802E7FF5DD7902A01E010528122841009000';
wwv_flow_imp.g_varchar2_table(24) := 'C50170BE3502E07C001000E703E0BCFD52040009703E884AED23004AE04BD91601282509EAD02050920020011A13E07B4F04C077FE7C06C079FEDEDB2F4D009000EF1399B77F04202FEFE276E30940719150504602250A00129071009C6F8500381F0004';
wwv_flow_imp.g_varchar2_table(25) := 'C0F900386FBF540140029C0F66A6F611804CA04BDD0601283519EACA41A064014002724C80EF3D1000DFF9F31900E7F97B6FBF74014002BC4F68DAFE1180B47C8B5F9D2700C547448109095810002420E100385F1A01703E000880F30170DEBE15014002';
wwv_flow_imp.g_varchar2_table(26) := '9C0F6AA2F611804460AD2C8B00949BD4DC627FB9B8A9F15EB9451AAFCC92002001C687ADC0F211800243C9591202909376FBBDE697FA72ED27F62CDFF08E97EC96C93124A03DBDF6575A130024A07DB65C399C0002309C51D5572000E5C5BB72F8DFFDD0';
wwv_flow_imp.g_varchar2_table(27) := 'EC72714F3F6713129028268B028004241A0687CB22000E435FDD320250D600AC3DFC57AA4302D2E4645500908034F3E06D5504C05BE26BFA4500CA1980F50E7F24205D46960500094837175E564600BC24BD4E9F0840190330ECF04702D2E4F4D0C37B65';
wwv_flow_imp.g_varchar2_table(28) := 'A97FF2C396567FA6E7BF2CD3F75C6FB57CEA5624800028C22F616B04403F85B6873F12103FABBDFB0EC8FCC242FC8533AF880464065EC976084025418EDA0602302AB938F7753DFC918038DC57563978E8B01C3F71F2C396D67F9000EB09E6AF1F01C8CF';
wwv_flow_imp.g_varchar2_table(29) := 'BCA81D1100BD38463DFC918078991D3B7E420E1D3E126F41E5959000E5008C6D8F00180B2C76B908406CA2EDD66B73F88F4D6D5E5E6C69EEC4BA8BF2D701ED78AF77D5E2E2923CBC775FD82285DD8D04141648C1E52000058793A334042007E553F7687B';
wwv_flow_imp.g_varchar2_table(30) := 'F8F7C6C6976FEC2F2D220109633A78E8881C3FB1BE6425DC3AD9D2484032B4552D8C00541567F7661080EECC42EEE87AF8AFEC85048450DFF8DEB9F979D9B7FF60BA0D9456460294C01BDA16013014568A521180145407AF39EAE18F04A4CFE8F0234765';
wwv_flow_imp.g_varchar2_table(31) := '66E658FA8D32EF800464066E6C3B04C05860B1CB450062134D73F823016973EAF7FBB277FF4159A8E04F02D7924202D2CE8EE5D51100CBE945A81D01880071C812CDBFEA77DD27F7C8CA77FB0FBABCF9C0DFCA7BFEC32AE2ED80618446FBFF9BEF03D87F';
wwv_flow_imp.g_varchar2_table(32) := 'E0A02C2DD9FE62A041DD2301A3CD44ED772100B5273CA43F0420ED003487FF1B6EDD235FDAB3FEDF9A7739FC79129038AFB9793970E81012901633AB17420001282408AD32108074E4531DFE5D24E0C6EFDA2D53E3FC53C25D526E9E04347F19C0DB015D';
wwv_flow_imp.g_varchar2_table(33) := 'A871AD45020880C5D422D68C004484B96AA9D4877F5B0978CAEE4DF2AE2B9180AE29379F09387274860F067605C7F5A6082000A6E28A5F2C02109F69AEC31F09889FDDDA159B3F119C9939CEF704A447CD0E0A04100005E8256D8900C44D23F7E18F04C4';
wwv_flow_imp.g_varchar2_table(34) := 'CD6FBDD59A6F0C9C9D9B93D9D9595958589485C545699E1258FEE1838196D38B533B021087A3D955108078D1691DFE4840BC0CBDADB474FBB77B6B997E571140009C8F0302106700B40F7F24204E8EDE564100BC257E6ABF0880EFFC0501081F80520E7F';
wwv_flow_imp.g_varchar2_table(35) := '24203C4B6F2B2000DE1247007C27BEA67B04206C1C4A3BFC9180B03CBDDD8D00784B1C01F09D3802102DFF520F7F24205AC4D52F8400541FF1860DF21680EFFC790B60C4FC4B3FFC9180118375761B02E02CF035ED2200BEF3470046C8DFCAE18F048C10';
wwv_flow_imp.g_varchar2_table(36) := 'AEB35B100067812300BE035FDB3D9F01E8360FD60E7F24A05BBEDEAE4600BC25CE67007C27CE670046CEFFD8FC925CF7C9BDD1FF619F910BEA78E3B07F4590AF0DEE08B482CB11800A420C6881B70002E0D5702B4F00DAA5D81CFE6FBC758FDCB36F6EDD';
wwv_flow_imp.g_varchar2_table(37) := '1B46F957FDDAED1EEF2A24201ECB1A5642006A4871F41E1080D1D955712702303CC65A0E7FDE0E189EB5B72B10006F89F31680EFC4790BA053FECDE17FED27F7C87FEC89FF9BFF33CF9D947F7D70BE533D6B2F1E758D614F022E3A7B93BCEDC567C9D6C9';
wwv_flow_imp.g_varchar2_table(38) := 'B1A0FAB8B96C020840D9F9A4AE8E2700A90917BE3E4F00D60F28E56FFE979E3329373CFF34F9BE3F3D1034217FF18367C80D9F7E44EE7CA8BB480C93800B774DC94D57EE460282122AFB6604A0EC7C52578700A4265CF8FA08C0E080721CFE53E33DB9EA';
wwv_flow_imp.g_varchar2_table(39) := '83FB8326E496579E29CD5F2620014118DDDE8C00B88D7EB97104C077FE7C0FC080FC731DFECDD63104A059070970FE421EB17D0460447095DC86005412E4A86DF004E05472430FFF5E4FC62637496F6CBC33F295C7FECD6FFE2B3FB1040009E81C073788';
wwv_flow_imp.g_varchar2_table(40) := '0802E07B0C1000DFF9F3046055FEAD0EFFA9CDD2EB75FF60DCA0C33FE6138095367812E0FC05DDB17D04A023B0CA2E47002A0BB46B3B3C0138494CE3F04F21003C09E8FA0AF07D3D02E03B7F04C077FE3C01503CFC5309401409989F15E9F707BE3AF8EB';
wwv_flow_imp.g_varchar2_table(41) := '807AFEA38100D493E5289D2000A350ABE81EEF4F00B47EF34FF11980B56319F476407F4996E64E200115BDD607B58200541EF090F61000DFF9BB7E02A07DF8A77C0210E533014840F5FF754000AA8F78C3061100DFF9BB1580120EFF1C02B0F276C09B6F';
wwv_flow_imp.g_varchar2_table(42) := '3B225FDCBBD079DAFB48406766966E40002CA515BF5604203E53532B7A7C0B60666E49DEF4890DFE619FE64FFD46FCB4FFD3CE9A90B7BD60BBACFE53BF8D0622E69F016EB4CFEC425FDE723B1260EAC599A158042003E482B740000A0E274769DE04A039';
wwv_flow_imp.g_varchar2_table(43) := 'FC5F7FCB1EF9AF03EB7CB77FE0E1FFD62BB6CBA689C7FECE7F5886B904A0A90309189686BFFF1F01F097F9EA8E1100DFF9BB7A0BA0B4C33FD75B00AB471C0970FE825FD33E02E07B1E1000DFF9BB1180120F7F0D01E04980F3173C02C000AC228000381F';
wwv_flow_imp.g_varchar2_table(44) := '070F6F01947AF86B090012E0FC45BFAA7D9E00F89E0504C077FED53F0128F9F0D714801C12F0CE97EC966D53DDBF36D9F94B326BFB084056DCC56D8600141749DE826A7E0250FAE1AF2D00A925E0EBCF9892775F8504E47D4577DB0D01E8C6ABB6AB1180';
wwv_flow_imp.g_varchar2_table(45) := 'DA12EDD84FAD0260E1F02F410090808E2F98CA2E47002A0BB4633B08404760B55D5EA3005839FC4B110024A0B65775FB7E1080F6AC6ABC1201A831D50E3DD52600960EFF9204604502AEBDED88FCC7BEF8DF18C8DB011D5E94192F450032C22E702B04A0';
wwv_flow_imp.g_varchar2_table(46) := 'C0507296549300583BFC4B1380A69EE30B7DB91E09C8F91254DD0B0150C5AFBE3902A01E816E01B50840CAC3FF1B774DC83B5ED0ED1BFEDAA69AF39B00DBD68404B42565FF3A04C07E86211D200021F42AB8B70601487DF8BFFD05DB654B87AFF7ED3216';
wwv_flow_imp.g_varchar2_table(47) := '250A004F02BA2468FB5A04C0767EA1D52300A1048DDF6F5D002C1FFE25BE05B07A9C791260FCC5DDA27C04A005A48A2F41002A0EB74D6B9605E091D92579C3AD69FE619FE6B17FCADFFC57B229F509C04A7D48409B5791DD6B1000BBD9C5A81C018841D1';
wwv_flow_imp.g_varchar2_table(48) := 'F01A5605A039FC5FF7F187E52B87E607D30FF857FD721DFEA53F0140020CBFB05B968E00B40455E9650840A5C1B66DCBA200D472F85B1180A64E9E04B47D45D9BA0E01B09557EC6A1180D8448DAD674D006A3AFC2D09001260EC85DDB25C04A025A84A2F';
wwv_flow_imp.g_varchar2_table(49) := '43002A0DB66D5B9604A0B6C3DF9A0020016D5F5576AE4300EC6495A25204200555436B5A11801A0F7F8B02B022016FFC9B2372DF01BE31D0D04B7D60A90880F504C3EA4700C2F899BFDB8200D47AF85B1580A6EE99F9BE5CFBA97412F0AE2B77CB699BF8';
wwv_flow_imp.g_varchar2_table(50) := 'A78453FF070601484DB8ECF51180B2F3495E5DE90250F3E16F5900524BC093764ECAAF7CF7D94840E2FF022000890117BE3C02507840A9CB2B5900521EFEE79F312137BD28DD37FCB5CDADF4EF0118D647CA270148C030FAE1FF3F0210CED0F20A0880E5';
wwv_flow_imp.g_varchar2_table(51) := 'F422D45EAA00A43EFCDFF1C2EDB26DB2178160D812D60580270161F96BDF8D006827A0BB3F02A0CB5F7DF71205C0CBE16FFD2D80D5C3CB9300F597F2480520002361ABE62604A09A28476BA43401F074F8D724003C0918EDF5A77D1702A09D80EEFE0880';
wwv_flow_imp.g_varchar2_table(52) := '2E7FF5DD4B12006F877F6D028004A8BF9C3B178000744656D50D08405571766FA61401F078F8D728004840F7D7A0E61D0880267DFDBD1100FD0C542B284500FEF6BE19B9E9D3FB07B308F8877D2E3863426E2CE4037F839AABE1438083FA9A99EBCBB5B7';
wwv_flow_imp.g_varchar2_table(53) := 'A5F99E80373D7F973CFFFCADAAAF9B5A3647006A4972B43E1080D1B85573572902D000FDD8BF3F22EFF9C783A7B20D38FC9B3FF52BE5D3FEEB0D4CAD02B0F224E00D7F7D58FEFBD062E7D74BBFBF244B732744FAFD53EE7DCDB79C2EDFFBD4D33AAFC70D';
wwv_flow_imp.g_varchar2_table(54) := '83092000BE270301F09DBF9424008F9380CA0FFF5ADF0258FD927A64AE2F6FFA9B3812C0E11FFF3F5608407CA6965644002CA595A0D6D204A069F1CFEF7E446EFEDC21199BDA2CBD5EF7AF83B5F09BFF4A94353F0158E93186045C73D94EF9FEA7F39B7F';
wwv_flow_imp.g_varchar2_table(55) := 'ECFF042000B189DA5A0F01B09557F46A4B1480A6C90FDF7D4C7EFFCEE39DFBB574F87B78021043025EFDCCADF2D2A76EE93C0BDC309C0002309C51CD57200035A7DBA2B75205A029FD8FBF705C3E78D7B1165D9CBCC4DAE1EF49009A5E477912F0A3CFD8';
wwv_flow_imp.g_varchar2_table(56) := '2A2F7B1A877FEB1741C70B11808EC02ABB1C01A82CD0AEED942C004D2FBF77C731F9C817873F09F8BA9DE3F2AEEFDC51C4D7FB76C9C0C35B00AB79749180AB2FDE223F7C099FF6EF324F5DAF4500BA12ABEB7A04A0AE3C3B7753BA00340DDDFCF919F9D8';
wwv_flow_imp.g_varchar2_table(57) := '974EACDB5B73F8BFF3453BE4B429FDEFF6EF1A80370168FB24A0F9ADBFF9ED9F9FB4041080B47C4B5F1D01283DA1C4F55910808D24C0F2E1EFED2D80B64F02BEF7299BE59A676D4B3CF92CDF1040007CCF0102E03BFFE2FE0C70A3387EEB733372CB3D8F';
wwv_flow_imp.g_varchar2_table(58) := '3D09B07EF87B1680F59E045C75E16679ED651CFEB9FEB38400E4225DE63E084099B964ABCACA13801520BFFED9A3F2D7F7CD4A0D87BF7701582B011CFED95EF68F6E8400E4675ED28E0840496928D4624D001A441FBAFBB85CF9E4CD26DFF35F1BB1C7CF';
wwv_flow_imp.g_varchar2_table(59) := '00AC65F0C86C5F3E71EF0979399FF6CFFE5F0004203BF2A23644008A8A237F311605203FA5743B2200E9D8B2F2700208C07046355F8100D49C6E8BDE10801690125E82002484CBD2430920004311557D01025075BCC39B430086334A79050290922E6B0F';
wwv_flow_imp.g_varchar2_table(60) := '2380000C2354F7FF8F00D49DEFD0EE1080A188925E800024C5CBE243082000BE470401F09DBFA93F03AC312A04A0C654EDF48400D8C92A45A508400AAA86D6E409806E5808802E7FEFBB2300BE270001F09D3F4F0094F34700940370BE3D02E07B001000';
wwv_flow_imp.g_varchar2_table(61) := 'DFF92300CAF92300CA0138DF1E01F03D000880EFFC1100E5FC1100E5009C6F8F00F81E0004C077FE088072FE08807200CEB747007C0F0002E03B7F0440397F04403900E7DB2300BE070001F09D3F02A09C3F02A01C80F3ED1100DF038000F8CE1F0150CE';
wwv_flow_imp.g_varchar2_table(62) := '1F01500EC0F9F60880EF0140007CE78F0028E78F002807E07C7B04C0F7002000BEF3470094F34700940370BE3D02E07B001000DFF92300CAF92300CA0138DF1E01F03D000880EFFC1100E5FC1100E5009C6F8F00F81E0004C077FE088072FE08807200CE';
wwv_flow_imp.g_varchar2_table(63) := 'B747007C0F0002E03B7F0440397F04403900E7DB2300BE070001F09D3F02A09C3F02A01C80F3ED1100DF038000F8CE1F0150CE1F01500EC0F9F60880EF0140007CE78F0028E78F002807E07C7B04C0F7002000BEF3470094F34700940370BE3D02E07B00';
wwv_flow_imp.g_varchar2_table(64) := '1000DFF92300CAF92300CA0138DF1E01F03D000880EFFC1100E5FC1100E5009C6F8F00F81E0004C077FE088072FE08807200CEB747007C0F0002E03B7F0440397FEB0270FEDF5F1744F0BECB6F0CBA9F9BC308200061FCACDF8D00584F30B0FEB12BFE2E';
wwv_flow_imp.g_varchar2_table(65) := '70056E0F218000200021F3137A2F02104AD0F6FD0880EDFC82AB47008211062D800020004103147833021008D0F8ED0880F10043CB4700420986DD8F00200061131476370210C6CFFADD0880F50403EB4700020106DE8E002000812314743B021084CFFC';
wwv_flow_imp.g_varchar2_table(66) := 'CD0880F908C31A4000C2F885DE8D002000A13314723F021042CFFEBD0880FD0C833A400082F005DF8C002000C14314B000021000AF825B11800A420C69010108A1177E2F028000844FD1E82B2000A3B3ABE14E04A08614037A400002E045B8D5BA005CF8';
wwv_flow_imp.g_varchar2_table(67) := '2F370451B8E79BC3EE0FDA9C9B0501F03D040880EFFCF92220E5FC11000440730411004DFAFA7B2300FA19A856C0130055FC820020009A13880068D2D7DF1B01D0CF40B5020440153F02C05B00AA038800A8E257DF1C01508F40B7000440973F4F007802';
wwv_flow_imp.g_varchar2_table(68) := 'A039810880267DFDBD1100FD0C542B400054F1F304802700AA038800A8E257DF1C01508F40B7000440973F4F007802A039810880267DFDBD1100FD0C542B400054F1F304802700AA038800A8E257DF1C01508F40B7000440973F4F007802A03981088026';
wwv_flow_imp.g_varchar2_table(69) := '7DFDBD1100FD0C542B400054F1F304802700AA038800A8E257DF1C01508F40B7000440973F4F007802A039810880267DFDBD1100FD0C542B400054F1F304802700AA038800A8E257DF1C01508F40B7000440973F4F007802A039810880267DFDBD1100FD';
wwv_flow_imp.g_varchar2_table(70) := '0C542B400054F1F304802700AA038800A8E257DF1C01508F40B7000440973F4F007802A039810880267DFDBD1100FD0C542B400054F1F304802700AA038800A8E257DF1C01508F40B7000440973F4F007802A039810880267DFDBD1100FD0C542B400054';
wwv_flow_imp.g_varchar2_table(71) := 'F1F304802700AA038800A8E257DF1C01508F40B7000440973F4F007802A039810880267DFDBD1100FD0C542B400054F1F304802700AA038800A8E257DF1C01508F40B7000440973F4F007802A039810880267DFDBD1100FD0C542B400054F1F304802700';
wwv_flow_imp.g_varchar2_table(72) := 'AA038800A8E257DF1C01508F40B7000440973F4F007802A039810880267DFDBD1100FD0C542B400054F1F304802700AA038800A8E257DF1C01508F40B700044097BFF5DD2FFC97B0DFE0EF41005447000150C5AFBE3902A01E816E0108802E7FEBBB2300';
wwv_flow_imp.g_varchar2_table(73) := 'B61344006CE7175A3D02104AD0F8FD0880F10095CB4700940308DC1E01080468FC7604C07880A1E52300A1047DDF8F00D8CE1F01B09D5F68F508402841E3F72300C603542E1F01500E20707B042010A0F1DB1100E30186968F008412F47D3F02603B7F04';
wwv_flow_imp.g_varchar2_table(74) := 'C0767EA1D52300A1048DDF8F00180F50B97C04403980C0ED11804080C66F47008C07185A3E02104AD0F7FD0880EDFC1100DBF985568F008412347E3F02603C40E5F21100E50002B7470002011ABF1D01301E6068F908402841DFF72300B6F347006CE717';
wwv_flow_imp.g_varchar2_table(75) := '5A3D02104AD0F8FD0880F10095CB4700940308DC1E01080468FC7604C07880A1E52300A1047DDF8F00D8CE1F01B09D5F68F508402841E3F72300C603542E1F01500E20707B042010A0F1DB1100E30186968F008412F47D3F02603B7F04C0767EA1D52300';
wwv_flow_imp.g_varchar2_table(76) := 'A1048DDF8F00180F50B97C04403980C0ED11804080C66F47008C07185A3E02104AD0F7FD0880EDFC1100DBF985568F008412347E3F02603C40E5F21100E50002B7470002011ABF1D01301E6068F908402841DFF72300B6F347006CE7175A3D02104AD0F8';
wwv_flow_imp.g_varchar2_table(77) := 'FD0880F10095CB4700940308DC1E01080468FC7604C07880A1E52300A1047DDF8F00D8CE1F01B09D5F68F508402841E3F72300C603542E1F01500E20707B042010A0F1DB1100E30186968F008412F47D3F02603B7F04C0767EA1D52300A1048DDF8F0018';
wwv_flow_imp.g_varchar2_table(78) := '0F50B97C04403980C0ED11804080C66F47008C07185A3E02104AB0DBFD8F2C9C90577FF10FE4FAF3AF928BA79FD8EDE602AF460044BE70F4FFE4A6FFFC84BCE7A21F96D326361798D2FA252100A6E28A5E2C02101DA9AD0511807C793587FF0FDE75B37C';
wwv_flow_imp.g_varchar2_table(79) := 'E9E843CB07C51F5EF22AF312E05D009AC3FF47EE7ABF34D93E65FA1CF9D34BAE3125010840BED77F893B210025A692B12604200FECD587FFCA8E3548806701587DF8AF646A4D0210803CAFFF527741004A4D26535D08407AD0830EFF5A24C0AB000C3AFC';
wwv_flow_imp.g_varchar2_table(80) := '2D4A000290FEF55FF20E0840C9E964A80D01480BF9D0C23179E55DBFB3FCD87FBD1FCB4F023C0AC04687BF35094000D2BEFE4B5F1D01283DA1C4F52100E9003787FF2BEEBC59EE9DD9337413AB12E04D00DA1CFE9624000118FAD2ACFA0204A0EA788737';
wwv_flow_imp.g_varchar2_table(81) := '87000C6734CA155D0E7FCB6F077812802E87BF15094000467975D7730F02504F96237582008C846DC39B4639FCAD4A80170118E5F05F2D011FBCE42764E7C4D6F8C316B822021008D0F8ED0880F10043CB470042099E7AFFD0C3BFD793B14D13D29F5B90';
wwv_flow_imp.g_varchar2_table(82) := 'FE527FE0E6CDDB017F72E9ABE5A9DBCE8D5B5C82D53C08C0B0C3BF37D693DED4842CCD2E88F407677AC1B6DDF2A14BAF294E021080042F0A434B220086C24A512A02108F6ADBC35FC67A227D91FEECFCBA12B063728B34BF35962E01B50B40ABC37FD3A4';
wwv_flow_imp.g_varchar2_table(83) := '484F4496FAE624000188F7FAB7B812026031B58835230071601E989F91ABEF7ADFFA1FF8FBEA6FFECB87FFCA4F05B7054E27000013DD494441541250B300FCFBCC8372F59DEF5BFE929F413FCBBFF9AF1CFE2B171893000420CEEBDFEA2A0880D5E422D5';
wwv_flow_imp.g_varchar2_table(84) := '8D00C401F9B13D77C8CF7FE9C383171B74F87790803FBAF85572D1F413E2141A79955A05E08B471F901FF9C2FBE5F0FCF1F6877F4B09F8CDA75E2D579E7571E424465B0E01188D5B2D772100B52439621F08C088E006DCF6870FFC93DC70EF5F9EFAFF6C';
wwv_flow_imp.g_varchar2_table(85) := '74F877908052DF0EA851009ADFFC9BEF6E18E9F0DF40027AD293B75FF85279C5B9CF8E3774812B210081008DDF8E00180F30B47C042094E0A9F79F22016D0E7FE312509B004439FC07484089877F53260210F7F56F6D3504C05A6291EB45002203159165';
wwv_flow_imp.g_varchar2_table(86) := '09B8EFE3CB9FF63FE53DFF615B19FC4C404D0210F5F05F2301375E50D66FFE8F9677FBB70F9B4AFEFF8A0920001587DBA63504A00DA5EED77C70CFE7E486AFDCDAFD466312508B002439FCBF9AFE0D4FBA525EB9FBB2EEB390E10E9E0064805CF0160840';
wwv_flow_imp.g_varchar2_table(87) := 'C1E1E4280D014847F98FF7FEB3FCE2FFDCD27D034312508300A43CFC7FE96BAF921F3AAB9CF7FCD70E2302D0FDE559D31D08404D698ED00B023002B40EB7D42E01D605C0F3E1DF8C3102D0E1C55CE1A5084085A176690901E8426BB46B534AC0872FFD49';
wwv_flow_imp.g_varchar2_table(88) := 'B960EBEED10A8B70976501F07EF82300115E00C69740008C07185A3E02104AB0DDFDA924E08CC96DCB5F1BAC2501560580C3FFE4DCF204A0DDEBB7D6AB10805A936DD91702D0125484CB6A94008B0270EFB13DF2F23BDF1BF677FEEBCC43E9EFF9AF2D1B';
wwv_flow_imp.g_varchar2_table(89) := '0188F0C236BC04026038BC18A523003128B65FA33609B02600CDE1DF7CBD6FF3D5CD837E067EBD6FCB78AD1DFE3C0168196CC59721001587DBA63504A00DA5B8D7D42401960480C3FFF173CC1380B8AF6D6BAB2100D6128B5C2F02101968CBE56A91002B';
wwv_flow_imp.g_varchar2_table(90) := '02C0E13F78301180962FD84A2F43002A0DB66D5B08405B52F1AFAB41022C080087FFFAB38B00C47F5D5B5A1101B09456825A118004503B2C695D024A17000EFF8D871101E8F062ADF05204A0C250BBB4840074A195E65ACB1250B20070F80F9F57046038';
wwv_flow_imp.g_varchar2_table(91) := 'A39AAF40006A4EB7456F08400B48192EB12A01A50A00877FBBA14500DA71AAF52A04A0D6645BF68500B40495E1328B1250A20070F8B71F5604A03DAB1AAF44006A4CB5434F08400758192E4D2501674D4DCB9F5C7A8D7CFD965D51BB284D0038FCBBC58B';
wwv_flow_imp.g_varchar2_table(92) := '0074E355DBD508406D8976EC0701E8082CC3E59624A02401F8AFE3FBE4E577BC972FF9E930A308400758155E8A0054186A979610802EB4F25D6B45024A1180E6F0BFFACE9B65EFDCD1812179FB86BFB6938A00B42555E77508409DB9B6EE0A01688D2AFB';
wwv_flow_imp.g_varchar2_table(93) := '851624A00401E0F01F7D341180D1D9D570270250438A013D200001F032DC5ABA04680B00877FD810220061FCACDF8D00584F30B07E0420106086DB4B96004D01E0F00F1F3E04209CA1E5151000CBE945A81D01880031C312BFF7F067E5EDF77FB2FB4E7D';
wwv_flow_imp.g_varchar2_table(94) := '91FEECBCF497FA03EF0DFDEB002D01E0F0EF3E0A83EE4000E270B4BA0A026035B94875230091406658A64409D010000EFF78C38600C46369712504C0626A116B460022C2CCB0546912905B0038FCE30E19021097A7B5D510006B8945AE1701880C34C372';
wwv_flow_imp.g_varchar2_table(95) := '2549404E014879F85F7FDE77C98F9EFD9C0CE995B5050250561EB9AB410072132F6C3F04A0B0405A969352023E72E94FC9795BCE6855492E01E0F06F1547E78B1080CEC8AABA0101A82ACEEECD2000DD999572472A09387BD376F9D025D7B492801C0270';
wwv_flow_imp.g_varchar2_table(96) := 'FFF103F2B23B7F3BC997FC78FDCD7F65861180525ECD3A7520003ADC8BD9150128268A910AD19680D402D01CFEAFB8EB667978F6C8403E21DFF0E7FDF06F80220023BDECAAB90901A826CAD11A410046E356D25D9A1290520038FCD34F1902909E71C93B';
wwv_flow_imp.g_varchar2_table(97) := '200025A793A136042003E40C5B6849402A01E0F0CF30343C01C803B9E05D108082C3C9511A029083729E3D342420850070F8E79917DE02C8C7B9D49D10805293C9541702900974A66D724B406C01E0F0CF34285FDD86B700F2F22E6D3704A0B44432D783';
wwv_flow_imp.g_varchar2_table(98) := '0064069E61BB9C1210530038FC330CC79A2D1080FCCC4BDA110128290D855A100005E819B6CC2501B10480C33FC3500CD80201D0E15ECAAE0840294928D581002881CFB06D0E098821001CFE1986619D2D10003DF625EC8C00949082620D088022FC0C5B';
wwv_flow_imp.g_varchar2_table(99) := 'A794808F3EE33572F9177E35A88BDB9FF633FC9D7F10C1B09B1180307ED6EF4600AC2718583F021008D0C0ED1F78F89FE41DF7FF55F74A87FC53C24FDC72BA3CD89BE9BEEEAA3BCE59DC2A0FCC1E1AB846C897FC5C7BDE8BE5C7CF7E6E506D1E6E46003C';
wwv_flow_imp.g_varchar2_table(100) := 'A4BC7E8F0880EFFC0501F03100A99E048C6D9D0A02B8746C2EFAE1CF37FCB58F040168CFAAC62B11801A53EDD01302D00196F14B5348400A0108F9CD9FC3BFDB902200DD78D5763502505BA21DFB41003A02337E796C09882D001CFE79070C01C8CBBBB4';
wwv_flow_imp.g_varchar2_table(101) := 'DD1080D212C95C0F0290197801DBC594809802C0E19F7F381080FCCC4BDA110128290D855A100005E8056C194B0262090087BFCE5020003ADC4BD91501282509A53A100025F0056C1B430262080087BFDE3020007AEC4BD81901282105C51A100045F805';
wwv_flow_imp.g_varchar2_table(102) := '6C1D22014B27E6656CCB645017FD13F3D2DB3429D2EBBE0C1FF8EBCE6CED1D08403843CB2B200096D38B503B021001A2F125DEFBD067E4DDFFFBA9EE5D2CF545C64638B957EFD4170EFFEEE4A3DD8100444369722104C0646CF18A4600E2B1B4BCD2C812';
wwv_flow_imp.g_varchar2_table(103) := 'A0D034BFF9C7838E00C46369712504C0626A116B460022C234BE940509E0F08F3B6408405C9ED6564300AC2516B95E04203250E3CB952C01AFFF9A17CA4F9EF33CE384CB2A1F01282B8FDCD52000B98917B61F02505820059453A20470F8A7190C04200D';
wwv_flow_imp.g_varchar2_table(104) := '572BAB220056924A5427029008ACF1654B92000EFF74C38400A4636B616504C0424A096B440012C235BE740912C0E19F76881080B47C4B5F1D01283DA1C4F5210089011B5F5E530238FCD30F0F02909E71C93B200025A793A13604200364E35B68480087';
wwv_flow_imp.g_varchar2_table(105) := '7F9EA14100F2702E751704A0D46432D5850064026D7C9B9C12C0E19F6F5810807CAC4BDC09012831958C35210019611BDF2A870470F8E71D1204202FEFD27643004A4B24733D084066E0C6B74B29011CFEF9870301C8CFBCA41D118092D250A805015080';
wwv_flow_imp.g_varchar2_table(106) := '6E7CCB1412C0E1AF331408800EF7527645004A4942A90E044009BCF16D634A0087BFDE3020007AEC4BD81901282105C51A100045F8C6B78E21011CFEBA438000E8F2D7DE1D01D04E40797F04403900E3DB87480087BF7EF808807E069A1520009AF40BD8';
wwv_flow_imp.g_varchar2_table(107) := '1B01282004E3258C22011CFE65848E009491835615088016F942F645000A09C278195D2480C3BF9CB0118072B2D0A80401D0A05ED09E08404161182FA58D0470F89715320250561EB9AB410072132F6C3F04A0B0408C97B3910470F897172E02505E2639';
wwv_flow_imp.g_varchar2_table(108) := '2B420072D22E702F04A0C0508C9734480238FCCB0C15012833975C552100B94817BA0F02506830C6CB5A2D011CFEE5868900949B4D8ECA10801C940BDE030128381CE3A5FDC6039F9689DE98BCF6DCCB8D77526FF90840BDD9B6E90C016843A9E26B1080';
wwv_flow_imp.g_varchar2_table(109) := '8AC3A535080C218000F81E1104C077FE8200381F00DA774D0001701DBF2000BEF347009CE74FFBBE092000BEF347007CE78F0038CF9FF67D1340007CE78F00F8CE1F01709E3FEDFB268000F8CE1F01F09D3F02E03C7FDAF74D0001F09D3F02E03B7F04C0';
wwv_flow_imp.g_varchar2_table(110) := '79FEB4EF9B0002E03B7F04C077FE0880F3FC69DF370104C077FE0880EFFC1100E7F9D3BE6F020880EFFC1100DFF92300CEF3A77DDF041000DFF92300BEF347009CE74FFBBE092000BEF347007CE78F0038CF9FF67D1340007CE78F00F8CE1F01709E3FED';
wwv_flow_imp.g_varchar2_table(111) := 'FB268000F8CE1F01F09D3F02E03C7FDAF74D0001F09D3F02E03B7F04C079FEB4EF9B0002E03B7F04C077FE0880F3FC69DF370104C077FE0880EFFC1100E7F9D3BE6F020880EFFC1100DFF98B7CDB2D323639ED9D02FD43C01D81A5F9A322FF7095BBBE69';
wwv_flow_imp.g_varchar2_table(112) := 'F831020880F369587CD6FB6572C705CE29D03E04FC11983F7CAF8C7FFE55FE1AA7E347092000CE87E1C405D7C9D627BDD83905DA87803F02C7BEF257B2F9DE1BFD354EC70800337092C0911D57CACE67BD111C1080803302873E7F936C3F7CABB3AE6977';
wwv_flow_imp.g_varchar2_table(113) := '35019E00389F873DC7B6CB39DFFD97CE29D03E04FC1178E8E3DF23BBB71EF1D7381DF30480193849E0C1FD7372C673DE2A5BCE7B214820000127048EDFFF2939F0D9B7C8B9674E39E998360711E00980F3B9680460EACCA7CB5957BCCF3909DA87801F02';
wwv_flow_imp.g_varchar2_table(114) := '7B6F7FB5CCEDBF1B01F013F9C04E1100E703D00840F3B3F39B5E27DB2EF801E734681F02F51398B9F7CFE4D0BFFDCA72A33C01A83FEF8D3A44007CE72F0F1F9C93A52511E98DCBEE17FEAE4CEEBCD03911DA8740BD04E60FDD237B3EF56322FD45191B13';
wwv_flow_imp.g_varchar2_table(115) := '39FB74DE02A837EDE19D2100C319557DC5BEC3F332BFD05FEEB1F93E805DDFF11EBE18A8EAC469CE2B81E68B7FF6FDED6BA4F9FBFFE5D7FB444F76ED98F48A83BE9BDFFB166FBBFCE47FFDF97149E0D0D105393EDB3C0238F933B5EB5239F379EF46025C';
wwv_flow_imp.g_varchar2_table(116) := '4E034DD74AA039FCF77FE6F532B7EFCE475BDCB2694C764E4FD4DA327DB5208000B48054F325C76697E4F0D185535A6C9E049C7ED92FF07640CDC1D39B1B02CD63FF839FFBE5477FF35F697CC7F4846CDD34E686038D3E9E0002E07C2A1697FAB2E7E0FC';
wwv_flow_imp.g_varchar2_table(117) := '80C918979DCFF8393E18E87C3E68DF3681E50FFCDDF16BCBEFF9AFFDD97DFAA48C8FF56C3748F541041080207C75DCBCF66D80D55D357F22387DE12BF89E803AA2A60B27049ABFF33F7ACF8796FFD46FD00F8FFF9D0CC290361100E660F94380CD870137';
wwv_flow_imp.g_varchar2_table(118) := 'FA19DFB24B369FFB3C993AEB1932B9E37C19DF7A0E9F13607620500081E6FDFDC5630FC9FCE1FB646EEF1D72E2C1CFC8E2F17D1B56D67CF8AFF910203FBE092000BEF37FB4FB23C71665E6F8E31F1382070210A88BC0B62DE3B27DEB785D4DD1CD480410';
wwv_flow_imp.g_varchar2_table(119) := '8091B0D579D3EA3F09ACB343BA82806F02FCE99FEFFCD7768F00300F8F1268DE0AD87F645EFAFC6128530181EA08F47A22676EE7D17F75C10634840004C0ABF1D6B985BE1C40026A8C969E1C13680EFF33B64FCA14EFFB3B9E82C7B78E00300E8F23D03C';
wwv_flow_imp.g_varchar2_table(120) := '09383CB3F0E8370482080210B04BA079ECBF63DB041FFAB31B61B2CA11806468ED2FCC0703ED674807BE09F0813FDFF90FEB1E011846C8F9FFDF3C0D9839B178CAD7053B4742FB10289E40F377FEDB368FF35B7FF149E9168800E8F237B37BF38D81B3F3';
wwv_flow_imp.g_varchar2_table(121) := '7D999B5F9285C5BE34FF7BF95F11E40702105025D0FCAB7ECD37FA4D8CF7646A724C364DF6F8863FD544EC6C8E00D8C98A4A21000108400002D1082000D150B210042000010840C00E0104C04E56540A0108400002108846000188869285200001084000';
wwv_flow_imp.g_varchar2_table(122) := '027608200076B2A252084000021080403402084034942C04010840000210B0430001B093159542000210800004A2114000A2A16421084000021080801D0208809DACA814021080000420108D0002100D250B41000210800004EC104000EC6445A5108000';
wwv_flow_imp.g_varchar2_table(123) := '0420008168041080682859080210800004206087000260272B2A85000420000108442380004443C942108000042000013B0410003B595129042000010840201A0104201A4A1682000420000108D8218000D8C98A4A21000108400002D1082000D150B210';
wwv_flow_imp.g_varchar2_table(124) := '042000010840C00E0104C04E56540A0108400002108846000188869285200001084000027608200076B2A252084000021080403402084034942C04010840000210B0430001B093159542000210800004A2114000A2A16421084000021080801D0208809D';
wwv_flow_imp.g_varchar2_table(125) := 'ACA814021080000420108D0002100D250B41000210800004EC104000EC6445A51080000420008168041080682859080210800004206087000260272B2A85000420000108442380004443C942108000042000013B0410003B595129042000010840201A01';
wwv_flow_imp.g_varchar2_table(126) := '04201A4A1682000420000108D8218000D8C98A4A21000108400002D1082000D150B210042000010840C00E0104C04E56540A0108400002108846000188869285200001084000027608200076B2A252084000021080403402084034942C04010840000210';
wwv_flow_imp.g_varchar2_table(127) := 'B0430001B093159542000210800004A2114000A2A16421084000021080801D0208809DACA814021080000420108D0002100D250B41000210800004EC104000EC6445A51080000420008168041080682859080210800004206087000260272B2A85000420';
wwv_flow_imp.g_varchar2_table(128) := '000108442380004443C942108000042000013B0410003B595129042000010840201A0104201A4A1682000420000108D8218000D8C98A4A21000108400002D1082000D150B210042000010840C00E0104C04E56540A010840000210884600018886928520';
wwv_flow_imp.g_varchar2_table(129) := '0001084000027608200076B2A252084000021080403402084034942C04010840000210B0430001B093159542000210800004A2114000A2A16421084000021080801D0208809DACA814021080000420108D0002100D250B41000210800004EC104000EC64';
wwv_flow_imp.g_varchar2_table(130) := '45A51080000420008168041080682859080210800004206087000260272B2A85000420000108442380004443C942108000042000013B0410003B595129042000010840201A0104201A4A1682000420000108D8218000D8C98A4A21000108400002D10820';
wwv_flow_imp.g_varchar2_table(131) := '00D150B210042000010840C00E0104C04E56540A0108400002108846000188869285200001084000027608200076B2A252084000021080403402084034942C04010840000210B0430001B093159542000210800004A2114000A2A1642108400002108080';
wwv_flow_imp.g_varchar2_table(132) := '1D0208809DACA814021080000420108D0002100D250B41000210800004EC104000EC6445A51080000420008168041080682859080210800004206087000260272B2A85000420000108442380004443C942108000042000013B0410003B59512904200001';
wwv_flow_imp.g_varchar2_table(133) := '0840201A0104201A4A1682000420000108D8218000D8C98A4A21000108400002D1082000D150B210042000010840C00E0104C04E56540A0108400002108846000188869285200001084000027608200076B2A252084000021080403402084034942C0401';
wwv_flow_imp.g_varchar2_table(134) := '0840000210B0430001B093159542000210800004A2114000A2A16421084000021080801D02FF0F9BCAD778AABE01B50000000049454E44AE426082';
wwv_flow_imp_shared.create_app_static_file(
 p_id=>wwv_flow_imp.id(571583527243296103)
,p_file_name=>'icons/app-icon-512.png'
,p_mime_type=>'image/png'
,p_file_charset=>'utf-8'
,p_file_content => wwv_flow_imp.varchar2_to_blob(wwv_flow_imp.g_varchar2_table)
);
end;
/
prompt --application/plugin_settings
begin
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(10040112905097309)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SELECT_MANY'
,p_attribute_01=>'separated'
,p_version_scn=>41609524351195
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(10040639800097311)
,p_plugin_type=>'DYNAMIC ACTION'
,p_plugin=>'NATIVE_OPEN_AI_ASSISTANT'
,p_version_scn=>41609524351195
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(10040867862097312)
,p_plugin_type=>'PROCESS TYPE'
,p_plugin=>'NATIVE_GEOCODING'
,p_attribute_01=>'RELAX_HOUSE_NUMBER'
,p_version_scn=>41609524351195
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(42176849416798944)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_STAR_RATING'
,p_attribute_01=>'fa-star'
,p_attribute_04=>'#VALUE#'
,p_version_scn=>37166093939409
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(140451393385159272)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_GEOCODED_ADDRESS'
,p_attribute_01=>'RELAX_HOUSE_NUMBER'
,p_attribute_02=>'N'
,p_attribute_03=>'POPUP:ITEM'
,p_attribute_04=>'default'
,p_attribute_06=>'LIST'
,p_version_scn=>37166093939409
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(162056090003067800)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_MAP_REGION'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'use_vector_tile_layers', 'N')).to_clob
,p_version_scn=>37166093939409
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(163820696024748835)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_DATE_PICKER_APEX'
,p_attribute_01=>'MONTH-PICKER:YEAR-PICKER'
,p_attribute_02=>'VISIBLE'
,p_attribute_03=>'15'
,p_attribute_04=>'FOCUS'
,p_version_scn=>37166093939409
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(216736034720777188)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_SINGLE_CHECKBOX'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_version_scn=>37166093939409
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(647439792887070666)
,p_plugin_type=>'WEB SOURCE TYPE'
,p_plugin=>'NATIVE_ADFBC'
,p_version_scn=>37166093939409
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1162014383559782142)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_YES_NO'
,p_attribute_01=>'Y'
,p_attribute_03=>'N'
,p_attribute_05=>'SWITCH'
,p_version_scn=>37166093939409
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1808199387925661778)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_DISPLAY_SELECTOR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'include_slider', 'N')).to_clob
,p_version_scn=>37166093939409
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1874899600599943883)
,p_plugin_type=>'REGION TYPE'
,p_plugin=>'NATIVE_IR'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'actions_menu_structure', 'IG')).to_clob
,p_version_scn=>37166093939409
);
wwv_flow_imp_shared.create_plugin_setting(
 p_id=>wwv_flow_imp.id(1960759052110889651)
,p_plugin_type=>'ITEM TYPE'
,p_plugin=>'NATIVE_COLOR_PICKER'
,p_attribute_01=>'FULL'
,p_attribute_02=>'POPUP'
,p_version_scn=>37166093939409
);
end;
/
prompt --application/shared_components/navigation/navigation_bar
begin
wwv_flow_imp_shared.create_icon_bar_item(
 p_id=>wwv_flow_imp.id(3240727804498591359)
,p_icon_sequence=>20
,p_icon_subtext=>'Help'
,p_icon_target=>'f?p=&APP_ID.:help:&SESSION.::&DEBUG.:::'
,p_nav_entry_is_feedback_yn=>'N'
,p_begins_on_new_line=>'NO'
,p_cell_colspan=>1
);
wwv_flow_imp_shared.create_icon_bar_item(
 p_id=>wwv_flow_imp.id(14835040603193770269)
,p_icon_sequence=>30
,p_icon_subtext=>'Logout'
,p_icon_target=>'&LOGOUT_URL.'
,p_icon_image_alt=>'Logout'
,p_icon_height=>32
,p_icon_width=>32
,p_icon_height2=>24
,p_icon_width2=>24
,p_nav_entry_is_feedback_yn=>'N'
,p_begins_on_new_line=>'NO'
,p_cell_colspan=>1
);
end;
/
prompt --application/shared_components/logic/application_processes/preview_blob
begin
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(28657478166313918)
,p_process_sequence=>1
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PREVIEW_BLOB'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    for file in (select * from ADMIN.MY_BOOKS WHERE ID = 222) loop',
'        --',
'        sys.htp.init;',
'        sys.owa_util.mime_header( file.FILE_TYPE, FALSE );',
'        sys.htp.p(''Content-length: '' || sys.dbms_lob.getlength( file.FILE_CONTENT));',
'        sys.htp.p(''Content-Disposition: attachment; filename="'' || file.file_name || ''"'' );',
'        sys.htp.p(''Cache-Control: max-age=3600'');  -- tell the browser to cache for one hour, adjust as necessary',
'        sys.owa_util.http_header_close;',
'       sys.wpg_docload.download_file( file.FILE_CONTENT );',
'    end loop;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_security_scheme=>'MUST_NOT_BE_PUBLIC_USER'
,p_version_scn=>41116262751454
);
end;
/
prompt --application/shared_components/logic/application_processes/trim_all_page_items
begin
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(1596087387173919564)
,p_process_sequence=>1
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Trim All Page Items'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    for c1 in (select item_name',
'               from apex_application_page_items',
'               where application_id = :APP_ID',
'                   and page_id = :APP_PAGE_ID',
'                   and display_as_code in (''NATIVE_TEXT_FIELD'',',
'                                           ''NATIVE_TEXTAREA'',',
'                                           ''NATIVE_NUMBER_FIELD'') ) loop',
'        apex_util.set_session_state( c1.item_name,',
'            regexp_replace(apex_util.get_session_state( c1.item_name ),',
'                ''^[[:space:]]*(.*?)[[:space:]]*$'', ''\1''',
'            )',
'        );',
'    end loop;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_version_scn=>37166093939409
);
end;
/
prompt --application/shared_components/logic/application_items/app_user
begin
wwv_flow_imp_shared.create_flow_item(
 p_id=>wwv_flow_imp.id(33778496601049024)
,p_name=>'APP_USER'
,p_protection_level=>'I'
,p_version_scn=>41199279082302
);
end;
/
prompt --application/shared_components/logic/application_items/last_view
begin
wwv_flow_imp_shared.create_flow_item(
 p_id=>wwv_flow_imp.id(3282224181629315126)
,p_name=>'LAST_VIEW'
,p_protection_level=>'N'
,p_version_scn=>37166093939409
);
end;
/
prompt --application/shared_components/logic/application_computations/app_user
begin
wwv_flow_imp_shared.create_flow_computation(
 p_id=>wwv_flow_imp.id(33779098460052563)
,p_computation_sequence=>10
,p_computation_item=>'APP_USER'
,p_computation_point=>'ON_NEW_INSTANCE'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation_processed=>'REPLACE_EXISTING'
,p_computation=>'&APP_USER.'
,p_version_scn=>41199279270654
);
end;
/
prompt --application/shared_components/logic/application_settings
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/standard
begin
null;
end;
/
prompt --application/shared_components/navigation/tabs/parent
begin
null;
end;
/
prompt --application/shared_components/user_interface/lovs/bucket_items
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(41138616429649405)
,p_lov_name=>'BUCKET_ITEMS'
,p_location=>'WEB_SOURCE'
,p_web_src_module_id=>wwv_flow_imp.id(41137145174628438)
,p_return_column_name=>'NAME'
,p_display_column_name=>'NAME'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
,p_version_scn=>41609524351393
);
end;
/
prompt --application/shared_components/user_interface/lovs/bucket_list
begin
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(38948881340078575)
,p_lov_name=>'BUCKET_LIST'
,p_location=>'WEB_SOURCE'
,p_web_src_module_id=>wwv_flow_imp.id(38944248231038585)
,p_return_column_name=>'NAME'
,p_display_column_name=>'NAME'
,p_default_sort_column_name=>'NAME'
,p_default_sort_direction=>'ASC'
,p_version_scn=>41609524351395
);
end;
/
prompt --application/pages/page_groups
begin
null;
end;
/
prompt --application/comments
begin
null;
end;
/
prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
wwv_flow_imp_shared.create_menu(
 p_id=>wwv_flow_imp.id(14835042392726770281)
,p_name=>' Breadcrumb'
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(1359136686169636514)
,p_short_name=>'SQL Syntax'
,p_link=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:::'
,p_page_id=>5
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(2167773507708569912)
,p_parent_id=>wwv_flow_imp.id(3281815300625264101)
,p_short_name=>'Application Theme Style'
,p_link=>'f?p=&APP_ID.:6:&SESSION.'
,p_page_id=>6
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(3281809289813225039)
,p_short_name=>'Help'
,p_link=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:::'
,p_page_id=>4
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(3281815300625264101)
,p_short_name=>'Administration'
,p_link=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:::'
,p_page_id=>7
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(3281820089328295373)
,p_parent_id=>wwv_flow_imp.id(3281815300625264101)
,p_short_name=>'Manage Sample Data'
,p_link=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:::'
,p_page_id=>10
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(3281821189966299662)
,p_parent_id=>wwv_flow_imp.id(3281815300625264101)
,p_short_name=>'Delete Files'
,p_link=>'f?p=&FLOW_ID.:11:&SESSION.'
,p_page_id=>11
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(3281846082668516912)
,p_short_name=>'File'
,p_link=>'f?p=&FLOW_ID.:12:&SESSION.'
,p_page_id=>12
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(3281856506966615314)
,p_short_name=>'Project'
,p_link=>'f?p=&FLOW_ID.:13:&SESSION.'
,p_page_id=>13
);
end;
/
prompt --application/shared_components/navigation/breadcrumbentry
begin
null;
end;
/
prompt --application/shared_components/user_interface/templates/page/drawer
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(320327565288562308)
,p_theme_id=>42
,p_name=>'Drawer'
,p_internal_name=>'DRAWER'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.modalDialog();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-Drawer-page t-PageTemplate--drawer #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Drawer" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Drawer-header">#REGION_POSITION_01#</div>',
'  <div class="t-Drawer-bodyWrapperOut">',
'    <div class="t-Drawer-bodyWrapperIn">',
'      <div class="t-Drawer-body" role="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</div>',
'    </div>',
'  </div>',
'  <div class="t-Drawer-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>11
,p_preset_template_options=>'js-dialog-class-t-Drawer--pullOutEnd'
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_js_init_code=>'apex.theme42.dialog(#PAGE_URL#,{title:#TITLE#,w:#DIALOG_WIDTH#,mxw:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,dlgCls:''t-Drawer-page--standard ''+#DIALOG_CSS_CLASSES#,#DIALOG_ATTRIBUTES#},#PAGE_CSS_CLASSES#,#TRIGGERING_ELEMENT#)'
,p_dialog_js_close_code=>'apex.theme42.dialog.close(#IS_MODAL#,#TARGET#)'
,p_dialog_js_cancel_code=>'apex.theme42.dialog.cancel(#IS_MODAL#)'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>1659739787629394056
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751005794967733237)
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751006279101733237)
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751006788933733238)
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_name=>'Dialog Footer'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/left_side_column
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(1949368791042220343)
,p_theme_id=>42
,p_name=>'Left Side Column'
,p_internal_name=>'LEFT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.leftSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft t-PageBody--hideActions no-anim t-PageTemplate--leftCol #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." title="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." id="t_Button_navControl" type="button"><span class="t-Header-'
||'controlsIcon" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'      #AFTER_LOGO#',
'    </div>',
'    <div class="t-Header-navBar">',
'      <div class="t-Header-navBar--start">#BEFORE_NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--center">#NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--end">#AFTER_NAVIGATION_BAR#</div>',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-side" id="t_Body_side">#REGION_POSITION_02#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main class="t-Body-mainContent" id="main">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" id="t_Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton" title="&"APP_TEXT$APEX.UI.BACK_TO_TOP"." aria-label="&"APP_TEXT$APEX.UI.BACK_TO_TOP"."><span class="a-Icon icon-up-chevron" aria-hidden="true"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs" id="t_Body_inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525196570560608698
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751015853244733246)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'After Logo'
,p_placeholder=>'AFTER_LOGO'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751016340971733246)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'After Navigation Bar'
,p_placeholder=>'AFTER_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751016882321733247)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'BEFORE_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751017343474733247)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751017803142733247)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751018388825733248)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751018857159733248)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'Dialogs, Drawers and Popups'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751019354069733248)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751019829115733249)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'Top Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751020334708733249)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'Banner'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751020843944733249)
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_name=>'Full Width Content'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/left_and_right_side_columns
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(1949371167155220354)
,p_theme_id=>42
,p_name=>'Left and Right Side Columns'
,p_internal_name=>'LEFT_AND_RIGHT_SIDE_COLUMNS'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.bothSideCols();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">  ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>',
'</head>',
'<body class="t-PageBody t-PageBody--showLeft no-anim t-PageTemplate--leftRightCol #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<script>(sessionStorage.getItem("ORA_WWV_apex.toggleCore.right.&APP_ID..&APP_PAGE_ID..preferenceForExpanded") === "true") ? document.getElementById(''t_PageBody'').classList.add(''js-rightExpanded'') : document.getElementById(''t_PageBody'').classList.add('
||'''js-rightCollapsed'')</script>',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." title="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." id="t_Button_navControl" type="button"><span class="t-Header-'
||'controlsIcon" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'      #AFTER_LOGO#',
'    </div>',
'    <div class="t-Header-navBar">',
'      <div class="t-Header-navBar--start">#BEFORE_NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--center">#NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--end">#AFTER_NAVIGATION_BAR#</div>',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-side" id="t_Body_side">#REGION_POSITION_02#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" id="t_Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton" title="&"APP_TEXT$APEX.UI.BACK_TO_TOP"." aria-label="&"APP_TEXT$APEX.UI.BACK_TO_TOP"."><span class="a-Icon icon-up-chevron" aria-hidden="true"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs" id="t_Body_inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525203692562657055
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751026709575733254)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'After Logo'
,p_placeholder=>'AFTER_LOGO'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751027290419733254)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'After Navigation Bar'
,p_placeholder=>'AFTER_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751027780273733255)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'BEFORE_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751028296164733255)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751028741769733255)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751029275561733256)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Left Column'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>3
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751029725648733256)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>3
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751030235545733256)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Dialogs, Drawers and Popups'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751030783675733257)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>6
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751031217672733257)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Top Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751031797920733257)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Banner'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751032257220733258)
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_name=>'Full Width Content'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>6
);
end;
/
prompt --application/shared_components/user_interface/templates/page/login
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(1949373694717220360)
,p_theme_id=>42
,p_name=>'Login'
,p_internal_name=>'LOGIN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.appLogin();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody--login t-PageTemplate--login no-anim #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#',
'<div class="t-Login-bg">',
'  #BACKGROUND_IMAGE#',
'  <div class="t-Login-bgImg"></div>',
'</div>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-container">',
'  <header class="t-Login-containerHeader">#REGION_POSITION_01#</header>',
'  <main class="t-Login-containerBody" id="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</main>',
'  <footer class="t-Login-containerFooter">#REGION_POSITION_02#</footer>',
'</div>',
''))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>6
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2099711150063350616
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751034904504733260)
,p_page_template_id=>wwv_flow_imp.id(1949373694717220360)
,p_name=>'Background Image'
,p_placeholder=>'BACKGROUND_IMAGE'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751035433426733260)
,p_page_template_id=>wwv_flow_imp.id(1949373694717220360)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751035902816733261)
,p_page_template_id=>wwv_flow_imp.id(1949373694717220360)
,p_name=>'Body Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751036471996733261)
,p_page_template_id=>wwv_flow_imp.id(1949373694717220360)
,p_name=>'Body Footer'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/master_detail
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(1949374476490220362)
,p_theme_id=>42
,p_name=>'Marquee'
,p_internal_name=>'MASTER_DETAIL'
,p_is_popup=>false
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyTableHeader#MIN#.js?v=#APEX_VERSION#',
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'))
,p_javascript_code_onload=>'apex.theme42.initializePage.masterDetail();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--masterDetail t-PageBody--hideLeft no-anim t-PageTemplate--marquee #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<script>(sessionStorage.getItem("ORA_WWV_apex.toggleCore.right.&APP_ID..&APP_PAGE_ID..preferenceForExpanded") === "true") ? document.getElementById(''t_PageBody'').classList.add(''js-rightExpanded'') : document.getElementById(''t_PageBody'').classList.add('
||'''js-rightCollapsed'')</script>',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." title="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." id="t_Button_navControl" type="button"><span class="t-Header-'
||'controlsIcon" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'      #AFTER_LOGO#',
'    </div>',
'    <div class="t-Header-navBar">',
'      <div class="t-Header-navBar--start">#BEFORE_NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--center">#NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--end">#AFTER_NAVIGATION_BAR#</div>',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-info" id="t_Body_info">#REGION_POSITION_02#</div>',
'        <div class="t-Body-contentInner" role="main">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" id="t_Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton" title="&"APP_TEXT$APEX.UI.BACK_TO_TOP"." aria-label="&"APP_TEXT$APEX.UI.BACK_TO_TOP"."><span class="a-Icon icon-up-chevron" aria-hidden="true"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs" id="t_Body_inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>1996914646461572319
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751044449187733268)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'After Logo'
,p_placeholder=>'AFTER_LOGO'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751044922080733268)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'After Navigation Bar'
,p_placeholder=>'AFTER_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751045494719733268)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'BEFORE_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751045952368733268)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751046428600733269)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751046908509733269)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Master Detail'
,p_placeholder=>'REGION_POSITION_02'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751047459500733269)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Right Side Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751047958061733270)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Dialogs, Drawers and Popups'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751048432986733270)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751048973329733270)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Top Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751049448309733271)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Banner'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751049901722733271)
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_name=>'Full Width Content'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/minimal_no_navigation
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(1949377373541220367)
,p_theme_id=>42
,p_name=>'Minimal (No Navigation)'
,p_internal_name=>'MINIMAL_NO_NAVIGATION'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#  ',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim #PAGE_CSS_CLASSES# t-PageBody--noNav t-PageTemplate--minimal" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="#EXPAND_COLLAPSE_NAV_LABEL#" title="#EXPAND_COLLAPSE_NAV_LABEL#" id="t_Button_navControl" type="button"><span class="t-Icon fa fa-bars" aria-hidden="true"'
||'></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'      #AFTER_LOGO#',
'    </div>',
'    <div class="t-Header-navBar">',
'      <div class="t-Header-navBar--start">#BEFORE_NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--center">#NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--end">#AFTER_NAVIGATION_BAR#</div>',
'    </div>',
'  </div>',
'</header>',
'    '))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" id="t_Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton" title="&"APP_TEXT$APEX.UI.BACK_TO_TOP"." aria-label="&"APP_TEXT$APEX.UI.BACK_TO_TOP"."><span class="a-Icon icon-up-chevron" aria-hidden="true"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs" id="t_Body_inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>4
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2977628563533209425
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751054999594733275)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'After Logo'
,p_placeholder=>'AFTER_LOGO'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751055591651733276)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'After Navigation Bar'
,p_placeholder=>'AFTER_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751056041683733276)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'BEFORE_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751056564395733276)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751057068846733277)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751057598240733277)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'Dialogs, Drawers and Popups'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751058048504733277)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751058545832733278)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'Top Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751059003065733278)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'Banner'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751059567286733278)
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_name=>'Full Width Content'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/page/modal_dialog
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(1949379456547220377)
,p_theme_id=>42
,p_name=>'Modal Dialog'
,p_internal_name=>'MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.modalDialog();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--standard t-PageTemplate--dialog #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'    <div class="t-Dialog-bodyWrapperIn">',
'      <div class="t-Dialog-body" role="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</div>',
'    </div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_js_init_code=>'apex.theme42.dialog(#PAGE_URL#,{title:#TITLE#,h:#DIALOG_HEIGHT#,w:#DIALOG_WIDTH#,mxw:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,dlgCls:''t-Dialog-page--standard ''+#DIALOG_CSS_CLASSES#,#DIALOG_ATTRIBUTES#},#PAGE_CSS_CLASSES#,#TRIGGERING_ELEMEN'
||'T#)'
,p_dialog_js_close_code=>'apex.theme42.dialog.close(#IS_MODAL#,#TARGET#)'
,p_dialog_js_cancel_code=>'apex.theme42.dialog.cancel(#IS_MODAL#)'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2098960803539086924
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751061885081733280)
,p_page_template_id=>wwv_flow_imp.id(1949379456547220377)
,p_name=>'Content Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751062307116733281)
,p_page_template_id=>wwv_flow_imp.id(1949379456547220377)
,p_name=>'Dialog Header'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751062852674733281)
,p_page_template_id=>wwv_flow_imp.id(1949379456547220377)
,p_name=>'Dialog Footer'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/page/right_side_column
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(1949380523915220380)
,p_theme_id=>42
,p_name=>'Right Side Column'
,p_internal_name=>'RIGHT_SIDE_COLUMN'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.rightSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8"> ',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft no-anim t-PageTemplate--rightSideCol #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<script>(sessionStorage.getItem("ORA_WWV_apex.toggleCore.right.&APP_ID..&APP_PAGE_ID..preferenceForExpanded") === "true") ? document.getElementById(''t_PageBody'').classList.add(''js-rightExpanded'') : document.getElementById(''t_PageBody'').classList.add('
||'''js-rightCollapsed'')</script>',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." title="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." id="t_Button_navControl" type="button"><span class="t-Header-'
||'controlsIcon" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'      #AFTER_LOGO#',
'    </div>',
'    <div class="t-Header-navBar">',
'      <div class="t-Header-navBar--start">#BEFORE_NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--center">#NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--end">#AFTER_NAVIGATION_BAR#</div>',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" id="t_Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton" title="&"APP_TEXT$APEX.UI.BACK_TO_TOP"." aria-label="&"APP_TEXT$APEX.UI.BACK_TO_TOP"."><span class="a-Icon icon-up-chevron" aria-hidden="true"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'  <div class="t-Body-actions" id="t_Body_actions">',
'    <button class="t-Body-actionsToggle" aria-label="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" title="#EXPAND_COLLAPSE_SIDE_COL_LABEL#" id="t_Button_rightControlButton" type="button"><span class="t-Body-actionsControlsIcon" aria-hidden="true"></span></button'
||'>',
'    <div class="t-Body-actionsContent" role="complementary">#REGION_POSITION_03#</div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs" id="t_Body_inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_sidebar_def_reg_pos=>'REGION_POSITION_03'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>17
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2525200116240651575
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751068642377733286)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'After Logo'
,p_placeholder=>'AFTER_LOGO'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751069137144733286)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'After Navigation Bar'
,p_placeholder=>'AFTER_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751069601990733287)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'BEFORE_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751070122180733287)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751070648624733287)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751071188886733288)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'Right Column'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751071656088733288)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'Dialogs, Drawers and Popups'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751072136504733288)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751072653632733289)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'Top Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751073144591733289)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'Banner'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751073644646733289)
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_name=>'Full Width Content'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>8
);
end;
/
prompt --application/shared_components/user_interface/templates/page/standard
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(1949382845217220384)
,p_theme_id=>42
,p_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_is_popup=>false
,p_javascript_code_onload=>'apex.theme42.initializePage.noSideCol();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-PageBody t-PageBody--hideLeft t-PageBody--hideActions no-anim t-PageTemplate--standard #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD# id="t_PageBody">',
'<a href="#main" id="t_Body_skipToContent">&APP_TEXT$UI_PAGE_SKIP_TO_CONTENT.</a>',
'#FORM_OPEN#',
'<header class="t-Header" id="t_Header" role="banner">',
'  #REGION_POSITION_07#',
'  <div class="t-Header-branding">',
'    <div class="t-Header-controls">',
'      <button class="t-Button t-Button--icon t-Button--header t-Button--headerTree" aria-label="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." title="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL"." id="t_Button_navControl" type="button"><span class="t-Header-'
||'controlsIcon" aria-hidden="true"></span></button>',
'    </div>',
'    <div class="t-Header-logo">',
'      <a href="#HOME_LINK#" class="t-Header-logo-link">#LOGO#</a>',
'      #AFTER_LOGO#',
'    </div>',
'    <div class="t-Header-navBar">',
'      <div class="t-Header-navBar--start">#BEFORE_NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--center">#NAVIGATION_BAR#</div>',
'      <div class="t-Header-navBar--end">#AFTER_NAVIGATION_BAR#</div>',
'    </div>',
'  </div>',
'  <div class="t-Header-nav">#TOP_GLOBAL_NAVIGATION_LIST##REGION_POSITION_06#</div>',
'</header>',
''))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body">',
'  #SIDE_GLOBAL_NAVIGATION_LIST#',
'  <div class="t-Body-main">',
'    <div class="t-Body-title" id="t_Body_title">#REGION_POSITION_01#</div>',
'    <div class="t-Body-content" id="t_Body_content">',
'      <main id="main" class="t-Body-mainContent">',
'        #SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION#',
'        <div class="t-Body-fullContent">#REGION_POSITION_08#</div>',
'        <div class="t-Body-contentInner">#BODY#</div>',
'      </main>',
'      <footer class="t-Footer" id="t_Footer" role="contentinfo">',
'        <div class="t-Footer-body">',
'          <div class="t-Footer-content">#REGION_POSITION_05#</div>',
'          <div class="t-Footer-apex">',
'            <div class="t-Footer-version">#APP_VERSION#</div>',
'            <div class="t-Footer-customize">#CUSTOMIZE#</div>',
'            #BUILT_WITH_LOVE_USING_APEX#',
'          </div>',
'        </div>',
'        <div class="t-Footer-top">',
'          <a href="#top" class="t-Footer-topButton" id="t_Footer_topButton" title="&"APP_TEXT$APEX.UI.BACK_TO_TOP"." aria-label="&"APP_TEXT$APEX.UI.BACK_TO_TOP"."><span class="a-Icon icon-up-chevron" aria-hidden="true"></span></a>',
'        </div>',
'      </footer>',
'    </div>',
'  </div>',
'</div>',
'<div class="t-Body-inlineDialogs" id="t_Body_inlineDialogs">#REGION_POSITION_04#</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>',
''))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_navigation_bar=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-NavigationBar t-NavigationBar--classic" data-mode="classic">',
'  <li class="t-NavigationBar-item">',
'    <span class="t-Button t-Button--icon t-Button--noUI t-Button--header t-Button--navBar t-Button--headerUser">',
'      <span class="t-Icon a-Icon icon-user"></span>',
'      <span class="t-Button-label">&APP_USER.</span>',
'    </span>',
'  </li>#BAR_BODY#',
'</ul>'))
,p_navbar_entry=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item">',
'  <a class="t-Button t-Button--icon t-Button--header" href="#LINK#">',
'    <span class="t-Icon #IMAGE#"></span>',
'    <span class="t-Button-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_breadcrumb_def_reg_pos=>'REGION_POSITION_01'
,p_theme_class_id=>1
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>4070909157481059304
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751078717271733294)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'After Logo'
,p_placeholder=>'AFTER_LOGO'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751079262708733294)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'After Navigation Bar'
,p_placeholder=>'AFTER_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751079767812733294)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'Before Navigation Bar'
,p_placeholder=>'BEFORE_NAVIGATION_BAR'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
,p_max_fixed_grid_columns=>4
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751080210513733295)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751080729393733295)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'Breadcrumb Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751081244472733295)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'Dialogs, Drawers and Popups'
,p_placeholder=>'REGION_POSITION_04'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751081713939733296)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'Footer'
,p_placeholder=>'REGION_POSITION_05'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751082249767733296)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'Top Navigation'
,p_placeholder=>'REGION_POSITION_06'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751082716756733296)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'Banner'
,p_placeholder=>'REGION_POSITION_07'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751083266182733297)
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_name=>'Full Width Content'
,p_placeholder=>'REGION_POSITION_08'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/page/wizard_modal_dialog
begin
wwv_flow_imp_shared.create_template(
 p_id=>wwv_flow_imp.id(1949384785685220388)
,p_theme_id=>42
,p_name=>'Wizard Modal Dialog'
,p_internal_name=>'WIZARD_MODAL_DIALOG'
,p_is_popup=>true
,p_javascript_code_onload=>'apex.theme42.initializePage.wizardModal();'
,p_header_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html class="no-js #RTL_CLASS# page-&APP_PAGE_ID. app-&APP_ALIAS." lang="&BROWSER_LANGUAGE." #TEXT_DIRECTION#>',
'<head>',
'  <meta http-equiv="x-ua-compatible" content="IE=edge" />',
'  <meta charset="utf-8">',
'  <title>#TITLE#</title>',
'  #APEX_CSS#',
'  #THEME_CSS#',
'  #TEMPLATE_CSS#',
'  #THEME_STYLE_CSS#',
'  #APPLICATION_CSS#',
'  #PAGE_CSS#',
'  #FAVICONS#',
'  #HEAD#',
'  <meta name="viewport" content="width=device-width, initial-scale=1.0" />',
'</head>',
'<body class="t-Dialog-page t-Dialog-page--wizard t-PageTemplate--wizard #DIALOG_CSS_CLASSES# #PAGE_CSS_CLASSES#" #TEXT_DIRECTION# #ONLOAD#>',
'#FORM_OPEN#'))
,p_box=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Dialog" role="dialog" aria-label="#TITLE#">',
'  <div class="t-Dialog-header">#REGION_POSITION_01#</div>',
'  <div class="t-Dialog-bodyWrapperOut">',
'    <div class="t-Dialog-bodyWrapperIn">',
'      <div class="t-Dialog-body" role="main">#SUCCESS_MESSAGE##NOTIFICATION_MESSAGE##GLOBAL_NOTIFICATION##BODY#</div>',
'    </div>',
'  </div>',
'  <div class="t-Dialog-footer">#REGION_POSITION_03#</div>',
'</div>'))
,p_footer_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#FORM_CLOSE#',
'#DEVELOPER_TOOLBAR#',
'#APEX_JAVASCRIPT#',
'#GENERATED_CSS#',
'#THEME_JAVASCRIPT#',
'#TEMPLATE_JAVASCRIPT#',
'#APPLICATION_JAVASCRIPT#',
'#PAGE_JAVASCRIPT#  ',
'#GENERATED_JAVASCRIPT#',
'</body>',
'</html>'))
,p_success_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--success t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Success">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-header">',
'          <h2 class="t-Alert-title" role="alert">#SUCCESS_MESSAGE#</h2>',
'        </div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Success'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_notification_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-alert">',
'  <div class="t-Alert t-Alert--defaultIcons t-Alert--warning t-Alert--horizontal t-Alert--page t-Alert--colorBG" id="t_Alert_Notification" role="alert">',
'    <div class="t-Alert-wrap">',
'      <div class="t-Alert-icon">',
'        <span class="t-Icon"></span>',
'      </div>',
'      <div class="t-Alert-content">',
'        <div class="t-Alert-body">#MESSAGE#</div>',
'      </div>',
'      <div class="t-Alert-buttons">',
'        <button class="t-Button t-Button--noUI t-Button--icon t-Button--closeAlert" onclick="apex.jQuery(''#t_Alert_Notification'').remove();" type="button" title="#CLOSE_NOTIFICATION#"><span class="t-Icon icon-close"></span></button>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_region_table_cattributes=>' summary="" cellpadding="0" border="0" cellspacing="0" width="100%"'
,p_theme_class_id=>3
,p_error_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--danger t-Alert--wizard t-Alert--defaultIcons">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-body">',
'        <h1 class="t-Alert-errorTitle">#MESSAGE#</h1>',
'        <p>#ADDITIONAL_INFO#</p>',
'        <div class="t-Alert-inset">#TECHNICAL_INFO#</div>',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      <button onclick="#BACK_LINK#" class="t-Button t-Button--hot w50p t-Button--large" type="button">#OK#</button>',
'    </div>',
'  </div>',
'</div>'))
,p_grid_type=>'FIXED'
,p_grid_max_columns=>12
,p_grid_always_use_max_columns=>true
,p_grid_has_column_span=>true
,p_grid_always_emit=>true
,p_grid_emit_empty_leading_cols=>true
,p_grid_emit_empty_trail_cols=>false
,p_grid_default_label_col_span=>2
,p_grid_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="container">',
'#ROWS#',
'</div>'))
,p_grid_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="row #CSS_CLASSES#">',
'#COLUMNS#',
'</div>'))
,p_grid_column_template=>'<div class="col col-#COLUMN_SPAN_NUMBER# #CSS_CLASSES# #FIRST_LAST_COLUMN_ATTRIBUTES#" #ATTRIBUTES#>#CONTENT#</div>'
,p_grid_first_column_attributes=>'col-start'
,p_grid_last_column_attributes=>'col-end'
,p_dialog_js_init_code=>'apex.theme42.dialog(#PAGE_URL#,{title:#TITLE#,h:#DIALOG_HEIGHT#,w:#DIALOG_WIDTH#,mxw:#DIALOG_MAX_WIDTH#,modal:#IS_MODAL#,dialog:#DIALOG#,dlgCls:''t-Dialog-page--wizard ''+#DIALOG_CSS_CLASSES#,#DIALOG_ATTRIBUTES#},#PAGE_CSS_CLASSES#,#TRIGGERING_ELEMENT#'
||')'
,p_dialog_js_close_code=>'apex.theme42.dialog.close(#IS_MODAL#,#TARGET#)'
,p_dialog_js_cancel_code=>'apex.theme42.dialog.cancel(#IS_MODAL#)'
,p_dialog_height=>'auto'
,p_dialog_width=>'720'
,p_dialog_max_width=>'960'
,p_dialog_browser_frame=>'MODAL'
,p_reference_id=>2120348229686426515
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751085562314733299)
,p_page_template_id=>wwv_flow_imp.id(1949384785685220388)
,p_name=>'Wizard Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751086057487733299)
,p_page_template_id=>wwv_flow_imp.id(1949384785685220388)
,p_name=>'Wizard Progress Bar'
,p_placeholder=>'REGION_POSITION_01'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_page_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751086562592733299)
,p_page_template_id=>wwv_flow_imp.id(1949384785685220388)
,p_name=>'Wizard Buttons'
,p_placeholder=>'REGION_POSITION_03'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/button/icon
begin
wwv_flow_imp_shared.create_button_templates(
 p_id=>wwv_flow_imp.id(1949426445798220509)
,p_template_name=>'Icon'
,p_internal_name=>'ICON'
,p_template=>'<button class="t-Button t-Button--noLabel  t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL!ATTR#" aria-label="#LABEL!ATTR#"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidd'
||'en="true"></span></button>'
,p_hot_template=>'<button class="t-Button t-Button--noLabel t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#" title="#LABEL!ATTR#" aria-label="#LABEL!ATTR#"><span class="t-Icon #ICON_CSS_CLASSE'
||'S#" aria-hidden="true"></span></button>'
,p_reference_id=>2347660919680321258
,p_translate_this_template=>'N'
,p_theme_class_id=>5
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/button/text_with_icon
begin
wwv_flow_imp_shared.create_button_templates(
 p_id=>wwv_flow_imp.id(1949426512066220512)
,p_template_name=>'Text with Icon'
,p_internal_name=>'TEXT_WITH_ICON'
,p_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES#" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-label">#LABEL#'
||'</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_hot_template=>'<button class="t-Button t-Button--icon #BUTTON_CSS_CLASSES# t-Button--hot" #BUTTON_ATTRIBUTES# onclick="#JAVASCRIPT#" type="button" id="#BUTTON_ID#"><span class="t-Icon t-Icon--left #ICON_CSS_CLASSES#" aria-hidden="true"></span><span class="t-Button-'
||'label">#LABEL#</span><span class="t-Icon t-Icon--right #ICON_CSS_CLASSES#" aria-hidden="true"></span></button>'
,p_reference_id=>2081382742158699622
,p_translate_this_template=>'N'
,p_theme_class_id=>4
,p_preset_template_options=>'t-Button--iconLeft'
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/button/text
begin
wwv_flow_imp_shared.create_button_templates(
 p_id=>wwv_flow_imp.id(1949427006011220515)
,p_template_name=>'Text'
,p_internal_name=>'TEXT'
,p_template=>'<button onclick="#JAVASCRIPT#" class="t-Button #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_hot_template=>'<button onclick="#JAVASCRIPT#" class="t-Button t-Button--hot #BUTTON_CSS_CLASSES#" type="button" #BUTTON_ATTRIBUTES# id="#BUTTON_ID#"><span class="t-Button-label">#LABEL#</span></button>'
,p_reference_id=>4070916158035059322
,p_translate_this_template=>'N'
,p_theme_class_id=>1
,p_theme_id=>42
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_popup
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(177545551280341897)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#" class="t-DialogRegion #REGION_CSS_CLASSES# js-regionPopup" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES# style="display:none" title="#TITLE!ATTR#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY##SUB_REGIONS#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Popup'
,p_internal_name=>'INLINE_POPUP'
,p_theme_id=>42
,p_theme_class_id=>24
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>1483922538999385230
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751235292613733428)
,p_plug_template_id=>wwv_flow_imp.id(177545551280341897)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751235778403733428)
,p_plug_template_id=>wwv_flow_imp.id(177545551280341897)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751236237362733428)
,p_plug_template_id=>wwv_flow_imp.id(177545551280341897)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751236770696733429)
,p_plug_template_id=>wwv_flow_imp.id(177545551280341897)
,p_name=>'Delete'
,p_placeholder=>'DELETE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751237286790733429)
,p_plug_template_id=>wwv_flow_imp.id(177545551280341897)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751237722943733430)
,p_plug_template_id=>wwv_flow_imp.id(177545551280341897)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751238287292733430)
,p_plug_template_id=>wwv_flow_imp.id(177545551280341897)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751238764822733430)
,p_plug_template_id=>wwv_flow_imp.id(177545551280341897)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_drawer
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(320524020049562112)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'  <div id="#REGION_STATIC_ID#" class="t-DrawerRegion js-dialog-class-ui-dialog--drawer #REGION_CSS_CLASSES# js-regionDialog" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES# style="display:none" title="#TITLE!ATTR#">',
'    <div class="t-DrawerRegion-wrap">',
'      <div class="t-DrawerRegion-bodyWrapperOut">',
'        <div class="t-DrawerRegion-bodyWrapperIn">',
'          <div class="t-DrawerRegion-body">#BODY##SUB_REGIONS#</div>',
'        </div>',
'      </div>',
'      <div class="t-DrawerRegion-buttons">',
'        <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'          <div class="t-ButtonRegion-wrap">',
'            <div class="t-ButtonRegion-col t-ButtonRegion-col--left">',
'              <div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div>',
'            </div>',
'            <div class="t-ButtonRegion-col t-ButtonRegion-col--right">',
'              <div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div>',
'            </div>',
'          </div>',
'        </div>',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Inline Drawer'
,p_internal_name=>'INLINE_DRAWER'
,p_theme_id=>42
,p_theme_class_id=>24
,p_default_template_options=>'js-modal'
,p_preset_template_options=>'js-dialog-class-t-Drawer--pullOutEnd'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>1659526333647509386
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751222973547733417)
,p_plug_template_id=>wwv_flow_imp.id(320524020049562112)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751223458956733417)
,p_plug_template_id=>wwv_flow_imp.id(320524020049562112)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751223939002733417)
,p_plug_template_id=>wwv_flow_imp.id(320524020049562112)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751224400709733418)
,p_plug_template_id=>wwv_flow_imp.id(320524020049562112)
,p_name=>'Delete'
,p_placeholder=>'DELETE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751224938748733418)
,p_plug_template_id=>wwv_flow_imp.id(320524020049562112)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751225454567733418)
,p_plug_template_id=>wwv_flow_imp.id(320524020049562112)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751225908587733419)
,p_plug_template_id=>wwv_flow_imp.id(320524020049562112)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751226418877733419)
,p_plug_template_id=>wwv_flow_imp.id(320524020049562112)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/search_results_container
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(454632904047587607)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ResultsRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-ResultsRegion-search">#SEARCH_FIELD#</div>',
'  #BODY#',
'  #SUB_REGIONS#',
'</div>',
''))
,p_page_plug_template_name=>'Search Results Container'
,p_internal_name=>'SEARCH_RESULTS_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>11
,p_default_template_options=>'u-colors'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_reference_id=>1554292095258992441
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751265331715733456)
,p_plug_template_id=>wwv_flow_imp.id(454632904047587607)
,p_name=>'Search Results'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751265877057733457)
,p_plug_template_id=>wwv_flow_imp.id(454632904047587607)
,p_name=>'Search Field'
,p_placeholder=>'SEARCH_FIELD'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751266398323733457)
,p_plug_template_id=>wwv_flow_imp.id(454632904047587607)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/item_container
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(454637287460587610)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ItemContainer #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-ItemContainer-start">#BUTTON_START#</div>',
'  <div class="t-ItemContainer-item">#BODY#</div>',
'  <div class="t-ItemContainer-end">#BUTTON_END#</div>',
'</div>'))
,p_page_plug_template_name=>'Item Container'
,p_internal_name=>'ITEM_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>21
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>1568547778806319863
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751252729054733445)
,p_plug_template_id=>wwv_flow_imp.id(454637287460587610)
,p_name=>'Item'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751253239030733445)
,p_plug_template_id=>wwv_flow_imp.id(454637287460587610)
,p_name=>'Button End'
,p_placeholder=>'BUTTON_END'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751253768957733446)
,p_plug_template_id=>wwv_flow_imp.id(454637287460587610)
,p_name=>'Button Start'
,p_placeholder=>'BUTTON_START'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/image
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(564007704899923465)
,p_layout=>'TABLE'
,p_template=>'<div id="#REGION_STATIC_ID#" class="t-ImageRegion #REGION_CSS_CLASSES#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#><img src="#REGION_IMAGE_URL#" alt="#REGION_IMAGE_ALT_TEXT#" #REGION_IMAGE_ATTRIBUTES# /></div>'
,p_page_plug_template_name=>'Image'
,p_internal_name=>'IMAGE'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-ImageRegion--auto:t-ImageRegion--cover:t-ImageRegion--square:t-ImageRegion--noFilter'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>1673953645642781634
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751196067470733393)
,p_plug_template_id=>wwv_flow_imp.id(564007704899923465)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>false
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751196536629733393)
,p_plug_template_id=>wwv_flow_imp.id(564007704899923465)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>false
);
end;
/
prompt --application/shared_components/user_interface/templates/region/cards_container
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(744548518493827048)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-CardsRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-Region-orderBy">#ORDER_BY_ITEM#</div>',
'  #BODY#',
'  #SUB_REGIONS#',
'</div>'))
,p_page_plug_template_name=>'Cards Container'
,p_internal_name=>'CARDS_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>21
,p_default_template_options=>'u-colors'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_reference_id=>2071277712695139743
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751120511664733329)
,p_plug_template_id=>wwv_flow_imp.id(744548518493827048)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751121058373733329)
,p_plug_template_id=>wwv_flow_imp.id(744548518493827048)
,p_name=>'Sort Order'
,p_placeholder=>'ORDER_BY_ITEM'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751121549748733329)
,p_plug_template_id=>wwv_flow_imp.id(744548518493827048)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/content_block
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1165299980216731287)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ContentBlock #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-ContentBlock-header">',
'    <div class="t-ContentBlock-headerItems t-ContentBlock-headerItems--title">',
'      <span class="t-ContentBlock-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'      <h2 class="t-ContentBlock-title" id="#REGION_STATIC_ID#_heading" data-apex-heading>#TITLE#</h2>',
'      #EDIT#',
'    </div>',
'    <div class="t-ContentBlock-headerItems t-ContentBlock-headerItems--buttons">#CHANGE#</div>',
'  </div>',
'  <div class="t-ContentBlock-body">#BODY##SUB_REGIONS#</div>',
'  <div class="t-ContentBlock-buttons">#PREVIOUS##NEXT#</div>',
'</div>',
''))
,p_page_plug_template_name=>'Content Block'
,p_internal_name=>'CONTENT_BLOCK'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-ContentBlock--h1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_region_title_dom_id=>'#REGION_STATIC_ID#_heading'
,p_reference_id=>2320668864738842174
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751177824921733377)
,p_plug_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751178321634733377)
,p_plug_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_name=>'Change'
,p_placeholder=>'CHANGE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751178843502733378)
,p_plug_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751179305025733378)
,p_plug_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751179838040733378)
,p_plug_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751180380226733379)
,p_plug_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/alert
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949385916556220392)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title" id="#REGION_STATIC_ID#_heading" data-apex-heading>#TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">#BODY##SUB_REGIONS#</div>',
'    </div>',
'    <div class="t-Alert-buttons">#PREVIOUS##CLOSE##CREATE##NEXT#</div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Alert'
,p_internal_name=>'ALERT'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>21
,p_preset_template_options=>'t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_reference_id=>2039236646100190748
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751090336743733303)
,p_plug_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751090893037733304)
,p_plug_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751091380270733304)
,p_plug_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751091866323733304)
,p_plug_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751092314944733304)
,p_plug_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751092888107733305)
,p_plug_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949388027252220400)
,p_layout=>'TABLE'
,p_template=>'<div id="#REGION_STATIC_ID#" class="#REGION_CSS_CLASSES#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>#PREVIOUS##BODY##SUB_REGIONS##NEXT#</div>'
,p_page_plug_template_name=>'Blank with Attributes'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>4499993862448380551
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751102031329733314)
,p_plug_template_id=>wwv_flow_imp.id(1949388027252220400)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751102533934733314)
,p_plug_template_id=>wwv_flow_imp.id(1949388027252220400)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751103008464733314)
,p_plug_template_id=>wwv_flow_imp.id(1949388027252220400)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751103528058733315)
,p_plug_template_id=>wwv_flow_imp.id(1949388027252220400)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/buttons_container
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949388267286220402)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ButtonRegion t-Form--floatLeft #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-ButtonRegion-wrap">',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##CLOSE##DELETE#</div></div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--content">',
'      #BODY#',
'      <div class="t-ButtonRegion-buttons">#CHANGE#</div>',
'      #SUB_REGIONS#',
'    </div>',
'    <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'  </div>',
'</div>'))
,p_page_plug_template_name=>'Buttons Container'
,p_internal_name=>'BUTTONS_CONTAINER'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>17
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_reference_id=>2124982336649579661
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751111857704733322)
,p_plug_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751112340063733322)
,p_plug_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_name=>'Change'
,p_placeholder=>'CHANGE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751112828657733322)
,p_plug_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751113305964733323)
,p_plug_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751113836556733323)
,p_plug_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_name=>'Delete'
,p_placeholder=>'DELETE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751114325577733323)
,p_plug_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751114812217733324)
,p_plug_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751115360934733324)
,p_plug_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751115870533733324)
,p_plug_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/carousel_container
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949389921510220408)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--carousel #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-Region-header">',
'    <div class="t-Region-headerItems t-Region-headerItems--title">',
'      <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'      <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading" data-apex-heading>#TITLE#</h2>',
'    </div>',
'    <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
'  </div>',
'  <div role="region" aria-label="#TITLE#" class="t-Region-bodyWrap">',
'    <div class="t-Region-buttons t-Region-buttons--top">',
'      <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'      <div class="t-Region-buttons-right">#NEXT#</div>',
'    </div>',
'    <div class="t-Region-body">',
'      #BODY#',
'      <div class="t-Region-carouselRegions">#SUB_REGIONS#</div>',
'    </div>',
'    <div class="t-Region-buttons t-Region-buttons--bottom">',
'      <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'      <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'    </div>',
'  </div>',
'</div>'))
,p_sub_plug_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div data-label="#SUB_REGION_TITLE#" id="SR_#SUB_REGION_ID#">',
'  #SUB_REGION#',
'</div>'))
,p_page_plug_template_name=>'Carousel Container'
,p_internal_name=>'CAROUSEL_CONTAINER'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#',
'#APEX_FILES#plugins/com.oracle.apex.carousel/1.1/com.oracle.apex.carousel#MIN#.js?v=#APEX_VERSION#'))
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-Region--showCarouselControls'
,p_preset_template_options=>'t-Region--hiddenOverflow'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_reference_id=>2865840475322558786
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751128817602733335)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751129350484733336)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Change'
,p_placeholder=>'CHANGE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751129837300733336)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751130380870733336)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Copy'
,p_placeholder=>'COPY'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751130829191733337)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751131397307733337)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Delete'
,p_placeholder=>'DELETE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751131801255733337)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751132390646733338)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Help'
,p_placeholder=>'HELP'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751132883328733338)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751133393584733338)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751133803856733339)
,p_plug_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_name=>'Slides'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/hero
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949394124666220412)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-HeroRegion #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-HeroRegion-top">',
'    <div class="t-HeroRegion-wrap">',
'      <div class="t-HeroRegion-col t-HeroRegion-col--beforeIcon">#UP#</div>',
'      <div class="t-HeroRegion-col t-HeroRegion-col--left">#REGION_IMAGE#<span class="t-HeroRegion-icon t-Icon #ICON_CSS_CLASSES#"></span></div>',
'      <div class="t-HeroRegion-col t-HeroRegion-col--content">',
'        <h1 id="#REGION_STATIC_ID#_heading" class="t-HeroRegion-title" data-apex-heading>#TITLE#</h1>',
'        #BODY#',
'      </div>',
'      <div class="t-HeroRegion-col t-HeroRegion-col--right"><div class="t-HeroRegion-form">#SUB_REGIONS#</div><div class="t-HeroRegion-buttons">#NEXT#</div></div>',
'    </div>',
'  </div>',
'  <div class="t-HeroRegion-bottom">#SMART_FILTERS#</div>',
'</div>',
''))
,p_page_plug_template_name=>'Hero'
,p_internal_name=>'HERO'
,p_image_template=>'<img class="t-HeroRegion-icon" src="#REGION_IMAGE_URL#" alt="" />'
,p_theme_id=>42
,p_theme_class_id=>22
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_region_title_dom_id=>'#REGION_STATIC_ID#_heading'
,p_reference_id=>2672571031438297268
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751188561824733386)
,p_plug_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751189023247733387)
,p_plug_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751189552491733387)
,p_plug_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_name=>'Search Field and Smart Filters'
,p_placeholder=>'SMART_FILTERS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751190041938733388)
,p_plug_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751190572800733388)
,p_plug_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_name=>'Up'
,p_placeholder=>'UP'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>false
);
end;
/
prompt --application/shared_components/user_interface/templates/region/collapsible
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949394665889220415)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region t-Region--hideShow #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" data-region-id="#REGION_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--controls"><span class="t-Button t-Button--icon t-Button--hideShow"><span class="a-Icon _a-Collapsible-icon" aria-hidden="true"></span></span></div>',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <h2 id="#REGION_STATIC_ID#_heading" class="t-Region-title" data-apex-heading><button class="t-Region-titleButton" type="button">#TITLE#</button></h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#EDIT#</div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#CLOSE#</div>',
'    <div class="t-Region-buttons-right">#CREATE#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     <div class="t-Region-orderBy">#ORDER_BY_ITEM#</div>',
'     #COPY#',
'     #BODY#',
'     #SUB_REGIONS#',
'     #CHANGE#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
' </div>',
'</div>',
'<script>',
'    (() => {',
'        const region = document.getElementById(''#REGION_STATIC_ID#'').classList;',
'        const pref = sessionStorage.getItem(''ORA_WWV_apex.toggleCore.a_Collapsible_#REGION_ID#.&APP_ID..&APP_PAGE_ID..preferenceForExpanded'');',
'        if (region.contains(''js-useLocalStorage'')) { region.toggle(''is-collapsed'', pref === ''false'' || region.contains(''is-collapsed'')); }',
'    })();',
'</script>'))
,p_page_plug_template_name=>'Collapsible'
,p_internal_name=>'COLLAPSIBLE'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>1
,p_preset_template_options=>'is-expanded:t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_region_title_dom_id=>'#REGION_STATIC_ID#_heading'
,p_reference_id=>2662888092628347716
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751152745878733356)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751153234187733356)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Change'
,p_placeholder=>'CHANGE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751153705079733357)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751154282269733357)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Copy'
,p_placeholder=>'COPY'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751154753641733357)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751155288159733358)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751155788757733358)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751156204750733358)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Sort Order'
,p_placeholder=>'ORDER_BY_ITEM'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751156738546733359)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751157216223733359)
,p_plug_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/interactive_report
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949397075503220418)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES# class="t-IRR-region #REGION_CSS_CLASSES#">',
'    <div class="t-Region-orderBy">#ORDER_BY_ITEM#</div>',
'    #PREVIOUS#',
'    #BODY#',
'    #SUB_REGIONS#',
'    #NEXT#',
'</div>',
''))
,p_page_plug_template_name=>'Interactive Report'
,p_internal_name=>'INTERACTIVE_REPORT'
,p_theme_id=>42
,p_theme_class_id=>9
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_reference_id=>2099079838218790610
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751248188269733440)
,p_plug_template_id=>wwv_flow_imp.id(1949397075503220418)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751248684201733440)
,p_plug_template_id=>wwv_flow_imp.id(1949397075503220418)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751249108294733441)
,p_plug_template_id=>wwv_flow_imp.id(1949397075503220418)
,p_name=>'Sort Order'
,p_placeholder=>'ORDER_BY_ITEM'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751249607575733441)
,p_plug_template_id=>wwv_flow_imp.id(1949397075503220418)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751250112632733442)
,p_plug_template_id=>wwv_flow_imp.id(1949397075503220418)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/login
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949397421054220421)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Login-region t-Form--stretchInputs t-Form--labelsAbove #REGION_CSS_CLASSES#" id="#REGION_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-Login-header">',
'    #REGION_IMAGE#',
'    <span class="t-Login-logo #ICON_CSS_CLASSES#" aria-hidden="true"></span>',
'    <h2 class="t-Login-title" id="#REGION_STATIC_ID#_heading" data-apex-heading>#TITLE#</h2>',
'  </div>',
'  <div class="t-Login-body">#BODY#</div>',
'  <div class="t-Login-buttons">#NEXT#</div>',
'  <div class="t-Login-links">#EDIT##CREATE#</div>',
'  <div class="t-Login-subRegions">#SUB_REGIONS#</div>',
'</div>'))
,p_page_plug_template_name=>'Login'
,p_internal_name=>'LOGIN'
,p_image_template=>'<img class="t-Login-logo" src="#REGION_IMAGE_URL#" alt="" data-app-icon />'
,p_theme_id=>42
,p_theme_class_id=>23
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_region_title_dom_id=>'#REGION_STATIC_ID#_heading'
,p_reference_id=>2672711194551076376
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751259592664733451)
,p_plug_template_id=>wwv_flow_imp.id(1949397421054220421)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751260000794733452)
,p_plug_template_id=>wwv_flow_imp.id(1949397421054220421)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751260518603733452)
,p_plug_template_id=>wwv_flow_imp.id(1949397421054220421)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751261077807733453)
,p_plug_template_id=>wwv_flow_imp.id(1949397421054220421)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751261519816733453)
,p_plug_template_id=>wwv_flow_imp.id(1949397421054220421)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/inline_dialog
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949397932973220424)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#_parent">',
'<div id="#REGION_STATIC_ID#" class="t-DialogRegion #REGION_CSS_CLASSES# js-regionDialog" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES# style="display:none" title="#TITLE!ATTR#">',
'  <div class="t-DialogRegion-wrap">',
'    <div class="t-DialogRegion-bodyWrapperOut"><div class="t-DialogRegion-bodyWrapperIn"><div class="t-DialogRegion-body">#BODY##SUB_REGIONS#</div></div></div>',
'    <div class="t-DialogRegion-buttons">',
'       <div class="t-ButtonRegion t-ButtonRegion--dialogRegion">',
'         <div class="t-ButtonRegion-wrap">',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--left"><div class="t-ButtonRegion-buttons">#PREVIOUS##DELETE##CLOSE#</div></div>',
'           <div class="t-ButtonRegion-col t-ButtonRegion-col--right"><div class="t-ButtonRegion-buttons">#EDIT##CREATE##NEXT#</div></div>',
'         </div>',
'       </div>',
'    </div>',
'  </div>',
'</div>',
'</div>'))
,p_page_plug_template_name=>'Inline Dialog'
,p_internal_name=>'INLINE_DIALOG'
,p_theme_id=>42
,p_theme_class_id=>24
,p_default_template_options=>'js-modal:js-draggable:js-resizable'
,p_preset_template_options=>'js-dialog-size600x400'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>2671226943886536762
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751211644743733407)
,p_plug_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751212125300733408)
,p_plug_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751212665485733408)
,p_plug_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751213105841733408)
,p_plug_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_name=>'Delete'
,p_placeholder=>'DELETE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751213648085733409)
,p_plug_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751214101227733409)
,p_plug_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751214652268733409)
,p_plug_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751215159804733410)
,p_plug_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/standard
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949398930020220427)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Region #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
' <div class="t-Region-header">',
'  <div class="t-Region-headerItems t-Region-headerItems--title">',
'    <span class="t-Region-headerIcon"><span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span></span>',
'    <h2 class="t-Region-title" id="#REGION_STATIC_ID#_heading" data-apex-heading>#TITLE#</h2>',
'  </div>',
'  <div class="t-Region-headerItems t-Region-headerItems--buttons">#COPY##EDIT#<span class="js-maximizeButtonContainer"></span></div>',
' </div>',
' <div class="t-Region-bodyWrap">',
'   <div class="t-Region-buttons t-Region-buttons--top">',
'    <div class="t-Region-buttons-left">#PREVIOUS#</div>',
'    <div class="t-Region-buttons-right">#NEXT#</div>',
'   </div>',
'   <div class="t-Region-body">',
'     <div class="t-Region-orderBy">#ORDER_BY_ITEM#</div>',
'     #BODY#',
'     #SUB_REGIONS#',
'   </div>',
'   <div class="t-Region-buttons t-Region-buttons--bottom">',
'    <div class="t-Region-buttons-left">#CLOSE##HELP#</div>',
'    <div class="t-Region-buttons-right">#DELETE##CHANGE##CREATE#</div>',
'   </div>',
' </div>',
'</div>',
''))
,p_page_plug_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_plug_table_bgcolor=>'#ffffff'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Region--scrollBody'
,p_plug_heading_bgcolor=>'#ffffff'
,p_plug_font_size=>'-1'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_reference_id=>4070912133526059312
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751275299269733465)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751275725648733466)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Change'
,p_placeholder=>'CHANGE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751276234946733466)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751276750842733466)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Copy'
,p_placeholder=>'COPY'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751277234343733467)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751277710726733467)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Delete'
,p_placeholder=>'DELETE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751278218263733467)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751278725716733468)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Help'
,p_placeholder=>'HELP'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751279295170733468)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751279773741733468)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Sort Order'
,p_placeholder=>'ORDER_BY_ITEM'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>false
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751280290398733469)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751280745465733469)
,p_plug_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
,p_max_fixed_grid_columns=>12
);
end;
/
prompt --application/shared_components/user_interface/templates/region/tabs_container
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949401472031220432)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-TabsRegion #REGION_CSS_CLASSES# apex-tabs-region" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES# id="#REGION_STATIC_ID#">',
'  #BODY#',
'  <div class="t-TabsRegion-items">#SUB_REGIONS#</div>',
'</div>'))
,p_sub_plug_template=>'<div data-label="#SUB_REGION_TITLE!ATTR#" id="SR_#SUB_REGION_ID#">#SUB_REGION#</div>'
,p_page_plug_template_name=>'Tabs Container'
,p_internal_name=>'TABS_CONTAINER'
,p_javascript_file_urls=>'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>5
,p_preset_template_options=>'t-TabsRegion-mod--simple'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3221725015618492759
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751299422530733486)
,p_plug_template_id=>wwv_flow_imp.id(1949401472031220432)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751299910022733487)
,p_plug_template_id=>wwv_flow_imp.id(1949401472031220432)
,p_name=>'Tabs'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/title_bar
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949403479597220436)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<nav id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES# class="t-BreadcrumbRegion #REGION_CSS_CLASSES#">',
'  <div class="t-BreadcrumbRegion-top">',
'    <div class="t-BreadcrumbRegion-buttons t-BreadcrumbRegion-buttons--start">#UP#</div>',
'    <div class="t-BreadcrumbRegion-body">',
'      <div class="t-BreadcrumbRegion-breadcrumb">#BODY#</div>',
'        <div class="t-BreadcrumbRegion-title">',
'        <h1 id="#REGION_STATIC_ID#_heading" class="t-BreadcrumbRegion-titleText" data-apex-heading>#TITLE#</h1>',
'      </div>',
'    </div>',
'    <div class="t-BreadcrumbRegion-buttons t-BreadcrumbRegion-buttons--end">#PREVIOUS##CLOSE##DELETE##HELP##CHANGE##EDIT##COPY##CREATE##NEXT#</div>',
'  </div>',
'  <div class="t-BreadcrumbRegion-bottom">#SMART_FILTERS#</div>',
'</nav>',
''))
,p_page_plug_template_name=>'Title Bar'
,p_internal_name=>'TITLE_BAR'
,p_theme_id=>42
,p_theme_class_id=>6
,p_default_template_options=>'t-BreadcrumbRegion--showBreadcrumb'
,p_preset_template_options=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'navigation'
,p_reference_id=>2530016523834132090
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751309235096733495)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751309722115733495)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Change'
,p_placeholder=>'CHANGE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751310217044733495)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751310702990733496)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Copy'
,p_placeholder=>'COPY'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751311239039733496)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751311732366733496)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Delete'
,p_placeholder=>'DELETE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751312231267733497)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751312714169733497)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Help'
,p_placeholder=>'HELP'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751313219268733497)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751313779329733498)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751314280559733498)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Search Field and Smart Filters'
,p_placeholder=>'SMART_FILTERS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751314760213733498)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751315257163733499)
,p_plug_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_name=>'Up'
,p_placeholder=>'UP'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>false
);
end;
/
prompt --application/shared_components/user_interface/templates/region/wizard_container
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1949404212621220439)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Wizard #REGION_CSS_CLASSES#" id="#REGION_STATIC_ID#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>',
'  <div class="t-Wizard-header">',
'    <h1 class="t-Wizard-title" id="#REGION_STATIC_ID#_heading" data-apex-heading>#TITLE#</h1>',
'    <div class="u-Table t-Wizard-controls">',
'      <div class="u-Table-fit t-Wizard-buttons">#PREVIOUS##CLOSE#</div>',
'      <div class="u-Table-fill t-Wizard-steps">#BODY#</div>',
'      <div class="u-Table-fit t-Wizard-buttons">#NEXT#</div>',
'    </div>',
'  </div>',
'  <div class="t-Wizard-body">#SUB_REGIONS#</div>',
'</div>'))
,p_page_plug_template_name=>'Wizard Container'
,p_internal_name=>'WIZARD_CONTAINER'
,p_theme_id=>42
,p_theme_class_id=>8
,p_preset_template_options=>'t-Wizard--hideStepsXSmall'
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_default_landmark_type=>'region'
,p_region_title_dom_id=>'#REGION_STATIC_ID#_heading'
,p_reference_id=>2117602213152591491
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751320424252733503)
,p_plug_template_id=>wwv_flow_imp.id(1949404212621220439)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751320983928733504)
,p_plug_template_id=>wwv_flow_imp.id(1949404212621220439)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751321486957733504)
,p_plug_template_id=>wwv_flow_imp.id(1949404212621220439)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751321925958733504)
,p_plug_template_id=>wwv_flow_imp.id(1949404212621220439)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751322472288733505)
,p_plug_template_id=>wwv_flow_imp.id(1949404212621220439)
,p_name=>'Wizard Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>false
);
end;
/
prompt --application/shared_components/user_interface/templates/region/blank_with_attributes_no_grid
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(1980278263172869311)
,p_layout=>'TABLE'
,p_template=>'<div id="#REGION_STATIC_ID#" class="#REGION_CSS_CLASSES#" #REGION_LANDMARK_ATTRIBUTES# #REGION_ATTRIBUTES#>#PREVIOUS##BODY##SUB_REGIONS##NEXT#</div>'
,p_page_plug_template_name=>'Blank with Attributes (No Grid)'
,p_internal_name=>'BLANK_WITH_ATTRIBUTES_NO_GRID'
,p_theme_id=>42
,p_theme_class_id=>7
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_reference_id=>3369790999010910123
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751105982291733317)
,p_plug_template_id=>wwv_flow_imp.id(1980278263172869311)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751106449808733317)
,p_plug_template_id=>wwv_flow_imp.id(1980278263172869311)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751106912172733317)
,p_plug_template_id=>wwv_flow_imp.id(1980278263172869311)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(751107485894733318)
,p_plug_template_id=>wwv_flow_imp.id(1980278263172869311)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>false
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/region/div_region_with_id
begin
wwv_flow_imp_shared.create_plug_template(
 p_id=>wwv_flow_imp.id(3312069187641750427)
,p_layout=>'TABLE'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="#REGION_STATIC_ID#" #REGION_ATTRIBUTES# class="#REGION_CSS_CLASSES#"> ',
'#BODY#',
'#CLOSE##PREVIOUS##NEXT##DELETE##EDIT##CHANGE##CREATE##CREATE2##EXPAND##COPY##HELP#',
'</div>'))
,p_page_plug_template_name=>'DIV Region with ID'
,p_internal_name=>'DIV_REGION_WITH_ID'
,p_theme_id=>101
,p_theme_class_id=>22
,p_default_label_alignment=>'RIGHT'
,p_default_field_alignment=>'LEFT'
,p_translate_this_template=>'N'
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217020679612062)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Region Body'
,p_placeholder=>'BODY'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>true
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217141600612062)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Sub Regions'
,p_placeholder=>'SUB_REGIONS'
,p_has_grid_support=>true
,p_has_region_support=>true
,p_has_item_support=>false
,p_has_button_support=>false
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217248353612062)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Edit'
,p_placeholder=>'EDIT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217338685612062)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Expand'
,p_placeholder=>'EXPAND'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217424492612062)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Create'
,p_placeholder=>'CREATE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217527631612062)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Create2'
,p_placeholder=>'CREATE2'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217654646612062)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Close'
,p_placeholder=>'CLOSE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217704437612062)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Help'
,p_placeholder=>'HELP'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217827458612061)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Delete'
,p_placeholder=>'DELETE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183217975496612061)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Copy'
,p_placeholder=>'COPY'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183218096591612061)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Next'
,p_placeholder=>'NEXT'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183218161297612061)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Previous'
,p_placeholder=>'PREVIOUS'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
wwv_flow_imp_shared.create_plug_tmpl_display_point(
 p_id=>wwv_flow_imp.id(183218279510612061)
,p_plug_template_id=>wwv_flow_imp.id(3312069187641750427)
,p_name=>'Change'
,p_placeholder=>'CHANGE'
,p_has_grid_support=>false
,p_has_region_support=>false
,p_has_item_support=>false
,p_has_button_support=>true
,p_glv_new_row=>true
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_tabs
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(72397434093945784)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavTabs-item #A03# is-active" aria-current="page" id="#A01#">',
'  <a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span>',
'    <span class="t-NavTabs-label">#TEXT_ESC_SC#</span>',
'    <span class="t-NavTabs-badge #A05#">#A02#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavTabs-item #A03#" id="#A01#">',
'  <a href="#LINK#" class="t-NavTabs-link #A04# " title="#TEXT_ESC_SC#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span>',
'    <span class="t-NavTabs-label">#TEXT_ESC_SC#</span>',
'    <span class="t-NavTabs-badge #A05#">#A02#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Top Navigation Tabs'
,p_internal_name=>'TOP_NAVIGATION_TABS'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-NavTabs--inlineLabels-lg:t-NavTabs--displayLabels-sm'
,p_list_template_before_rows=>'<ul class="t-NavTabs #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_navtabs">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'List Item ID'
,p_a02_label=>'Badge Value'
,p_a03_label=>'List Item Class'
,p_a04_label=>'Link Class'
,p_a05_label=>'Badge Class'
,p_reference_id=>1453011561172885578
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_mega_menu
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(615424010440921046)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--noSub is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--noSub #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_list_template_name=>'Top Navigation Mega Menu'
,p_internal_name=>'TOP_NAVIGATION_MEGA_MENU'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-MegaMenu #COMPONENT_CSS_CLASSES#" id="t_MenuNav" style="display:none;">',
'  <div class="a-Menu-content t-MegaMenu-container">',
'    <div class="t-MegaMenu-body">',
'    <ul class="t-MegaMenu-list t-MegaMenu-list--top">'))
,p_list_template_after_rows=>' </ul></div></div></div>'
,p_before_sub_list=>'<ul class="t-MegaMenu-list t-MegaMenu-list--sub">'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_sub_list_item_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--hasSub is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item t-MegaMenu-item--top t-MegaMenu-item--hasSub #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>',
'</li>'))
,p_sub_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item is-active #A04#" data-current="true" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_sub_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MegaMenu-item #A04#" data-current="false" data-id="#A01#" data-shortcut="#A05#">',
'  <span class="a-Menu-item t-MegaMenu-itemBody #A08#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#"></span>',
'    <a class="a-Menu-label t-MegaMenu-labelWrap" href="#LINK#" target="#A06#">',
'      <span class="t-MegaMenu-label">#TEXT_ESC_SC#</span>',
'      <span class="t-MegaMenu-desc">#A03#</span>',
'    </a>',
'    <span class="t-MegaMenu-badge #A07#">#A02#</span>',
'  </span>'))
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Description'
,p_a04_label=>'List Item Class'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_a07_label=>'Badge Class'
,p_a08_label=>'Menu Item Class'
,p_reference_id=>1665447133514362075
);
end;
/
prompt --application/shared_components/user_interface/templates/list/badge_list
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949414696789220473)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02# is-current" aria-current="page">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'    <span class="t-BadgeList-label">#TEXT#</span>',
'    <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item #A02#">',
'  <a class="t-BadgeList-wrap u-color #A04#" href="#LINK#" #A03#>',
'    <span class="t-BadgeList-label">#TEXT#</span>',
'    <span class="t-BadgeList-value">#A01#</span>',
'  </a>',
'</li>',
''))
,p_list_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_theme_id=>42
,p_theme_class_id=>3
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--cols t-BadgeList--3cols:t-BadgeList--circular'
,p_list_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Value'
,p_a02_label=>'List item CSS Classes'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'Link Classes'
,p_reference_id=>2062482847268086664
,p_list_template_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'A01: Large Number',
'A02: List Item Classes',
'A03: Link Attributes'))
);
end;
/
prompt --application/shared_components/user_interface/templates/list/cards
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949416705322220477)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item is-active #A04#" aria-current="page">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap">',
'        <h3 class="t-Card-title">#TEXT#</h3>',
'        <h4 class="t-Card-subtitle">#A07#</h4>',
'      </div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#" aria-hidden="true"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #A04#">',
'  <div class="t-Card">',
'    <a href="#LINK#" class="t-Card-wrap" #A05#>',
'      <div class="t-Card-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#"><span class="t-Card-initials" role="presentation">#A03#</span></span></div>',
'      <div class="t-Card-titleWrap">',
'        <h3 class="t-Card-title">#TEXT#</h3>',
'        <h4 class="t-Card-subtitle">#A07#</h4>',
'      </div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#A01#</div>',
'        <div class="t-Card-info">#A02#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #A06#" aria-hidden="true"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_list_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_list_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Secondary Information'
,p_a03_label=>'Initials'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Attributes'
,p_a06_label=>'Card Color Class'
,p_a07_label=>'Subtitle'
,p_reference_id=>2885322685880632508
);
end;
/
prompt --application/shared_components/user_interface/templates/list/links_list
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949419333489220480)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-LinksList-item is-current #A03#" aria-current="page">',
'  <a href="#LINK#" class="t-LinksList-link" #A02#>',
'    <span class="t-LinksList-icon" aria-hidden="true"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span>',
'    <span class="t-LinksList-label">#TEXT#</span>',
'    <span class="t-LinksList-badge">#A01#</span>',
'  </a>',
'</li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-LinksList-item #A03#">',
'  <a href="#LINK#" class="t-LinksList-link" #A02#>',
'    <span class="t-LinksList-icon" aria-hidden="true"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span>',
'    <span class="t-LinksList-label">#TEXT#</span>',
'    <span class="t-LinksList-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Links List'
,p_internal_name=>'LINKS_LIST'
,p_theme_id=>42
,p_theme_class_id=>18
,p_list_template_before_rows=>'<ul class="t-LinksList #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<ul class="t-LinksList-list">'
,p_after_sub_list=>'</ul>'
,p_sub_list_item_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-LinksList-item is-current #A03#" aria-current="page">',
'  <a href="#LINK#" class="t-LinksList-link" #A02#>',
'    <span class="t-LinksList-icon" aria-hidden="true"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span>',
'    <span class="t-LinksList-label">#TEXT#</span>',
'    <span class="t-LinksList-badge">#A01#</span>',
'  </a>',
'</li>',
''))
,p_sub_list_item_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-LinksList-item #A03#">',
'  <a href="#LINK#" class="t-LinksList-link" #A02#>',
'    <span class="t-LinksList-icon" aria-hidden="true"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span>',
'    <span class="t-LinksList-label">#TEXT#</span>',
'    <span class="t-LinksList-badge">#A01#</span>',
'  </a>',
'</li>',
''))
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-LinksList-item is-current #A03#" aria-current="page">',
'  <a href="#LINK#" class="t-LinksList-link" #A02#>',
'    <span class="t-LinksList-icon" aria-hidden="true"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span>',
'    <span class="t-LinksList-label">#TEXT#</span>',
'    <span class="t-LinksList-badge">#A01#</span>',
'  </a>',
'  #SUB_LISTS#',
'</li>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-LinksList-item #A03#">',
'  <a href="#LINK#" class="t-LinksList-link" #A02#>',
'    <span class="t-LinksList-icon" aria-hidden="true"><span class="t-Icon #ICON_CSS_CLASSES#"></span></span>',
'    <span class="t-LinksList-label">#TEXT#</span>',
'    <span class="t-LinksList-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_a01_label=>'Badge Value'
,p_a02_label=>'Link Attributes'
,p_a03_label=>'List Item CSS Classes'
,p_reference_id=>4070914341144059318
);
end;
/
prompt --application/shared_components/user_interface/templates/list/media_list
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949420499205220482)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item is-active #A04#">',
'  <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'    <div class="t-MediaList-iconWrap" aria-hidden="true">',
'      <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'    </div>',
'    <div class="t-MediaList-body">',
'      <h3 class="t-MediaList-title" aria-current="page">#TEXT#</h3>',
'      <p class="t-MediaList-desc">#A01#</p>',
'    </div>',
'    <div class="t-MediaList-badgeWrap">',
'      <span class="t-MediaList-badge">#A02#</span>',
'    </div>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item  #A04#">',
'  <a href="#LINK#" class="t-MediaList-itemWrap #A05#" #A03#>',
'    <div class="t-MediaList-iconWrap" aria-hidden="true">',
'      <span class="t-MediaList-icon u-color #A06#"><span class="t-Icon #ICON_CSS_CLASSES#" #IMAGE_ATTR#></span></span>',
'    </div>',
'    <div class="t-MediaList-body">',
'      <h3 class="t-MediaList-title">#TEXT#</h3>',
'      <p class="t-MediaList-desc">#A01#</p>',
'    </div>',
'    <div class="t-MediaList-badgeWrap">',
'      <span class="t-MediaList-badge">#A02#</span>',
'    </div>',
'  </a>',
'</li>'))
,p_list_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_theme_id=>42
,p_theme_class_id=>5
,p_default_template_options=>'t-MediaList--showIcons:t-MediaList--showDesc'
,p_list_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'Description'
,p_a02_label=>'Badge Value'
,p_a03_label=>'Link Attributes'
,p_a04_label=>'List Item CSS Classes'
,p_a05_label=>'Link Class'
,p_a06_label=>'Icon Color Class'
,p_reference_id=>2066548068783481421
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_bar
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949422252641220485)
,p_list_template_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Menu Bar'
,p_internal_name=>'MENU_BAR'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menubar", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  iconType: ''fa'',',
'  menubar: true,',
'  menubarOverflow: true,',
'  callout: e.hasClass("js-menu-callout")',
'});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-showSubMenuIcons'
,p_list_template_before_rows=>'<div class="t-MenuBar #COMPONENT_CSS_CLASSES#" id="#PARENT_STATIC_ID#_menubar"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut'
,p_a06_label=>'Link Target'
,p_reference_id=>2008709236185638887
);
end;
/
prompt --application/shared_components/user_interface/templates/list/navigation_bar
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949422808189220487)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#" aria-current="page">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" title="#A04#" target="#A06#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <a class="t-Button t-Button--icon t-Button--header t-Button--navBar" href="#LINK#" title="#A04#" target="#A06#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Navigation Bar'
,p_internal_name=>'NAVIGATION_BAR'
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<ul class="t-NavigationBar #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_before_sub_list=>'<div class="t-NavigationBar-menu" style="display: none" id="menu_#PARENT_LIST_ITEM_ID#"><ul>'
,p_after_sub_list=>'</ul></div></li>'
,p_sub_list_item_current=>'<li class="#A02#" data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li class="#A02#" data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item is-active #A02#" aria-current="page">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#" title="#A04#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow" aria-hidden="true"></span>',
'  </button>'))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-NavigationBar-item #A02#">',
'  <button class="t-Button t-Button--icon t-Button t-Button--header t-Button--navBar" type="button" id="#LIST_ITEM_ID#" data-menu="menu_#LIST_ITEM_ID#" title="#A04#">',
'      <span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true" #IMAGE_ATTR#></span><span class="t-Button-label">#TEXT_ESC_SC#</span><span class="t-Button-badge">#A01#</span><span class="a-Icon icon-down-arrow" aria-hidden="true"></span>',
'  </button>'))
,p_sub_templ_curr_w_child=>'<li class="#A02#" data-current="true" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_templ_noncurr_w_child=>'<li class="#A02#" data-current="false" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_a01_label=>'Badge Value'
,p_a02_label=>'List  Item CSS Classes'
,p_a04_label=>'Title Attribute'
,p_a06_label=>'Link Target'
,p_reference_id=>2846096252961119197
);
end;
/
prompt --application/shared_components/user_interface/templates/list/side_navigation_menu
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949422988307220490)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#">',
'  <a href="#LINK#" title="#A04#" style="display: none" target="#A06#">#TEXT_ESC_SC#</a>',
'  <div class="a-TreeView-node a-TreeView-node--topLevel" aria-hidden="true">',
'    <div role="none" class="a-TreeView-row"></div>',
'    <div role="none" class="a-TreeView-content">',
'      <span class="fa fa-file-o #ICON_CSS_CLASSES#"></span>',
'      <span class="a-TreeView-label">#TEXT_ESC_SC#</span>',
'    </div>',
'  </div>',
'</li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-current="false" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#">',
'  <a href="#LINK#" title="#A04#" style="display: none" target="#A06#">#TEXT_ESC_SC#</a>',
'  <div class="a-TreeView-node a-TreeView-node--topLevel" aria-hidden="true">',
'    <div role="none" class="a-TreeView-row"></div>',
'    <div role="none" class="a-TreeView-content">',
'      <span class="fa fa-file-o #ICON_CSS_CLASSES#"></span>',
'      <span class="a-TreeView-label">#TEXT_ESC_SC#</span>',
'    </div>',
'  </div>',
'</li>'))
,p_list_template_name=>'Side Navigation Menu'
,p_internal_name=>'SIDE_NAVIGATION_MENU'
,p_javascript_file_urls=>'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.treeView#MIN#.js?v=#APEX_VERSION#'
,p_javascript_code_onload=>'apex.jQuery(''body'').addClass(''t-PageBody--leftNav'');'
,p_theme_id=>42
,p_theme_class_id=>19
,p_default_template_options=>'js-defaultCollapsed'
,p_preset_template_options=>'t-TreeNav--styleA:js-navCollapsed--hidden'
,p_list_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Body-nav" id="t_Body_nav" role="navigation" aria-label="&"APP_TEXT$APEX.TEMPLATE.APPLICATION".">',
'  <div class="a-TreeView t-TreeNav #COMPONENT_CSS_CLASSES#" id="t_TreeNav" data-id="#PARENT_STATIC_ID#_tree" aria-label="&"APP_TEXT$APEX.TEMPLATE.MAIN_NAV_LABEL".">',
'    <ul>',
''))
,p_list_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    </ul>',
'  </div>',
'</div>',
'<script>',
'(() => {',
'  const pref = "ORA_WWV_apex.toggleCore.nav.&APP_ID..preferenceForExpanded",',
'        nav  = document.getElementById(''t_TreeNav'').classList,',
'        body = document.getElementById(''t_PageBody'');',
'  if ( !sessionStorage.getItem( pref ) ) { sessionStorage.setItem( pref, !nav.contains(''js-defaultCollapsed'') ); }',
'  if ( nav.contains(''js-navCollapsed--default'') ) {',
'      body?.classList.add(''js-navCollapsed--icons'');',
'      if ( sessionStorage.getItem( pref ) === "false" ) { body?.classList.add(''js-navCollapsed''); }',
'  }',
'  if ( sessionStorage.getItem( pref ) === "true" && window.matchMedia("(min-width: " + getComputedStyle(document.documentElement).getPropertyValue("--js-mq-lg") + ")").matches) { body?.classList.add(''js-navExpanded''); }',
'  for (const label of document.querySelectorAll(".a-TreeView .a-TreeView-label")) {',
'      label.textContent = label.textContent.replaceAll(/\[(.*?)\]/ig, '''');',
'  }',
'})();',
'</script>'))
,p_before_sub_list=>'<ul style="display:none">'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#">',
'  <a href="#LINK#" title="#A04#" style="display: none" target="#A06#">#TEXT_ESC_SC#</a>',
'  <div class="a-TreeView-node a-TreeView-node--topLevel" aria-hidden="true">',
'    <div role="none" class="a-TreeView-row"></div>',
'    <div role="none" class="a-TreeView-content">',
'      <span class="fa fa-file-o #ICON_CSS_CLASSES#"></span>',
'      <span class="a-TreeView-label">#TEXT_ESC_SC#</span>',
'    </div>',
'  </div>',
''))
,p_item_templ_noncurr_w_child=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-current="false" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#">',
'  <a href="#LINK#" title="#A04#" style="display: none" target="#A06#">#TEXT_ESC_SC#</a>',
'  <div class="a-TreeView-node a-TreeView-node--topLevel" aria-hidden="true">',
'    <div role="none" class="a-TreeView-row"></div>',
'    <div role="none" class="a-TreeView-content">',
'      <span class="fa fa-file-o #ICON_CSS_CLASSES#"></span>',
'      <span class="a-TreeView-label">#TEXT_ESC_SC#</span>',
'    </div>',
'  </div>',
''))
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-icon="#ICON_CSS_CLASSES#" data-shortcut="#A05#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'ID Attribute'
,p_a02_label=>'Disabled (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_reference_id=>2466292414354694776
);
end;
/
prompt --application/shared_components/user_interface/templates/list/tabs
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949423187476220492)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Tabs-item is-active #A03#" aria-current="page" id="#A01#">',
'  <a href="#LINK#" class="t-Tabs-link #A04#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span>',
'    <span class="t-Tabs-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Tabs-item #A03#" id="#A01#">',
'  <a href="#LINK#" class="t-Tabs-link #A04#">',
'    <span class="t-Icon #ICON_CSS_CLASSES#" aria-hidden="true"></span>',
'    <span class="t-Tabs-label">#TEXT#</span>',
'  </a>',
'</li>'))
,p_list_template_name=>'Tabs'
,p_internal_name=>'TABS'
,p_javascript_file_urls=>'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.apexTabs#MIN#.js?v=#APEX_VERSION#'
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Tabs--simple'
,p_list_template_before_rows=>'<ul class="t-Tabs #COMPONENT_CSS_CLASSES#">'
,p_list_template_after_rows=>'</ul>'
,p_a01_label=>'List Item ID'
,p_a03_label=>'List Item Class'
,p_a04_label=>'Link Class'
,p_reference_id=>3288206686691809997
);
end;
/
prompt --application/shared_components/user_interface/templates/list/top_navigation_menu
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949424306183220494)
,p_list_template_current=>'<li class="a-MenuBar-item a-Menu--current" data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a class="a-MenuBar-label" href="#LINK#" title="#A04#" target="#A06#">#TEXT_ES'
||'C_SC#</a></li>'
,p_list_template_noncurrent=>'<li class="a-MenuBar-item" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a class="a-MenuBar-label" href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_list_template_name=>'Top Navigation Menu'
,p_internal_name=>'TOP_NAVIGATION_MENU'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("#t_MenuNav", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({',
'  behaveLikeTabs: e.hasClass("js-tabLike"),',
'  menubarShowSubMenuIcon: e.hasClass("js-showSubMenuIcons") || null,',
'  menubar: true,',
'  menubarOverflow: true,',
'  callout: e.hasClass("js-menu-callout")',
'});',
''))
,p_theme_id=>42
,p_theme_class_id=>20
,p_default_template_options=>'js-tabLike'
,p_list_template_before_rows=>'<div class="t-Header-nav-list #COMPONENT_CSS_CLASSES#" id="t_MenuNav"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul style="display: none">'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li class="a-MenuBar-item a-Menu--current" data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a class="a-MenuBar-label" href="#LINK#" title="#A04#" target="#A06#">#TEXT_ES'
||'C_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li class="a-MenuBar-item" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a class="a-MenuBar-label" href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-current="true" data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut Key'
,p_a06_label=>'Link Target'
,p_reference_id=>2525307901300239072
);
end;
/
prompt --application/shared_components/user_interface/templates/list/wizard_progress
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(1949424871898220496)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-WizardSteps-step is-active" aria-current="step" id="#LIST_ITEM_ID#">',
'  <div class="t-WizardSteps-wrap" data-link="#LINK#">',
'    <span class="t-WizardSteps-marker" aria-hidden="true"></span>',
'    <span class="t-WizardSteps-label">#TEXT# <span aria-hidden="true" class="t-WizardSteps-labelState"></span></span>',
'  </div>',
'</li>'))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-WizardSteps-step" id="#LIST_ITEM_ID#">',
'  <div class="t-WizardSteps-wrap" data-link="#LINK#">',
'    <span class="t-WizardSteps-marker" aria-hidden="true"></span>',
'    <span class="t-WizardSteps-label">#TEXT# <span aria-hidden="true" class="t-WizardSteps-labelState"></span></span>',
'  </div>',
'</li>'))
,p_list_template_name=>'Wizard Progress'
,p_internal_name=>'WIZARD_PROGRESS'
,p_javascript_code_onload=>'apex.theme.initWizardProgressBar();'
,p_theme_id=>42
,p_theme_class_id=>17
,p_preset_template_options=>'t-WizardSteps--displayLabels'
,p_list_template_before_rows=>'<ul aria-label="#CURRENT_PROGRESS#" class="t-WizardSteps #COMPONENT_CSS_CLASSES#" id="#LIST_ID#">'
,p_list_template_after_rows=>'</ul>'
,p_reference_id=>2008702338707394488
);
end;
/
prompt --application/shared_components/user_interface/templates/list/menu_popup
begin
wwv_flow_imp_shared.create_list_template(
 p_id=>wwv_flow_imp.id(2139854369470213616)
,p_list_template_current=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_noncurrent=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>',
''))
,p_list_template_name=>'Menu Popup'
,p_internal_name=>'MENU_POPUP'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var e = apex.jQuery("##PARENT_STATIC_ID#_menu", apex.gPageContext$);',
'if (e.hasClass("js-addActions")) {',
'  apex.actions.addFromMarkup( e );',
'}',
'e.menu({ iconType: ''fa'', callout: e.hasClass("js-menu-callout")});'))
,p_theme_id=>42
,p_theme_class_id=>20
,p_list_template_before_rows=>'<div id="#PARENT_STATIC_ID#_menu" class="#COMPONENT_CSS_CLASSES#" style="display:none;"><ul>'
,p_list_template_after_rows=>'</ul></div>'
,p_before_sub_list=>'<ul>'
,p_after_sub_list=>'</ul></li>'
,p_sub_list_item_current=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_sub_list_item_noncurrent=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a></li>'
,p_item_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_item_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_curr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_sub_templ_noncurr_w_child=>'<li data-id="#A01#" data-disabled="#A02#" data-hide="#A03#" data-shortcut="#A05#" data-icon="#ICON_CSS_CLASSES#"><a href="#LINK#" title="#A04#" target="#A06#">#TEXT_ESC_SC#</a>'
,p_a01_label=>'Menu Item ID / Action Name'
,p_a02_label=>'Disabled (True/False)'
,p_a03_label=>'Hidden (True/False)'
,p_a04_label=>'Title Attribute (Used By Actions Only)'
,p_a05_label=>'Shortcut'
,p_a06_label=>'Link Target'
,p_reference_id=>3492264004432431646
);
end;
/
prompt --application/shared_components/user_interface/templates/report/media_list
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(72437493019945811)
,p_row_template_name=>'Media List'
,p_internal_name=>'MEDIA_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item #LIST_CLASS#">',
'  <a href="#LINK#" class="t-MediaList-itemWrap #LINK_CLASS#" #LINK_ATTR#>',
'    <div class="t-MediaList-iconWrap" aria-hidden="true">',
'      <span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#"><span class="t-Icon #ICON_CLASS#"></span></span>',
'    </div>',
'    <div class="t-MediaList-body">',
'      <h3 class="t-MediaList-title">#LIST_TITLE#</h3>',
'      <p class="t-MediaList-desc">#LIST_TEXT#</p>',
'    </div>',
'    <div class="t-MediaList-badgeWrap">',
'      <span class="t-MediaList-badge">#LIST_BADGE#</span>',
'    </div>',
'  </a>',
'</li>',
''))
,p_row_template_condition1=>':LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-MediaList-item #LIST_CLASS#">',
'  <div class="t-MediaList-itemWrap #LINK_CLASS#" #LINK_ATTR#>',
'    <div class="t-MediaList-iconWrap" aria-hidden="true">',
'      <span class="t-MediaList-icon u-color #ICON_COLOR_CLASS#"><span class="t-Icon #ICON_CLASS#"></span></span>',
'    </div>',
'    <div class="t-MediaList-body">',
'      <h3 class="t-MediaList-title">#LIST_TITLE#</h3>',
'      <p class="t-MediaList-desc">#LIST_TEXT#</p>',
'    </div>',
'    <div class="t-MediaList-badgeWrap">',
'      <span class="t-MediaList-badge">#LIST_BADGE#</span>',
'    </div>',
'  </div>',
'</li>',
''))
,p_row_template_before_rows=>'<ul class="t-MediaList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_default_template_options=>'t-MediaList--showIcons:t-MediaList--showDesc'
,p_preset_template_options=>'t-MediaList--stack'
,p_reference_id=>2092157460408299055
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/timeline
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(223715108711423199)
,p_row_template_name=>'Timeline'
,p_internal_name=>'TIMELINE'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <div class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#" role="presentation">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':EVENT_LINK is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Timeline-item #EVENT_MODIFIERS#" #EVENT_ATTRIBUTES#>',
'  <a href="#EVENT_LINK#" class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      <div class="t-Timeline-avatar #USER_COLOR#" role="presentation">',
'        #USER_AVATAR#',
'      </div>',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">#USER_NAME#</span>',
'        <span class="t-Timeline-date">#EVENT_DATE#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      <div class="t-Timeline-typeWrap">',
'        <div class="t-Timeline-type #EVENT_STATUS#">',
'          <span class="t-Icon #EVENT_ICON#"></span>',
'          <span class="t-Timeline-typename">#EVENT_TYPE#</span>',
'        </div>',
'      </div>',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">#EVENT_TITLE#</h3>',
'        <p class="t-Timeline-desc">#EVENT_DESC#</p>',
'      </div>',
'    </div>',
'  </a>',
'</li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-Timeline #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_timeline" data-region-id="#REGION_STATIC_ID#">',
''))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_reference_id=>1513373588340069864
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/content_row
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(661420922046844151)
,p_row_template_name=>'Content Row'
,p_internal_name=>'CONTENT_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-ContentRow-item #ITEM_CLASSES#">',
'  <div class="t-ContentRow-wrap">',
'    <div class="t-ContentRow-selection">#SELECTION#</div>',
'    <div class="t-ContentRow-iconWrap">',
'      <span class="t-ContentRow-icon #ICON_CLASS#">#ICON_HTML#</span>',
'    </div>',
'    <div class="t-ContentRow-body">',
'      <div class="t-ContentRow-content">',
'        <h3 class="t-ContentRow-title">#TITLE#</h3>',
'        <div class="t-ContentRow-description">#DESCRIPTION#</div>',
'      </div>',
'      <div class="t-ContentRow-misc">#MISC#</div>',
'      <div class="t-ContentRow-actions">#ACTIONS#</div>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-ContentRow #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>1797843454948280151
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/contextual_info
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(846086529051073354)
,p_row_template_name=>'Contextual Info'
,p_internal_name=>'CONTEXTUAL_INFO'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ContextualInfo-item">',
'  <span class="t-ContextualInfo-label">#COLUMN_HEADER#</span>',
'  <span class="t-ContextualInfo-value">#COLUMN_VALUE#</span>',
'</div>'))
,p_row_template_before_rows=>' <div class="t-ContextualInfo #COMPONENT_CSS_CLASSES#" id="report_#REGION_STATIC_ID#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</div>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_reference_id=>2114325881116323585
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/alerts
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(1949405014838220442)
,p_row_template_name=>'Alerts'
,p_internal_name=>'ALERTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Alert t-Alert--horizontal t-Alert--colorBG t-Alert--defaultIcons t-Alert--#ALERT_TYPE#" role="alert">',
'  <div class="t-Alert-wrap">',
'    <div class="t-Alert-icon">',
'      <span class="t-Icon" aria-hidden="true"></span>',
'    </div>',
'    <div class="t-Alert-content">',
'      <div class="t-Alert-header">',
'        <h2 class="t-Alert-title">#ALERT_TITLE#</h2>',
'      </div>',
'      <div class="t-Alert-body">',
'        #ALERT_DESC#',
'      </div>',
'    </div>',
'    <div class="t-Alert-buttons">',
'      #ALERT_ACTION#',
'    </div>',
'  </div>',
'</div>'))
,p_row_template_before_rows=>'<div class="t-Alerts #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_alerts" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</div>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>14
,p_reference_id=>2881456138952347027
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/badge_list
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(1949405206224220445)
,p_row_template_name=>'Badge List'
,p_internal_name=>'BADGE_LIST'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-BadgeList-item">',
'  <span class="t-BadgeList-wrap u-color">',
'    <span class="t-BadgeList-label">#COLUMN_HEADER#</span>',
'    <span class="t-BadgeList-value">#COLUMN_VALUE#</span>',
'  </span>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-BadgeList #COMPONENT_CSS_CLASSES#" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-BadgeList--large:t-BadgeList--fixed:t-BadgeList--circular'
,p_reference_id=>2103197159775914759
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/cards
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(1949407374930220453)
,p_row_template_name=>'Cards'
,p_internal_name=>'CARDS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <a href="#CARD_LINK#" class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </a>',
'  </div>',
'</li>'))
,p_row_template_condition1=>':CARD_LINK is not null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Cards-item #CARD_MODIFIERS#">',
'  <div class="t-Card">',
'    <div class="t-Card-wrap">',
'      <div class="t-Card-icon u-color #CARD_COLOR#"><span class="t-Icon fa #CARD_ICON#"><span class="t-Card-initials" role="presentation">#CARD_INITIALS#</span></span></div>',
'      <div class="t-Card-titleWrap"><h3 class="t-Card-title">#CARD_TITLE#</h3><h4 class="t-Card-subtitle">#CARD_SUBTITLE#</h4></div>',
'      <div class="t-Card-body">',
'        <div class="t-Card-desc">#CARD_TEXT#</div>',
'        <div class="t-Card-info">#CARD_SUBTEXT#</div>',
'      </div>',
'      <span class="t-Card-colorFill u-color #CARD_COLOR#"></span>',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Cards #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_cards" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Cards--animColorFill:t-Cards--3cols:t-Cards--basic'
,p_reference_id=>2973535649510699732
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/comments
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(1949409987720220457)
,p_row_template_name=>'Comments'
,p_internal_name=>'COMMENTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Comments-item #COMMENT_MODIFIERS#">',
'  <div class="t-Comments-icon">',
'    <div class="t-Comments-userIcon #ICON_MODIFIER#" aria-hidden="true">#USER_ICON#</div>',
'  </div>',
'  <div class="t-Comments-body">',
'    <div class="t-Comments-info">',
'      #USER_NAME# <span class="t-Comments-date">#COMMENT_DATE#</span> <span class="t-Comments-actions">#ACTIONS#</span>',
'    </div>',
'    <div class="t-Comments-comment">',
'      #COMMENT_TEXT##ATTRIBUTE_1##ATTRIBUTE_2##ATTRIBUTE_3##ATTRIBUTE_4#',
'    </div>',
'  </div>',
'</li>'))
,p_row_template_before_rows=>'<ul class="t-Comments #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>',
''))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-Comments--chat'
,p_reference_id=>2611722012730764232
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/search_results
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(1949410588092220460)
,p_row_template_name=>'Search Results'
,p_internal_name=>'SEARCH_RESULTS'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition1=>':LABEL_02 is null'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition2=>':LABEL_03 is null'
,p_row_template3=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'    </div>',
'  </li>'))
,p_row_template_condition3=>':LABEL_04 is null'
,p_row_template4=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-SearchResults-item">',
'    <h3 class="t-SearchResults-title"><a href="#SEARCH_LINK#">#SEARCH_TITLE#</a></h3>',
'    <div class="t-SearchResults-info">',
'      <p class="t-SearchResults-desc">#SEARCH_DESC#</p>',
'      <span class="t-SearchResults-misc">#LABEL_01#: #VALUE_01#</span>',
'      <span class="t-SearchResults-misc">#LABEL_02#: #VALUE_02#</span>',
'      <span class="t-SearchResults-misc">#LABEL_03#: #VALUE_03#</span>',
'      <span class="t-SearchResults-misc">#LABEL_04#: #VALUE_04#</span>',
'    </div>',
'  </li>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-SearchResults #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="#REGION_STATIC_ID#_report" data-region-id="#REGION_STATIC_ID#">',
'<ul class="t-SearchResults-list">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</ul>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>',
'</div>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'NOT_CONDITIONAL'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070913431524059316
,p_translate_this_template=>'N'
,p_row_template_comment=>' (SELECT link_text, link_target, detail1, detail2, last_modified)'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/standard
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(1949410800764220464)
,p_row_template_name=>'Standard'
,p_internal_name=>'STANDARD'
,p_row_template1=>'<td class="t-Report-cell" #ALIGNMENT# #ACCESSIBLE_HEADERS#>#COLUMN_VALUE#</td>'
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Report #COMPONENT_CSS_CLASSES#" id="report_#REGION_STATIC_ID#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">',
'  <div class="t-Report-wrap">',
'    <table class="t-Report-pagination" role="presentation">#TOP_PAGINATION#</table>',
'    <div class="t-Report-tableWrap">',
'    <table class="t-Report-report" id="report_table_#REGION_STATIC_ID#" aria-label="#REGION_TITLE#">'))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'      </tbody>',
'    </table>',
'    </div>',
'    <div class="t-Report-links">#EXTERNAL_LINK##CSV_LINK#</div>',
'    <table class="t-Report-pagination t-Report-pagination--bottom" role="presentation">#PAGINATION#</table>',
'  </div>',
'</div>'))
,p_row_template_before_first=>'<tr>'
,p_row_template_after_last=>'</tr>'
,p_row_template_type=>'GENERIC_COLUMNS'
,p_before_column_heading=>'<thead>'
,p_column_heading_template=>'<th class="t-Report-colHead" #ARIA_SORT# #ALIGNMENT# id="#COLUMN_HEADER_NAME#" #COLUMN_WIDTH#>#COLUMN_HEADER#</th>'
,p_after_column_heading=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</thead>',
'<tbody>'))
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>4
,p_preset_template_options=>'t-Report--altRowsDefault:t-Report--rowHighlight'
,p_reference_id=>2537207537838287671
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_column
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(1949412517353220469)
,p_row_template_name=>'Value Attribute Pairs - Column'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_COLUMN'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #COLUMN_HEADER#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #COLUMN_VALUE#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'GENERIC_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>6
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068636272681754
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/report/value_attribute_pairs_row
begin
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(1949413684294220471)
,p_row_template_name=>'Value Attribute Pairs - Row'
,p_internal_name=>'VALUE_ATTRIBUTE_PAIRS_ROW'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<dt class="t-AVPList-label">',
'  #1#',
'</dt>',
'<dd class="t-AVPList-value">',
'  #2#',
'</dd>'))
,p_row_template_before_rows=>'<dl class="t-AVPList #COMPONENT_CSS_CLASSES#" #REPORT_ATTRIBUTES# id="report_#REGION_STATIC_ID#" data-region-id="#REGION_STATIC_ID#">'
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</dl>',
'<table class="t-Report-pagination" role="presentation">#PAGINATION#</table>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_row_template_display_cond1=>'0'
,p_row_template_display_cond2=>'0'
,p_row_template_display_cond3=>'0'
,p_row_template_display_cond4=>'0'
,p_pagination_template=>'<span class="t-Report-paginationText">#TEXT#</span>'
,p_next_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_page_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS#',
'</a>'))
,p_next_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--next">',
'  #PAGINATION_NEXT_SET#<span class="a-Icon icon-right-arrow" aria-hidden="true"></span>',
'</a>'))
,p_previous_set_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#LINK#" class="t-Button t-Button--small t-Button--noUI t-Report-paginationLink t-Report-paginationLink--prev">',
'  <span class="a-Icon icon-left-arrow" aria-hidden="true"></span>#PAGINATION_PREVIOUS_SET#',
'</a>'))
,p_theme_id=>42
,p_theme_class_id=>7
,p_preset_template_options=>'t-AVPList--leftAligned'
,p_reference_id=>2099068321678681753
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_floating
begin
wwv_flow_imp_shared.create_field_template(
 p_id=>wwv_flow_imp.id(315853137824632244)
,p_template_name=>'Required - Floating'
,p_internal_name=>'REQUIRED_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  </label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-inputContainer">',
'  <div class="t-Form-itemRequired-marker" aria-hidden="true"></div>',
'  <div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'))
,p_after_element=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#ITEM_POST_TEXT##HELP_TEMPLATE#',
'  </div>',
'  <div class="t-Form-itemAssistance">',
'    #ERROR_TEMPLATE#',
'    <div class="t-Form-itemRequired" aria-hidden="true">#REQUIRED#</div>',
'  </div>',
'  #INLINE_HELP_TEMPLATE#',
'</div>'))
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<div class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</div>'
,p_error_template=>'<div class="t-Form-error">#ERROR_MESSAGE#</div>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>1607675344320152883
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional_floating
begin
wwv_flow_imp_shared.create_field_template(
 p_id=>wwv_flow_imp.id(315853414985632244)
,p_template_name=>'Optional - Floating'
,p_internal_name=>'OPTIONAL_FLOATING'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--floatingLabel #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>1607675164727151865
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/hidden
begin
wwv_flow_imp_shared.create_field_template(
 p_id=>wwv_flow_imp.id(1949425654686220498)
,p_template_name=>'Hidden'
,p_internal_name=>'HIDDEN'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer t-Form-labelContainer--hiddenLabel col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label u-VisuallyHidden">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--hiddenLabel rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>13
,p_reference_id=>2039339104148359505
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional
begin
wwv_flow_imp_shared.create_field_template(
 p_id=>wwv_flow_imp.id(1949425987980220501)
,p_template_name=>'Optional'
,p_internal_name=>'OPTIONAL'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label>',
'</div>',
''))
,p_before_item=>'<div class="t-Form-fieldContainer rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT##HELP_TEMPLATE#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>2317154212072806530
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/optional_above
begin
wwv_flow_imp_shared.create_field_template(
 p_id=>wwv_flow_imp.id(1949426144808220503)
,p_template_name=>'Optional - Above'
,p_internal_name=>'OPTIONAL_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'<label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</label> #HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>'<div class="t-Form-inputContainer"><div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'
,p_after_element=>'#ITEM_POST_TEXT#</div>#INLINE_HELP_TEMPLATE##ERROR_TEMPLATE#</div>'
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<span class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</span>'
,p_error_template=>'<span class="t-Form-error">#ERROR_MESSAGE#</span>'
,p_theme_id=>42
,p_theme_class_id=>3
,p_reference_id=>3030114864004968404
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required
begin
wwv_flow_imp_shared.create_field_template(
 p_id=>wwv_flow_imp.id(1949426243331220505)
,p_template_name=>'Required'
,p_internal_name=>'REQUIRED'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer col col-#LABEL_COLUMN_SPAN_NUMBER#">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  </label>',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer is-required rel-col #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-inputContainer col col-#ITEM_COLUMN_SPAN_NUMBER#">',
'  <div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'))
,p_after_element=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#ITEM_POST_TEXT##HELP_TEMPLATE#',
'  </div>',
'  <div class="t-Form-itemAssistance">',
'    #ERROR_TEMPLATE#',
'    <div class="t-Form-itemRequired" aria-hidden="true">#REQUIRED#</div>',
'  </div>',
'  #INLINE_HELP_TEMPLATE#',
'</div>'))
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<div class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</div>'
,p_error_template=>'<div class="t-Form-error">#ERROR_MESSAGE#</div>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>2525313812251712801
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/label/required_above
begin
wwv_flow_imp_shared.create_field_template(
 p_id=>wwv_flow_imp.id(1949426297686220507)
,p_template_name=>'Required - Above'
,p_internal_name=>'REQUIRED_ABOVE'
,p_template_body1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-labelContainer">',
'  <label for="#CURRENT_ITEM_NAME#" id="#LABEL_ID#" class="t-Form-label">'))
,p_template_body2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  </label> #HELP_TEMPLATE#',
'</div>'))
,p_before_item=>'<div class="t-Form-fieldContainer t-Form-fieldContainer--stacked is-required #ITEM_CSS_CLASSES#" id="#CURRENT_ITEM_CONTAINER_ID#">'
,p_after_item=>'</div>'
,p_item_pre_text=>'<span class="t-Form-itemText t-Form-itemText--pre">#CURRENT_ITEM_PRE_TEXT#</span>'
,p_item_post_text=>'<span class="t-Form-itemText t-Form-itemText--post">#CURRENT_ITEM_POST_TEXT#</span>'
,p_before_element=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-Form-inputContainer">',
'  <div class="t-Form-itemWrapper">#ITEM_PRE_TEXT#'))
,p_after_element=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#ITEM_POST_TEXT#</div>',
'  <div class="t-Form-itemAssistance">',
'    #ERROR_TEMPLATE#',
'    <div class="t-Form-itemRequired" aria-hidden="true">#REQUIRED#</div>',
'  </div>',
'  #INLINE_HELP_TEMPLATE#',
'</div>',
''))
,p_help_link=>'<button class="t-Form-helpButton js-itemHelp" data-itemhelp="#CURRENT_ITEM_ID#" title="#CURRENT_ITEM_HELP_LABEL#" aria-label="#CURRENT_ITEM_HELP_LABEL#" tabindex="-1" type="button"><span class="a-Icon icon-help" aria-hidden="true"></span></button>'
,p_inline_help_text=>'<div class="t-Form-inlineHelp">#CURRENT_ITEM_INLINE_HELP_TEXT#</div>'
,p_error_template=>'<div class="t-Form-error">#ERROR_MESSAGE#</div>'
,p_theme_id=>42
,p_theme_class_id=>4
,p_reference_id=>3030115129444970113
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/breadcrumb/breadcrumb
begin
wwv_flow_imp_shared.create_menu_template(
 p_id=>wwv_flow_imp.id(1949427078141220517)
,p_name=>'Breadcrumb'
,p_internal_name=>'BREADCRUMB'
,p_before_first=>'<ul class="t-Breadcrumb #COMPONENT_CSS_CLASSES#">'
,p_current_page_option=>'<li class="t-Breadcrumb-item is-active" aria-current="page"><h1 class="t-Breadcrumb-label">#NAME#</h1></li>'
,p_non_current_page_option=>'<li class="t-Breadcrumb-item"><a href="#LINK#" class="t-Breadcrumb-label">#NAME#</a></li>'
,p_after_last=>'</ul>'
,p_max_levels=>6
,p_start_with_node=>'PARENT_TO_LEAF'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916542570059325
,p_translate_this_template=>'N'
);
end;
/
prompt --application/shared_components/user_interface/templates/popuplov
begin
wwv_flow_imp_shared.create_popup_lov_template(
 p_id=>wwv_flow_imp.id(1949427270124220521)
,p_page_name=>'winlov'
,p_page_title=>'Search Dialog'
,p_page_html_head=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!DOCTYPE html>',
'<html lang="&BROWSER_LANGUAGE.">',
'<head>',
'<title>#TITLE#</title>',
'#APEX_CSS#',
'#THEME_CSS#',
'#THEME_STYLE_CSS#',
'#FAVICONS#',
'#APEX_JAVASCRIPT#',
'#THEME_JAVASCRIPT#',
'<meta name="viewport" content="width=device-width,initial-scale=1.0" />',
'</head>'))
,p_page_body_attr=>'onload="first_field()" class="t-Page t-Page--popupLOV"'
,p_before_field_text=>'<div class="t-PopupLOV-actions t-Form--large">'
,p_filter_width=>'20'
,p_filter_max_width=>'100'
,p_filter_text_attr=>'class="apex-item-text"'
,p_find_button_text=>'Search'
,p_find_button_attr=>'class="t-Button t-Button--hot t-Button--padLeft"'
,p_close_button_text=>'Close'
,p_close_button_attr=>'class="t-Button u-pullRight"'
,p_next_button_text=>'Next &gt;'
,p_next_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_prev_button_text=>'&lt; Previous'
,p_prev_button_attr=>'class="t-Button t-PopupLOV-button"'
,p_after_field_text=>'</div>'
,p_scrollbars=>'1'
,p_resizable=>'1'
,p_width=>'380'
,p_result_row_x_of_y=>'<div class="t-PopupLOV-pagination">Row(s) #FIRST_ROW# - #LAST_ROW#</div>'
,p_result_rows_per_pg=>100
,p_before_result_set=>'<div class="t-PopupLOV-links">'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>2885398517835871876
,p_translate_this_template=>'N'
,p_after_result_set=>'</div>'
);
end;
/
prompt --application/shared_components/user_interface/templates/calendar/calendar
begin
wwv_flow_imp_shared.create_calendar_template(
 p_id=>wwv_flow_imp.id(1949427224344220520)
,p_cal_template_name=>'Calendar'
,p_internal_name=>'CALENDAR'
,p_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" aria-label="#IMONTH# #YYYY#">'
,p_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>',
''))
,p_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_day_close_format=>'</td>'
,p_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">#TITLE_FORMAT#<div class="t-ClassicCalendar-dayEvents">#DATA#</div>'
,p_weekend_close_format=>'</td>'
,p_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_nonday_close_format=>'</td>'
,p_week_open_format=>'<tr>'
,p_week_close_format=>'</tr> '
,p_daily_title_format=>'<table cellspacing="0" cellpadding="0" border="0" summary="" class="t1DayCalendarHolder"> <tr> <td class="t1MonthTitle">#IMONTH# #DD#, #YYYY#</td> </tr> <tr> <td>'
,p_daily_open_format=>'<tr>'
,p_daily_close_format=>'</tr>'
,p_weekly_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--weekly">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_weekly_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_weekly_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" aria-label="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_weekly_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_weekly_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_day_close_format=>'</div></td>'
,p_weekly_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_weekly_weekend_close_format=>'</div></td>'
,p_weekly_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_weekly_time_close_format=>'</th>'
,p_weekly_time_title_format=>'#TIME#'
,p_weekly_hour_open_format=>'<tr>'
,p_weekly_hour_close_format=>'</tr>'
,p_daily_day_of_week_format=>'<th scope="col" id="#DY#" class="t-ClassicCalendar-dayColumn">#IDAY#</th>'
,p_daily_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--daily">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #DD#, #YYYY#</h1>'))
,p_daily_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" aria-label="#CALENDAR_TITLE# #START_DL#" class="t-ClassicCalendar-calendar">'
,p_daily_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_daily_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_day_close_format=>'</div></td>'
,p_daily_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_daily_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol" id="#TIME#">'
,p_daily_time_close_format=>'</th>'
,p_daily_time_title_format=>'#TIME#'
,p_daily_hour_open_format=>'<tr>'
,p_daily_hour_close_format=>'</tr>'
,p_cust_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#IMONTH# #YYYY#</h1>'))
,p_cust_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th id="#DY#" scope="col" class="t-ClassicCalendar-dayColumn">',
'  <span class="visible-md visible-lg">#IDAY#</span>',
'  <span class="hidden-md hidden-lg">#IDY#</span>',
'</th>'))
,p_cust_month_open_format=>'<table class="t-ClassicCalendar-calendar" cellpadding="0" cellspacing="0" border="0" aria-label="#IMONTH# #YYYY#">'
,p_cust_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_week_open_format=>'<tr>'
,p_cust_week_close_format=>'</tr> '
,p_cust_day_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_day_close_format=>'</td>'
,p_cust_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#">'
,p_cust_nonday_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_nonday_open_format=>'<td class="t-ClassicCalendar-day is-inactive" headers="#DY#">'
,p_cust_nonday_close_format=>'</td>'
,p_cust_weekend_title_format=>'<span class="t-ClassicCalendar-date">#DD#</span>'
,p_cust_weekend_open_format=>'<td class="t-ClassicCalendar-day is-weekend" headers="#DY#">'
,p_cust_weekend_close_format=>'</td>'
,p_cust_hour_open_format=>'<tr>'
,p_cust_hour_close_format=>'</tr>'
,p_cust_time_title_format=>'#TIME#'
,p_cust_time_open_format=>'<th scope="row" class="t-ClassicCalendar-day t-ClassicCalendar-timeCol">'
,p_cust_time_close_format=>'</th>'
,p_cust_wk_month_title_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar">',
'<h1 class="t-ClassicCalendar-title">#WTITLE#</h1>'))
,p_cust_wk_day_of_week_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<th scope="col" class="t-ClassicCalendar-dayColumn" id="#DY#">',
'  <span class="visible-md visible-lg">#DD# #IDAY#</span>',
'  <span class="hidden-md hidden-lg">#DD# #IDY#</span>',
'</th>'))
,p_cust_wk_month_open_format=>'<table border="0" cellpadding="0" cellspacing="0" summary="#CALENDAR_TITLE# #START_DL# - #END_DL#" class="t-ClassicCalendar-calendar">'
,p_cust_wk_month_close_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</table>',
'</div>'))
,p_cust_wk_week_open_format=>'<tr>'
,p_cust_wk_week_close_format=>'</tr> '
,p_cust_wk_day_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_day_close_format=>'</div></td>'
,p_cust_wk_today_open_format=>'<td class="t-ClassicCalendar-day is-today" headers="#DY#"><div class="t-ClassicCalendar-dayEvents">'
,p_cust_wk_weekend_open_format=>'<td class="t-ClassicCalendar-day" headers="#DY#">'
,p_cust_wk_weekend_close_format=>'</td>'
,p_agenda_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="t-ClassicCalendar t-ClassicCalendar--list">',
'  <div class="t-ClassicCalendar-title">#IMONTH# #YYYY#</div>',
'  <ul class="t-ClassicCalendar-list">',
'    #DAYS#',
'  </ul>',
'</div>'))
,p_agenda_past_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-past">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_today_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-today">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_future_day_format=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <li class="t-ClassicCalendar-listTitle is-future">',
'    <span class="t-ClassicCalendar-listDayTitle">#IDAY#</span><span class="t-ClassicCalendar-listDayDate">#IMONTH# #DD#</span>',
'  </li>'))
,p_agenda_past_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-past">#DATA#</li>'
,p_agenda_today_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-today">#DATA#</li>'
,p_agenda_future_entry_format=>'  <li class="t-ClassicCalendar-listEvent is-future">#DATA#</li>'
,p_month_data_format=>'#DAYS#'
,p_month_data_entry_format=>'<span class="t-ClassicCalendar-event">#DATA#</span>'
,p_theme_id=>42
,p_theme_class_id=>1
,p_reference_id=>4070916747979059326
);
end;
/
prompt --application/shared_components/user_interface/themes
begin
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(1949429468741220575)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_version_identifier=>'23.2'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_imp.id(1949382845217220384)
,p_default_dialog_template=>wwv_flow_imp.id(1949379456547220377)
,p_error_template=>wwv_flow_imp.id(1949373694717220360)
,p_printer_friendly_template=>wwv_flow_imp.id(1949382845217220384)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_imp.id(1949373694717220360)
,p_default_button_template=>wwv_flow_imp.id(1949427006011220515)
,p_default_region_template=>wwv_flow_imp.id(1949398930020220427)
,p_default_chart_template=>wwv_flow_imp.id(1949398930020220427)
,p_default_form_template=>wwv_flow_imp.id(1949398930020220427)
,p_default_reportr_template=>wwv_flow_imp.id(1949398930020220427)
,p_default_tabform_template=>wwv_flow_imp.id(1949398930020220427)
,p_default_wizard_template=>wwv_flow_imp.id(1949398930020220427)
,p_default_menur_template=>wwv_flow_imp.id(1949403479597220436)
,p_default_listr_template=>wwv_flow_imp.id(1949398930020220427)
,p_default_irr_template=>wwv_flow_imp.id(1949397075503220418)
,p_default_report_template=>wwv_flow_imp.id(1949410800764220464)
,p_default_label_template=>wwv_flow_imp.id(1949425987980220501)
,p_default_menu_template=>wwv_flow_imp.id(1949427078141220517)
,p_default_calendar_template=>wwv_flow_imp.id(1949427224344220520)
,p_default_list_template=>wwv_flow_imp.id(1949419333489220480)
,p_default_nav_list_template=>wwv_flow_imp.id(1949424306183220494)
,p_default_top_nav_list_temp=>wwv_flow_imp.id(1949424306183220494)
,p_default_side_nav_list_temp=>wwv_flow_imp.id(1949422988307220490)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_imp.id(1949388267286220402)
,p_default_dialogr_template=>wwv_flow_imp.id(1949388027252220400)
,p_default_option_label=>wwv_flow_imp.id(1949425987980220501)
,p_default_header_template=>wwv_flow_imp.id(1949388027252220400)
,p_default_footer_template=>wwv_flow_imp.id(1949388027252220400)
,p_default_required_label=>wwv_flow_imp.id(1949426243331220505)
,p_default_navbar_list_template=>wwv_flow_imp.id(1949422808189220487)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#APEX_FILES#themes/theme_42/23.2/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_FILES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_FILES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
end;
/
prompt --application/shared_components/user_interface/theme_style
begin
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(750714048700732996)
,p_theme_id=>42
,p_name=>'Redwood Light'
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/oracle-fonts/oraclesans-apex#MIN#.css?v=#APEX_VERSION#',
'#THEME_FILES#css/Redwood#MIN#.css?v=#APEX_VERSION#'))
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Redwood-Theme.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Redwood-Theme#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2596426436825065489
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(750714478522732997)
,p_theme_id=>42
,p_name=>'Vita'
,p_is_current=>true
,p_is_public=>true
,p_is_accessible=>true
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Vita#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>2719875314571594493
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(750714870873732997)
,p_theme_id=>42
,p_name=>'Vita - Dark'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita-Dark.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Vita-Dark#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3543348412015319650
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(750715210703732997)
,p_theme_id=>42
,p_name=>'Vita - Red'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita-Red.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Vita-Red#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>1938457712423918173
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(750715681539732998)
,p_theme_id=>42
,p_name=>'Vita - Slate'
,p_is_current=>false
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Vita-Slate.less'
,p_theme_roller_output_file_url=>'#THEME_FILES#css/Vita-Slate#MIN#.css?v=#APEX_VERSION#'
,p_theme_roller_read_only=>true
,p_reference_id=>3291983347983194966
);
end;
/
prompt --application/shared_components/user_interface/theme_files
begin
null;
end;
/
prompt --application/shared_components/user_interface/template_opt_groups
begin
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750877938565733139)
,p_theme_id=>42
,p_name=>'BUTTON_SET'
,p_display_name=>'Button Set'
,p_display_sequence=>40
,p_template_types=>'BUTTON'
,p_help_text=>'Enables you to group many buttons together into a pill. You can use this option to specify where the button is within this set. Set the option to Default if this button is not part of a button set.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750878373848733140)
,p_theme_id=>42
,p_name=>'ICON_HOVER_ANIMATION'
,p_display_name=>'Icon Hover Animation'
,p_display_sequence=>55
,p_template_types=>'BUTTON'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750878731150733140)
,p_theme_id=>42
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>50
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the position of the icon relative to the label.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750879145060733140)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the size of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750879536865733140)
,p_theme_id=>42
,p_name=>'SPACING_BOTTOM'
,p_display_name=>'Spacing Bottom'
,p_display_sequence=>100
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the bottom of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750879946614733141)
,p_theme_id=>42
,p_name=>'SPACING_LEFT'
,p_display_name=>'Spacing Left'
,p_display_sequence=>70
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the left of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750880384977733141)
,p_theme_id=>42
,p_name=>'SPACING_RIGHT'
,p_display_name=>'Spacing Right'
,p_display_sequence=>80
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the right of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750880722349733141)
,p_theme_id=>42
,p_name=>'SPACING_TOP'
,p_display_name=>'Spacing Top'
,p_display_sequence=>90
,p_template_types=>'BUTTON'
,p_help_text=>'Controls the spacing to the top of the button.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750881100280733141)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>30
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the style of the button. Use the "Simple" option for secondary actions or sets of buttons. Use the "Remove UI Decoration" option to make the button appear as text.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750881552311733142)
,p_theme_id=>42
,p_name=>'TYPE'
,p_display_name=>'Type'
,p_display_sequence=>20
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750881985522733142)
,p_theme_id=>42
,p_name=>'WIDTH'
,p_display_name=>'Width'
,p_display_sequence=>60
,p_template_types=>'BUTTON'
,p_help_text=>'Sets the width of the button.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750882346676733142)
,p_theme_id=>42
,p_name=>'BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the bottom margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750882793459733142)
,p_theme_id=>42
,p_name=>'DISPLAY_TEXT_STYLE'
,p_display_name=>'Display Text Style'
,p_display_sequence=>400
,p_template_types=>'FIELD'
,p_help_text=>'Determines the display style for Display Only & Read Only display items.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750883136550733143)
,p_theme_id=>42
,p_name=>'ITEM_POST_TEXT'
,p_display_name=>'Item Post Text'
,p_display_sequence=>30
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Post Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750883535438733143)
,p_theme_id=>42
,p_name=>'ITEM_PRE_TEXT'
,p_display_name=>'Item Pre Text'
,p_display_sequence=>20
,p_template_types=>'FIELD'
,p_help_text=>'Adjust the display of the Item Pre Text'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750883943583733143)
,p_theme_id=>42
,p_name=>'LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'FIELD'
,p_help_text=>'Set the left margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750884307340733144)
,p_theme_id=>42
,p_name=>'PRESERVE_LABEL_SPACING'
,p_display_name=>'Preserve Label Spacing'
,p_display_sequence=>1
,p_template_types=>'FIELD'
,p_help_text=>'Preserves the label space and enables use of the Label Column Span property.'
,p_null_text=>'Yes'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750884794256733144)
,p_theme_id=>42
,p_name=>'RADIO_GROUP_DISPLAY'
,p_display_name=>'Item Group Display'
,p_display_sequence=>300
,p_template_types=>'FIELD'
,p_help_text=>'Determines the display style for radio and check box items.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750885147108733144)
,p_theme_id=>42
,p_name=>'REQUIRED_INDICATOR'
,p_display_name=>'Required Indicator'
,p_display_sequence=>1
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750885543034733144)
,p_theme_id=>42
,p_name=>'RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'FIELD'
,p_help_text=>'Set the right margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750885922330733145)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>10
,p_template_types=>'FIELD'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750886370585733145)
,p_theme_id=>42
,p_name=>'TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'FIELD'
,p_help_text=>'Set the top margin for this field.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750886740465733145)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>80
,p_template_types=>'LIST'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750887172826733145)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>70
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750887524368733146)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'LIST'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750887986809733146)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE'
,p_display_name=>'Collapse Mode'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750888322298733146)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750888761339733146)
,p_theme_id=>42
,p_name=>'DESKTOP'
,p_display_name=>'Desktop'
,p_display_sequence=>90
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a desktop-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750889118497733147)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750889517607733147)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'LIST'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750889944628733147)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'LIST'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Circle'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750890354704733147)
,p_theme_id=>42
,p_name=>'ICON_STYLE'
,p_display_name=>'Icon Style'
,p_display_sequence=>35
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750890779976733148)
,p_theme_id=>42
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>50
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750891151443733148)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750891577760733148)
,p_theme_id=>42
,p_name=>'MOBILE'
,p_display_name=>'Mobile'
,p_display_sequence=>100
,p_template_types=>'LIST'
,p_help_text=>'Determines the display for a mobile-sized screen'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750891989635733148)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750892342801733149)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750892761456733149)
,p_theme_id=>42
,p_name=>'CONTENT_PADDING'
,p_display_name=>'Content Padding'
,p_display_sequence=>1
,p_template_types=>'PAGE'
,p_help_text=>'Sets the Content Body padding for the page.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750893131780733149)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'PAGE'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750893514463733149)
,p_theme_id=>42
,p_name=>'DISPLAY_MODE'
,p_display_name=>'Display Mode'
,p_display_sequence=>30
,p_template_types=>'PAGE'
,p_help_text=>'Determines the default display appearance and positioning of the dialog. The default opens a floating dialog position at the center of the screen.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750893981621733150)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND'
,p_display_name=>'Page Background'
,p_display_sequence=>20
,p_template_types=>'PAGE'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750894314090733150)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT'
,p_display_name=>'Page Layout'
,p_display_sequence=>10
,p_template_types=>'PAGE'
,p_null_text=>'Floating (Default)'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750894765883733150)
,p_theme_id=>42
,p_name=>'PAGE_POSITION'
,p_display_name=>'Position'
,p_display_sequence=>1
,p_template_types=>'PAGE'
,p_help_text=>'Sets the position of the page.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750895143527733150)
,p_theme_id=>42
,p_name=>'ACCENT'
,p_display_name=>'Accent'
,p_display_sequence=>30
,p_template_types=>'REGION'
,p_help_text=>'Set the Region''s accent. This accent corresponds to a Theme-Rollable color and sets the background of the Region''s Header.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750895597930733151)
,p_theme_id=>42
,p_name=>'ALERT_DISPLAY'
,p_display_name=>'Alert Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the layout of the Alert Region.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750895983136733151)
,p_theme_id=>42
,p_name=>'ALERT_ICONS'
,p_display_name=>'Alert Icons'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets how icons are handled for the Alert Region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750896319568733151)
,p_theme_id=>42
,p_name=>'ALERT_TITLE'
,p_display_name=>'Alert Title'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the title of the alert is displayed.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750896763287733151)
,p_theme_id=>42
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_help_text=>'Sets the type of alert which can be used to determine the icon, icon color, and the background color.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750897158047733152)
,p_theme_id=>42
,p_name=>'ALIGNMENT'
,p_display_name=>'Alignment'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'This sets the vertical alignment of the region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750897501690733152)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the animation when navigating within the Carousel Region.'
,p_null_text=>'Fade'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750897899718733152)
,p_theme_id=>42
,p_name=>'BODY_HEIGHT'
,p_display_name=>'Body Height'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body height. You can also specify a custom height by modifying the Region''s CSS Classes and using the height helper classes "i-hXXX" where XXX is any increment of 10 from 100 to 800.'
,p_null_text=>'Auto - Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750898338126733152)
,p_theme_id=>42
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Determines the scroll behavior when the region contents are larger than their container.'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750898714975733153)
,p_theme_id=>42
,p_name=>'BODY_PADDING'
,p_display_name=>'Body Padding'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the Region Body padding for the region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750899165902733153)
,p_theme_id=>42
,p_name=>'BODY_STYLE'
,p_display_name=>'Body Style'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the region''s body container.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750899507085733153)
,p_theme_id=>42
,p_name=>'CALLOUT_POSITION'
,p_display_name=>'Callout Position'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Determines where the callout for the popup will be positioned relative to its parent.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750899986755733153)
,p_theme_id=>42
,p_name=>'COLLAPSIBLE_BUTTON_ICONS'
,p_display_name=>'Collapsible Button Icons'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines which arrows to use to represent the icons for the collapse and expand button.'
,p_null_text=>'Arrows'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750900300685733154)
,p_theme_id=>42
,p_name=>'COLLAPSIBLE_ICON_POSITION'
,p_display_name=>'Collapsible Icon Position'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the position of the expand and collapse toggle for the region.'
,p_null_text=>'Start'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750900790784733154)
,p_theme_id=>42
,p_name=>'DEFAULT_STATE'
,p_display_name=>'Default State'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the default state of the region.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750901163857733154)
,p_theme_id=>42
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750901521730733155)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON'
,p_display_name=>'Display Icon'
,p_display_sequence=>50
,p_template_types=>'REGION'
,p_help_text=>'Display the Hero Region icon.'
,p_null_text=>'Yes (Default)'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750901973112733155)
,p_theme_id=>42
,p_name=>'DISPLAY_MODE'
,p_display_name=>'Display Mode'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Determines the default display appearance and positioning of the dialog. The default opens a floating dialog position at the center of the screen.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750902381065733155)
,p_theme_id=>42
,p_name=>'HEADER'
,p_display_name=>'Header'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_help_text=>'Determines the display of the Region Header which also contains the Region Title.'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750902760722733155)
,p_theme_id=>42
,p_name=>'HEADING_FONT'
,p_display_name=>'Heading Font'
,p_display_sequence=>100
,p_template_types=>'REGION'
,p_help_text=>'Sets the font-family of the heading for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750903103977733156)
,p_theme_id=>42
,p_name=>'HEADING_LEVEL'
,p_display_name=>'Heading Level'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750903515806733156)
,p_theme_id=>42
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750903945719733156)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'REGION'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Rounded Corners'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750904324862733156)
,p_theme_id=>42
,p_name=>'ICON_SIZE'
,p_display_name=>'Icon Size'
,p_display_sequence=>3
,p_template_types=>'REGION'
,p_null_text=>'Initial'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750904781379733157)
,p_theme_id=>42
,p_name=>'IMAGE_FILTER'
,p_display_name=>'Filter'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750905136356733157)
,p_theme_id=>42
,p_name=>'IMAGE_RATIO'
,p_display_name=>'Ratio'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750905516959733157)
,p_theme_id=>42
,p_name=>'IMAGE_SCALE'
,p_display_name=>'Scale'
,p_display_sequence=>20
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750905987156733157)
,p_theme_id=>42
,p_name=>'IMAGE_SHAPE'
,p_display_name=>'Shape'
,p_display_sequence=>30
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750906365484733158)
,p_theme_id=>42
,p_name=>'ITEM_PADDING'
,p_display_name=>'Item Spacing'
,p_display_sequence=>100
,p_template_types=>'REGION'
,p_help_text=>'Sets the padding around items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750906701505733158)
,p_theme_id=>42
,p_name=>'ITEM_SIZE'
,p_display_name=>'Item Size'
,p_display_sequence=>110
,p_template_types=>'REGION'
,p_help_text=>'Sets the size of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750907198325733158)
,p_theme_id=>42
,p_name=>'ITEM_WIDTH'
,p_display_name=>'Item Width'
,p_display_sequence=>120
,p_template_types=>'REGION'
,p_help_text=>'Sets the width of the form items within this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750907543332733158)
,p_theme_id=>42
,p_name=>'LABEL_ALIGNMENT'
,p_display_name=>'Label Alignment'
,p_display_sequence=>130
,p_template_types=>'REGION'
,p_help_text=>'Set the label text alignment for items within this region.'
,p_null_text=>'Right'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750907965404733159)
,p_theme_id=>42
,p_name=>'LABEL_POSITION'
,p_display_name=>'Label Position'
,p_display_sequence=>140
,p_template_types=>'REGION'
,p_help_text=>'Sets the position of the label relative to the form item.'
,p_null_text=>'Inline - Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750908355546733159)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750908754169733159)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER'
,p_display_name=>'Login Header'
,p_display_sequence=>10
,p_template_types=>'REGION'
,p_help_text=>'Controls the display of the Login region header.'
,p_null_text=>'Icon and Title (Default)'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750909198817733159)
,p_theme_id=>42
,p_name=>'REGION_BOTTOM_MARGIN'
,p_display_name=>'Bottom Margin'
,p_display_sequence=>210
,p_template_types=>'REGION'
,p_help_text=>'Set the bottom margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750909560251733160)
,p_theme_id=>42
,p_name=>'REGION_LEFT_MARGIN'
,p_display_name=>'Left Margin'
,p_display_sequence=>220
,p_template_types=>'REGION'
,p_help_text=>'Set the left margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750909923116733160)
,p_theme_id=>42
,p_name=>'REGION_POSITION'
,p_display_name=>'Position'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the position of the region.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750910318560733160)
,p_theme_id=>42
,p_name=>'REGION_RIGHT_MARGIN'
,p_display_name=>'Right Margin'
,p_display_sequence=>230
,p_template_types=>'REGION'
,p_help_text=>'Set the right margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750910738032733160)
,p_theme_id=>42
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Sets the source of the Title Bar region''s title.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750911145208733161)
,p_theme_id=>42
,p_name=>'REGION_TOP_MARGIN'
,p_display_name=>'Top Margin'
,p_display_sequence=>200
,p_template_types=>'REGION'
,p_help_text=>'Set the top margin for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750911528994733161)
,p_theme_id=>42
,p_name=>'RESULT_APPEARANCE'
,p_display_name=>'Result Appearance'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750911917274733162)
,p_theme_id=>42
,p_name=>'RESULT_SEPARATOR'
,p_display_name=>'Result Separator'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_null_text=>'Show'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750912339360733162)
,p_theme_id=>42
,p_name=>'SORT_ORDER_ALIGNMENT'
,p_display_name=>'Sort Order Alignment'
,p_display_sequence=>145
,p_template_types=>'REGION'
,p_help_text=>'Sets the alignment of the sort order item.'
,p_null_text=>'Default (Start)'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750912708010733162)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>40
,p_template_types=>'REGION'
,p_help_text=>'Determines how the region is styled. Use the "Remove Borders" template option to remove the region''s borders and shadows.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750913163953733162)
,p_theme_id=>42
,p_name=>'TABS_SIZE'
,p_display_name=>'Tabs Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750913519641733163)
,p_theme_id=>42
,p_name=>'TAB_STYLE'
,p_display_name=>'Tab Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750913982961733163)
,p_theme_id=>42
,p_name=>'TIMER'
,p_display_name=>'Timer'
,p_display_sequence=>2
,p_template_types=>'REGION'
,p_help_text=>'Sets the timer for when to automatically navigate to the next region within the Carousel Region.'
,p_null_text=>'No Timer'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750914333288733163)
,p_theme_id=>42
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Shades alternate rows in the report with slightly different background colors.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750914786110733163)
,p_theme_id=>42
,p_name=>'ANIMATION'
,p_display_name=>'Animation'
,p_display_sequence=>70
,p_template_types=>'REPORT'
,p_help_text=>'Sets the hover and focus animation.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750915160844733164)
,p_theme_id=>42
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750915533406733164)
,p_theme_id=>42
,p_name=>'BODY_TEXT'
,p_display_name=>'Body Text'
,p_display_sequence=>40
,p_template_types=>'REPORT'
,p_help_text=>'Determines the height of the card body.'
,p_null_text=>'Auto'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750915995787733164)
,p_theme_id=>42
,p_name=>'COLOR_ACCENTS'
,p_display_name=>'Color Accents'
,p_display_sequence=>50
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750916317826733164)
,p_theme_id=>42
,p_name=>'COL_ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>150
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750916764549733165)
,p_theme_id=>42
,p_name=>'COL_CONTENT_DESCRIPTION'
,p_display_name=>'Description'
,p_display_sequence=>130
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750917116013733165)
,p_theme_id=>42
,p_name=>'COL_CONTENT_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>120
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750917539896733165)
,p_theme_id=>42
,p_name=>'COL_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>110
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750917988838733166)
,p_theme_id=>42
,p_name=>'COL_MISC'
,p_display_name=>'Misc'
,p_display_sequence=>140
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750918394756733166)
,p_theme_id=>42
,p_name=>'COL_SELECTION'
,p_display_name=>'Selection'
,p_display_sequence=>100
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750918785216733166)
,p_theme_id=>42
,p_name=>'COMMENTS_STYLE'
,p_display_name=>'Comments Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the style in which comments are displayed.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750919154347733166)
,p_theme_id=>42
,p_name=>'CONTENT_ALIGNMENT'
,p_display_name=>'Content Alignment'
,p_display_sequence=>90
,p_template_types=>'REPORT'
,p_null_text=>'Center (Default)'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750919543925733167)
,p_theme_id=>42
,p_name=>'DISPLAY_ITEMS'
,p_display_name=>'Display Items'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_null_text=>'Inline (Default)'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750919942656733167)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS'
,p_display_name=>'Display Labels'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_null_text=>'Inline (Default)'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750920381272733167)
,p_theme_id=>42
,p_name=>'ICONS'
,p_display_name=>'Icons'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Controls how to handle icons in the report.'
,p_null_text=>'No Icons'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750920716459733168)
,p_theme_id=>42
,p_name=>'ICON_SHAPE'
,p_display_name=>'Icon Shape'
,p_display_sequence=>60
,p_template_types=>'REPORT'
,p_help_text=>'Determines the shape of the icon.'
,p_null_text=>'Circle'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750921124182733168)
,p_theme_id=>42
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750921542967733168)
,p_theme_id=>42
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Determines the layout of Cards in the report.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750921906800733168)
,p_theme_id=>42
,p_name=>'PAGINATION_DISPLAY'
,p_display_name=>'Pagination Display'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of pagination for this region.'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750922346983733169)
,p_theme_id=>42
,p_name=>'REPORT_BORDER'
,p_display_name=>'Report Border'
,p_display_sequence=>30
,p_template_types=>'REPORT'
,p_help_text=>'Controls the display of the Report''s borders.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750922736819733169)
,p_theme_id=>42
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>20
,p_template_types=>'REPORT'
,p_help_text=>'Determines whether you want the row to be highlighted on hover.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750923192699733169)
,p_theme_id=>42
,p_name=>'SIZE'
,p_display_name=>'Size'
,p_display_sequence=>35
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(750923501031733169)
,p_theme_id=>42
,p_name=>'STYLE'
,p_display_name=>'Style'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_help_text=>'Determines the overall style for the component.'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011767389272010272)
,p_theme_id=>142
,p_name=>'ALERT_TYPE'
,p_display_name=>'Alert Type'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011767695107010272)
,p_theme_id=>142
,p_name=>'DISPLAY_TYPE'
,p_display_name=>'Display Type'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011769648840010276)
,p_theme_id=>142
,p_name=>'REGION_STYLE'
,p_display_name=>'Region Style'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011770036188010276)
,p_theme_id=>142
,p_name=>'REGION_PADDING'
,p_display_name=>'Region Padding'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011771755821010281)
,p_theme_id=>142
,p_name=>'BODY_HEIGHT'
,p_display_name=>'Body Height'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Extend to Fit Contents'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011772262865010281)
,p_theme_id=>142
,p_name=>'REGION_HEADER'
,p_display_name=>'Region Header'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011772484741010282)
,p_theme_id=>142
,p_name=>'BODY_OVERFLOW'
,p_display_name=>'Body Overflow'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011773647695010282)
,p_theme_id=>142
,p_name=>'REGION_TYPE'
,p_display_name=>'Region Type'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Normal - Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011774587727010283)
,p_theme_id=>142
,p_name=>'HIDE_STEPS_FOR'
,p_display_name=>'Hide Steps For'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011775349927010284)
,p_theme_id=>142
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>1
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011775617478010284)
,p_theme_id=>142
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011777678969010288)
,p_theme_id=>142
,p_name=>'ALTERNATING_ROWS'
,p_display_name=>'Alternating Rows'
,p_display_sequence=>1
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011778143185010288)
,p_theme_id=>142
,p_name=>'ROW_HIGHLIGHTING'
,p_display_name=>'Row Highlighting'
,p_display_sequence=>1
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011778415094010288)
,p_theme_id=>142
,p_name=>'REPORT_BORDER'
,p_display_name=>'Report Border'
,p_display_sequence=>1
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011779793869010292)
,p_theme_id=>142
,p_name=>'LAYOUT'
,p_display_name=>'Layout'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011780727060010294)
,p_theme_id=>142
,p_name=>'BADGE_SIZE'
,p_display_name=>'Badge Size'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011782170565010296)
,p_theme_id=>142
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011783303429010297)
,p_theme_id=>142
,p_name=>'ICON_STYLE'
,p_display_name=>'Icon Style'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011785180735010302)
,p_theme_id=>142
,p_name=>'LABEL_DISPLAY'
,p_display_name=>'Label Display'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011786399886010305)
,p_theme_id=>142
,p_name=>'ICON_POSITION'
,p_display_name=>'Icon Position'
,p_display_sequence=>1
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011787110234010306)
,p_theme_id=>142
,p_name=>'BREADCRUMB_DIVIDER'
,p_display_name=>'Breadcrumb Divider'
,p_display_sequence=>1
,p_template_types=>'BREADCRUMB'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011788428009010309)
,p_theme_id=>142
,p_name=>'BUTTON_TYPE'
,p_display_name=>'Button Type'
,p_display_sequence=>1
,p_template_types=>'BUTTON'
,p_null_text=>'Normal'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011788727262010309)
,p_theme_id=>142
,p_name=>'SPACING_LEFT'
,p_display_name=>'Spacing Left'
,p_display_sequence=>1
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011789012039010309)
,p_theme_id=>142
,p_name=>'SPACING_RIGHT'
,p_display_name=>'Spacing Right'
,p_display_sequence=>1
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011789446354010310)
,p_theme_id=>142
,p_name=>'BUTTON_SIZE'
,p_display_name=>'Button Size'
,p_display_sequence=>1
,p_template_types=>'BUTTON'
,p_null_text=>'Default Size'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011789684619010310)
,p_theme_id=>142
,p_name=>'BUTTON_STYLE'
,p_display_name=>'Button Style'
,p_display_sequence=>1
,p_template_types=>'BUTTON'
,p_null_text=>'Default Style'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011790192500010311)
,p_theme_id=>142
,p_name=>'BUTTON_SET'
,p_display_name=>'Button Set'
,p_display_sequence=>1
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011791061524010311)
,p_theme_id=>142
,p_name=>'BUTTON_WIDTH'
,p_display_name=>'Button Width'
,p_display_sequence=>1
,p_template_types=>'BUTTON'
,p_null_text=>'Default Width'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011791473243010311)
,p_theme_id=>142
,p_name=>'FORM_LABEL_WIDTH'
,p_display_name=>'Form Label Width'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Help text for Form Label Width'
,p_null_text=>'Default Width'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011792032683010311)
,p_theme_id=>142
,p_name=>'FORM_LABEL_POSITION'
,p_display_name=>'Form Label Position'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Inline - Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011792294375010311)
,p_theme_id=>142
,p_name=>'FORM_ITEMS_SIZE'
,p_display_name=>'Form Items Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default Size'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011792609313010312)
,p_theme_id=>142
,p_name=>'LABEL_ALIGNMENT'
,p_display_name=>'Label Alignment'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_help_text=>'Set the label text alignment for items within this region.'
,p_null_text=>'Right'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1011792943288010312)
,p_theme_id=>142
,p_name=>'FORM_ITEM_PADDING'
,p_display_name=>'Form Item Padding'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default Padding'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1073638008888306533)
,p_theme_id=>142
,p_name=>'NAVIGATION_COLOR_SCHEME'
,p_display_name=>'Navigation Color Scheme'
,p_display_sequence=>1
,p_template_types=>'PAGE'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1096308593835388989)
,p_theme_id=>142
,p_name=>'CURRENT_PAGE'
,p_display_name=>'Current Page'
,p_display_sequence=>1
,p_template_types=>'BREADCRUMB'
,p_null_text=>'Visible - Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1255709133758961662)
,p_theme_id=>142
,p_name=>'REGION_ACCENT'
,p_display_name=>'Region Accent'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1255715045405961671)
,p_theme_id=>142
,p_name=>'LIST_STYLE'
,p_display_name=>'List Style'
,p_display_sequence=>1
,p_template_types=>'LIST'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1294952071296284004)
,p_theme_id=>142
,p_name=>'DIALOG_SIZE'
,p_display_name=>'Dialog Size'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1294954509811284007)
,p_theme_id=>142
,p_name=>'DISPLAY'
,p_display_name=>'Display'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1294973593095284037)
,p_theme_id=>142
,p_name=>'FORM_ITEM_WIDTH'
,p_display_name=>'Form Item Width'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_null_text=>'Default'
,p_is_advanced=>'Y'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1380970837587213950)
,p_theme_id=>142
,p_name=>'LABEL_WIDTH'
,p_display_name=>'Label Width'
,p_display_sequence=>10
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1384495270232571313)
,p_theme_id=>142
,p_name=>'REGION_TITLE'
,p_display_name=>'Region Title'
,p_display_sequence=>1
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_opt_group(
 p_id=>wwv_flow_imp.id(1560739803845660637)
,p_theme_id=>142
,p_name=>'COMMENTS_STYLE'
,p_display_name=>'Comments Style'
,p_display_sequence=>1
,p_template_types=>'REPORT'
,p_null_text=>'Default'
,p_is_advanced=>'N'
);
end;
/
prompt --application/shared_components/user_interface/template_options
begin
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72253863367945692)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_imp.id(1949379456547220377)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72271892306945702)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_imp.id(1949384785685220388)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72388412340945778)
,p_theme_id=>42
,p_name=>'COLLAPSED_DEFAULT'
,p_display_name=>'Collapsed by Default'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949422988307220490)
,p_css_classes=>'js-defaultCollapsed'
,p_template_types=>'LIST'
,p_help_text=>'This option will load the side navigation menu in a collapsed state by default.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72438038196945811)
,p_theme_id=>42
,p_name=>'2_COLUMN_GRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72438445220945811)
,p_theme_id=>42
,p_name=>'3_COLUMN_GRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72438828612945811)
,p_theme_id=>42
,p_name=>'4_COLUMN_GRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72439253322945812)
,p_theme_id=>42
,p_name=>'5_COLUMN_GRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72439630399945812)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72440043299945812)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72440421263945812)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72440783909945812)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72441213010945813)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(72441584894945813)
,p_theme_id=>42
,p_name=>'STACK'
,p_display_name=>'Stack'
,p_display_sequence=>5
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--stack'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(110265390318992763)
,p_theme_id=>42
,p_name=>'NONE'
,p_display_name=>'None'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_css_classes=>'js-dialog-nosize'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(177546548705341898)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(177546950384341898)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(177547354094341898)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(177547703528341898)
,p_theme_id=>42
,p_name=>'NONE'
,p_display_name=>'None'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-dialog-nosize'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(177548121143341899)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(202956783302269909)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(2139854369470213616)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Enables you to define a keyboard shortcut to activate the menu item.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(225808699531748004)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_imp.id(223715108711423199)
,p_css_classes=>'t-Timeline--compact'
,p_group_id=>wwv_flow_imp.id(750923501031733169)
,p_template_types=>'REPORT'
,p_help_text=>'Displays a compact version of timeline with smaller text and fewer columns.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274113511111360286)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-ContentBlock--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274121909571360293)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274126823335360296)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274194793651360346)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949422988307220490)
,p_css_classes=>'t-TreeNav--styleB'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation B'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274195470148360346)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949422988307220490)
,p_css_classes=>'t-TreeNav--styleA'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
,p_help_text=>'Style Variation A'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274196134515360346)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Classic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949422988307220490)
,p_css_classes=>'t-TreeNav--classic'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
,p_help_text=>'Classic Style'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274208266962360355)
,p_theme_id=>42
,p_name=>'WIZARD_PROGRESS_LINKS'
,p_display_name=>'Make Wizard Steps Clickable'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_imp.id(1949424871898220496)
,p_css_classes=>'js-wizardProgressLinks'
,p_template_types=>'LIST'
,p_help_text=>'This option will make the wizard steps clickable links.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274258915498360392)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_imp.id(1949426445798220509)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_imp.id(750878373848733140)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274259546016360393)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_imp.id(1949426445798220509)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_imp.id(750878373848733140)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274261889779360395)
,p_theme_id=>42
,p_name=>'PUSH'
,p_display_name=>'Push'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_css_classes=>'t-Button--hoverIconPush'
,p_group_id=>wwv_flow_imp.id(750878373848733140)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will animate to the right or left on button hover or focus.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274262584314360395)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_css_classes=>'t-Button--hoverIconSpin'
,p_group_id=>wwv_flow_imp.id(750878373848733140)
,p_template_types=>'BUTTON'
,p_help_text=>'The icon will spin on button hover or focus.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(274262984033360395)
,p_theme_id=>42
,p_name=>'HIDE_LABEL_ON_MOBILE'
,p_display_name=>'Hide Label on Mobile'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_css_classes=>'t-Button--mobileHideLabel'
,p_template_types=>'BUTTON'
,p_help_text=>'This template options hides the button label on small screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313455086559120476)
,p_theme_id=>42
,p_name=>'ICONS_PLUS_OR_MINUS'
,p_display_name=>'Plus or Minus'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--hideShowIconsMath'
,p_group_id=>wwv_flow_imp.id(750899986755733153)
,p_template_types=>'REGION'
,p_help_text=>'Use the plus and minus icons for the expand and collapse button.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313455741809120476)
,p_theme_id=>42
,p_name=>'CONRTOLS_POSITION_END'
,p_display_name=>'End'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--controlsPosEnd'
,p_group_id=>wwv_flow_imp.id(750900300685733154)
,p_template_types=>'REGION'
,p_help_text=>'Position the expand / collapse button to the end of the region header.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313472942603120490)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_css_classes=>'t-HeroRegion--iconsSquare'
,p_group_id=>wwv_flow_imp.id(750903945719733156)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a square.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313473675054120491)
,p_theme_id=>42
,p_name=>'ICONS_CIRCULAR'
,p_display_name=>'Circle'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_css_classes=>'t-HeroRegion--iconsCircle'
,p_group_id=>wwv_flow_imp.id(750903945719733156)
,p_template_types=>'REGION'
,p_help_text=>'The icons are displayed within a circle.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313482905898120498)
,p_theme_id=>42
,p_name=>'REMOVE_PAGE_OVERLAY'
,p_display_name=>'Remove Page Overlay'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-popup-noOverlay'
,p_template_types=>'REGION'
,p_help_text=>'This option will display the inline dialog without an overlay on the background.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313528315128120534)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_imp.id(750889944628733147)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313529015977120536)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_imp.id(750889944628733147)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313546238289120549)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_imp.id(750889944628733147)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313546901387120549)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_imp.id(750889944628733147)
,p_template_types=>'LIST'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313580642652120577)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--iconsSquare'
,p_group_id=>wwv_flow_imp.id(750920716459733168)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313581305434120577)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--iconsRounded'
,p_group_id=>wwv_flow_imp.id(750920716459733168)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313594936304120588)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949409987720220457)
,p_css_classes=>'t-Comments--iconsSquare'
,p_group_id=>wwv_flow_imp.id(750920716459733168)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313595624933120589)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949409987720220457)
,p_css_classes=>'t-Comments--iconsRounded'
,p_group_id=>wwv_flow_imp.id(750920716459733168)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313599063330120591)
,p_theme_id=>42
,p_name=>'ICONS_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--iconsSquare'
,p_group_id=>wwv_flow_imp.id(750920716459733168)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square shape.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(313599797191120592)
,p_theme_id=>42
,p_name=>'ICONS_ROUNDED'
,p_display_name=>'Rounded Corners'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--iconsRounded'
,p_group_id=>wwv_flow_imp.id(750920716459733168)
,p_template_types=>'REPORT'
,p_help_text=>'The icons are displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320329591874562306)
,p_theme_id=>42
,p_name=>'DRAWER_SIZE_EXTRA_LARGE'
,p_display_name=>'Extra Large'
,p_display_sequence=>40
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_css_classes=>'js-dialog-class-t-Drawer--xl'
,p_group_id=>wwv_flow_imp.id(750893131780733149)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320329932219562306)
,p_theme_id=>42
,p_name=>'DRAWER_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_css_classes=>'js-dialog-class-t-Drawer--lg'
,p_group_id=>wwv_flow_imp.id(750893131780733149)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320330336704562306)
,p_theme_id=>42
,p_name=>'DRAWER_SIZE_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_css_classes=>'js-dialog-class-t-Drawer--md'
,p_group_id=>wwv_flow_imp.id(750893131780733149)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320330797457562305)
,p_theme_id=>42
,p_name=>'DRAWER_SIZE_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_css_classes=>'js-dialog-class-t-Drawer--sm'
,p_group_id=>wwv_flow_imp.id(750893131780733149)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320331100903562305)
,p_theme_id=>42
,p_name=>'POSITION_END'
,p_display_name=>'End'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_css_classes=>'js-dialog-class-t-Drawer--pullOutEnd'
,p_group_id=>wwv_flow_imp.id(750894765883733150)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320331547853562305)
,p_theme_id=>42
,p_name=>'POSITION_START'
,p_display_name=>'Start'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_css_classes=>'js-dialog-class-t-Drawer--pullOutStart'
,p_group_id=>wwv_flow_imp.id(750894765883733150)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320331937674562304)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_imp.id(320327565288562308)
,p_css_classes=>'t-Dialog--noPadding'
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320528582628562109)
,p_theme_id=>42
,p_name=>'DRAWER_SIZE_EXTRA_LARGE'
,p_display_name=>'Extra Large'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(320524020049562112)
,p_css_classes=>'js-dialog-class-t-Drawer--xl'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320528901490562109)
,p_theme_id=>42
,p_name=>'DRAWER_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(320524020049562112)
,p_css_classes=>'js-dialog-class-t-Drawer--lg'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320529394518562109)
,p_theme_id=>42
,p_name=>'DRAWER_SIZE_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(320524020049562112)
,p_css_classes=>'js-dialog-class-t-Drawer--md'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320529729196562109)
,p_theme_id=>42
,p_name=>'DRAWER_SIZE_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(320524020049562112)
,p_css_classes=>'js-dialog-class-t-Drawer--sm'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320530130122562108)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(320524020049562112)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320530516295562108)
,p_theme_id=>42
,p_name=>'NONE'
,p_display_name=>'None (Auto)'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_imp.id(320524020049562112)
,p_css_classes=>'js-dialog-nosize'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320530907934562104)
,p_theme_id=>42
,p_name=>'POSITION_END'
,p_display_name=>'End'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(320524020049562112)
,p_css_classes=>'js-dialog-class-t-Drawer--pullOutEnd'
,p_group_id=>wwv_flow_imp.id(750909923116733160)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320531381839562103)
,p_theme_id=>42
,p_name=>'POSITION_START'
,p_display_name=>'Start'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(320524020049562112)
,p_css_classes=>'js-dialog-class-t-Drawer--pullOutStart'
,p_group_id=>wwv_flow_imp.id(750909923116733160)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320531759647562103)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_imp.id(320524020049562112)
,p_css_classes=>'t-DialogRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the region body.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(320651571297561971)
,p_theme_id=>42
,p_name=>'HIDE_ICON_ON_DESKTOP'
,p_display_name=>'Hide Icon on Desktop'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_css_classes=>'t-Button--desktopHideIcon'
,p_template_types=>'BUTTON'
,p_help_text=>'This template options hides the button icon on large screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454501305939587506)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-ContentBlock--hideHeader'
,p_group_id=>wwv_flow_imp.id(750902381065733155)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454502080142587507)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-Region--removeHeader js-removeLandmark'
,p_group_id=>wwv_flow_imp.id(750902381065733155)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454634952998587609)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(454632904047587607)
,p_css_classes=>'u-colors'
,p_template_types=>'REGION'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within search results.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454635370125587609)
,p_theme_id=>42
,p_name=>'ICON_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_imp.id(454632904047587607)
,p_css_classes=>'t-ResultsRegion--iconLg'
,p_group_id=>wwv_flow_imp.id(750904324862733156)
,p_template_types=>'REGION'
,p_help_text=>'Sets the icon size to large (64px).'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454635751906587609)
,p_theme_id=>42
,p_name=>'ICON_SIZE_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>2
,p_region_template_id=>wwv_flow_imp.id(454632904047587607)
,p_css_classes=>'t-ResultsRegion--iconMd'
,p_group_id=>wwv_flow_imp.id(750904324862733156)
,p_template_types=>'REGION'
,p_help_text=>'Sets the icon size to medium (32px).'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454636134935587610)
,p_theme_id=>42
,p_name=>'ICON_SIZE_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(454632904047587607)
,p_css_classes=>'t-ResultsRegion--iconSm'
,p_group_id=>wwv_flow_imp.id(750904324862733156)
,p_template_types=>'REGION'
,p_help_text=>'Sets the icon size to small (16px).'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454636577916587610)
,p_theme_id=>42
,p_name=>'RESULT_APPEARANCE_BOXED'
,p_display_name=>'Boxed'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(454632904047587607)
,p_css_classes=>'t-ResultsRegion--boxed'
,p_group_id=>wwv_flow_imp.id(750911528994733161)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454636984901587610)
,p_theme_id=>42
,p_name=>'RESULT_APPEARANCE_FLAT'
,p_display_name=>'Flat'
,p_display_sequence=>2
,p_region_template_id=>wwv_flow_imp.id(454632904047587607)
,p_css_classes=>'t-ResultsRegion--flat'
,p_group_id=>wwv_flow_imp.id(750911528994733161)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454639237666587612)
,p_theme_id=>42
,p_name=>'ALIGNMENT_CENTER'
,p_display_name=>'Center'
,p_display_sequence=>11
,p_region_template_id=>wwv_flow_imp.id(454637287460587610)
,p_css_classes=>'t-ItemContainer--alignCenter'
,p_group_id=>wwv_flow_imp.id(750897158047733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454639631204587612)
,p_theme_id=>42
,p_name=>'ALIGNMENT_END'
,p_display_name=>'End'
,p_display_sequence=>12
,p_region_template_id=>wwv_flow_imp.id(454637287460587610)
,p_css_classes=>'t-ItemContainer--alignEnd'
,p_group_id=>wwv_flow_imp.id(750897158047733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454640058276587612)
,p_theme_id=>42
,p_name=>'ALIGNMENT_START'
,p_display_name=>'Start'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(454637287460587610)
,p_css_classes=>'t-ItemContainer--alignStart'
,p_group_id=>wwv_flow_imp.id(750897158047733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454640423390587612)
,p_theme_id=>42
,p_name=>'ALIGNMENT_STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>13
,p_region_template_id=>wwv_flow_imp.id(454637287460587610)
,p_css_classes=>'t-ItemContainer--alignStretch'
,p_group_id=>wwv_flow_imp.id(750897158047733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454640775818587613)
,p_theme_id=>42
,p_name=>'STACK_MOBILE'
,p_display_name=>'Stack on Mobile'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(454637287460587610)
,p_css_classes=>'t-ItemContainer--stackMobile'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(454641177097587613)
,p_theme_id=>42
,p_name=>'WRAP_ITEMS'
,p_display_name=>'Wrap Items'
,p_display_sequence=>2
,p_region_template_id=>wwv_flow_imp.id(454637287460587610)
,p_css_classes=>'t-ItemContainer--wrap'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469835710978570064)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469877733875570096)
,p_theme_id=>42
,p_name=>'SHOW_REGION_ICON'
,p_display_name=>'Show Region Icon'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--showIcon'
,p_template_types=>'REGION'
,p_help_text=>'Displays the region icon in the region header beside the region title'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469905703583570122)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469906437508570122)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469907109253570123)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469917142018570131)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469917814652570131)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469949423474570155)
,p_theme_id=>42
,p_name=>'NO_LABEL_LG'
,p_display_name=>'Do not display labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(72397434093945784)
,p_css_classes=>'t-NavTabs--hiddenLabels-lg'
,p_group_id=>wwv_flow_imp.id(750888761339733146)
,p_template_types=>'LIST'
,p_help_text=>'Hides the label for the list item'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469950095849570156)
,p_theme_id=>42
,p_name=>'LABEL_INLINE_LG'
,p_display_name=>'Display labels inline'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(72397434093945784)
,p_css_classes=>'t-NavTabs--inlineLabels-lg'
,p_group_id=>wwv_flow_imp.id(750888761339733146)
,p_template_types=>'LIST'
,p_help_text=>'Display the label inline with the icon and badge'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469950845364570156)
,p_theme_id=>42
,p_name=>'LABEL_ABOVE_LG'
,p_display_name=>'Display labels above'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(72397434093945784)
,p_css_classes=>'t-NavTabs--stacked'
,p_group_id=>wwv_flow_imp.id(750888761339733146)
,p_template_types=>'LIST'
,p_help_text=>'Display the label stacked above the icon and badge'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469951511172570157)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS_SM'
,p_display_name=>'Display labels'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_imp.id(72397434093945784)
,p_css_classes=>'t-NavTabs--displayLabels-sm'
,p_group_id=>wwv_flow_imp.id(750891577760733148)
,p_template_types=>'LIST'
,p_help_text=>'Displays the label for the list items below the icon'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469952232023570157)
,p_theme_id=>42
,p_name=>'HIDE_LABELS_SM'
,p_display_name=>'Do not display labels'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_imp.id(72397434093945784)
,p_css_classes=>'t-NavTabs--hiddenLabels-sm'
,p_group_id=>wwv_flow_imp.id(750891577760733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469958934089570164)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469959641404570164)
,p_theme_id=>42
,p_name=>'CIRCULAR'
,p_display_name=>'Circular'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--circular'
,p_group_id=>wwv_flow_imp.id(750923501031733169)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469960330831570165)
,p_theme_id=>42
,p_name=>'GRID'
,p_display_name=>'Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--dash'
,p_group_id=>wwv_flow_imp.id(750923501031733169)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469970636594570173)
,p_theme_id=>42
,p_name=>'BLOCK'
,p_display_name=>'Block'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--featured t-Cards--block force-fa-lg'
,p_group_id=>wwv_flow_imp.id(750923501031733169)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(469970981772570173)
,p_theme_id=>42
,p_name=>'DISPLAY_SUBTITLE'
,p_display_name=>'Display Subtitle'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--displaySubtitle'
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(518653438125248400)
,p_theme_id=>42
,p_name=>'USE_COMPACT_STYLE'
,p_display_name=>'Use Compact Style'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_css_classes=>'t-BreadcrumbRegion--compactTitle'
,p_template_types=>'REGION'
,p_help_text=>'Uses a compact style for the breadcrumbs.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(518726447468248457)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(72437493019945811)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_imp.id(750923192699733169)
,p_template_types=>'REPORT'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564009292582923466)
,p_theme_id=>42
,p_name=>'FILTER_BLUR'
,p_display_name=>'Blur'
,p_display_sequence=>430
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--blur'
,p_group_id=>wwv_flow_imp.id(750904781379733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564009629526923467)
,p_theme_id=>42
,p_name=>'FILTER_GRAYSCALE'
,p_display_name=>'Grayscale'
,p_display_sequence=>410
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--grayscale'
,p_group_id=>wwv_flow_imp.id(750904781379733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564010085619923467)
,p_theme_id=>42
,p_name=>'FILTER_INVERT'
,p_display_name=>'Invert'
,p_display_sequence=>440
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--invert'
,p_group_id=>wwv_flow_imp.id(750904781379733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564010481717923467)
,p_theme_id=>42
,p_name=>'FILTER_NONE'
,p_display_name=>'None'
,p_display_sequence=>400
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--noFilter'
,p_group_id=>wwv_flow_imp.id(750904781379733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564010839828923468)
,p_theme_id=>42
,p_name=>'FILTER_SATURATE'
,p_display_name=>'Saturate'
,p_display_sequence=>450
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--saturate'
,p_group_id=>wwv_flow_imp.id(750904781379733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564011202364923468)
,p_theme_id=>42
,p_name=>'FILTER_SEPIA'
,p_display_name=>'Sepia'
,p_display_sequence=>420
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--sepia'
,p_group_id=>wwv_flow_imp.id(750904781379733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564011656046923468)
,p_theme_id=>42
,p_name=>'IMAGE_STRETCH'
,p_display_name=>'Image Stretch'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--stretch'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564012087992923470)
,p_theme_id=>42
,p_name=>'RATIO_16_9'
,p_display_name=>'16:9 (Widescreen)'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--16x9'
,p_group_id=>wwv_flow_imp.id(750905136356733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564012448053923470)
,p_theme_id=>42
,p_name=>'RATIO_1_1'
,p_display_name=>'1:1 (Square)'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--1x1'
,p_group_id=>wwv_flow_imp.id(750905136356733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564012821337923470)
,p_theme_id=>42
,p_name=>'RATIO_2_1'
,p_display_name=>'2:1 (Univisium)'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--2x1'
,p_group_id=>wwv_flow_imp.id(750905136356733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564013279547923470)
,p_theme_id=>42
,p_name=>'RATIO_4_3'
,p_display_name=>'4:3 (Standard)'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--4x3'
,p_group_id=>wwv_flow_imp.id(750905136356733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564013625276923471)
,p_theme_id=>42
,p_name=>'RATIO_AUTO'
,p_display_name=>'Auto'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--auto'
,p_group_id=>wwv_flow_imp.id(750905136356733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564014014810923471)
,p_theme_id=>42
,p_name=>'SCALE_CONTAIN'
,p_display_name=>'Contain'
,p_display_sequence=>200
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--contain'
,p_group_id=>wwv_flow_imp.id(750905516959733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564014418134923471)
,p_theme_id=>42
,p_name=>'SCALE_COVER'
,p_display_name=>'Cover'
,p_display_sequence=>210
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--cover'
,p_group_id=>wwv_flow_imp.id(750905516959733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564014882020923471)
,p_theme_id=>42
,p_name=>'SCALE_DOWN'
,p_display_name=>'Scale Down'
,p_display_sequence=>230
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--scale-down'
,p_group_id=>wwv_flow_imp.id(750905516959733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564015213114923472)
,p_theme_id=>42
,p_name=>'SCALE_FILL'
,p_display_name=>'Fill'
,p_display_sequence=>220
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--fill'
,p_group_id=>wwv_flow_imp.id(750905516959733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564015664821923472)
,p_theme_id=>42
,p_name=>'SHAPE_CIRCLE'
,p_display_name=>'Circle'
,p_display_sequence=>320
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--circle'
,p_group_id=>wwv_flow_imp.id(750905987156733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564016062454923472)
,p_theme_id=>42
,p_name=>'SHAPE_ROUNDED'
,p_display_name=>'Rounded'
,p_display_sequence=>310
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--rounded'
,p_group_id=>wwv_flow_imp.id(750905987156733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(564016451803923472)
,p_theme_id=>42
,p_name=>'SHAPE_SQUARE'
,p_display_name=>'Square'
,p_display_sequence=>300
,p_region_template_id=>wwv_flow_imp.id(564007704899923465)
,p_css_classes=>'t-ImageRegion--square'
,p_group_id=>wwv_flow_imp.id(750905987156733157)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(592326529704240110)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_imp.id(1949379456547220377)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(592344266938240127)
,p_theme_id=>42
,p_name=>'STRETCH_TO_FIT_WINDOW'
,p_display_name=>'Stretch to Fit Window'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_imp.id(1949384785685220388)
,p_css_classes=>'ui-dialog--stretch'
,p_template_types=>'PAGE'
,p_help_text=>'Stretch the dialog to fit the browser window.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(592394102752240190)
,p_theme_id=>42
,p_name=>'TEXT_CONTENT'
,p_display_name=>'Text Content'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--textContent'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_help_text=>'Useful for displaying primarily text-based content, such as FAQs and more.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(615424581291921047)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(615424010440921046)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Displays a callout arrow that points to where the menu was activated from.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(615424958986921047)
,p_theme_id=>42
,p_name=>'FULL_WIDTH'
,p_display_name=>'Full Width'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(615424010440921046)
,p_css_classes=>'t-MegaMenu--fullWidth'
,p_template_types=>'LIST'
,p_help_text=>'Stretches the menu to fill the width of the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(615425317334921047)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(615424010440921046)
,p_css_classes=>'t-MegaMenu--layout2Cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(615425793416921047)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(615424010440921046)
,p_css_classes=>'t-MegaMenu--layout3Cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(615426156466921047)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(615424010440921046)
,p_css_classes=>'t-MegaMenu--layout4Cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(615426533419921048)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_imp.id(615424010440921046)
,p_css_classes=>'t-MegaMenu--layout5Cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(615426931640921048)
,p_theme_id=>42
,p_name=>'CUSTOM'
,p_display_name=>'Custom'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_imp.id(615424010440921046)
,p_css_classes=>'t-MegaMenu--layoutCustom'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(615427317222921048)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_imp.id(615424010440921046)
,p_css_classes=>'t-MegaMenu--layoutStacked'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(619863168562560690)
,p_theme_id=>42
,p_name=>'AUTO_HEIGHT_INLINE_DIALOG'
,p_display_name=>'Auto Height'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_css_classes=>'js-dialog-autoheight'
,p_template_types=>'REGION'
,p_help_text=>'This option will set the height of the dialog to fit its contents.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661169907021843960)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_3'
,p_display_name=>'Background 3'
,p_display_sequence=>30
,p_page_template_id=>wwv_flow_imp.id(1949373694717220360)
,p_css_classes=>'t-LoginPage--bg3'
,p_group_id=>wwv_flow_imp.id(750893981621733150)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661170654045843960)
,p_theme_id=>42
,p_name=>'PAGE_LAYOUT_SPLIT'
,p_display_name=>'Split'
,p_display_sequence=>1
,p_page_template_id=>wwv_flow_imp.id(1949373694717220360)
,p_css_classes=>'t-LoginPage--split'
,p_group_id=>wwv_flow_imp.id(750894314090733150)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661171312839843960)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_1'
,p_display_name=>'Background 1'
,p_display_sequence=>10
,p_page_template_id=>wwv_flow_imp.id(1949373694717220360)
,p_css_classes=>'t-LoginPage--bg1'
,p_group_id=>wwv_flow_imp.id(750893981621733150)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661172030745843961)
,p_theme_id=>42
,p_name=>'PAGE_BACKGROUND_2'
,p_display_name=>'Background 2'
,p_display_sequence=>20
,p_page_template_id=>wwv_flow_imp.id(1949373694717220360)
,p_css_classes=>'t-LoginPage--bg2'
,p_group_id=>wwv_flow_imp.id(750893981621733150)
,p_template_types=>'PAGE'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661271472817844034)
,p_theme_id=>42
,p_name=>'DISPLAY_POPUP_CALLOUT'
,p_display_name=>'Display Popup Callout'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-popup-callout'
,p_template_types=>'REGION'
,p_help_text=>'Use this option to add display a callout for the popup. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661272156174844035)
,p_theme_id=>42
,p_name=>'BEFORE'
,p_display_name=>'Before'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-popup-pos-before'
,p_group_id=>wwv_flow_imp.id(750899507085733153)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout before or typically to the left of the parent.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661272873137844035)
,p_theme_id=>42
,p_name=>'AFTER'
,p_display_name=>'After'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-popup-pos-after'
,p_group_id=>wwv_flow_imp.id(750899507085733153)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout after or typically to the right of the parent.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661273572349844036)
,p_theme_id=>42
,p_name=>'ABOVE'
,p_display_name=>'Above'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-popup-pos-above'
,p_group_id=>wwv_flow_imp.id(750899507085733153)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout above or typically on top of the parent.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661274212599844036)
,p_theme_id=>42
,p_name=>'BELOW'
,p_display_name=>'Below'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-popup-pos-below'
,p_group_id=>wwv_flow_imp.id(750899507085733153)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout below or typically to the bottom of the parent.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661274949603844037)
,p_theme_id=>42
,p_name=>'INSIDE'
,p_display_name=>'Inside'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_imp.id(177545551280341897)
,p_css_classes=>'js-popup-pos-inside'
,p_group_id=>wwv_flow_imp.id(750899507085733153)
,p_template_types=>'REGION'
,p_help_text=>'Positions the callout inside of the parent. This is useful when the parent is sufficiently large, such as a report or large region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661284356173844043)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_ICON'
,p_display_name=>'Icon'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949397421054220421)
,p_css_classes=>'t-Login-region--headerIcon'
,p_group_id=>wwv_flow_imp.id(750908754169733159)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Icon in the Login region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661285081226844044)
,p_theme_id=>42
,p_name=>'LOGIN_HEADER_TITLE'
,p_display_name=>'Title'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949397421054220421)
,p_css_classes=>'t-Login-region--headerTitle js-removeLandmark'
,p_group_id=>wwv_flow_imp.id(750908754169733159)
,p_template_types=>'REGION'
,p_help_text=>'Displays only the Region Title in the Login region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661285704418844044)
,p_theme_id=>42
,p_name=>'LOGO_HEADER_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949397421054220421)
,p_css_classes=>'t-Login-region--headerHidden js-removeLandmark'
,p_group_id=>wwv_flow_imp.id(750908754169733159)
,p_template_types=>'REGION'
,p_help_text=>'Hides both the Region Icon and Title from the Login region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661350005514844096)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_imp.id(1949422252641220485)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661352275678844098)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(2139854369470213616)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu. Note that callout will only be displayed if the data-parent-element custom attribute is defined.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661353599175844099)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949422808189220487)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661354827805844100)
,p_theme_id=>42
,p_name=>'ICON_DEFAULT'
,p_display_name=>'Icon'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949422988307220490)
,p_css_classes=>'js-navCollapsed--default'
,p_group_id=>wwv_flow_imp.id(750887986809733146)
,p_template_types=>'LIST'
,p_help_text=>'Display icons when the navigation menu is collapsed for large screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661355565899844100)
,p_theme_id=>42
,p_name=>'COLLAPSE_STYLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949422988307220490)
,p_css_classes=>'js-navCollapsed--hidden'
,p_group_id=>wwv_flow_imp.id(750887986809733146)
,p_template_types=>'LIST'
,p_help_text=>'Completely hide the navigation menu when it is collapsed.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661364001855844107)
,p_theme_id=>42
,p_name=>'DISPLAY_MENU_CALLOUT'
,p_display_name=>'Display Menu Callout'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_imp.id(1949424306183220494)
,p_css_classes=>'js-menu-callout'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add display a callout for the menu.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661421473823844151)
,p_theme_id=>42
,p_name=>'ACTIONS_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_imp.id(661420922046844151)
,p_css_classes=>'t-ContentRow--hideActions'
,p_group_id=>wwv_flow_imp.id(750916317826733164)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Actions column from being rendered on the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661421836177844151)
,p_theme_id=>42
,p_name=>'ALIGNMENT_TOP'
,p_display_name=>'Top'
,p_display_sequence=>100
,p_report_template_id=>wwv_flow_imp.id(661420922046844151)
,p_css_classes=>'t-ContentRow--alignTop'
,p_group_id=>wwv_flow_imp.id(750919154347733166)
,p_template_types=>'REPORT'
,p_help_text=>'Aligns the content to the top of the row. This is useful when you expect that yours rows will vary in height (e.g. some rows will have longer descriptions than others).'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661422297931844152)
,p_theme_id=>42
,p_name=>'DESCRIPTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_imp.id(661420922046844151)
,p_css_classes=>'t-ContentRow--hideDescription'
,p_group_id=>wwv_flow_imp.id(750916764549733165)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Description from being rendered on the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661422613170844152)
,p_theme_id=>42
,p_name=>'ICON_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(661420922046844151)
,p_css_classes=>'t-ContentRow--hideIcon'
,p_group_id=>wwv_flow_imp.id(750917539896733165)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Icon from being rendered on the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661423004556844152)
,p_theme_id=>42
,p_name=>'MISC_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_imp.id(661420922046844151)
,p_css_classes=>'t-ContentRow--hideMisc'
,p_group_id=>wwv_flow_imp.id(750917988838733166)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Misc column from being rendered on the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661423432223844152)
,p_theme_id=>42
,p_name=>'SELECTION_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(661420922046844151)
,p_css_classes=>'t-ContentRow--hideSelection'
,p_group_id=>wwv_flow_imp.id(750918394756733166)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Selection column from being rendered on the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661423838369844153)
,p_theme_id=>42
,p_name=>'STYLE_COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_imp.id(661420922046844151)
,p_css_classes=>'t-ContentRow--styleCompact'
,p_group_id=>wwv_flow_imp.id(750923501031733169)
,p_template_types=>'REPORT'
,p_help_text=>'This option reduces the padding and font sizes to present a compact display of the same information.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(661424246184844153)
,p_theme_id=>42
,p_name=>'TITLE_HIDDEN'
,p_display_name=>'Hidden'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(661420922046844151)
,p_css_classes=>'t-ContentRow--hideTitle'
,p_group_id=>wwv_flow_imp.id(750917116013733165)
,p_template_types=>'REPORT'
,p_help_text=>'Hides the Title from being rendered on the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(688916145554544009)
,p_theme_id=>42
,p_name=>'HEADING_FONT_ALTERNATIVE'
,p_display_name=>'Alternative'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-ContentBlock--headingFontAlt'
,p_group_id=>wwv_flow_imp.id(750902760722733155)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(688922249124544013)
,p_theme_id=>42
,p_name=>'HEADING_FONT_ALTERNATIVE'
,p_display_name=>'Alternative'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_css_classes=>'t-HeroRegion--headingFontAlt'
,p_group_id=>wwv_flow_imp.id(750902760722733155)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(688974099629544054)
,p_theme_id=>42
,p_name=>'HEADING_FONT_ALTERNATIVE'
,p_display_name=>'Alternative'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_css_classes=>'t-BreadcrumbRegion--headingFontAlt'
,p_group_id=>wwv_flow_imp.id(750902760722733155)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(689091625964544169)
,p_theme_id=>42
,p_name=>'INDICATOR_ASTERISK'
,p_display_name=>'Asterisk'
,p_display_sequence=>10
,p_field_template_id=>wwv_flow_imp.id(1949426243331220505)
,p_css_classes=>'t-Form-fieldContainer--indicatorAsterisk'
,p_group_id=>wwv_flow_imp.id(750885147108733144)
,p_template_types=>'FIELD'
,p_help_text=>'Displays an asterisk * on required items.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(689092330589544169)
,p_theme_id=>42
,p_name=>'INDICATOR_LABEL'
,p_display_name=>'Inline Label'
,p_display_sequence=>20
,p_field_template_id=>wwv_flow_imp.id(1949426243331220505)
,p_css_classes=>'t-Form-fieldContainer--indicatorLabel'
,p_group_id=>wwv_flow_imp.id(750885147108733144)
,p_template_types=>'FIELD'
,p_help_text=>'Displays "Required" inline.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(689094493011544171)
,p_theme_id=>42
,p_name=>'INDICATOR_ASTERISK'
,p_display_name=>'Asterisk'
,p_display_sequence=>10
,p_field_template_id=>wwv_flow_imp.id(1949426297686220507)
,p_css_classes=>'t-Form-fieldContainer--indicatorAsterisk'
,p_group_id=>wwv_flow_imp.id(750885147108733144)
,p_template_types=>'FIELD'
,p_help_text=>'Displays an asterisk * on required items.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(689095135921544171)
,p_theme_id=>42
,p_name=>'INDICATOR_LABEL'
,p_display_name=>'Inline Label'
,p_display_sequence=>20
,p_field_template_id=>wwv_flow_imp.id(1949426297686220507)
,p_css_classes=>'t-Form-fieldContainer--indicatorLabel'
,p_group_id=>wwv_flow_imp.id(750885147108733144)
,p_template_types=>'FIELD'
,p_help_text=>'Displays "Required" inline.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(689097297651544173)
,p_theme_id=>42
,p_name=>'INDICATOR_ASTERISK'
,p_display_name=>'Asterisk'
,p_display_sequence=>10
,p_field_template_id=>wwv_flow_imp.id(315853137824632244)
,p_css_classes=>'t-Form-fieldContainer--indicatorAsterisk'
,p_group_id=>wwv_flow_imp.id(750885147108733144)
,p_template_types=>'FIELD'
,p_help_text=>'Displays an asterisk * on required items.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(689097962806544173)
,p_theme_id=>42
,p_name=>'INDICATOR_LABEL'
,p_display_name=>'Inline Label'
,p_display_sequence=>20
,p_field_template_id=>wwv_flow_imp.id(315853137824632244)
,p_css_classes=>'t-Form-fieldContainer--indicatorLabel'
,p_group_id=>wwv_flow_imp.id(750885147108733144)
,p_template_types=>'FIELD'
,p_help_text=>'Displays "Required" inline.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(744549098632827048)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(744548518493827048)
,p_css_classes=>'u-colors'
,p_template_types=>'REGION'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(744549424731827048)
,p_theme_id=>42
,p_name=>'STYLE_A'
,p_display_name=>'Style A'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(744548518493827048)
,p_css_classes=>'t-CardsRegion--styleA'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(744549830483827049)
,p_theme_id=>42
,p_name=>'STYLE_B'
,p_display_name=>'Style B'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(744548518493827048)
,p_css_classes=>'t-CardsRegion--styleB'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(744550242772827049)
,p_theme_id=>42
,p_name=>'STYLE_C'
,p_display_name=>'Style C'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(744548518493827048)
,p_css_classes=>'t-CardsRegion--styleC'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(744586320692827076)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_imp.id(1949422988307220490)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(744595114103827086)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_imp.id(615424010440921046)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750948584292733191)
,p_theme_id=>42
,p_name=>'HEADING_LEVEL_H1'
,p_display_name=>'H1'
,p_display_sequence=>10
,p_css_classes=>'js-headingLevel-1'
,p_group_id=>wwv_flow_imp.id(750903103977733156)
,p_template_types=>'REGION'
,p_help_text=>'H1'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750949228012733192)
,p_theme_id=>42
,p_name=>'HEADING_LEVEL_H2'
,p_display_name=>'H2'
,p_display_sequence=>20
,p_css_classes=>'js-headingLevel-2'
,p_group_id=>wwv_flow_imp.id(750903103977733156)
,p_template_types=>'REGION'
,p_help_text=>'H2'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750949945601733192)
,p_theme_id=>42
,p_name=>'HEADING_LEVEL_H3'
,p_display_name=>'H3'
,p_display_sequence=>30
,p_css_classes=>'js-headingLevel-3'
,p_group_id=>wwv_flow_imp.id(750903103977733156)
,p_template_types=>'REGION'
,p_help_text=>'H3'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750950652823733193)
,p_theme_id=>42
,p_name=>'H4'
,p_display_name=>'H4'
,p_display_sequence=>40
,p_css_classes=>'js-headingLevel-4'
,p_group_id=>wwv_flow_imp.id(750903103977733156)
,p_template_types=>'REGION'
,p_help_text=>'H4'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750951331852733194)
,p_theme_id=>42
,p_name=>'HEADING_LEVEL_H5'
,p_display_name=>'H5'
,p_display_sequence=>50
,p_css_classes=>'js-headingLevel-5'
,p_group_id=>wwv_flow_imp.id(750903103977733156)
,p_template_types=>'REGION'
,p_help_text=>'H5'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750952047485733194)
,p_theme_id=>42
,p_name=>'HEADING_LEVEL_H6'
,p_display_name=>'H6'
,p_display_sequence=>60
,p_css_classes=>'js-headingLevel-6'
,p_group_id=>wwv_flow_imp.id(750903103977733156)
,p_template_types=>'REGION'
,p_help_text=>'H6'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750952745281733195)
,p_theme_id=>42
,p_name=>'FBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_imp.id(750882346676733142)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large bottom margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750953459348733195)
,p_theme_id=>42
,p_name=>'RBM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-bottom-lg'
,p_group_id=>wwv_flow_imp.id(750909198817733159)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large bottom margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750954126861733196)
,p_theme_id=>42
,p_name=>'FBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_imp.id(750882346676733142)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium bottom margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750954891318733196)
,p_theme_id=>42
,p_name=>'RBM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-bottom-md'
,p_group_id=>wwv_flow_imp.id(750909198817733159)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium bottom margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750955583992733197)
,p_theme_id=>42
,p_name=>'FBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_imp.id(750882346676733142)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the bottom margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750956215230733197)
,p_theme_id=>42
,p_name=>'RBM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-bottom-none'
,p_group_id=>wwv_flow_imp.id(750909198817733159)
,p_template_types=>'REGION'
,p_help_text=>'Removes the bottom margin for this region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750956940569733198)
,p_theme_id=>42
,p_name=>'FBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_imp.id(750882346676733142)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small bottom margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750957674065733199)
,p_theme_id=>42
,p_name=>'RBM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-bottom-sm'
,p_group_id=>wwv_flow_imp.id(750909198817733159)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small bottom margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750958365507733199)
,p_theme_id=>42
,p_name=>'FLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_imp.id(750883943583733143)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large left margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750959059794733200)
,p_theme_id=>42
,p_name=>'RLM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-left-lg'
,p_group_id=>wwv_flow_imp.id(750909560251733160)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750959759297733200)
,p_theme_id=>42
,p_name=>'FLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_imp.id(750883943583733143)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium left margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750960492285733201)
,p_theme_id=>42
,p_name=>'RLM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-left-md'
,p_group_id=>wwv_flow_imp.id(750909560251733160)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750961139431733202)
,p_theme_id=>42
,p_name=>'FLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_imp.id(750883943583733143)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the left margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750961836305733202)
,p_theme_id=>42
,p_name=>'RLM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-left-none'
,p_group_id=>wwv_flow_imp.id(750909560251733160)
,p_template_types=>'REGION'
,p_help_text=>'Removes the left margin from the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750962538265733203)
,p_theme_id=>42
,p_name=>'FLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_imp.id(750883943583733143)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small left margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750963255023733203)
,p_theme_id=>42
,p_name=>'RLM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-left-sm'
,p_group_id=>wwv_flow_imp.id(750909560251733160)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small left margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750963967350733204)
,p_theme_id=>42
,p_name=>'FRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_imp.id(750885543034733144)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large right margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750964683712733204)
,p_theme_id=>42
,p_name=>'RRM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-right-lg'
,p_group_id=>wwv_flow_imp.id(750910318560733160)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large right margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750965375969733205)
,p_theme_id=>42
,p_name=>'FRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_imp.id(750885543034733144)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium right margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750966063996733206)
,p_theme_id=>42
,p_name=>'RRM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-right-md'
,p_group_id=>wwv_flow_imp.id(750910318560733160)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium right margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750966788781733206)
,p_theme_id=>42
,p_name=>'FRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_imp.id(750885543034733144)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the right margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750967408956733207)
,p_theme_id=>42
,p_name=>'RRM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-right-none'
,p_group_id=>wwv_flow_imp.id(750910318560733160)
,p_template_types=>'REGION'
,p_help_text=>'Removes the right margin from the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750968131310733207)
,p_theme_id=>42
,p_name=>'FRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_imp.id(750885543034733144)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small right margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750968866597733208)
,p_theme_id=>42
,p_name=>'RRM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-right-sm'
,p_group_id=>wwv_flow_imp.id(750910318560733160)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small right margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750969585078733208)
,p_theme_id=>42
,p_name=>'FTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_imp.id(750886370585733145)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a large top margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750970217028733209)
,p_theme_id=>42
,p_name=>'RTM_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>40
,p_css_classes=>'margin-top-lg'
,p_group_id=>wwv_flow_imp.id(750911145208733161)
,p_template_types=>'REGION'
,p_help_text=>'Adds a large top margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750970984063733209)
,p_theme_id=>42
,p_name=>'FTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_imp.id(750886370585733145)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a medium top margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750971635982733210)
,p_theme_id=>42
,p_name=>'RTM_MEDIUM'
,p_display_name=>'Medium'
,p_display_sequence=>30
,p_css_classes=>'margin-top-md'
,p_group_id=>wwv_flow_imp.id(750911145208733161)
,p_template_types=>'REGION'
,p_help_text=>'Adds a medium top margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750972348713733211)
,p_theme_id=>42
,p_name=>'FTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_imp.id(750886370585733145)
,p_template_types=>'FIELD'
,p_help_text=>'Removes the top margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750973090037733211)
,p_theme_id=>42
,p_name=>'RTM_NONE'
,p_display_name=>'None'
,p_display_sequence=>10
,p_css_classes=>'margin-top-none'
,p_group_id=>wwv_flow_imp.id(750911145208733161)
,p_template_types=>'REGION'
,p_help_text=>'Removes the top margin for this region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750973703784733212)
,p_theme_id=>42
,p_name=>'FTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_imp.id(750886370585733145)
,p_template_types=>'FIELD'
,p_help_text=>'Adds a small top margin for this field.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750974333105733212)
,p_theme_id=>42
,p_name=>'RTM_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'margin-top-sm'
,p_group_id=>wwv_flow_imp.id(750911145208733161)
,p_template_types=>'REGION'
,p_help_text=>'Adds a small top margin to the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750975092159733213)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>30
,p_css_classes=>'t-Button--danger'
,p_group_id=>wwv_flow_imp.id(750881552311733142)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750975725241733213)
,p_theme_id=>42
,p_name=>'LARGEBOTTOMMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapBottom'
,p_group_id=>wwv_flow_imp.id(750879536865733140)
,p_template_types=>'BUTTON'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750976489653733214)
,p_theme_id=>42
,p_name=>'LARGELEFTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapLeft'
,p_group_id=>wwv_flow_imp.id(750879946614733141)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750977152151733214)
,p_theme_id=>42
,p_name=>'LARGERIGHTMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapRight'
,p_group_id=>wwv_flow_imp.id(750880384977733141)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750977862088733215)
,p_theme_id=>42
,p_name=>'LARGETOPMARGIN'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_css_classes=>'t-Button--gapTop'
,p_group_id=>wwv_flow_imp.id(750880722349733141)
,p_template_types=>'BUTTON'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750978536032733215)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>30
,p_css_classes=>'t-Button--large'
,p_group_id=>wwv_flow_imp.id(750879145060733140)
,p_template_types=>'BUTTON'
,p_help_text=>'A large button.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750979291707733216)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_LINK'
,p_display_name=>'Display as Link'
,p_display_sequence=>30
,p_css_classes=>'t-Button--link'
,p_group_id=>wwv_flow_imp.id(750881100280733141)
,p_template_types=>'BUTTON'
,p_help_text=>'This option makes the button appear as a text link.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750979906040733216)
,p_theme_id=>42
,p_name=>'NOUI'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>20
,p_css_classes=>'t-Button--noUI'
,p_group_id=>wwv_flow_imp.id(750881100280733141)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750980604094733217)
,p_theme_id=>42
,p_name=>'SMALLBOTTOMMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padBottom'
,p_group_id=>wwv_flow_imp.id(750879536865733140)
,p_template_types=>'BUTTON'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750981323853733217)
,p_theme_id=>42
,p_name=>'SMALLLEFTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padLeft'
,p_group_id=>wwv_flow_imp.id(750879946614733141)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750982060993733218)
,p_theme_id=>42
,p_name=>'SMALLRIGHTMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padRight'
,p_group_id=>wwv_flow_imp.id(750880384977733141)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750982720657733218)
,p_theme_id=>42
,p_name=>'SMALLTOPMARGIN'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_css_classes=>'t-Button--padTop'
,p_group_id=>wwv_flow_imp.id(750880722349733141)
,p_template_types=>'BUTTON'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750983477113733219)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Inner Button'
,p_display_sequence=>20
,p_css_classes=>'t-Button--pill'
,p_group_id=>wwv_flow_imp.id(750877938565733139)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750984101057733220)
,p_theme_id=>42
,p_name=>'PILLEND'
,p_display_name=>'Last Button'
,p_display_sequence=>30
,p_css_classes=>'t-Button--pillEnd'
,p_group_id=>wwv_flow_imp.id(750877938565733139)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750984815979733220)
,p_theme_id=>42
,p_name=>'PILLSTART'
,p_display_name=>'First Button'
,p_display_sequence=>10
,p_css_classes=>'t-Button--pillStart'
,p_group_id=>wwv_flow_imp.id(750877938565733139)
,p_template_types=>'BUTTON'
,p_help_text=>'Use this for the start of a pill button.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750985578727733221)
,p_theme_id=>42
,p_name=>'PRIMARY'
,p_display_name=>'Primary'
,p_display_sequence=>10
,p_css_classes=>'t-Button--primary'
,p_group_id=>wwv_flow_imp.id(750881552311733142)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750986203214733221)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_css_classes=>'t-Button--simple'
,p_group_id=>wwv_flow_imp.id(750881100280733141)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750986939517733222)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>20
,p_css_classes=>'t-Button--small'
,p_group_id=>wwv_flow_imp.id(750879145060733140)
,p_template_types=>'BUTTON'
,p_help_text=>'A small button.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750987637033733222)
,p_theme_id=>42
,p_name=>'STRETCH'
,p_display_name=>'Stretch'
,p_display_sequence=>10
,p_css_classes=>'t-Button--stretch'
,p_group_id=>wwv_flow_imp.id(750881985522733142)
,p_template_types=>'BUTTON'
,p_help_text=>'Stretches button to fill container'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750988341284733223)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_css_classes=>'t-Button--success'
,p_group_id=>wwv_flow_imp.id(750881552311733142)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750989062630733224)
,p_theme_id=>42
,p_name=>'TINY'
,p_display_name=>'Tiny'
,p_display_sequence=>10
,p_css_classes=>'t-Button--tiny'
,p_group_id=>wwv_flow_imp.id(750879145060733140)
,p_template_types=>'BUTTON'
,p_help_text=>'A very small button.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750989773309733224)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>20
,p_css_classes=>'t-Button--warning'
,p_group_id=>wwv_flow_imp.id(750881552311733142)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750990102516733224)
,p_theme_id=>42
,p_name=>'DEFERRED_PAGE_RENDERING'
,p_display_name=>'Deferred Page Rendering'
,p_display_sequence=>1
,p_css_classes=>'t-DeferredRendering'
,p_template_types=>'PAGE'
,p_help_text=>'Defer page rendering until all page components have finished loading.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750990801518733225)
,p_theme_id=>42
,p_name=>'SHOWFORMLABELSABOVE'
,p_display_name=>'Show Form Labels Above'
,p_display_sequence=>10
,p_css_classes=>'t-Form--labelsAbove'
,p_group_id=>wwv_flow_imp.id(750907965404733159)
,p_template_types=>'REGION'
,p_help_text=>'Show form labels above input fields.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750991521174733225)
,p_theme_id=>42
,p_name=>'FORMSIZELARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form--large'
,p_group_id=>wwv_flow_imp.id(750906701505733158)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750992247933733226)
,p_theme_id=>42
,p_name=>'FORMLEFTLABELS'
,p_display_name=>'Left'
,p_display_sequence=>20
,p_css_classes=>'t-Form--leftLabels'
,p_group_id=>wwv_flow_imp.id(750907543332733158)
,p_template_types=>'REGION'
,p_help_text=>'Align form labels to left.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750992913537733227)
,p_theme_id=>42
,p_name=>'FORMREMOVEPADDING'
,p_display_name=>'None'
,p_display_sequence=>20
,p_css_classes=>'t-Form--noPadding'
,p_group_id=>wwv_flow_imp.id(750906365484733158)
,p_template_types=>'REGION'
,p_help_text=>'Removes spacing between items.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750993655826733227)
,p_theme_id=>42
,p_name=>'FORMSLIMPADDING'
,p_display_name=>'Slim'
,p_display_sequence=>10
,p_css_classes=>'t-Form--slimPadding'
,p_group_id=>wwv_flow_imp.id(750906365484733158)
,p_template_types=>'REGION'
,p_help_text=>'Reduces form item spacing.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750994331622733228)
,p_theme_id=>42
,p_name=>'FORMSTANDARDPADDING'
,p_display_name=>'Standard'
,p_display_sequence=>5
,p_css_classes=>'t-Form--standardPadding'
,p_group_id=>wwv_flow_imp.id(750906365484733158)
,p_template_types=>'REGION'
,p_help_text=>'Uses the standard spacing between items.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750995080945733228)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_FIELDS'
,p_display_name=>'Stretch Form Fields'
,p_display_sequence=>10
,p_css_classes=>'t-Form--stretchInputs'
,p_group_id=>wwv_flow_imp.id(750907198325733158)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750995796485733229)
,p_theme_id=>42
,p_name=>'FORMSIZEXLARGE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form--xlarge'
,p_group_id=>wwv_flow_imp.id(750906701505733158)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750996485336733229)
,p_theme_id=>42
,p_name=>'DISPLAY_TEXT_STYLE_BOLD'
,p_display_name=>'Bold'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--boldDisplay'
,p_group_id=>wwv_flow_imp.id(750882793459733142)
,p_template_types=>'FIELD'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750997104167733230)
,p_theme_id=>42
,p_name=>'LARGE_FIELD'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--large'
,p_group_id=>wwv_flow_imp.id(750885922330733145)
,p_template_types=>'FIELD'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750997886054733230)
,p_theme_id=>42
,p_name=>'DISPLAY_TEXT_STYLE_NORMAL'
,p_display_name=>'Normal'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--normalDisplay'
,p_group_id=>wwv_flow_imp.id(750882793459733142)
,p_template_types=>'FIELD'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750998542038733231)
,p_theme_id=>42
,p_name=>'POST_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--postTextBlock'
,p_group_id=>wwv_flow_imp.id(750883136550733143)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Post Text in a block style immediately after the item.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750999256437733231)
,p_theme_id=>42
,p_name=>'PRE_TEXT_BLOCK'
,p_display_name=>'Display as Block'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--preTextBlock'
,p_group_id=>wwv_flow_imp.id(750883535438733143)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the Item Pre Text in a block style immediately before the item.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(750999993401733232)
,p_theme_id=>42
,p_name=>'DISPLAY_AS_PILL_BUTTON'
,p_display_name=>'Display as Pill Button'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--radioButtonGroup'
,p_group_id=>wwv_flow_imp.id(750884794256733144)
,p_template_types=>'FIELD'
,p_help_text=>'Displays the radio buttons to look like a button set / pill button.  Note that the the radio buttons must all be in the same row for this option to work.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(751000397968733232)
,p_theme_id=>42
,p_name=>'STRETCH_FORM_ITEM'
,p_display_name=>'Stretch Form Item'
,p_display_sequence=>10
,p_css_classes=>'t-Form-fieldContainer--stretchInputs'
,p_template_types=>'FIELD'
,p_help_text=>'Stretches the form item to fill its container.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(751001047593733233)
,p_theme_id=>42
,p_name=>'X_LARGE_SIZE'
,p_display_name=>'X Large'
,p_display_sequence=>20
,p_css_classes=>'t-Form-fieldContainer--xlarge'
,p_group_id=>wwv_flow_imp.id(750885922330733145)
,p_template_types=>'FIELD'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(751001721228733233)
,p_theme_id=>42
,p_name=>'REMOVE_PADDING'
,p_display_name=>'Remove Padding'
,p_display_sequence=>1
,p_css_classes=>'t-PageBody--noContentPadding'
,p_group_id=>wwv_flow_imp.id(750892761456733149)
,p_template_types=>'PAGE'
,p_help_text=>'Removes padding from the content region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(751002479128733234)
,p_theme_id=>42
,p_name=>'SORT_CENTER'
,p_display_name=>'Center'
,p_display_sequence=>10
,p_css_classes=>'t-Region-orderBy--center'
,p_group_id=>wwv_flow_imp.id(750912339360733162)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(751003152165733235)
,p_theme_id=>42
,p_name=>'SORT_END'
,p_display_name=>'End'
,p_display_sequence=>20
,p_css_classes=>'t-Region-orderBy--end'
,p_group_id=>wwv_flow_imp.id(750912339360733162)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(751003831339733235)
,p_theme_id=>42
,p_name=>'HIDE_WHEN_ALL_ROWS_DISPLAYED'
,p_display_name=>'Hide when all rows displayed'
,p_display_sequence=>10
,p_css_classes=>'t-Report--hideNoPagination'
,p_group_id=>wwv_flow_imp.id(750921906800733168)
,p_template_types=>'REPORT'
,p_help_text=>'This option will hide the pagination when all rows are displayed.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(792701934482417748)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_css_classes=>'t-HeroRegion--featured'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(792702639349417749)
,p_theme_id=>42
,p_name=>'DISPLAY_ICON_NO'
,p_display_name=>'No'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_css_classes=>'t-HeroRegion--hideIcon'
,p_group_id=>wwv_flow_imp.id(750901521730733155)
,p_template_types=>'REGION'
,p_help_text=>'Hide the Hero Region icon.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(792703337118417750)
,p_theme_id=>42
,p_name=>'STACKED_FEATURED'
,p_display_name=>'Stacked Featured'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_css_classes=>'t-HeroRegion--featured t-HeroRegion--centered'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(826651997372902766)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_imp.id(1949368791042220343)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(826661102505902774)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_imp.id(1949371167155220354)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(826672320485902784)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_imp.id(1949374476490220362)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(826679602466902788)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_imp.id(1949377373541220367)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(826691442375902795)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_imp.id(1949380523915220380)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(826698606412902799)
,p_theme_id=>42
,p_name=>'STICKY_HEADER_ON_MOBILE'
,p_display_name=>'Sticky Header on Mobile'
,p_display_sequence=>100
,p_page_template_id=>wwv_flow_imp.id(1949382845217220384)
,p_css_classes=>'js-pageStickyMobileHeader'
,p_template_types=>'PAGE'
,p_help_text=>'This will position the contents of the Breadcrumb Bar region position so it sticks to the top of the screen for small screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(826715515735902828)
,p_theme_id=>42
,p_name=>'STICK_TO_BOTTOM'
,p_display_name=>'Stick to Bottom for Mobile'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_css_classes=>'t-ButtonRegion--stickToBottom'
,p_template_types=>'REGION'
,p_help_text=>'This will position the button container region to the bottom of the screen for small screens.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845895909822073126)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845896620709073126)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845897323468073127)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845898057742073127)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845898762645073130)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845899442579073130)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845900142070073131)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845900802802073131)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845901520033073132)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(845902280498073132)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(846087034402073356)
,p_theme_id=>42
,p_name=>'DISPLAY_ITEMS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_imp.id(846086529051073354)
,p_css_classes=>'t-ContextualInfo-item--stacked'
,p_group_id=>wwv_flow_imp.id(750919543925733167)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(846087455464073356)
,p_theme_id=>42
,p_name=>'DISPLAY_LABELS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>1
,p_report_template_id=>wwv_flow_imp.id(846086529051073354)
,p_css_classes=>'t-ContextualInfo-label--stacked'
,p_group_id=>wwv_flow_imp.id(750919942656733167)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165226676149731176)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--removeHeading js-removeLandmark'
,p_group_id=>wwv_flow_imp.id(750896319568733151)
,p_template_types=>'REGION'
,p_help_text=>'Hides the Alert Title from being displayed.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165227387266731177)
,p_theme_id=>42
,p_name=>'HIDDENHEADER'
,p_display_name=>'Hidden but Accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--accessibleHeading'
,p_group_id=>wwv_flow_imp.id(750896319568733151)
,p_template_types=>'REGION'
,p_help_text=>'Visually hides the alert title, but assistive technologies can still read it.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165268626651731232)
,p_theme_id=>42
,p_name=>'REMOVE_BODY_PADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394124666220412)
,p_css_classes=>'t-HeroRegion--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes the padding around the hero region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165300535626731289)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H1'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-ContentBlock--h1'
,p_group_id=>wwv_flow_imp.id(750910738032733160)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165300905623731289)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H2'
,p_display_name=>'Medium'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-ContentBlock--h2'
,p_group_id=>wwv_flow_imp.id(750910738032733160)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165301341826731290)
,p_theme_id=>42
,p_name=>'CONTENT_TITLE_H3'
,p_display_name=>'Small'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-ContentBlock--h3'
,p_group_id=>wwv_flow_imp.id(750910738032733160)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165310686453731308)
,p_theme_id=>42
,p_name=>'CARDS_STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--stacked'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Stacks the cards on top of each other.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165311428628731309)
,p_theme_id=>42
,p_name=>'RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_imp.id(750886740465733145)
,p_template_types=>'LIST'
,p_help_text=>'Raises the card so it pops up.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165312085414731310)
,p_theme_id=>42
,p_name=>'COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_imp.id(750886740465733145)
,p_template_types=>'LIST'
,p_help_text=>'Fills the card background with the color of the icon or default link style.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165351160996731376)
,p_theme_id=>42
,p_name=>'CARD_RAISE_CARD'
,p_display_name=>'Raise Card'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--animRaiseCard'
,p_group_id=>wwv_flow_imp.id(750914786110733163)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1165351849944731377)
,p_theme_id=>42
,p_name=>'CARDS_COLOR_FILL'
,p_display_name=>'Color Fill'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--animColorFill'
,p_group_id=>wwv_flow_imp.id(750914786110733163)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1383373130088647758)
,p_theme_id=>42
,p_name=>'REMEMBER_COLLAPSIBLE_STATE'
,p_display_name=>'Remember Collapsible State'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
,p_help_text=>'This option saves the current state of the collapsible region for the duration of the session.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1519077738655502198)
,p_theme_id=>42
,p_name=>'APPLY_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies colors from the Theme''s color palette to icons in the list.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1524270707545891940)
,p_theme_id=>42
,p_name=>'LIST_SIZE_LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--large force-fa-lg'
,p_group_id=>wwv_flow_imp.id(750891989635733148)
,p_template_types=>'LIST'
,p_help_text=>'Increases the size of the text and icons in the list.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528828665042269927)
,p_theme_id=>42
,p_name=>'ACCENT_10'
,p_display_name=>'Accent 10'
,p_display_sequence=>100
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent10'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528829282951269928)
,p_theme_id=>42
,p_name=>'ACCENT_11'
,p_display_name=>'Accent 11'
,p_display_sequence=>110
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent11'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528829989076269928)
,p_theme_id=>42
,p_name=>'ACCENT_15'
,p_display_name=>'Accent 15'
,p_display_sequence=>150
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent15'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528830709927269929)
,p_theme_id=>42
,p_name=>'ACCENT_7'
,p_display_name=>'Accent 7'
,p_display_sequence=>70
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent7'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528831388045269929)
,p_theme_id=>42
,p_name=>'ACCENT_6'
,p_display_name=>'Accent 6'
,p_display_sequence=>60
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent6'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528832092206269930)
,p_theme_id=>42
,p_name=>'ACCENT_13'
,p_display_name=>'Accent 13'
,p_display_sequence=>130
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent13'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528832809759269930)
,p_theme_id=>42
,p_name=>'ACCENT_8'
,p_display_name=>'Accent 8'
,p_display_sequence=>80
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent8'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528833543046269931)
,p_theme_id=>42
,p_name=>'ACCENT_9'
,p_display_name=>'Accent 9'
,p_display_sequence=>90
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent9'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528834266148269931)
,p_theme_id=>42
,p_name=>'ACCENT_14'
,p_display_name=>'Accent 14'
,p_display_sequence=>140
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent14'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1528834913305269932)
,p_theme_id=>42
,p_name=>'ACCENT_12'
,p_display_name=>'Accent 12'
,p_display_sequence=>120
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent12'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949386423143220396)
,p_theme_id=>42
,p_name=>'COLOREDBACKGROUND'
,p_display_name=>'Highlight Background'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--colorBG'
,p_template_types=>'REGION'
,p_help_text=>'Set alert background color to that of the alert type (warning, success, etc.)'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949386725584220399)
,p_theme_id=>42
,p_name=>'DANGER'
,p_display_name=>'Danger'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--danger'
,p_group_id=>wwv_flow_imp.id(750896763287733151)
,p_template_types=>'REGION'
,p_help_text=>'Show an error or danger alert.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949387038826220399)
,p_theme_id=>42
,p_name=>'HIDE_ICONS'
,p_display_name=>'Hide Icons'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--noIcon'
,p_group_id=>wwv_flow_imp.id(750895983136733151)
,p_template_types=>'REGION'
,p_help_text=>'Hides alert icons'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949387289752220399)
,p_theme_id=>42
,p_name=>'HORIZONTAL'
,p_display_name=>'Horizontal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--horizontal'
,p_group_id=>wwv_flow_imp.id(750895597930733151)
,p_template_types=>'REGION'
,p_help_text=>'Show horizontal alert with buttons to the right.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949387371591220399)
,p_theme_id=>42
,p_name=>'INFORMATION'
,p_display_name=>'Information'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--info'
,p_group_id=>wwv_flow_imp.id(750896763287733151)
,p_template_types=>'REGION'
,p_help_text=>'Show informational alert.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949387522923220399)
,p_theme_id=>42
,p_name=>'SHOW_CUSTOM_ICONS'
,p_display_name=>'Show Custom Icons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--customIcons'
,p_group_id=>wwv_flow_imp.id(750895983136733151)
,p_template_types=>'REGION'
,p_help_text=>'Set custom icons by modifying the Alert Region''s Icon CSS Classes property.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949387611227220399)
,p_theme_id=>42
,p_name=>'SUCCESS'
,p_display_name=>'Success'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--success'
,p_group_id=>wwv_flow_imp.id(750896763287733151)
,p_template_types=>'REGION'
,p_help_text=>'Show success alert.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949387744158220400)
,p_theme_id=>42
,p_name=>'USEDEFAULTICONS'
,p_display_name=>'Show Default Icons'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--defaultIcons'
,p_group_id=>wwv_flow_imp.id(750895983136733151)
,p_template_types=>'REGION'
,p_help_text=>'Uses default icons for alert types.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949387790100220400)
,p_theme_id=>42
,p_name=>'WARNING'
,p_display_name=>'Warning'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--warning'
,p_group_id=>wwv_flow_imp.id(750896763287733151)
,p_template_types=>'REGION'
,p_help_text=>'Show a warning alert.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949387947638220400)
,p_theme_id=>42
,p_name=>'WIZARD'
,p_display_name=>'Wizard'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949385916556220392)
,p_css_classes=>'t-Alert--wizard'
,p_group_id=>wwv_flow_imp.id(750895597930733151)
,p_template_types=>'REGION'
,p_help_text=>'Show the alert in a wizard style region.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949389220167220407)
,p_theme_id=>42
,p_name=>'BORDERLESS'
,p_display_name=>'Borderless'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_css_classes=>'t-ButtonRegion--noBorder'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949389533456220407)
,p_theme_id=>42
,p_name=>'NOPADDING'
,p_display_name=>'No Padding'
,p_display_sequence=>3
,p_region_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_css_classes=>'t-ButtonRegion--noPadding'
,p_group_id=>wwv_flow_imp.id(750898714975733153)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949389607800220407)
,p_theme_id=>42
,p_name=>'REMOVEUIDECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>4
,p_region_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_css_classes=>'t-ButtonRegion--noUI'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949389723552220408)
,p_theme_id=>42
,p_name=>'SLIMPADDING'
,p_display_name=>'Slim Padding'
,p_display_sequence=>5
,p_region_template_id=>wwv_flow_imp.id(1949388267286220402)
,p_css_classes=>'t-ButtonRegion--slimPadding'
,p_group_id=>wwv_flow_imp.id(750898714975733153)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949390965775220411)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949391036414220411)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949391157533220411)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949391382596220411)
,p_theme_id=>42
,p_name=>'5_SECONDS'
,p_display_name=>'5 Seconds'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'js-cycle5s'
,p_group_id=>wwv_flow_imp.id(750913982961733163)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949391525729220411)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949391829260220411)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949391904477220411)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949391998027220411)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949392164521220411)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949392240753220411)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949392552937220411)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--removeHeader'
,p_group_id=>wwv_flow_imp.id(750902381065733155)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949392778798220412)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_imp.id(750898338126733152)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949392903189220412)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_imp.id(750902381065733155)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949393047021220412)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949393122926220412)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949393265628220412)
,p_theme_id=>42
,p_name=>'REMEMBER_CAROUSEL_SLIDE'
,p_display_name=>'Remember Carousel Slide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949393269750220412)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_imp.id(750898338126733152)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949393557252220412)
,p_theme_id=>42
,p_name=>'SHOW_NEXT_AND_PREVIOUS_BUTTONS'
,p_display_name=>'Show Next and Previous Buttons'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--showCarouselControls'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949393799709220412)
,p_theme_id=>42
,p_name=>'SLIDE'
,p_display_name=>'Slide'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--carouselSlide'
,p_group_id=>wwv_flow_imp.id(750897501690733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949393881054220412)
,p_theme_id=>42
,p_name=>'SPIN'
,p_display_name=>'Spin'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--carouselSpin'
,p_group_id=>wwv_flow_imp.id(750897501690733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949394022745220412)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949395372477220418)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949395540035220418)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949395657266220418)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949395714507220418)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949395839645220418)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949395885996220418)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949396033749220418)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949396360343220418)
,p_theme_id=>42
,p_name=>'COLLAPSED'
,p_display_name=>'Collapsed'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'is-collapsed'
,p_group_id=>wwv_flow_imp.id(750900790784733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949396369451220418)
,p_theme_id=>42
,p_name=>'EXPANDED'
,p_display_name=>'Expanded'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'is-expanded'
,p_group_id=>wwv_flow_imp.id(750900790784733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949396478802220418)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_imp.id(750898338126733152)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949396643013220418)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949396754314220418)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949396801932220418)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_imp.id(750898338126733152)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949396979853220418)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949397352515220421)
,p_theme_id=>42
,p_name=>'REMOVEBORDERS'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949397075503220418)
,p_css_classes=>'t-IRR-region--noBorders'
,p_template_types=>'REGION'
,p_help_text=>'Removes borders around the Interactive Report'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949398162605220426)
,p_theme_id=>42
,p_name=>'DRAGGABLE'
,p_display_name=>'Draggable'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_css_classes=>'js-draggable'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949398398905220427)
,p_theme_id=>42
,p_name=>'LARGE_720X480'
,p_display_name=>'Large (720x480)'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_css_classes=>'js-dialog-size720x480'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949398471976220427)
,p_theme_id=>42
,p_name=>'MEDIUM_600X400'
,p_display_name=>'Medium (600x400)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_css_classes=>'js-dialog-size600x400'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949398584412220427)
,p_theme_id=>42
,p_name=>'MODAL'
,p_display_name=>'Modal'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_css_classes=>'js-modal'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949398767378220427)
,p_theme_id=>42
,p_name=>'RESIZABLE'
,p_display_name=>'Resizable'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_css_classes=>'js-resizable'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949398782874220427)
,p_theme_id=>42
,p_name=>'SMALL_480X320'
,p_display_name=>'Small (480x320)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949397932973220424)
,p_css_classes=>'js-dialog-size480x320'
,p_group_id=>wwv_flow_imp.id(750901163857733154)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949399690875220430)
,p_theme_id=>42
,p_name=>'240PX'
,p_display_name=>'240px'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'i-h240'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 240px.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949399792215220430)
,p_theme_id=>42
,p_name=>'320PX'
,p_display_name=>'320px'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'i-h320'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
,p_help_text=>'Sets region body height to 320px.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949399941192220430)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949399996083220430)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949400074138220430)
,p_theme_id=>42
,p_name=>'ACCENT_1'
,p_display_name=>'Accent 1'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent1'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949400239920220430)
,p_theme_id=>42
,p_name=>'ACCENT_2'
,p_display_name=>'Accent 2'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent2'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949400288960220430)
,p_theme_id=>42
,p_name=>'ACCENT_3'
,p_display_name=>'Accent 3'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent3'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949400390161220430)
,p_theme_id=>42
,p_name=>'ACCENT_4'
,p_display_name=>'Accent 4'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent4'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949400509717220430)
,p_theme_id=>42
,p_name=>'ACCENT_5'
,p_display_name=>'Accent 5'
,p_display_sequence=>50
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--accent5'
,p_group_id=>wwv_flow_imp.id(750895143527733150)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949400745156220430)
,p_theme_id=>42
,p_name=>'HIDDENHEADERNOAT'
,p_display_name=>'Hidden'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--removeHeader js-removeLandmark'
,p_group_id=>wwv_flow_imp.id(750902381065733155)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949400826272220430)
,p_theme_id=>42
,p_name=>'HIDEOVERFLOW'
,p_display_name=>'Hide'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--hiddenOverflow'
,p_group_id=>wwv_flow_imp.id(750898338126733152)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949400900034220430)
,p_theme_id=>42
,p_name=>'HIDEREGIONHEADER'
,p_display_name=>'Hidden but accessible'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--hideHeader'
,p_group_id=>wwv_flow_imp.id(750902381065733155)
,p_template_types=>'REGION'
,p_help_text=>'This option will hide the region header.  Note that the region title will still be audible for Screen Readers. Buttons placed in the region header will be hidden and inaccessible.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949401025036220430)
,p_theme_id=>42
,p_name=>'NOBODYPADDING'
,p_display_name=>'Remove Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--noPadding'
,p_template_types=>'REGION'
,p_help_text=>'Removes padding from region body.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949401137689220431)
,p_theme_id=>42
,p_name=>'NOBORDER'
,p_display_name=>'Remove Borders'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--noBorder'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_help_text=>'Removes borders from the region.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949401219403220431)
,p_theme_id=>42
,p_name=>'SCROLLBODY'
,p_display_name=>'Scroll - Default'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--scrollBody'
,p_group_id=>wwv_flow_imp.id(750898338126733152)
,p_template_types=>'REGION'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949401440642220432)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stack Region'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--stacked'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_help_text=>'Removes side borders and shadows, and can be useful for accordions and regions that need to be grouped together vertically.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949402510433220435)
,p_theme_id=>42
,p_name=>'FILL_TAB_LABELS'
,p_display_name=>'Fill Tab Labels'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949401472031220432)
,p_css_classes=>'t-TabsRegion-mod--fillLabels'
,p_group_id=>wwv_flow_imp.id(750908355546733159)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949402790492220435)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949401472031220432)
,p_css_classes=>'t-TabsRegion-mod--pill'
,p_group_id=>wwv_flow_imp.id(750913519641733163)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949402889532220435)
,p_theme_id=>42
,p_name=>'REMEMBER_ACTIVE_TAB'
,p_display_name=>'Remember Active Tab'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949401472031220432)
,p_css_classes=>'js-useLocalStorage'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949403025494220435)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949401472031220432)
,p_css_classes=>'t-TabsRegion-mod--simple'
,p_group_id=>wwv_flow_imp.id(750913519641733163)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949403356725220436)
,p_theme_id=>42
,p_name=>'TABSLARGE'
,p_display_name=>'Large'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949401472031220432)
,p_css_classes=>'t-TabsRegion-mod--large'
,p_group_id=>wwv_flow_imp.id(750913163953733162)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949403406249220436)
,p_theme_id=>42
,p_name=>'TABS_SMALL'
,p_display_name=>'Small'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949401472031220432)
,p_css_classes=>'t-TabsRegion-mod--small'
,p_group_id=>wwv_flow_imp.id(750913163953733162)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949403914746220438)
,p_theme_id=>42
,p_name=>'GET_TITLE_FROM_BREADCRUMB'
,p_display_name=>'Use Current Breadcrumb Entry'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_css_classes=>'t-BreadcrumbRegion--useBreadcrumbTitle'
,p_group_id=>wwv_flow_imp.id(750910738032733160)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949403990764220438)
,p_theme_id=>42
,p_name=>'HIDE_BREADCRUMB'
,p_display_name=>'Show Breadcrumbs'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_css_classes=>'t-BreadcrumbRegion--showBreadcrumb'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949404136288220439)
,p_theme_id=>42
,p_name=>'REGION_HEADER_VISIBLE'
,p_display_name=>'Use Region Title'
,p_display_sequence=>1
,p_region_template_id=>wwv_flow_imp.id(1949403479597220436)
,p_css_classes=>'t-BreadcrumbRegion--useRegionTitle'
,p_group_id=>wwv_flow_imp.id(750910738032733160)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949404762564220442)
,p_theme_id=>42
,p_name=>'HIDESMALLSCREENS'
,p_display_name=>'Small Screens (Tablet)'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949404212621220439)
,p_css_classes=>'t-Wizard--hideStepsSmall'
,p_group_id=>wwv_flow_imp.id(750903515806733156)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949404918470220442)
,p_theme_id=>42
,p_name=>'HIDEXSMALLSCREENS'
,p_display_name=>'X Small Screens (Mobile)'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949404212621220439)
,p_css_classes=>'t-Wizard--hideStepsXSmall'
,p_group_id=>wwv_flow_imp.id(750903515806733156)
,p_template_types=>'REGION'
,p_help_text=>'Hides the wizard progress steps for screens that are smaller than 768px wide.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949405581149220449)
,p_theme_id=>42
,p_name=>'128PX'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_imp.id(750915160844733164)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949405950029220449)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406025371220450)
,p_theme_id=>42
,p_name=>'32PX'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_imp.id(750915160844733164)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406080778220450)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406206095220450)
,p_theme_id=>42
,p_name=>'48PX'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_imp.id(750915160844733164)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406293991220450)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406414608220450)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406484299220450)
,p_theme_id=>42
,p_name=>'64PX'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_imp.id(750915160844733164)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406601254220450)
,p_theme_id=>42
,p_name=>'96PX'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_imp.id(750915160844733164)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406729321220450)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406846491220450)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949406931824220450)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949407100553220450)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949405206224220445)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949407616550220456)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>15
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949407927125220456)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_imp.id(750915533406733164)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949408045763220456)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949408120605220456)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_imp.id(750915533406733164)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949408192195220456)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949408271689220456)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_imp.id(750915533406733164)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949408373804220457)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949408716731220457)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_imp.id(750923501031733169)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949408825746220457)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_imp.id(750923501031733169)
,p_template_types=>'REPORT'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949409096308220457)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_imp.id(750920381272733167)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949409200063220457)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_imp.id(750920381272733167)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949409311582220457)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_imp.id(750923501031733169)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949409457256220457)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949409521156220457)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_imp.id(750915533406733164)
,p_template_types=>'REPORT'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949409584517220457)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949409946847220457)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949407374930220453)
,p_css_classes=>'u-colors'
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949410388731220460)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949409987720220457)
,p_css_classes=>'t-Comments--basic'
,p_group_id=>wwv_flow_imp.id(750918785216733166)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949410528852220460)
,p_theme_id=>42
,p_name=>'SPEECH_BUBBLES'
,p_display_name=>'Speech Bubbles'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949409987720220457)
,p_css_classes=>'t-Comments--chat'
,p_group_id=>wwv_flow_imp.id(750918785216733166)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949411171344220468)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949410800764220464)
,p_css_classes=>'t-Report--staticRowColors'
,p_group_id=>wwv_flow_imp.id(750914333288733163)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949411360690220468)
,p_theme_id=>42
,p_name=>'ALTROWCOLORSENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949410800764220464)
,p_css_classes=>'t-Report--altRowsDefault'
,p_group_id=>wwv_flow_imp.id(750914333288733163)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949411603255220468)
,p_theme_id=>42
,p_name=>'ENABLE'
,p_display_name=>'Enable'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949410800764220464)
,p_css_classes=>'t-Report--rowHighlight'
,p_group_id=>wwv_flow_imp.id(750922736819733169)
,p_template_types=>'REPORT'
,p_help_text=>'Enable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949411914176220468)
,p_theme_id=>42
,p_name=>'HORIZONTALBORDERS'
,p_display_name=>'Horizontal Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949410800764220464)
,p_css_classes=>'t-Report--horizontalBorders'
,p_group_id=>wwv_flow_imp.id(750922346983733169)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949412049997220468)
,p_theme_id=>42
,p_name=>'REMOVEALLBORDERS'
,p_display_name=>'No Borders'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(1949410800764220464)
,p_css_classes=>'t-Report--noBorders'
,p_group_id=>wwv_flow_imp.id(750922346983733169)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949412158382220468)
,p_theme_id=>42
,p_name=>'REMOVEOUTERBORDERS'
,p_display_name=>'No Outer Borders'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_imp.id(1949410800764220464)
,p_css_classes=>'t-Report--inline'
,p_group_id=>wwv_flow_imp.id(750922346983733169)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949412256702220468)
,p_theme_id=>42
,p_name=>'ROWHIGHLIGHTDISABLE'
,p_display_name=>'Disable'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949410800764220464)
,p_css_classes=>'t-Report--rowHighlightOff'
,p_group_id=>wwv_flow_imp.id(750922736819733169)
,p_template_types=>'REPORT'
,p_help_text=>'Disable row highlighting on mouse over'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949412269501220468)
,p_theme_id=>42
,p_name=>'STRETCHREPORT'
,p_display_name=>'Stretch Report'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949410800764220464)
,p_css_classes=>'t-Report--stretch'
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949412385201220469)
,p_theme_id=>42
,p_name=>'VERTICALBORDERS'
,p_display_name=>'Vertical Only'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949410800764220464)
,p_css_classes=>'t-Report--verticalBorders'
,p_group_id=>wwv_flow_imp.id(750922346983733169)
,p_template_types=>'REPORT'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949412938277220470)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(1949412517353220469)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949413034707220471)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949412517353220469)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949413109879220471)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949412517353220469)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949413227814220471)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949412517353220469)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949413284944220471)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949412517353220469)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949413466542220471)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_imp.id(1949412517353220469)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949413496924220471)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_imp.id(1949412517353220469)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949413637669220471)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_imp.id(1949412517353220469)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949413905914220473)
,p_theme_id=>42
,p_name=>'FIXED_LARGE'
,p_display_name=>'Fixed - Large'
,p_display_sequence=>30
,p_report_template_id=>wwv_flow_imp.id(1949413684294220471)
,p_css_classes=>'t-AVPList--fixedLabelLarge'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949413990098220473)
,p_theme_id=>42
,p_name=>'FIXED_MEDIUM'
,p_display_name=>'Fixed - Medium'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949413684294220471)
,p_css_classes=>'t-AVPList--fixedLabelMedium'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949414145434220473)
,p_theme_id=>42
,p_name=>'FIXED_SMALL'
,p_display_name=>'Fixed - Small'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949413684294220471)
,p_css_classes=>'t-AVPList--fixedLabelSmall'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949414207275220473)
,p_theme_id=>42
,p_name=>'LEFT_ALIGNED_DETAILS'
,p_display_name=>'Left Aligned Details'
,p_display_sequence=>10
,p_report_template_id=>wwv_flow_imp.id(1949413684294220471)
,p_css_classes=>'t-AVPList--leftAligned'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949414346477220473)
,p_theme_id=>42
,p_name=>'RIGHT_ALIGNED_DETAILS'
,p_display_name=>'Right Aligned Details'
,p_display_sequence=>20
,p_report_template_id=>wwv_flow_imp.id(1949413684294220471)
,p_css_classes=>'t-AVPList--rightAligned'
,p_group_id=>wwv_flow_imp.id(750921542967733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949414464221220473)
,p_theme_id=>42
,p_name=>'VARIABLE_LARGE'
,p_display_name=>'Variable - Large'
,p_display_sequence=>60
,p_report_template_id=>wwv_flow_imp.id(1949413684294220471)
,p_css_classes=>'t-AVPList--variableLabelLarge'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949414511610220473)
,p_theme_id=>42
,p_name=>'VARIABLE_MEDIUM'
,p_display_name=>'Variable - Medium'
,p_display_sequence=>50
,p_report_template_id=>wwv_flow_imp.id(1949413684294220471)
,p_css_classes=>'t-AVPList--variableLabelMedium'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949414609878220473)
,p_theme_id=>42
,p_name=>'VARIABLE_SMALL'
,p_display_name=>'Variable - Small'
,p_display_sequence=>40
,p_report_template_id=>wwv_flow_imp.id(1949413684294220471)
,p_css_classes=>'t-AVPList--variableLabelSmall'
,p_group_id=>wwv_flow_imp.id(750921124182733168)
,p_template_types=>'REPORT'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949415070485220476)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a two column grid'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949415245927220476)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--3cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 3 column grid'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949415323432220476)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--4cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in 4 column grid'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949415432279220476)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--cols t-BadgeList--5cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Arrange badges in a 5 column grid'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949415555891220477)
,p_theme_id=>42
,p_name=>'FIXED'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--fixed'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Span badges horizontally'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949415665487220477)
,p_theme_id=>42
,p_name=>'FLEXIBLEBOX'
,p_display_name=>'Flexible Box'
,p_display_sequence=>80
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--flex'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Use flexbox to arrange items'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949415676796220477)
,p_theme_id=>42
,p_name=>'FLOATITEMS'
,p_display_name=>'Float Items'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--float'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Float badges to left'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949415975673220477)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'64px'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--large'
,p_group_id=>wwv_flow_imp.id(750887172826733145)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949416076807220477)
,p_theme_id=>42
,p_name=>'MEDIUM'
,p_display_name=>'48px'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--medium'
,p_group_id=>wwv_flow_imp.id(750887172826733145)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949416339647220477)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'32px'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--small'
,p_group_id=>wwv_flow_imp.id(750887172826733145)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949416407729220477)
,p_theme_id=>42
,p_name=>'STACKED'
,p_display_name=>'Stacked'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--stacked'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Stack badges on top of each other'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949416471902220477)
,p_theme_id=>42
,p_name=>'XLARGE'
,p_display_name=>'96px'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--xlarge'
,p_group_id=>wwv_flow_imp.id(750887172826733145)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949416652753220477)
,p_theme_id=>42
,p_name=>'XXLARGE'
,p_display_name=>'128px'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_imp.id(1949414696789220473)
,p_css_classes=>'t-BadgeList--xxlarge'
,p_group_id=>wwv_flow_imp.id(750887172826733145)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949416924263220479)
,p_theme_id=>42
,p_name=>'2_COLUMNS'
,p_display_name=>'2 Columns'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949417238909220479)
,p_theme_id=>42
,p_name=>'2_LINES'
,p_display_name=>'2 Lines'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--desc-2ln'
,p_group_id=>wwv_flow_imp.id(750887524368733146)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949417278167220479)
,p_theme_id=>42
,p_name=>'3_COLUMNS'
,p_display_name=>'3 Columns'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--3cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949417464586220479)
,p_theme_id=>42
,p_name=>'3_LINES'
,p_display_name=>'3 Lines'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--desc-3ln'
,p_group_id=>wwv_flow_imp.id(750887524368733146)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949417540841220480)
,p_theme_id=>42
,p_name=>'4_COLUMNS'
,p_display_name=>'4 Columns'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--4cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949417600578220480)
,p_theme_id=>42
,p_name=>'4_LINES'
,p_display_name=>'4 Lines'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--desc-4ln'
,p_group_id=>wwv_flow_imp.id(750887524368733146)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949417702810220480)
,p_theme_id=>42
,p_name=>'5_COLUMNS'
,p_display_name=>'5 Columns'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--5cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949418037451220480)
,p_theme_id=>42
,p_name=>'BASIC'
,p_display_name=>'Basic'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--basic'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949418163133220480)
,p_theme_id=>42
,p_name=>'COMPACT'
,p_display_name=>'Compact'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--compact'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
,p_help_text=>'Use this option when you want to show smaller cards.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949418397439220480)
,p_theme_id=>42
,p_name=>'DISPLAY_ICONS'
,p_display_name=>'Display Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--displayIcons'
,p_group_id=>wwv_flow_imp.id(750889517607733147)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949418542940220480)
,p_theme_id=>42
,p_name=>'DISPLAY_INITIALS'
,p_display_name=>'Display Initials'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--displayInitials'
,p_group_id=>wwv_flow_imp.id(750889517607733147)
,p_template_types=>'LIST'
,p_help_text=>'Initials come from List Attribute 3'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949418597819220480)
,p_theme_id=>42
,p_name=>'FEATURED'
,p_display_name=>'Featured'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--featured force-fa-lg'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949418703170220480)
,p_theme_id=>42
,p_name=>'FLOAT'
,p_display_name=>'Float'
,p_display_sequence=>60
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--float'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949418797972220480)
,p_theme_id=>42
,p_name=>'HIDDEN_BODY_TEXT'
,p_display_name=>'Hidden'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--hideBody'
,p_group_id=>wwv_flow_imp.id(750887524368733146)
,p_template_types=>'LIST'
,p_help_text=>'This option hides the card body which contains description and subtext.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949418965389220480)
,p_theme_id=>42
,p_name=>'SPAN_HORIZONTALLY'
,p_display_name=>'Span Horizontally'
,p_display_sequence=>70
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'t-Cards--spanHorizontally'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949419211148220480)
,p_theme_id=>42
,p_name=>'USE_THEME_COLORS'
,p_display_name=>'Apply Theme Colors'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949416705322220477)
,p_css_classes=>'u-colors'
,p_template_types=>'LIST'
,p_help_text=>'Applies the colors from the theme''s color palette to the icons or initials within cards.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949419513577220482)
,p_theme_id=>42
,p_name=>'ACTIONS'
,p_display_name=>'Actions'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949419333489220480)
,p_css_classes=>'t-LinksList--actions'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
,p_help_text=>'Render as actions to be placed on the right side column.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949419645722220482)
,p_theme_id=>42
,p_name=>'DISABLETEXTWRAPPING'
,p_display_name=>'Disable Text Wrapping'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949419333489220480)
,p_css_classes=>'t-LinksList--nowrap'
,p_template_types=>'LIST'
,p_help_text=>'Do not allow link text to wrap to new lines. Truncate with ellipsis.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949419867849220482)
,p_theme_id=>42
,p_name=>'SHOWBADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949419333489220480)
,p_css_classes=>'t-LinksList--showBadge'
,p_template_types=>'LIST'
,p_help_text=>'Show badge to right of link (requires Attribute 1 to be populated)'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949419876082220482)
,p_theme_id=>42
,p_name=>'SHOWGOTOARROW'
,p_display_name=>'Show Right Arrow'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949419333489220480)
,p_css_classes=>'t-LinksList--showArrow'
,p_template_types=>'LIST'
,p_help_text=>'Show arrow to the right of link'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949420215491220482)
,p_theme_id=>42
,p_name=>'SHOWICONS'
,p_display_name=>'For All Items'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949419333489220480)
,p_css_classes=>'t-LinksList--showIcons'
,p_group_id=>wwv_flow_imp.id(750889118497733147)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949420291156220482)
,p_theme_id=>42
,p_name=>'SHOWTOPICONS'
,p_display_name=>'For Top Level Items Only'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949419333489220480)
,p_css_classes=>'t-LinksList--showTopIcons'
,p_group_id=>wwv_flow_imp.id(750889118497733147)
,p_template_types=>'LIST'
,p_help_text=>'This will show icons for top level items of the list only. It will not show icons for sub lists.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949420675088220484)
,p_theme_id=>42
,p_name=>'2COLUMNGRID'
,p_display_name=>'2 Column Grid'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--cols t-MediaList--2cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949420842921220484)
,p_theme_id=>42
,p_name=>'3COLUMNGRID'
,p_display_name=>'3 Column Grid'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--cols t-MediaList--3cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949420939400220484)
,p_theme_id=>42
,p_name=>'4COLUMNGRID'
,p_display_name=>'4 Column Grid'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--cols t-MediaList--4cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949421045603220484)
,p_theme_id=>42
,p_name=>'5COLUMNGRID'
,p_display_name=>'5 Column Grid'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--cols t-MediaList--5cols'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949422067235220485)
,p_theme_id=>42
,p_name=>'SPANHORIZONTAL'
,p_display_name=>'Span Horizontal'
,p_display_sequence=>50
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--horizontal'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Show all list items in one horizontal row.'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949422384898220487)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>40
,p_list_template_id=>wwv_flow_imp.id(1949422252641220485)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949422563450220487)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949422252641220485)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949422685440220487)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949422252641220485)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949423378235220493)
,p_theme_id=>42
,p_name=>'ABOVE_LABEL'
,p_display_name=>'Above Label'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949423187476220492)
,p_css_classes=>'t-Tabs--iconsAbove'
,p_group_id=>wwv_flow_imp.id(750889517607733147)
,p_template_types=>'LIST'
,p_help_text=>'Places icons above tab label.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949423540660220494)
,p_theme_id=>42
,p_name=>'FILL_LABELS'
,p_display_name=>'Fill Labels'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_imp.id(1949423187476220492)
,p_css_classes=>'t-Tabs--fillLabels'
,p_group_id=>wwv_flow_imp.id(750891151443733148)
,p_template_types=>'LIST'
,p_help_text=>'Stretch tabs to fill to the width of the tabs container.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949423576758220494)
,p_theme_id=>42
,p_name=>'INLINE_WITH_LABEL'
,p_display_name=>'Inline with Label'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949423187476220492)
,p_css_classes=>'t-Tabs--inlineIcons'
,p_group_id=>wwv_flow_imp.id(750889517607733147)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949423956445220494)
,p_theme_id=>42
,p_name=>'LARGE'
,p_display_name=>'Large'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949423187476220492)
,p_css_classes=>'t-Tabs--large'
,p_group_id=>wwv_flow_imp.id(750891989635733148)
,p_template_types=>'LIST'
,p_help_text=>'Increases font size and white space around tab items.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949423985224220494)
,p_theme_id=>42
,p_name=>'PILL'
,p_display_name=>'Pill'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949423187476220492)
,p_css_classes=>'t-Tabs--pill'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
,p_help_text=>'Displays tabs in a pill container.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949424099673220494)
,p_theme_id=>42
,p_name=>'SIMPLE'
,p_display_name=>'Simple'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949423187476220492)
,p_css_classes=>'t-Tabs--simple'
,p_group_id=>wwv_flow_imp.id(750892342801733149)
,p_template_types=>'LIST'
,p_help_text=>'A very simplistic tab UI.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949424204133220494)
,p_theme_id=>42
,p_name=>'SMALL'
,p_display_name=>'Small'
,p_display_sequence=>5
,p_list_template_id=>wwv_flow_imp.id(1949423187476220492)
,p_css_classes=>'t-Tabs--small'
,p_group_id=>wwv_flow_imp.id(750891989635733148)
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949424567381220496)
,p_theme_id=>42
,p_name=>'ADD_ACTIONS'
,p_display_name=>'Add Actions'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_imp.id(1949424306183220494)
,p_css_classes=>'js-addActions'
,p_template_types=>'LIST'
,p_help_text=>'Use this option to add shortcuts for menu items. Note that actions.js must be included on your page to support this functionality.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949424583272220496)
,p_theme_id=>42
,p_name=>'BEHAVE_LIKE_TABS'
,p_display_name=>'Behave Like Tabs'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_imp.id(1949424306183220494)
,p_css_classes=>'js-tabLike'
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949424795246220496)
,p_theme_id=>42
,p_name=>'SHOW_SUB_MENU_ICONS'
,p_display_name=>'Show Sub Menu Icons'
,p_display_sequence=>1
,p_list_template_id=>wwv_flow_imp.id(1949424306183220494)
,p_css_classes=>'js-showSubMenuIcons'
,p_template_types=>'LIST'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949425320737220498)
,p_theme_id=>42
,p_name=>'ALLSTEPS'
,p_display_name=>'All Steps'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949424871898220496)
,p_css_classes=>'t-WizardSteps--displayLabels'
,p_group_id=>wwv_flow_imp.id(750890779976733148)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949425374576220498)
,p_theme_id=>42
,p_name=>'CURRENTSTEPONLY'
,p_display_name=>'Current Step Only'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949424871898220496)
,p_css_classes=>'t-WizardSteps--displayCurrentLabelOnly'
,p_group_id=>wwv_flow_imp.id(750890779976733148)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949425546673220498)
,p_theme_id=>42
,p_name=>'HIDELABELS'
,p_display_name=>'Hide Labels'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949424871898220496)
,p_css_classes=>'t-WizardSteps--hideLabels'
,p_group_id=>wwv_flow_imp.id(750890779976733148)
,p_template_types=>'LIST'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949426854182220515)
,p_theme_id=>42
,p_name=>'LEFTICON'
,p_display_name=>'Left'
,p_display_sequence=>10
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_css_classes=>'t-Button--iconLeft'
,p_group_id=>wwv_flow_imp.id(750878731150733140)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1949426890169220515)
,p_theme_id=>42
,p_name=>'RIGHTICON'
,p_display_name=>'Right'
,p_display_sequence=>20
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_css_classes=>'t-Button--iconRight'
,p_group_id=>wwv_flow_imp.id(750878731150733140)
,p_template_types=>'BUTTON'
,p_is_advanced=>'N'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1992936702646359424)
,p_theme_id=>42
,p_name=>'SHOW_ICONS'
,p_display_name=>'Show Icons'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--showIcons'
,p_template_types=>'LIST'
,p_help_text=>'Display an icon next to the list item.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1992937009614359424)
,p_theme_id=>42
,p_name=>'SHOW_DESCRIPTION'
,p_display_name=>'Show Description'
,p_display_sequence=>20
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--showDesc'
,p_template_types=>'LIST'
,p_help_text=>'Shows the description (Attribute 1) for each list item.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(1992937274657359424)
,p_theme_id=>42
,p_name=>'SHOW_BADGES'
,p_display_name=>'Show Badges'
,p_display_sequence=>30
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
,p_css_classes=>'t-MediaList--showBadges'
,p_template_types=>'LIST'
,p_help_text=>'Show a badge (Attribute 2) to the right of the list item.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2240374185741312899)
,p_theme_id=>42
,p_name=>'LIGHT_BACKGROUND'
,p_display_name=>'Light Background'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-ContentBlock--lightBG'
,p_group_id=>wwv_flow_imp.id(750899165902733153)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly lighter background.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2240374661205312899)
,p_theme_id=>42
,p_name=>'ADD_BODY_PADDING'
,p_display_name=>'Add Body Padding'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-ContentBlock--padded'
,p_template_types=>'REGION'
,p_help_text=>'Adds padding to the region''s body container.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2240375373989312900)
,p_theme_id=>42
,p_name=>'SHADOW_BACKGROUND'
,p_display_name=>'Shadow Background'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1165299980216731287)
,p_css_classes=>'t-ContentBlock--shadowBG'
,p_group_id=>wwv_flow_imp.id(750899165902733153)
,p_template_types=>'REGION'
,p_help_text=>'Gives the region body a slightly darker background.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2317529364867916187)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2317553181751916413)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949397075503220418)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Interactive Reports toolbar to maximize the report. Clicking this button will toggle the maximize state and stretch the report to fill the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2317557446040916475)
,p_theme_id=>42
,p_name=>'SHOW_MAXIMIZE_BUTTON'
,p_display_name=>'Show Maximize Button'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'js-showMaximizeButton'
,p_template_types=>'REGION'
,p_help_text=>'Displays a button in the Region Header to maximize the region. Clicking this button will toggle the maximize state and stretch the region to fill the screen.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2343958150511559429)
,p_theme_id=>42
,p_name=>'VERTICAL_LIST'
,p_display_name=>'Vertical Orientation'
,p_display_sequence=>10
,p_list_template_id=>wwv_flow_imp.id(1949424871898220496)
,p_css_classes=>'t-WizardSteps--vertical'
,p_template_types=>'LIST'
,p_help_text=>'Displays the wizard progress list in a vertical orientation and is suitable for displaying within a side column of a page.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2426766230508450494)
,p_theme_id=>42
,p_name=>'SHOW_TITLE'
,p_display_name=>'Show Title'
,p_display_sequence=>10
,p_region_template_id=>wwv_flow_imp.id(1949404212621220439)
,p_css_classes=>'t-Wizard--showTitle'
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2449873659948599393)
,p_theme_id=>42
,p_name=>'10_SECONDS'
,p_display_name=>'10 Seconds'
,p_display_sequence=>20
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'js-cycle10s'
,p_group_id=>wwv_flow_imp.id(750913982961733163)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2449874221188599394)
,p_theme_id=>42
,p_name=>'15_SECONDS'
,p_display_name=>'15 Seconds'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'js-cycle15s'
,p_group_id=>wwv_flow_imp.id(750913982961733163)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2449874836100599394)
,p_theme_id=>42
,p_name=>'20_SECONDS'
,p_display_name=>'20 Seconds'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949389921510220408)
,p_css_classes=>'js-cycle20s'
,p_group_id=>wwv_flow_imp.id(750913982961733163)
,p_template_types=>'REGION'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2449889027463599420)
,p_theme_id=>42
,p_name=>'480PX'
,p_display_name=>'480px'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'i-h480'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 480px.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2449889607749599420)
,p_theme_id=>42
,p_name=>'640PX'
,p_display_name=>'640px'
,p_display_sequence=>40
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'i-h640'
,p_group_id=>wwv_flow_imp.id(750897899718733152)
,p_template_types=>'REGION'
,p_help_text=>'Sets body height to 640px.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2514102574198507200)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949394665889220415)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
wwv_flow_imp_shared.create_template_option(
 p_id=>wwv_flow_imp.id(2514633541224598553)
,p_theme_id=>42
,p_name=>'REMOVE_UI_DECORATION'
,p_display_name=>'Remove UI Decoration'
,p_display_sequence=>30
,p_region_template_id=>wwv_flow_imp.id(1949398930020220427)
,p_css_classes=>'t-Region--noUI'
,p_group_id=>wwv_flow_imp.id(750912708010733162)
,p_template_types=>'REGION'
,p_help_text=>'Removes UI decoration (borders, backgrounds, shadows, etc) from the region.'
);
end;
/
prompt --application/shared_components/globalization/language
begin
null;
end;
/
prompt --application/shared_components/globalization/translations
begin
null;
end;
/
prompt --application/shared_components/logic/build_options
begin
null;
end;
/
prompt --application/shared_components/globalization/messages
begin
wwv_flow_imp_shared.create_message(
 p_id=>wwv_flow_imp.id(15096419296523731804)
,p_name=>'AC_CONFIGURATION_INFO'
,p_message_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p><b>Enabling Access Control</b> means that access to the application and its features are controlled by the current <b>Access Control List</b>, as defined by the application administrator. There are 3 access levels available that can be granted to '
||'a user; Administrator, Contributor and Reader. Please see the Manager User pages for further details on what each level provides.</p>',
'<p>In addition, if you don''t want to have to define every ''Reader'' of your application, you can select <b>Any Authenticated User</b> from the <b>Reader Access</b> configuration option. This opens read-only access to any user who can authenticate into'
||' your application.</p>',
'<br />',
'<p><b>Disabling Access Control</b> means that access to the application and all of its features including Administration are open to any user who can authenticate to the application.</p>',
'<br />',
'<p>Note: Irrespective of whether Access Control is enabled or disabled, a user still has to authenticate successfully into the application.</p>'))
,p_version_scn=>37166093939415
);
wwv_flow_imp_shared.create_message(
 p_id=>wwv_flow_imp.id(15050345873207027794)
,p_name=>'ADMINISTRATION'
,p_message_text=>'Administration'
,p_version_scn=>37166093939415
);
wwv_flow_imp_shared.create_message(
 p_id=>wwv_flow_imp.id(15050361279095029439)
,p_name=>'HELP'
,p_message_text=>'Help'
,p_version_scn=>37166093939415
);
wwv_flow_imp_shared.create_message(
 p_id=>wwv_flow_imp.id(3206351796728889955)
,p_name=>'LOGOUT'
,p_message_text=>'Logout'
,p_version_scn=>37166093939415
);
wwv_flow_imp_shared.create_message(
 p_id=>wwv_flow_imp.id(15050384893986033810)
,p_name=>'MOBILE'
,p_message_text=>'Mobile'
,p_version_scn=>37166093939415
);
wwv_flow_imp_shared.create_message(
 p_id=>wwv_flow_imp.id(15050337901127026355)
,p_name=>'USER'
,p_message_text=>'User'
,p_version_scn=>37166093939415
);
end;
/
prompt --application/shared_components/globalization/dyntranslations
begin
null;
end;
/
prompt --application/shared_components/user_interface/shortcuts/delete_confirm_msg
begin
wwv_flow_imp_shared.create_shortcut(
 p_id=>wwv_flow_imp.id(15095889476663619015)
,p_shortcut_name=>'DELETE_CONFIRM_MSG'
,p_shortcut_type=>'TEXT_ESCAPE_JS'
,p_version_scn=>41609524352528
,p_shortcut=>'Would you like to perform this delete action?'
);
end;
/
prompt --application/shared_components/security/authentications/apex_auth
begin
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(14835041091875770271)
,p_name=>'APEX Auth'
,p_scheme_type=>'NATIVE_APEX_ACCOUNTS'
,p_invalid_session_type=>'LOGIN'
,p_logout_url=>'f?p=&APP_ID.:1'
,p_cookie_name=>'ORA_WWV_PACKAGED_APPLICATIONS'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
,p_version_scn=>41609524352528
);
end;
/
prompt --application/shared_components/plugins/template_component/theme_42_avatar
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(454763766624587720)
,p_plugin_type=>'TEMPLATE COMPONENT'
,p_theme_id=>nvl(wwv_flow_application_install.get_theme_id, '42')
,p_name=>'THEME_42$AVATAR'
,p_display_name=>'Avatar'
,p_supported_component_types=>'PARTIAL'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('TEMPLATE COMPONENT','THEME_42$AVATAR'),'')
,p_partial_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if APEX$IS_LAZY_LOADING/}',
'  <span class="t-Avatar is-placeholder{if ?SHAPE/} #SHAPE!ATTR#{endif/}{if ?SIZE/} #SIZE!ATTR#{endif/}{if ?CSS_CLASSES/} #CSS_CLASSES!ATTR#{endif/}"></span>',
'{else/}',
'  {if ?LINK/}<a href="#LINK!ATTR#" #LINK_ATTR!RAW#{else/}<span{endif/} class="t-Avatar{if ?TYPE/} t-Avatar--{if ?IMAGE/}image{else/}{if ?INITIALS/}initials{else/}icon{endif/}{endif/}{endif/}{if ?SHAPE/} #SHAPE!ATTR#{endif/}{if ?SIZE/} #SIZE!ATTR#{end'
||'if/}{if ?ICON/} #ICON!ATTR#{else/} fa fa-user{endif/}{if ?CSS_CLASSES/} #CSS_CLASSES!ATTR#{endif/} u-color" {if !IMAGE/}{if DESCRIPTION/} role="img" aria-label="#DESCRIPTION!ATTR#" title="#DESCRIPTION!ATTR#"{else/} role="presentation"{endif/}{endif/}'
||'>{if IMAGE/}<img src="#IMAGE!ATTR#" alt="#DESCRIPTION!ATTR#"{if ?DESCRIPTION/} title="#DESCRIPTION!ATTR#"{endif/} loading="lazy" />{else/}{if ?INITIALS/}#INITIALS!RAW#{endif/}{endif/}{if ?LINK/}</a>{else/}</span>{endif/}',
'{endif/}'))
,p_default_escape_mode=>'HTML'
,p_translate_this_template=>false
,p_api_version=>2
,p_standard_attributes=>'REGION_TEMPLATE'
,p_substitute_attributes=>true
,p_reference_id=>1564363394689414260
,p_subscribe_plugin_settings=>true
,p_help_text=>'Display an image, icon, or initials. Available as a partial template to display a single row.'
,p_version_identifier=>'1.0'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751447041323733633)
,p_plugin_id=>wwv_flow_imp.id(454763766624587720)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'TYPE'
,p_prompt=>'Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'IMAGE'
,p_demo_value=>'IMAGE'
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Select the type of content that will be displayed in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751447500627733633)
,p_plugin_attribute_id=>wwv_flow_imp.id(751447041323733633)
,p_display_sequence=>10
,p_display_value=>'Image'
,p_return_value=>'IMAGE'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751448150751733634)
,p_plugin_attribute_id=>wwv_flow_imp.id(751447041323733633)
,p_display_sequence=>20
,p_display_value=>'Initials'
,p_return_value=>'INITIALS'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751448775573733635)
,p_plugin_attribute_id=>wwv_flow_imp.id(751447041323733633)
,p_display_sequence=>30
,p_display_value=>'Icon'
,p_return_value=>'ICON'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751449300079733635)
,p_plugin_id=>wwv_flow_imp.id(454763766624587720)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'IMAGE'
,p_prompt=>'Image'
,p_attribute_type=>'MEDIA'
,p_is_required=>false
,p_demo_value=>'#APEX_FILES#apex_ui/img/favicons/app-artwork-catalog.png'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751447041323733633)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'IMAGE'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Use the Media popup dialog to select a source for the avatar image.</p>',
'',
'<p>Available options include:',
'<ul>',
'<li>URL</li>',
'<li>BLOB Column</li>',
'<li>URL Column</li>',
'</ul>',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751449855105733636)
,p_plugin_id=>wwv_flow_imp.id(454763766624587720)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>55
,p_static_id=>'DESCRIPTION'
,p_prompt=>'Description'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Enter a short description of the image/icon or select a source column from the quick pick options. This will be used as title & alt text for the avatar image/icon.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751450306521733636)
,p_plugin_id=>wwv_flow_imp.id(454763766624587720)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'INITIALS'
,p_prompt=>'Initials'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>false
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751447041323733633)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'INITIALS'
,p_help_text=>'Select the source column to be displayed within each avatar. Only varchar2 data types are supported.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751450885671733637)
,p_plugin_id=>wwv_flow_imp.id(454763766624587720)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'ICON'
,p_prompt=>'Icon'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751447041323733633)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'ICON'
,p_help_text=>'Enter an icon class or use the Pick Icon dialog to select the icon you want to add to display in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751451385170733637)
,p_plugin_id=>wwv_flow_imp.id(454763766624587720)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'SHAPE'
,p_prompt=>'Shape'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Select the shape of the avatar. Default inherits the shape set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751451808380733638)
,p_plugin_attribute_id=>wwv_flow_imp.id(751451385170733637)
,p_display_sequence=>10
,p_display_value=>'Rounded'
,p_return_value=>'t-Avatar--rounded'
,p_help_text=>'Displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751452441419733638)
,p_plugin_attribute_id=>wwv_flow_imp.id(751451385170733637)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'t-Avatar--circle'
,p_help_text=>'Displayed within a circular shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751453067834733639)
,p_plugin_attribute_id=>wwv_flow_imp.id(751451385170733637)
,p_display_sequence=>30
,p_display_value=>'Square'
,p_return_value=>'t-Avatar--square'
,p_help_text=>'Displayed within a square shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751453635527733640)
,p_plugin_attribute_id=>wwv_flow_imp.id(751451385170733637)
,p_display_sequence=>40
,p_display_value=>'No Shape'
,p_return_value=>'t-Avatar--noShape'
,p_help_text=>'Displayed inline without a containing shape.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751454286345733641)
,p_plugin_id=>wwv_flow_imp.id(454763766624587720)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'SIZE'
,p_prompt=>'Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Set the size of the avatar. The default inherits the sizing set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751454771230733641)
,p_plugin_attribute_id=>wwv_flow_imp.id(751454286345733641)
,p_display_sequence=>10
,p_display_value=>'Extra Extra Small'
,p_return_value=>'t-Avatar--xxs'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751455317575733642)
,p_plugin_attribute_id=>wwv_flow_imp.id(751454286345733641)
,p_display_sequence=>20
,p_display_value=>'Extra Small'
,p_return_value=>'t-Avatar--xs'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751455937632733643)
,p_plugin_attribute_id=>wwv_flow_imp.id(751454286345733641)
,p_display_sequence=>30
,p_display_value=>'Small'
,p_return_value=>'t-Avatar--sm'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751456536766733644)
,p_plugin_attribute_id=>wwv_flow_imp.id(751454286345733641)
,p_display_sequence=>40
,p_display_value=>'Medium'
,p_return_value=>'t-Avatar--md'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751457177555733645)
,p_plugin_attribute_id=>wwv_flow_imp.id(751454286345733641)
,p_display_sequence=>50
,p_display_value=>'Large'
,p_return_value=>'t-Avatar--lg'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751457781257733645)
,p_plugin_attribute_id=>wwv_flow_imp.id(751454286345733641)
,p_display_sequence=>60
,p_display_value=>'Extra Large'
,p_return_value=>'t-Avatar--xl'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751458365952733646)
,p_plugin_attribute_id=>wwv_flow_imp.id(751454286345733641)
,p_display_sequence=>70
,p_display_value=>'Extra Extra Large'
,p_return_value=>'t-Avatar--xxl'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751458925272733647)
,p_plugin_id=>wwv_flow_imp.id(454763766624587720)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'CSS_CLASSES'
,p_prompt=>'CSS Classes'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_common=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Enter classes to add to this component. You may add multiple classes by separating them with a space.'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2254814832112701472)
,p_plugin_id=>wwv_flow_imp.id(454763766624587720)
,p_name=>'Link'
,p_static_id=>'LINK'
,p_display_sequence=>10
,p_is_quick_pick=>true
,p_type=>'LINK'
);
end;
/
prompt --application/shared_components/plugins/template_component/theme_42_badge
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(454778065441587730)
,p_plugin_type=>'TEMPLATE COMPONENT'
,p_theme_id=>nvl(wwv_flow_application_install.get_theme_id, '42')
,p_name=>'THEME_42$BADGE'
,p_display_name=>'Badge'
,p_supported_component_types=>'PARTIAL:REPORT'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('TEMPLATE COMPONENT','THEME_42$BADGE'),'')
,p_partial_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if APEX$IS_LAZY_LOADING/}',
'  <span class="t-Badge is-placeholder{if ?SIZE/} #SIZE!ATTR#{endif/}{if ?SHAPE/} #SHAPE!ATTR#{endif/}"></span>',
'{else/}',
'  {if ?LINK/}<a href="#LINK!ATTR#" #LINK_ATTR!RAW#{else/}<span{endif/} class="t-Badge {if ?STATE/}t-Badge--#STATE!ATTR#{endif/} {if ?STYLE/}#STYLE!ATTR#{endif/} {if ?SIZE/}#SIZE!ATTR#{endif/} {if ?SHAPE/}#SHAPE!ATTR#{endif/}" role="status" aria-label'
||'="#LABEL!ATTR# #VALUE!ATTR#" title="#LABEL!ATTR# #VALUE!ATTR#">',
'    {if ?ICON/}<span class="t-Badge-icon #ICON!ATTR#" aria-hidden="true"></span>{endif/}',
'    {if LABEL_DISPLAY/}<span class="t-Badge-label">#LABEL!RAW#</span>{endif/}',
'    <span class="t-Badge-value">#VALUE!RAW#</span>',
'  {if ?LINK/}</a>{else/}</span>{endif/}',
'{endif/}',
''))
,p_default_escape_mode=>'HTML'
,p_translate_this_template=>true
,p_api_version=>2
,p_report_body_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if !APEX$HAS_MESSAGE/}',
'  <ul class="t-Badges #APEX$COMPONENT_CSS_CLASSES#">#APEX$ROWS#</ul>',
'{endif/}'))
,p_report_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Badges-item" #APEX$ROW_IDENTIFICATION#>#APEX$PARTIAL#</li>',
''))
,p_report_placeholder_count=>1
,p_standard_attributes=>'REGION_TEMPLATE'
,p_substitute_attributes=>true
,p_reference_id=>1564377533892414278
,p_subscribe_plugin_settings=>true
,p_help_text=>'Display content within a badge. Available for multiple report rows or a single row.'
,p_version_identifier=>'1.0'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751461415411733655)
,p_plugin_id=>wwv_flow_imp.id(454778065441587730)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'LABEL'
,p_prompt=>'Label'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_escape_mode=>'STRIPHTML'
,p_is_translatable=>true
,p_help_text=>'Enter a value for the badge label or select a source column from the quick pick options.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751461986000733656)
,p_plugin_id=>wwv_flow_imp.id(454778065441587730)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'VALUE'
,p_prompt=>'Value'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_escape_mode=>'STRIPHTML'
,p_column_data_types=>'VARCHAR2:NUMBER:DATE:INTERVAL_Y2M:INTERVAL_D2S'
,p_is_translatable=>false
,p_help_text=>'Select a source column for the badge value.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751462494555733657)
,p_plugin_id=>wwv_flow_imp.id(454778065441587730)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'STATE'
,p_prompt=>'State'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select the source column for the state of the badge. Substitute column value with "danger", "warning", "success" or "info" for default styling.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751462960073733657)
,p_plugin_id=>wwv_flow_imp.id(454778065441587730)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'ICON'
,p_prompt=>'Icon'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Enter an icon class or use the Pick Icon dialog to select the icon you want to add to display in the badge.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751463474810733658)
,p_plugin_id=>wwv_flow_imp.id(454778065441587730)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'LABEL_DISPLAY'
,p_prompt=>'Display Label'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to display or hide the badge label. When set to Yes, the badge label will be displayed in addition to the badge value. When set to No, only the badge value will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751463939552733659)
,p_plugin_id=>wwv_flow_imp.id(454778065441587730)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'STYLE'
,p_prompt=>'Style'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Select the badge style. Default inherits the style set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751464426044733660)
,p_plugin_attribute_id=>wwv_flow_imp.id(751463939552733659)
,p_display_sequence=>10
,p_display_value=>'Subtle'
,p_return_value=>'t-Badge--subtle'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751465017916733661)
,p_plugin_attribute_id=>wwv_flow_imp.id(751463939552733659)
,p_display_sequence=>20
,p_display_value=>'Outline'
,p_return_value=>'t-Badge--outline'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751465683207733662)
,p_plugin_id=>wwv_flow_imp.id(454778065441587730)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'SHAPE'
,p_prompt=>'Shape'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Select the shape of the badge. Default inherits the shape set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751466135764733662)
,p_plugin_attribute_id=>wwv_flow_imp.id(751465683207733662)
,p_display_sequence=>10
,p_display_value=>'Rounded'
,p_return_value=>'t-Badge--rounded'
,p_help_text=>'Displayed with rounded corners.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751466782290733663)
,p_plugin_attribute_id=>wwv_flow_imp.id(751465683207733662)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'t-Badge--circle'
,p_help_text=>'Displayed with circular edges.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751467362216733664)
,p_plugin_attribute_id=>wwv_flow_imp.id(751465683207733662)
,p_display_sequence=>30
,p_display_value=>'Square'
,p_return_value=>'t-Badge--square'
,p_help_text=>'Displayed with squared edges.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751467932995733665)
,p_plugin_id=>wwv_flow_imp.id(454778065441587730)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'SIZE'
,p_prompt=>'Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Set the size of the badge. The default inherits the sizing set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751468470308733665)
,p_plugin_attribute_id=>wwv_flow_imp.id(751467932995733665)
,p_display_sequence=>10
,p_display_value=>'Small'
,p_return_value=>'t-Badge--sm'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751469055405733666)
,p_plugin_attribute_id=>wwv_flow_imp.id(751467932995733665)
,p_display_sequence=>20
,p_display_value=>'Medium'
,p_return_value=>'t-Badge--md'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751469630517733667)
,p_plugin_attribute_id=>wwv_flow_imp.id(751467932995733665)
,p_display_sequence=>30
,p_display_value=>'Large'
,p_return_value=>'t-Badge--lg'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2262943368261835844)
,p_plugin_id=>wwv_flow_imp.id(454778065441587730)
,p_name=>'Link'
,p_static_id=>'LINK'
,p_display_sequence=>10
,p_type=>'LINK'
);
end;
/
prompt --application/shared_components/plugins/template_component/theme_42_comments
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(454787370578587737)
,p_plugin_type=>'TEMPLATE COMPONENT'
,p_theme_id=>nvl(wwv_flow_application_install.get_theme_id, '42')
,p_name=>'THEME_42$COMMENTS'
,p_display_name=>'Comments'
,p_supported_component_types=>'PARTIAL:REPORT'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('TEMPLATE COMPONENT','THEME_42$COMMENTS'),'')
,p_partial_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if APEX$IS_LAZY_LOADING/}',
'  <div class="t-Comments-item{if ?COMMENT_CLASS/} #COMMENT_CLASS!ATTR#{endif/}">',
'    {if DISPLAY_AVATAR%assigned/}',
'      <div class="t-Comments-icon">',
'        {with/}',
'          SIZE:=t-Avatar--xs',
'          SHAPE:=#AVATAR_SHAPE#',
'        {apply THEME$AVATAR/}',
'      </div>',
'    {endif/}',
'    <div class="t-Comments-body">',
'      <div class="t-Comments-info">',
'        <span class="t-Comments-user is-placeholder"></span>',
'      </div>',
'      <div class="t-Comments-comment is-placeholder"></div>',
'    </div>',
'  </div>',
'{else/}',
'  <div class="t-Comments-item{if ?COMMENT_CLASS/} #COMMENT_CLASS!ATTR#{endif/}">',
'    {if DISPLAY_AVATAR/}',
'      <div class="t-Comments-icon">',
'        {with/}',
'          TYPE:=#AVATAR_TYPE#',
'          IMAGE:=#AVATAR_IMAGE#',
'          DESCRIPTION:=#AVATAR_DESCRIPTION#',
'          ICON:=#AVATAR_ICON#',
'          INITIALS:=#AVATAR_INITIALS#',
'          SIZE:=t-Avatar--xs',
'          SHAPE:=#AVATAR_SHAPE#',
'          CSS_CLASSES:=u-color',
'          LINK:=#AVATAR_LINK#',
'          LINK_ATTR:=#AVATAR_LINK_ATTR!RAW#',
'        {apply THEME$AVATAR/}',
'      </div>',
'    {endif/}',
'    <div class="t-Comments-body">',
'      <div class="t-Comments-info">',
'        <span class="t-Comments-user">{if USER_NAME_LINK/}<a href="#USER_NAME_LINK!ATTR#" #USER_NAME_LINK_ATTR!RAW#>{endif/}#USER_NAME!RAW#{if USER_NAME_LINK/}</a>{endif/}</span>',
'        {if COMMENT_DATE/}<span class="t-Comments-date">#COMMENT_DATE!RAW#</span>{endif/}',
'        {if ACTIONS/}<span class="t-Comments-actions">#ACTIONS!RAW#</span>{endif/}',
'      </div>',
'      <div class="t-Comments-comment">',
'        #COMMENT_TEXT!RAW#',
'        {if ATTRIBUTES/}<div class="t-Comments-attributes">#ATTRIBUTES!RAW#</div>{endif/}',
'      </div>',
'    </div>',
'  </div>',
'{endif/}'))
,p_default_escape_mode=>'HTML'
,p_translate_this_template=>false
,p_api_version=>1
,p_report_body_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-Comments{if ?STYLE/} #STYLE!ATTR#{endif/} {if APPLY_THEME_COLORS/} u-colors{endif/} #APEX$COMPONENT_CSS_CLASSES#">#APEX$ROWS#</ul>',
''))
,p_report_row_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<li class="t-Comments-item" #APEX$ROW_IDENTIFICATION#>#APEX$PARTIAL#</li>',
''))
,p_report_placeholder_count=>3
,p_standard_attributes=>'REGION_TEMPLATE'
,p_substitute_attributes=>true
,p_reference_id=>1564386865908414285
,p_subscribe_plugin_settings=>true
,p_is_quick_pick=>true
,p_help_text=>'Display user comments and status updates. Supports avatars. Available for a single row or as a report with multiple rows.'
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(2551360593285765395)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_title=>'Avatar'
,p_display_sequence=>20
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751475869968733681)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'COMMENT_TEXT'
,p_prompt=>'Comment Text'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_demo_value=>'Praesent vel felis rutrum erat elementum viverra sit amet non odio. Cras vel auctor eros, in malesuada dolor. Nulla tellus magna, ornare consectetur purus id, volutpat egestas felis. Proin lobortis risus massa, nec faucibus arcu malesuada a. Nunc sed'
||' gravida urna. Fusce at ligula sed erat consequat pharetra.'
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select a source column containing text for user comments.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751476378030733682)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'USER_NAME'
,p_prompt=>'User Name'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_demo_value=>'Joel'
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select a source column to be displayed as the user name associated with a comment.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751476828710733683)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'COMMENT_DATE'
,p_prompt=>'Date'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>false
,p_demo_value=>'5 minutes ago'
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2:DATE'
,p_is_translatable=>false
,p_help_text=>'Select a source column containing a date, date range, or time.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751477367045733684)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'ATTRIBUTES'
,p_prompt=>'Attributes'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_escape_mode=>'HTML'
,p_is_translatable=>true
,p_help_text=>'Enter some text and/or column substitution strings to be used as the comment attributes.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751477876860733684)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'AVATAR_TYPE'
,p_prompt=>'Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'icon'
,p_demo_value=>'initials'
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751485068825733696)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2551360593285765395)
,p_help_text=>'Select the type of content that will be displayed in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751478353402733685)
,p_plugin_attribute_id=>wwv_flow_imp.id(751477876860733684)
,p_display_sequence=>10
,p_display_value=>'Image'
,p_return_value=>'image'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751478967166733686)
,p_plugin_attribute_id=>wwv_flow_imp.id(751477876860733684)
,p_display_sequence=>20
,p_display_value=>'Initials'
,p_return_value=>'initials'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751479553010733687)
,p_plugin_attribute_id=>wwv_flow_imp.id(751477876860733684)
,p_display_sequence=>30
,p_display_value=>'Icon'
,p_return_value=>'icon'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751480176066733688)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'AVATAR_IMAGE'
,p_prompt=>'Image'
,p_attribute_type=>'MEDIA'
,p_is_required=>true
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751477876860733684)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'image'
,p_attribute_group_id=>wwv_flow_imp.id(2551360593285765395)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Use the Media popup dialog to select a source for the avatar image.</p>',
'',
'<p>Available options include:',
'<ul>',
'<li>URL</li>',
'<li>BLOB Column</li>',
'<li>URL Column</li>',
'</ul>',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751480654748733689)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>95
,p_static_id=>'AVATAR_DESCRIPTION'
,p_prompt=>'Description'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>true
,p_attribute_group_id=>wwv_flow_imp.id(2551360593285765395)
,p_help_text=>'Enter a short description of the image/icon or select a source column from the quick pick options. This will be used as title & alt text for the avatar image/icon.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751481191818733690)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'AVATAR_INITIALS'
,p_prompt=>'Initials'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_demo_value=>'JK'
,p_escape_mode=>'STRIPHTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751477876860733684)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'initials'
,p_attribute_group_id=>wwv_flow_imp.id(2551360593285765395)
,p_help_text=>'Select the source column to be displayed within each avatar. Only varchar2 data types are supported.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751481602207733690)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_static_id=>'AVATAR_ICON'
,p_prompt=>'Icon'
,p_attribute_type=>'ICON'
,p_is_required=>true
,p_default_value=>'fa-user'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751477876860733684)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'icon'
,p_attribute_group_id=>wwv_flow_imp.id(2551360593285765395)
,p_help_text=>'Enter an icon class or use the Pick Icon dialog to select the icon you want to add to display in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751482118742733691)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_static_id=>'AVATAR_SHAPE'
,p_prompt=>'Shape'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'t-Avatar--rounded'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751485068825733696)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2551360593285765395)
,p_help_text=>'Select the shape of the avatar. Default inherits the shape set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751482675282733692)
,p_plugin_attribute_id=>wwv_flow_imp.id(751482118742733691)
,p_display_sequence=>10
,p_display_value=>'Rounded'
,p_return_value=>'t-Avatar--rounded'
,p_help_text=>'Displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751483209867733693)
,p_plugin_attribute_id=>wwv_flow_imp.id(751482118742733691)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'t-Avatar--circle'
,p_help_text=>'Displayed within a circular shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751483815028733694)
,p_plugin_attribute_id=>wwv_flow_imp.id(751482118742733691)
,p_display_sequence=>30
,p_display_value=>'Square'
,p_return_value=>'t-Avatar--square'
,p_help_text=>'Displayed within a square shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751484442981733695)
,p_plugin_attribute_id=>wwv_flow_imp.id(751482118742733691)
,p_display_sequence=>40
,p_display_value=>'No Shape'
,p_return_value=>'t-Avatar--noShape'
,p_help_text=>'Displayed inline without a containing shape.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751485068825733696)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_static_id=>'DISPLAY_AVATAR'
,p_prompt=>'Display Avatar'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_demo_value=>'Y'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to display or hide the avatar for each row. When set to Yes, an avatar will be displayed with the assigned image, icon, or initials. When set to No, no avatar will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751485589436733697)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>45
,p_static_id=>'COMMENT_CLASS'
,p_prompt=>'Comment Class'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Allows you to pass a class onto individual comments. Example using is-active will highlight the specific comment with a different shade.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751486050053733698)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_static_id=>'STYLE'
,p_prompt=>'Style'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'t-Comments--basic'
,p_demo_value=>'t-Comments--chat'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_help_text=>'Set the style of the comments.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751486528452733698)
,p_plugin_attribute_id=>wwv_flow_imp.id(751486050053733698)
,p_display_sequence=>10
,p_display_value=>'Basic'
,p_return_value=>'t-Comments--basic'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751487177661733699)
,p_plugin_attribute_id=>wwv_flow_imp.id(751486050053733698)
,p_display_sequence=>20
,p_display_value=>'Chat (Speech Bubbles)'
,p_return_value=>'t-Comments--chat'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751487734353733699)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_static_id=>'APPLY_THEME_COLORS'
,p_prompt=>'Apply Theme Colors'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to use the Universal Theme colors for avatar and badge row items. When set to Yes, the u-colors class will be applied to each row. When set to No, a default color will be used instead.'
);
wwv_flow_imp_shared.create_plugin_act_template(
 p_id=>wwv_flow_imp.id(2254805715110720956)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_name=>'Link'
,p_type=>'BUTTON'
,p_template=>'{if !IS_DISABLED/}<a {if CSS_CLASSES/}class="#CSS_CLASSES#"{endif/} href="#LINK_URL#" #LINK_ATTR!RAW#>#LABEL!RAW#</a>{endif/}'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2254805123605713499)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_name=>'Actions'
,p_static_id=>'ACTIONS'
,p_display_sequence=>10
,p_type=>'TEMPLATE'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2254860747275695378)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_name=>'Avatar Link'
,p_static_id=>'AVATAR_LINK'
,p_display_sequence=>20
,p_type=>'LINK'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2255012964988566149)
,p_plugin_id=>wwv_flow_imp.id(454787370578587737)
,p_name=>'User Name Link'
,p_static_id=>'USER_NAME_LINK'
,p_display_sequence=>30
,p_type=>'LINK'
);
end;
/
prompt --application/shared_components/plugins/template_component/theme_42_button
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(454804153755587750)
,p_plugin_type=>'TEMPLATE COMPONENT'
,p_theme_id=>nvl(wwv_flow_application_install.get_theme_id, '42')
,p_name=>'THEME_42$BUTTON'
,p_display_name=>'Button'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('TEMPLATE COMPONENT','THEME_42$BUTTON'),'')
,p_partial_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if MENU_ID/}<button type="button" data-menu="#MENU_ID!ATTR#"{else/}<a href="#LINK_URL!ATTR#" #LINK_ATTR!RAW#{endif/} class="t-Button{if IS_HOT/} t-Button--hot{endif/}{if IS_ICON_ONLY/} t-Button--noLabel t-Button--icon{else/}{if ICON_CLASSES/} t-Butt'
||'on--iconLeft{endif/}{endif/} #CSS_CLASSES!ATTR#" title="#LABEL!ATTR#" {if IS_DISABLED/} disabled{endif/}>',
'  {if ?ICON_CLASSES/}<span class="t-Icon t-Icon--left #ICON_CLASSES!ATTR#" aria-hidden="true"></span>{endif/}<span class="t-Button-label">#LABEL!RAW#</span>',
'{if MENU_ID/}</button>{else/}</a>{endif/}',
''))
,p_default_escape_mode=>'HTML'
,p_translate_this_template=>false
,p_api_version=>1
,p_substitute_attributes=>true
,p_reference_id=>1568467215199837453
,p_subscribe_plugin_settings=>true
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751471015814733670)
,p_plugin_id=>wwv_flow_imp.id(454804153755587750)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'LABEL'
,p_prompt=>'Label'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_escape_mode=>'RAW'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751471577643733670)
,p_plugin_id=>wwv_flow_imp.id(454804153755587750)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'LINK_URL'
,p_prompt=>'Link URL'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751472060135733671)
,p_plugin_id=>wwv_flow_imp.id(454804153755587750)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'LINK_ATTR'
,p_prompt=>'Link Attribute'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_escape_mode=>'RAW'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751472561731733672)
,p_plugin_id=>wwv_flow_imp.id(454804153755587750)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'ICON_CLASSES'
,p_prompt=>'Icon Classes'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751473081359733672)
,p_plugin_id=>wwv_flow_imp.id(454804153755587750)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'CSS_CLASSES'
,p_prompt=>'CSS Classes'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751473574066733673)
,p_plugin_id=>wwv_flow_imp.id(454804153755587750)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'IS_DISABLED'
,p_prompt=>'Is Disabled'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'HTML'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751474068906733673)
,p_plugin_id=>wwv_flow_imp.id(454804153755587750)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'IS_HOT'
,p_prompt=>'Is Hot'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'HTML'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751474564628733674)
,p_plugin_id=>wwv_flow_imp.id(454804153755587750)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'IS_ICON_ONLY'
,p_prompt=>'Is Icon Only'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'HTML'
,p_is_translatable=>false
);
end;
/
prompt --application/shared_components/plugins/template_component/theme_42_timeline
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(454808610226587753)
,p_plugin_type=>'TEMPLATE COMPONENT'
,p_theme_id=>nvl(wwv_flow_application_install.get_theme_id, '42')
,p_name=>'THEME_42$TIMELINE'
,p_display_name=>'Timeline'
,p_supported_component_types=>'PARTIAL:REPORT'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('TEMPLATE COMPONENT','THEME_42$TIMELINE'),'')
,p_partial_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div{if ?CSS_CLASSES/} class="#CSS_CLASSES#"{endif/}{if ?ATTRIBUTES/}#ATTRIBUTES!RAW#{endif/}>',
'  <div class="t-Timeline-wrap">',
'    <div class="t-Timeline-user">',
'      {if DISPLAY_AVATAR/}',
'        {with/}',
'          TYPE:=#AVATAR_TYPE#',
'          IMAGE:=#AVATAR_IMAGE#',
'          DESCRIPTION:=#AVATAR_DESCRIPTION#',
'          INITIALS:=#AVATAR_INITIALS#',
'          ICON:=#AVATAR_ICON#',
'          SHAPE:=#AVATAR_SHAPE#',
'          SIZE:=',
'          LINK:=#AVATAR_LINK#',
'          LINK_ATTR:=#AVATAR_LINK_ATTR!RAW#',
'        {apply THEME$AVATAR/}',
'      {endif/}',
'      <div class="t-Timeline-userinfo">',
'        <span class="t-Timeline-username">{if ?USER_NAME_LINK/}<a href="#USER_NAME_LINK!ATTR#" #USER_NAME_LINK_ATTR!RAW#>{endif/}#USER_NAME!RAW#{if ?USER_NAME_LINK/}</a>{endif/}</span>',
'        <span class="t-Timeline-date">#DATE!RAW#</span>',
'      </div>',
'    </div>',
'    <div class="t-Timeline-content">',
'      {if DISPLAY_BADGE/}',
'        <div class="t-Timeline-typeWrap">',
'          {with/}',
'            LABEL_DISPLAY:=#BADGE_LABEL_DISPLAY#',
'            LABEL:=#BADGE_LABEL#',
'            VALUE:=#BADGE_VALUE#',
'            ICON:=#BADGE_ICON#',
'            STATE:=#BADGE_STATE#',
'          {apply THEME$BADGE/}',
'        </div>',
'      {endif/}',
'      <div class="t-Timeline-body">',
'        <h3 class="t-Timeline-title">{if ?TITLE_LINK/}<a href="#TITLE_LINK!ATTR#" #TITLE_LINK_ATTR!RAW#>{endif/}#TITLE!RAW#{if ?TITLE_LINK/}</a>{endif/}</h3>',
'        {if ?DESCRIPTION/}<p class="t-Timeline-desc">#DESCRIPTION!RAW#</p>{endif/}',
'      </div>',
'    </div>',
'  </div>',
'</div>'))
,p_default_escape_mode=>'HTML'
,p_translate_this_template=>false
,p_api_version=>1
,p_report_body_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul class="t-Timeline{if ?STYLE/} #STYLE#{endif/}{if APPLY_THEME_COLORS/} u-colors{endif/} #APEX$COMPONENT_CSS_CLASSES#">#APEX$ROWS#</ul>',
''))
,p_report_row_template=>'<li class="t-Timeline-item" #APEX$ROW_IDENTIFICATION#>#APEX$PARTIAL#</li>'
,p_report_placeholder_count=>3
,p_standard_attributes=>'REGION_TEMPLATE'
,p_substitute_attributes=>true
,p_reference_id=>1601817836543095628
,p_subscribe_plugin_settings=>true
,p_is_quick_pick=>true
,p_help_text=>'Display a series of events. Supports avatars and badges. Available for a single row or as a report with multiple rows.'
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(2898646629016840755)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_title=>'Avatar'
,p_display_sequence=>10
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(2898646074004840754)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_title=>'Badge'
,p_display_sequence=>20
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751564247482733806)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'USER_NAME'
,p_prompt=>'User Name'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_demo_value=>'User'
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select a source column to be displayed as the user name associated with a timeline event.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751564714950733807)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'DATE'
,p_prompt=>'Date'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_demo_value=>'1 hour ago'
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2:NUMBER:DATE:INTERVAL_Y2M:INTERVAL_D2S'
,p_is_translatable=>false
,p_help_text=>'Select a source column containing a date, date range, or time.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751565276636733807)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'TITLE'
,p_prompt=>'Title'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_demo_value=>'Lorem ipsum dolor sit amet'
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select a source column to be used as the title.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751565766797733808)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'DESCRIPTION'
,p_prompt=>'Description'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>false
,p_demo_value=>'Nunc sit amet nunc quis magna ornare suscipit. Etiam aliquet maximus sapien, at sagittis sem gravida nec.'
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select a source column to be used for the row description.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751566260473733808)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'DISPLAY_AVATAR'
,p_prompt=>'Display Avatar'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_demo_value=>'Y'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to display or hide the avatar for each row. When set to Yes, an avatar will be displayed with the assigned image, icon, or initials. When set to No, no avatar will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751566741558733808)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'DISPLAY_BADGE'
,p_prompt=>'Display Badge'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_demo_value=>'Y'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to display or hide the badge for each row. When set to Yes, a badge will be displayed in each row. When set to No, no badge will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751567261960733809)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'AVATAR_TYPE'
,p_prompt=>'Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'icon'
,p_demo_value=>'icon'
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751566260473733808)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2898646629016840755)
,p_help_text=>'Select the type of content that will be displayed in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751567707273733809)
,p_plugin_attribute_id=>wwv_flow_imp.id(751567261960733809)
,p_display_sequence=>10
,p_display_value=>'Image'
,p_return_value=>'image'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751568390637733810)
,p_plugin_attribute_id=>wwv_flow_imp.id(751567261960733809)
,p_display_sequence=>20
,p_display_value=>'Initials'
,p_return_value=>'initials'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751568905819733810)
,p_plugin_attribute_id=>wwv_flow_imp.id(751567261960733809)
,p_display_sequence=>30
,p_display_value=>'Icon'
,p_return_value=>'icon'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751569535950733811)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'AVATAR_IMAGE'
,p_prompt=>'Image'
,p_attribute_type=>'MEDIA'
,p_is_required=>true
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751567261960733809)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'image'
,p_attribute_group_id=>wwv_flow_imp.id(2898646629016840755)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Use the Media popup dialog to select a source for the avatar image.</p>',
'',
'<p>Available options include:',
'<ul>',
'<li>URL</li>',
'<li>BLOB Column</li>',
'<li>URL Column</li>',
'</ul>',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751570099399733811)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>115
,p_static_id=>'AVATAR_DESCRIPTION'
,p_prompt=>'Description'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>true
,p_attribute_group_id=>wwv_flow_imp.id(2898646629016840755)
,p_help_text=>'Enter a short description of the image/icon or select a source column from the quick pick options. This will be used as title & alt text for the avatar image/icon.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751570497849733812)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_static_id=>'AVATAR_INITIALS'
,p_prompt=>'Initials'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_escape_mode=>'STRIPHTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751567261960733809)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'initials'
,p_attribute_group_id=>wwv_flow_imp.id(2898646629016840755)
,p_help_text=>'Select the source column to be displayed within each avatar. Only varchar2 data types are supported.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751570971997733812)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_static_id=>'AVATAR_ICON'
,p_prompt=>'Icon'
,p_attribute_type=>'ICON'
,p_is_required=>true
,p_default_value=>'fa-user'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751567261960733809)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'icon'
,p_attribute_group_id=>wwv_flow_imp.id(2898646629016840755)
,p_help_text=>'Enter an icon class or use the Pick Icon dialog to select the icon you want to add to display in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751571444008733813)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_static_id=>'AVATAR_SHAPE'
,p_prompt=>'Shape'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'t-Avatar--circle'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751566260473733808)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2898646629016840755)
,p_help_text=>'Select the shape of the avatar. Default inherits the shape set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751571916108733814)
,p_plugin_attribute_id=>wwv_flow_imp.id(751571444008733813)
,p_display_sequence=>10
,p_display_value=>'Rounded'
,p_return_value=>'t-Avatar--rounded'
,p_help_text=>'Displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751572590522733814)
,p_plugin_attribute_id=>wwv_flow_imp.id(751571444008733813)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'t-Avatar--circle'
,p_help_text=>'Displayed within a circular shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751573198353733815)
,p_plugin_attribute_id=>wwv_flow_imp.id(751571444008733813)
,p_display_sequence=>30
,p_display_value=>'Square'
,p_return_value=>'t-Avatar--square'
,p_help_text=>'Displayed within a square shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751573789098733815)
,p_plugin_attribute_id=>wwv_flow_imp.id(751571444008733813)
,p_display_sequence=>40
,p_display_value=>'No Shape'
,p_return_value=>'t-Avatar--noShape'
,p_help_text=>'Displayed inline without a containing shape.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751574382217733816)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_static_id=>'BADGE_LABEL'
,p_prompt=>'Label'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_escape_mode=>'HTML'
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_imp.id(751566741558733808)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2898646074004840754)
,p_help_text=>'Enter a value for the badge label or select a source column from the quick pick options.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751574833615733816)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_static_id=>'BADGE_VALUE'
,p_prompt=>'Value'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_demo_value=>'Closed'
,p_escape_mode=>'ATTR'
,p_column_data_types=>'VARCHAR2:NUMBER:DATE:INTERVAL_Y2M:INTERVAL_D2S'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751566741558733808)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2898646074004840754)
,p_help_text=>'Select a source column for the badge value.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751575391179733817)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>150
,p_static_id=>'BADGE_STATE'
,p_prompt=>'State'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>false
,p_demo_value=>'is-removed'
,p_escape_mode=>'ATTR'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751566741558733808)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2898646074004840754)
,p_help_text=>'Select the source column for the state of the badge. Substitute column value with "danger", "warning", "success" or "info" for default styling.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751575829822733817)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>160
,p_static_id=>'BADGE_ICON'
,p_prompt=>'Icon'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_demo_value=>'fa-check-circle-o'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751566741558733808)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2898646074004840754)
,p_help_text=>'Enter an icon class or use the Pick Icon dialog to select the icon you want to add to display in the badge.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751576313796733818)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>170
,p_static_id=>'BADGE_LABEL_DISPLAY'
,p_prompt=>'Display Label'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751566741558733808)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2898646074004840754)
,p_help_text=>'Specify whether to display or hide the badge label. When set to Yes, the badge label will be displayed in addition to the badge value. When set to No, only the badge value will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751576824299733818)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>180
,p_static_id=>'BADGE_STYLE'
,p_prompt=>'Style'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751566741558733808)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2898646074004840754)
,p_null_text=>'Default'
,p_help_text=>'Select the badge style. Default inherits the style set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751577335621733819)
,p_plugin_attribute_id=>wwv_flow_imp.id(751576824299733818)
,p_display_sequence=>10
,p_display_value=>'Subtle'
,p_return_value=>'t-Badge--subtle'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751577954135733819)
,p_plugin_attribute_id=>wwv_flow_imp.id(751576824299733818)
,p_display_sequence=>20
,p_display_value=>'Outline'
,p_return_value=>'t-Badge--outline'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751578578910733820)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>190
,p_static_id=>'BADGE_SHAPE'
,p_prompt=>'Shape'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751566741558733808)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2898646074004840754)
,p_null_text=>'Default'
,p_help_text=>'Select the shape of the badge. Default inherits the shape set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751579085039733820)
,p_plugin_attribute_id=>wwv_flow_imp.id(751578578910733820)
,p_display_sequence=>10
,p_display_value=>'Rounded'
,p_return_value=>'t-Badge--rounded'
,p_help_text=>'Displayed with rounded corners.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751579673781733821)
,p_plugin_attribute_id=>wwv_flow_imp.id(751578578910733820)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'t-Badge--circle'
,p_help_text=>'Displayed with circular edges.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751580260311733821)
,p_plugin_attribute_id=>wwv_flow_imp.id(751578578910733820)
,p_display_sequence=>30
,p_display_value=>'Square'
,p_return_value=>'t-Badge--square'
,p_help_text=>'Displayed with squared edges.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751580887058733822)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>20
,p_display_sequence=>200
,p_static_id=>'STYLE'
,p_prompt=>'Style'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Set the style of timeline items.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751581320008733822)
,p_plugin_attribute_id=>wwv_flow_imp.id(751580887058733822)
,p_display_sequence=>10
,p_display_value=>'Compact'
,p_return_value=>'t-Timeline--compact'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751581919434733823)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>21
,p_display_sequence=>210
,p_static_id=>'APPLY_THEME_COLORS'
,p_prompt=>'Apply Theme Colors'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_demo_value=>'Y'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to use the Universal Theme colors for avatar and badge row items. When set to Yes, the u-colors class will be applied to each row. When set to No, a default color will be used instead.'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2249661746132903292)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_name=>'Title Link'
,p_static_id=>'TITLE_LINK'
,p_display_sequence=>25
,p_type=>'LINK'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2364073109121166893)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_name=>'User Name Link'
,p_static_id=>'USER_NAME_LINK'
,p_display_sequence=>15
,p_type=>'LINK'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2483104356095471334)
,p_plugin_id=>wwv_flow_imp.id(454808610226587753)
,p_name=>'Avatar Link'
,p_static_id=>'AVATAR_LINK'
,p_display_sequence=>10
,p_type=>'LINK'
);
end;
/
prompt --application/shared_components/plugins/template_component/theme_42_content_row
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(454834611091587773)
,p_plugin_type=>'TEMPLATE COMPONENT'
,p_theme_id=>nvl(wwv_flow_application_install.get_theme_id, '42')
,p_name=>'THEME_42$CONTENT_ROW'
,p_display_name=>'Content Row'
,p_supported_component_types=>'PARTIAL:REPORT'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('TEMPLATE COMPONENT','THEME_42$CONTENT_ROW'),'')
,p_partial_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if APEX$IS_LAZY_LOADING/}',
'  <div class="t-ContentRow-wrap" aria-hidden="true">',
'    {if ?SELECTION%assigned/}<div class="t-ContentRow-selection is-placeholder"></div>{endif/}',
'    {if DISPLAY_BADGE/}',
'      <div class="t-ContentRow-badge #BADGE_COL_WIDTH!ATTR# #BADGE_POS!ATTR# #BADGE_ALIGNMENT!ATTR#">',
'        {with/}',
'          LABEL:=',
'          VALUE:=',
'          SIZE:=#BADGE_SIZE#',
'          SHAPE:=#BADGE_SHAPE#',
'        {apply THEME$BADGE/}',
'      </div>',
'    {endif/}',
'    {if DISPLAY_AVATAR/}',
'      <div class="t-ContentRow-avatar">',
'        {with/}',
'          SHAPE:=#AVATAR_SHAPE#',
'          SIZE:=#AVATAR_SIZE#',
'        {apply THEME$AVATAR/}',
'      </div>',
'    {endif/}',
'    <div class="t-ContentRow-body">',
'      <div class="t-ContentRow-content">',
'        {if ?OVERLINE%assigned/}<div class="t-ContentRow-overline is-placeholder"></div>{endif/}',
'        {if ?TITLE%assigned/}<div class="t-ContentRow-title is-placeholder"></div>{endif/}',
'        {if ?DESCRIPTION%assigned/}<div class="t-ContentRow-description is-placeholder"></div>{endif/}',
'      </div>',
'      {if ?MISC%assigned/}<div class="t-ContentRow-misc is-placeholder"></div>{endif/}',
'      {if ?PRIMARY_ACTIONS%assigned/}<div class="t-ContentRow-actions is-placeholder"></div>{endif/}',
'    </div>',
'  </div>',
'{else/}',
'  {if ?FULL_ROW_LINK/}<a class="t-ContentRow-fullLink" href="#FULL_ROW_LINK!ATTR#" #FULL_ROW_LINK_ATTR!RAW#></a>{endif/}',
'  <div class="t-ContentRow-wrap">',
'    {if ?SELECTION%assigned/}<div class="t-ContentRow-selection">#SELECTION!RAW#</div>{endif/}',
'    {if DISPLAY_BADGE/}',
'      <div class="t-ContentRow-badge #BADGE_COL_WIDTH!ATTR# #BADGE_POS!ATTR# #BADGE_ALIGNMENT!ATTR#">',
'        {with/}',
'          LABEL_DISPLAY:=#BADGE_LABEL_DISPLAY#',
'          LABEL:=#BADGE_LABEL#',
'          VALUE:=#BADGE_VALUE#',
'          ICON:=#BADGE_ICON#',
'          STATE:=#BADGE_STATE#',
'          SIZE:=#BADGE_SIZE#',
'          STYLE:=#BADGE_STYLE#',
'          SHAPE:=#BADGE_SHAPE#',
'          LINK:=#BADGE_LINK#',
'          LINK_ATTR:=#BADGE_LINK_ATTR!RAW#',
'        {apply THEME$BADGE/}',
'      </div>',
'    {endif/}',
'    {if DISPLAY_AVATAR/}',
'      <div class="t-ContentRow-avatar" aria-hidden="true">',
'        {with/}',
'          TYPE:=#AVATAR_TYPE#',
'          IMAGE:=#AVATAR_IMAGE#',
'          DESCRIPTION:=#AVATAR_DESCRIPTION#',
'          INITIALS:=#AVATAR_INITIALS#',
'          ICON:=#AVATAR_ICON#',
'          SHAPE:=#AVATAR_SHAPE#',
'          SIZE:=#AVATAR_SIZE#',
'          LINK:=#AVATAR_LINK#',
'          LINK_ATTR:=#AVATAR_LINK_ATTR!RAW#',
'        {apply THEME$AVATAR/}',
'      </div>',
'    {endif/}',
'    <div class="t-ContentRow-body">',
'      <div class="t-ContentRow-content">',
'        {if ?OVERLINE/}<div class="t-ContentRow-overline">#OVERLINE!RAW#</div>{endif/}',
'        {if ?TITLE/}<h3 class="t-ContentRow-title">{if ?TITLE_LINK/}<a href="#TITLE_LINK!ATTR#" #TITLE_LINK_ATTR!RAW#>{endif/}#TITLE!RAW#{if ?TITLE_LINK/}</a>{endif/}</h3>{endif/}',
'        {if ?DESCRIPTION/}<div class="t-ContentRow-description">#DESCRIPTION!RAW#</div>{endif/}',
'      </div>',
'      {if ?MISC%assigned/}<div class="t-ContentRow-misc">#MISC!RAW#</div>{endif/}',
'      {if ?PRIMARY_ACTIONS/}<div class="t-ContentRow-actions">#PRIMARY_ACTIONS#</div>{endif/}',
'    </div>',
'  </div>',
'{endif/}',
''))
,p_default_escape_mode=>'HTML'
,p_translate_this_template=>false
,p_api_version=>1
,p_report_body_template=>'<ul class="t-ContentRow{if ?STYLE/} #STYLE!ATTR#{endif/}{if REMOVE_PADDING/} t-ContentRow--removePadding{endif/}{if HIDE_BORDERS/} t-ContentRow--hideBorders{endif/}{if APPLY_THEME_COLORS/} u-colors{endif/} #APEX$COMPONENT_CSS_CLASSES#">#APEX$ROWS#</u'
||'l>'
,p_report_row_template=>'<li class="t-ContentRow-item{if ?ITEM_CLASSES/} #ITEM_CLASSES#{endif/}" #APEX$ROW_IDENTIFICATION#>#APEX$PARTIAL#</li>'
,p_report_placeholder_count=>3
,p_standard_attributes=>'REGION_TEMPLATE'
,p_substitute_attributes=>true
,p_reference_id=>1568468153344837456
,p_subscribe_plugin_settings=>true
,p_is_quick_pick=>true
,p_help_text=>'Display content in a formatted row with a title, description, and more. Supports avatars and badges. Available for a single row or as a report with multiple rows.'
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(2678729818920805407)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_title=>'Avatar'
,p_display_sequence=>10
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(2678729263908805406)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_title=>'Badge'
,p_display_sequence=>20
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(2421837200178531893)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_title=>'Appearance'
,p_display_sequence=>30
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751493364274733715)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'OVERLINE'
,p_prompt=>'Overline'
,p_attribute_type=>'HTML'
,p_is_required=>false
,p_demo_value=>'Category'
,p_escape_mode=>'RAW'
,p_is_translatable=>true
,p_help_text=>'Enter some text and/or column substitution strings to display at the top of each row above the title and description.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751493871319733716)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'TITLE'
,p_prompt=>'Title'
,p_attribute_type=>'HTML'
,p_is_required=>false
,p_demo_value=>'Lorem ipsum dolor sit amet'
,p_escape_mode=>'HTML'
,p_is_translatable=>true
,p_help_text=>'Enter some text and/or column substitution strings to be used as the title in each row.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751494361260733716)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'DESCRIPTION'
,p_prompt=>'Description'
,p_attribute_type=>'HTML'
,p_is_required=>false
,p_demo_value=>'Nunc sit amet nunc quis magna ornare suscipit. Etiam aliquet maximus sapien, at sagittis sem gravida nec.'
,p_escape_mode=>'RAW'
,p_is_translatable=>true
,p_help_text=>'Enter some text and/or column substitution strings to be used as the description in each row.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751494822782733717)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'MISC'
,p_prompt=>'Miscellaneous'
,p_attribute_type=>'HTML'
,p_is_required=>false
,p_escape_mode=>'RAW'
,p_is_translatable=>true
,p_help_text=>'Enter miscellaneous content such as additional text and/or column substitution strings to display in each row.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751495313753733717)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'DISPLAY_AVATAR'
,p_prompt=>'Display Avatar'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to display or hide the avatar for each row. When set to Yes, an avatar will be displayed with the assigned image, icon, or initials. When set to No, no avatar will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751495873258733718)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'DISPLAY_BADGE'
,p_prompt=>'Display Badge'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to display or hide the badge for each row. When set to Yes, a badge will be displayed in each row. When set to No, no badge will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751496310665733719)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'AVATAR_TYPE'
,p_prompt=>'Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'icon'
,p_demo_value=>'icon'
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495313753733717)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2678729818920805407)
,p_help_text=>'Select the type of content that will be displayed in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751496873236733719)
,p_plugin_attribute_id=>wwv_flow_imp.id(751496310665733719)
,p_display_sequence=>10
,p_display_value=>'Image'
,p_return_value=>'image'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751497399938733720)
,p_plugin_attribute_id=>wwv_flow_imp.id(751496310665733719)
,p_display_sequence=>20
,p_display_value=>'Initials'
,p_return_value=>'initials'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751498060264733721)
,p_plugin_attribute_id=>wwv_flow_imp.id(751496310665733719)
,p_display_sequence=>30
,p_display_value=>'Icon'
,p_return_value=>'icon'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751498655451733721)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'AVATAR_IMAGE'
,p_prompt=>'Image'
,p_attribute_type=>'MEDIA'
,p_is_required=>true
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751496310665733719)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'image'
,p_attribute_group_id=>wwv_flow_imp.id(2678729818920805407)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Use the Media popup dialog to select a source for the avatar image.</p>',
'',
'<p>Available options include:',
'<ul>',
'<li>URL</li>',
'<li>BLOB Column</li>',
'<li>URL Column</li>',
'</ul>',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751499143477733722)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>115
,p_static_id=>'AVATAR_DESCRIPTION'
,p_prompt=>'Description'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>true
,p_attribute_group_id=>wwv_flow_imp.id(2678729818920805407)
,p_help_text=>'Enter a short description of the image or select a source column from the quick pick options. This will be used as alt text for the avatar image.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751499676653733723)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_static_id=>'AVATAR_INITIALS'
,p_prompt=>'Initials'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_escape_mode=>'STRIPHTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751496310665733719)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'initials'
,p_attribute_group_id=>wwv_flow_imp.id(2678729818920805407)
,p_help_text=>'Select the source column to be displayed within each avatar. Only varchar2 data types are supported.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751500127505733723)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_static_id=>'AVATAR_ICON'
,p_prompt=>'Icon'
,p_attribute_type=>'ICON'
,p_is_required=>true
,p_default_value=>'fa-user'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751496310665733719)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'icon'
,p_attribute_group_id=>wwv_flow_imp.id(2678729818920805407)
,p_help_text=>'Enter an icon class or use the Pick Icon dialog to select the icon you want to add to display in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751500688019733723)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_static_id=>'AVATAR_SHAPE'
,p_prompt=>'Shape'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'t-Avatar--rounded'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495313753733717)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2678729818920805407)
,p_help_text=>'Select the shape of the avatar. Default inherits the shape set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751501140308733724)
,p_plugin_attribute_id=>wwv_flow_imp.id(751500688019733723)
,p_display_sequence=>10
,p_display_value=>'Rounded'
,p_return_value=>'t-Avatar--rounded'
,p_help_text=>'Displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751501739521733724)
,p_plugin_attribute_id=>wwv_flow_imp.id(751500688019733723)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'t-Avatar--circle'
,p_help_text=>'Displayed within a circular shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751502325052733725)
,p_plugin_attribute_id=>wwv_flow_imp.id(751500688019733723)
,p_display_sequence=>30
,p_display_value=>'Square'
,p_return_value=>'t-Avatar--square'
,p_help_text=>'Displayed within a square shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751502995804733726)
,p_plugin_attribute_id=>wwv_flow_imp.id(751500688019733723)
,p_display_sequence=>40
,p_display_value=>'No Shape'
,p_return_value=>'t-Avatar--noShape'
,p_help_text=>'Displayed inline without a containing shape.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751503516504733726)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_static_id=>'BADGE_LABEL'
,p_prompt=>'Label'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_escape_mode=>'HTML'
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_help_text=>'Enter a value for the badge label or select a source column from the quick pick options.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751504005407733727)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_static_id=>'BADGE_VALUE'
,p_prompt=>'Value'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_escape_mode=>'ATTR'
,p_column_data_types=>'VARCHAR2:NUMBER:DATE:INTERVAL_Y2M:INTERVAL_D2S'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_help_text=>'Select a source column for the badge value.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751504549575733727)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>150
,p_static_id=>'BADGE_STATE'
,p_prompt=>'State'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_help_text=>'Select the source column for the state of the badge. Substitute column value with "danger", "warning", "success" or "info" for default styling.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751505053507733728)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>160
,p_static_id=>'BADGE_ICON'
,p_prompt=>'Icon'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_help_text=>'Enter an icon class or use the Pick Icon dialog to select the icon you want to add to display in the badge.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751505572398733728)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>170
,p_static_id=>'BADGE_LABEL_DISPLAY'
,p_prompt=>'Display Label'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_help_text=>'Specify whether to display or hide the badge label. When set to Yes, the badge label will be displayed in addition to the badge value. When set to No, only the badge value will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751506053813733729)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>18
,p_display_sequence=>180
,p_static_id=>'BADGE_STYLE'
,p_prompt=>'Style'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_null_text=>'Default'
,p_help_text=>'Select the badge style. Default inherits the style set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751506573418733729)
,p_plugin_attribute_id=>wwv_flow_imp.id(751506053813733729)
,p_display_sequence=>10
,p_display_value=>'Subtle'
,p_return_value=>'t-Badge--subtle'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751507181834733730)
,p_plugin_attribute_id=>wwv_flow_imp.id(751506053813733729)
,p_display_sequence=>20
,p_display_value=>'Outline'
,p_return_value=>'t-Badge--outline'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751507713531733730)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>19
,p_display_sequence=>190
,p_static_id=>'BADGE_SHAPE'
,p_prompt=>'Shape'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_null_text=>'Default'
,p_help_text=>'Select the shape of the badge. Default inherits the shape set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751508215373733731)
,p_plugin_attribute_id=>wwv_flow_imp.id(751507713531733730)
,p_display_sequence=>10
,p_display_value=>'Rounded'
,p_return_value=>'t-Badge--rounded'
,p_help_text=>'Displayed with rounded corners.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751508800965733732)
,p_plugin_attribute_id=>wwv_flow_imp.id(751507713531733730)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'t-Badge--circle'
,p_help_text=>'Displayed with circular edges.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751509462191733732)
,p_plugin_attribute_id=>wwv_flow_imp.id(751507713531733730)
,p_display_sequence=>30
,p_display_value=>'Square'
,p_return_value=>'t-Badge--square'
,p_help_text=>'Displayed with squared edges.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751510014145733733)
,p_plugin_attribute_id=>wwv_flow_imp.id(751507713531733730)
,p_display_sequence=>40
,p_display_value=>'No Shape'
,p_return_value=>'t-Avatar--noShape'
,p_help_text=>'Displayed inline without a containing shape.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751510699063733734)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>20
,p_display_sequence=>200
,p_static_id=>'AVATAR_SIZE'
,p_prompt=>'Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495313753733717)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2678729818920805407)
,p_null_text=>'Default'
,p_help_text=>'Set the size of the avatar. The default inherits the sizing set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751511160063733734)
,p_plugin_attribute_id=>wwv_flow_imp.id(751510699063733734)
,p_display_sequence=>10
,p_display_value=>'Extra Extra Small'
,p_return_value=>'t-Avatar--xxs'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751511788973733735)
,p_plugin_attribute_id=>wwv_flow_imp.id(751510699063733734)
,p_display_sequence=>20
,p_display_value=>'Extra Small'
,p_return_value=>'t-Avatar--xs'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751512359906733735)
,p_plugin_attribute_id=>wwv_flow_imp.id(751510699063733734)
,p_display_sequence=>30
,p_display_value=>'Small'
,p_return_value=>'t-Avatar--sm'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751512954333733736)
,p_plugin_attribute_id=>wwv_flow_imp.id(751510699063733734)
,p_display_sequence=>40
,p_display_value=>'Medium'
,p_return_value=>'t-Avatar--md'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751513530827733737)
,p_plugin_attribute_id=>wwv_flow_imp.id(751510699063733734)
,p_display_sequence=>50
,p_display_value=>'Large'
,p_return_value=>'t-Avatar--lg'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751514121633733737)
,p_plugin_attribute_id=>wwv_flow_imp.id(751510699063733734)
,p_display_sequence=>60
,p_display_value=>'Extra Large'
,p_return_value=>'t-Avatar--xl'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751514711329733738)
,p_plugin_attribute_id=>wwv_flow_imp.id(751510699063733734)
,p_display_sequence=>70
,p_display_value=>'Extra Extra Large'
,p_return_value=>'t-Avatar--xxl'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751515366332733738)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>21
,p_display_sequence=>210
,p_static_id=>'BADGE_SIZE'
,p_prompt=>'Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_null_text=>'Default'
,p_help_text=>'Set the size of the badge. The default inherits the sizing set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751515884594733739)
,p_plugin_attribute_id=>wwv_flow_imp.id(751515366332733738)
,p_display_sequence=>10
,p_display_value=>'Small'
,p_return_value=>'t-Badge--sm'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751516493765733739)
,p_plugin_attribute_id=>wwv_flow_imp.id(751515366332733738)
,p_display_sequence=>20
,p_display_value=>'Medium'
,p_return_value=>'t-Badge--md'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751517060998733740)
,p_plugin_attribute_id=>wwv_flow_imp.id(751515366332733738)
,p_display_sequence=>30
,p_display_value=>'Large'
,p_return_value=>'t-Badge--lg'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751517674319733740)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>22
,p_display_sequence=>220
,p_static_id=>'BADGE_COL_WIDTH'
,p_prompt=>'Column Width'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'t-ContentRow-badge--md'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_null_text=>'Default'
,p_help_text=>'Set the width of the content row columns. Default width is medium.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751518112917733741)
,p_plugin_attribute_id=>wwv_flow_imp.id(751517674319733740)
,p_display_sequence=>10
,p_display_value=>'Small'
,p_return_value=>'t-ContentRow-badge--sm'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751518699793733741)
,p_plugin_attribute_id=>wwv_flow_imp.id(751517674319733740)
,p_display_sequence=>20
,p_display_value=>'Medium'
,p_return_value=>'t-ContentRow-badge--md'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751519362145733742)
,p_plugin_attribute_id=>wwv_flow_imp.id(751517674319733740)
,p_display_sequence=>30
,p_display_value=>'Large'
,p_return_value=>'t-ContentRow-badge--lg'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751519980303733742)
,p_plugin_attribute_id=>wwv_flow_imp.id(751517674319733740)
,p_display_sequence=>40
,p_display_value=>'Auto'
,p_return_value=>'t-ContentRow-badge--auto'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751520565533733743)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>24
,p_display_sequence=>240
,p_static_id=>'BADGE_POS'
,p_prompt=>'Position'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_null_text=>'Start'
,p_help_text=>'Positions the Badge column to either the "Start" or "End" of the row.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751521057086733743)
,p_plugin_attribute_id=>wwv_flow_imp.id(751520565533733743)
,p_display_sequence=>10
,p_display_value=>'End'
,p_return_value=>'t-ContentRow-badge--posEnd'
,p_help_text=>'Positions the Badge column to the "end" of the row.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751521637750733744)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>25
,p_display_sequence=>250
,p_static_id=>'BADGE_ALIGNMENT'
,p_prompt=>'Alignment'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751495873258733718)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2678729263908805406)
,p_null_text=>'Start'
,p_help_text=>'Changes the alignment of the badge within its column.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751522758125733746)
,p_plugin_attribute_id=>wwv_flow_imp.id(751521637750733744)
,p_display_sequence=>10
,p_display_value=>'Center'
,p_return_value=>'t-ContentRow-badge--alignCenter'
,p_help_text=>'Aligns the badge to the "center" of its column.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751522132581733745)
,p_plugin_attribute_id=>wwv_flow_imp.id(751521637750733744)
,p_display_sequence=>20
,p_display_value=>'End'
,p_return_value=>'t-ContentRow-badge--alignEnd'
,p_help_text=>'Aligns the badge to the "end" of its column.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751523353959733747)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>23
,p_display_sequence=>230
,p_static_id=>'APPLY_THEME_COLORS'
,p_prompt=>'Apply Theme Colors'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(2421837200178531893)
,p_help_text=>'Specify whether to use the Universal Theme colors for avatar and badge row items. When set to Yes, the u-colors class will be applied to each row. When set to No, a default color will be used instead.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751523824587733748)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>27
,p_display_sequence=>270
,p_static_id=>'STYLE'
,p_prompt=>'Style'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2421837200178531893)
,p_null_text=>'Default'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751524391356733748)
,p_plugin_attribute_id=>wwv_flow_imp.id(751523824587733748)
,p_display_sequence=>10
,p_display_value=>'Compact'
,p_return_value=>'t-ContentRow--styleCompact'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751525280032733749)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>28
,p_display_sequence=>280
,p_static_id=>'HIDE_BORDERS'
,p_prompt=>'Hide Borders'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(2421837200178531893)
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751525748861733750)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>30
,p_display_sequence=>300
,p_static_id=>'REMOVE_PADDING'
,p_prompt=>'Remove Padding'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_attribute_group_id=>wwv_flow_imp.id(2421837200178531893)
);
wwv_flow_imp_shared.create_plugin_act_template(
 p_id=>wwv_flow_imp.id(2263286588971481082)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_name=>'Button'
,p_type=>'BUTTON'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{with/}',
'LINK_URL:=#LINK_URL!RAW#',
'LINK_ATTR:=#LINK_ATTR!RAW#',
'LABEL:=#LABEL!RAW#',
'ICON_CLASSES:=#ICON_CLASSES#',
'CSS_CLASSES:=#CSS_CLASSES#',
'IS_HOT:=#IS_HOT#',
'IS_ICON_ONLY:=#IS_ICON_ONLY#',
'IS_DISABLED:=#IS_DISABLED#',
'{apply THEME$BUTTON/}'))
);
wwv_flow_imp_shared.create_plugin_act_template(
 p_id=>wwv_flow_imp.id(2263287848491485230)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_name=>'Menu'
,p_type=>'MENU'
,p_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{with/}',
'MENU_ID:=#MENU_ID#',
'LABEL:=#LABEL!RAW#',
'ICON_CLASSES:=#ICON_CLASSES#',
'CSS_CLASSES:=#CSS_CLASSES#',
'IS_HOT:=#IS_HOT#',
'IS_DISABLED:=#IS_DISABLED#',
'IS_ICON_ONLY:=#IS_ICON_ONLY#',
'{apply THEME$BUTTON/}',
'#MENU#'))
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2249692960297074349)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_name=>'Title Link'
,p_static_id=>'TITLE_LINK'
,p_display_sequence=>30
,p_type=>'LINK'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2250372261027157453)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_name=>'Full Row Link'
,p_static_id=>'FULL_ROW_LINK'
,p_display_sequence=>40
,p_type=>'LINK'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2262992194240868591)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_name=>'Badge Link'
,p_static_id=>'BADGE_LINK'
,p_display_sequence=>50
,p_type=>'LINK'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2263284653904436096)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_name=>'Avatar Link'
,p_static_id=>'AVATAR_LINK'
,p_display_sequence=>10
,p_type=>'LINK'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2263285987294449953)
,p_plugin_id=>wwv_flow_imp.id(454834611091587773)
,p_name=>'Primary Actions'
,p_static_id=>'PRIMARY_ACTIONS'
,p_display_sequence=>20
,p_type=>'TEMPLATE'
);
end;
/
prompt --application/shared_components/plugins/template_component/theme_42_media_list
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(454871926507587800)
,p_plugin_type=>'TEMPLATE COMPONENT'
,p_theme_id=>nvl(wwv_flow_application_install.get_theme_id, '42')
,p_name=>'THEME_42$MEDIA_LIST'
,p_display_name=>'Media List'
,p_supported_component_types=>'PARTIAL:REPORT'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('TEMPLATE COMPONENT','THEME_42$MEDIA_LIST'),'')
,p_partial_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{if APEX$IS_LAZY_LOADING/}',
'  <div class="t-MediaList-itemWrap">',
'    {if DISPLAY_AVATAR/}',
'      <div class="t-MediaList-iconWrap" aria-hidden="true">',
'        {with/}',
'          SIZE:=t-Avatar--xs',
'          SHAPE:=#AVATAR_SHAPE#',
'        {apply THEME$AVATAR/}',
'      </div>',
'    {endif/}',
'    <div class="t-MediaList-body">',
'      {if ?TITLE%assigned/}<div class="t-MediaList-title is-placeholder"></div>{endif/}',
'      {if ?DESCRIPTION%assigned/}<div class="t-MediaList-desc is-placeholder"></div>{endif/}',
'    </div>',
'    {if DISPLAY_BADGE%assigned/}',
'      {with/}',
'        LABEL:=',
'        VALUE:=',
'        SHAPE:=#BADGE_SHAPE#',
'        STYLE:=#BADGE_STYLE#',
'      {apply THEME$BADGE/}',
'    {endif/}',
'  </div>',
'{else/}',
'  {if LINK/}<a href="#LINK!ATTR#" #LINK_ATTR!RAW#{else/}<div{endif/} class="t-MediaList-itemWrap{if ?DESCRIPTION/} t-MediaList-itemWrap--showDesc{endif/}">',
'    {if DISPLAY_AVATAR/}',
'      <div class="t-MediaList-iconWrap" aria-hidden="true">',
'        {with/}',
'          TYPE:=#AVATAR_TYPE#',
'          IMAGE:=#AVATAR_IMAGE#',
'          DESCRIPTION:=#AVATAR_DESCRIPTION#',
'          ICON:=#AVATAR_ICON#',
'          INITIALS:=#AVATAR_INITIALS#',
'          CSS_CLASSES:=u-color',
'          SHAPE:=#AVATAR_SHAPE#',
'        {apply THEME$AVATAR/}',
'      </div>',
'    {endif/}',
'    <div class="t-MediaList-body">',
'      {if ?TITLE/}<h3 class="t-MediaList-title">#TITLE!RAW#</h3>{endif/}',
'      {if ?DESCRIPTION/}<p class="t-MediaList-desc">#DESCRIPTION!RAW#</p>{endif/}',
'    </div>',
'    {if DISPLAY_BADGE/}',
'      {with/}',
'        LABEL_DISPLAY:=#BADGE_LABEL_DISPLAY#',
'        LABEL:=#BADGE_LABEL#',
'        VALUE:=#BADGE_VALUE#',
'        ICON:=#BADGE_ICON#',
'        STATE:=#BADGE_STATE#',
'        SIZE:=t-Badge--md',
'        STYLE:=#BADGE_STYLE#',
'        SHAPE:=#BADGE_SHAPE#',
'      {apply THEME$BADGE/}',
'    {endif/}',
'  {if LINK/}</a>{else/}</div>{endif/}',
'{endif/}'))
,p_default_escape_mode=>'HTML'
,p_translate_this_template=>false
,p_api_version=>1
,p_report_body_template=>'<ul class="t-MediaList t-MediaList--showIcons{if ?LAYOUT/} #LAYOUT!ATTR#{endif/}{if ?SIZE/} #SIZE!ATTR#{endif/}{if APPLY_THEME_COLORS/} u-colors{endif/} #APEX$COMPONENT_CSS_CLASSES#">#APEX$ROWS#</ul>'
,p_report_row_template=>'<li class="t-MediaList-item" #APEX$ROW_IDENTIFICATION#>#APEX$PARTIAL#</li>'
,p_report_placeholder_count=>3
,p_standard_attributes=>'REGION_TEMPLATE'
,p_substitute_attributes=>true
,p_reference_id=>1564403634518414297
,p_subscribe_plugin_settings=>true
,p_is_quick_pick=>true
,p_help_text=>'Display report content in a formatted media list. Supports avatars and badges. Available for a single row or as a report with multiple rows.'
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(2551554364986617418)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_title=>'Avatar'
,p_display_sequence=>10
);
wwv_flow_imp_shared.create_plugin_attr_group(
 p_id=>wwv_flow_imp.id(2551553809974617417)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_title=>'Badge'
,p_display_sequence=>20
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751537005234733771)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'TITLE'
,p_prompt=>'Title'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_demo_value=>'Lorem ipsum dolor sit amet'
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select a source column to be used as the title.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751537570983733772)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'DESCRIPTION'
,p_prompt=>'Description'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>false
,p_demo_value=>'Nunc sit amet nunc quis magna ornare suscipit. Etiam aliquet maximus sapien, at sagittis sem gravida nec.'
,p_escape_mode=>'HTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_help_text=>'Select a source column to be used for the row description.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751538094530733772)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_static_id=>'DISPLAY_AVATAR'
,p_prompt=>'Display Avatar'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to display or hide the avatar for each row. When set to Yes, an avatar will be displayed with the assigned image, icon, or initials. When set to No, no avatar will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751538542550733773)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_static_id=>'DISPLAY_BADGE'
,p_prompt=>'Display Badge'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to display or hide the badge for each row. When set to Yes, a badge will be displayed in each row. When set to No, no badge will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751539056564733773)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'AVATAR_TYPE'
,p_prompt=>'Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'icon'
,p_demo_value=>'icon'
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751538094530733772)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2551554364986617418)
,p_help_text=>'Select the type of content that will be displayed in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751539586087733774)
,p_plugin_attribute_id=>wwv_flow_imp.id(751539056564733773)
,p_display_sequence=>10
,p_display_value=>'Image'
,p_return_value=>'image'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751540193884733774)
,p_plugin_attribute_id=>wwv_flow_imp.id(751539056564733773)
,p_display_sequence=>20
,p_display_value=>'Initials'
,p_return_value=>'initials'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751540745349733775)
,p_plugin_attribute_id=>wwv_flow_imp.id(751539056564733773)
,p_display_sequence=>30
,p_display_value=>'Icon'
,p_return_value=>'icon'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751541373181733775)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'AVATAR_IMAGE'
,p_prompt=>'Image'
,p_attribute_type=>'MEDIA'
,p_is_required=>true
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751539056564733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'image'
,p_attribute_group_id=>wwv_flow_imp.id(2551554364986617418)
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Use the Media popup dialog to select a source for the avatar image.</p>',
'',
'<p>Available options include:',
'<ul>',
'<li>URL</li>',
'<li>BLOB Column</li>',
'<li>URL Column</li>',
'</ul>',
'</p>'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751541852268733776)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>95
,p_static_id=>'AVATAR_DESCRIPTION'
,p_prompt=>'Description'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>true
,p_attribute_group_id=>wwv_flow_imp.id(2551554364986617418)
,p_help_text=>'Enter a short description of the image/icon or select a source column from the quick pick options. This will be used as title & alt text for the avatar image/icon.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751542328916733776)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'AVATAR_INITIALS'
,p_prompt=>'Initials'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_escape_mode=>'STRIPHTML'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751539056564733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'initials'
,p_attribute_group_id=>wwv_flow_imp.id(2551554364986617418)
,p_help_text=>'Select the source column to be displayed within each avatar. Only varchar2 data types are supported.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751542880372733777)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_static_id=>'AVATAR_ICON'
,p_prompt=>'Icon'
,p_attribute_type=>'ICON'
,p_is_required=>true
,p_default_value=>'fa-user'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751539056564733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'icon'
,p_attribute_group_id=>wwv_flow_imp.id(2551554364986617418)
,p_help_text=>'Enter an icon class or use the Pick Icon dialog to select the icon you want to add to display in the avatar.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751543305501733777)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_static_id=>'AVATAR_SHAPE'
,p_prompt=>'Shape'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'t-Avatar--rounded'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751538094530733772)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2551554364986617418)
,p_help_text=>'Select the shape of the avatar. Default inherits the shape set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751543880095733778)
,p_plugin_attribute_id=>wwv_flow_imp.id(751543305501733777)
,p_display_sequence=>10
,p_display_value=>'Rounded'
,p_return_value=>'t-Avatar--rounded'
,p_help_text=>'Displayed within a square with rounded corners.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751544425960733778)
,p_plugin_attribute_id=>wwv_flow_imp.id(751543305501733777)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'t-Avatar--circle'
,p_help_text=>'Displayed within a circular shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751545026149733779)
,p_plugin_attribute_id=>wwv_flow_imp.id(751543305501733777)
,p_display_sequence=>30
,p_display_value=>'Square'
,p_return_value=>'t-Avatar--square'
,p_help_text=>'Displayed within a square shape.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751545661819733779)
,p_plugin_attribute_id=>wwv_flow_imp.id(751543305501733777)
,p_display_sequence=>40
,p_display_value=>'No Shape'
,p_return_value=>'t-Avatar--noShape'
,p_help_text=>'Displayed inline without a containing shape.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751546227301733780)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_static_id=>'BADGE_LABEL'
,p_prompt=>'Label'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_escape_mode=>'HTML'
,p_is_translatable=>true
,p_depending_on_attribute_id=>wwv_flow_imp.id(751538542550733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2551553809974617417)
,p_help_text=>'Enter a value for the badge label or select a source column from the quick pick options.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751546779509733781)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_static_id=>'BADGE_VALUE'
,p_prompt=>'Value'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>true
,p_escape_mode=>'ATTR'
,p_column_data_types=>'VARCHAR2:NUMBER:DATE:INTERVAL_Y2M:INTERVAL_D2S'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751538542550733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2551553809974617417)
,p_help_text=>'Select a source column for the badge value.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751547202232733781)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_static_id=>'BADGE_STATE'
,p_prompt=>'State'
,p_attribute_type=>'SESSION STATE VALUE'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_column_data_types=>'VARCHAR2'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751538542550733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2551553809974617417)
,p_help_text=>'Select the source column for the state of the badge. Substitute column value with "danger", "warning", "success" or "info" for default styling.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751547711407733783)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_static_id=>'BADGE_ICON'
,p_prompt=>'Icon'
,p_attribute_type=>'ICON'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751538542550733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2551553809974617417)
,p_help_text=>'Enter an icon class or use the Pick Icon dialog to select the icon you want to add to display in the badge.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751548257018733784)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>15
,p_display_sequence=>150
,p_static_id=>'BADGE_LABEL_DISPLAY'
,p_prompt=>'Display Label'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751538542550733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_attribute_group_id=>wwv_flow_imp.id(2551553809974617417)
,p_help_text=>'Specify whether to display or hide the badge label. When set to Yes, the badge label will be displayed in addition to the badge value. When set to No, only the badge value will be displayed.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751548762086733785)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>16
,p_display_sequence=>160
,p_static_id=>'BADGE_STYLE'
,p_prompt=>'Style'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751538542550733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2551553809974617417)
,p_null_text=>'Default'
,p_help_text=>'Select the badge style. Default inherits the style set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751549254154733785)
,p_plugin_attribute_id=>wwv_flow_imp.id(751548762086733785)
,p_display_sequence=>10
,p_display_value=>'Subtle'
,p_return_value=>'t-Badge--subtle'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751549801195733786)
,p_plugin_attribute_id=>wwv_flow_imp.id(751548762086733785)
,p_display_sequence=>20
,p_display_value=>'Outline'
,p_return_value=>'t-Badge--outline'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751550499033733786)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>17
,p_display_sequence=>170
,p_static_id=>'BADGE_SHAPE'
,p_prompt=>'Shape'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(751538542550733773)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
,p_attribute_group_id=>wwv_flow_imp.id(2551553809974617417)
,p_null_text=>'Default'
,p_help_text=>'Select the shape of the badge. Default inherits the shape set by the containing template.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751550946719733787)
,p_plugin_attribute_id=>wwv_flow_imp.id(751550499033733786)
,p_display_sequence=>10
,p_display_value=>'Rounded'
,p_return_value=>'t-Badge--rounded'
,p_help_text=>'Displayed with rounded corners.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751551516052733787)
,p_plugin_attribute_id=>wwv_flow_imp.id(751550499033733786)
,p_display_sequence=>20
,p_display_value=>'Circular'
,p_return_value=>'t-Badge--circle'
,p_help_text=>'Displayed with circular edges.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751552138782733788)
,p_plugin_attribute_id=>wwv_flow_imp.id(751550499033733786)
,p_display_sequence=>30
,p_display_value=>'Square'
,p_return_value=>'t-Badge--square'
,p_help_text=>'Displayed with squared edges.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751552742316733788)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>18
,p_display_sequence=>180
,p_static_id=>'LAYOUT'
,p_prompt=>'Layout'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Select the number of grid columns the media list content will display in. Horizontal Span will display all columns in a single horizontal row.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751553285685733789)
,p_plugin_attribute_id=>wwv_flow_imp.id(751552742316733788)
,p_display_sequence=>10
,p_display_value=>'2 Column Grid'
,p_return_value=>'t-MediaList--cols t-MediaList--2cols'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751553870978733789)
,p_plugin_attribute_id=>wwv_flow_imp.id(751552742316733788)
,p_display_sequence=>20
,p_display_value=>'3 Column Grid'
,p_return_value=>'t-MediaList--cols t-MediaList--3cols'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751554434693733790)
,p_plugin_attribute_id=>wwv_flow_imp.id(751552742316733788)
,p_display_sequence=>30
,p_display_value=>'4 Column Grid'
,p_return_value=>'t-MediaList--cols t-MediaList--4cols'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751555054566733790)
,p_plugin_attribute_id=>wwv_flow_imp.id(751552742316733788)
,p_display_sequence=>40
,p_display_value=>'5 Column Grid'
,p_return_value=>'t-MediaList--cols t-MediaList--5cols'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751555643839733791)
,p_plugin_attribute_id=>wwv_flow_imp.id(751552742316733788)
,p_display_sequence=>50
,p_display_value=>'Horizontal Span'
,p_return_value=>'t-MediaList--horizontal'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751556209947733792)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>19
,p_display_sequence=>190
,p_static_id=>'SIZE'
,p_prompt=>'Size'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_escape_mode=>'HTML'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
,p_null_text=>'Default'
,p_help_text=>'Set the size of media list items.'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(751556707261733792)
,p_plugin_attribute_id=>wwv_flow_imp.id(751556209947733792)
,p_display_sequence=>10
,p_display_value=>'Large'
,p_return_value=>'t-MediaList--large force-fa-lg'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(751557358276733793)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_attribute_scope=>'REPORT'
,p_attribute_sequence=>20
,p_display_sequence=>200
,p_static_id=>'APPLY_THEME_COLORS'
,p_prompt=>'Apply Theme Colors'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_escape_mode=>'ATTR'
,p_is_translatable=>false
,p_help_text=>'Specify whether to use the Universal Theme colors for avatar and badge row items. When set to Yes, the u-colors class will be applied to each row. When set to No, a default color will be used instead.'
);
wwv_flow_imp_shared.create_plugin_act_position(
 p_id=>wwv_flow_imp.id(2255093571831618077)
,p_plugin_id=>wwv_flow_imp.id(454871926507587800)
,p_name=>'Link'
,p_static_id=>'LINK'
,p_display_sequence=>10
,p_type=>'LINK'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_display_source
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(1362647091099198596)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.DISPLAY_SOURCE'
,p_display_name=>'Source Display'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.DISPLAY_SOURCE'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render (',
'        p_region              in apex_plugin.t_region,',
'        p_plugin              in apex_plugin.t_plugin,',
'        p_is_printer_friendly in boolean )',
'    return apex_plugin.t_region_render_result',
'is',
'    -- It''s better to have named variables instead of using the generic ones,',
'    -- makes the code more readable. We are using the same defaults for the',
'    -- required attributes as in the plug-in attribute configuration, because',
'    -- they can still be null. Keep them in sync!',
'    c_region_static_id    constant varchar2(255) := p_region.attribute_01;',
'    c_highlight_page_item constant varchar2(255) := p_region.attribute_02;',
'',
'    l_highlight_term varchar2(4000) := '''';',
'',
'    cursor sql_csr( d_region_static_id in varchar2 ) is',
'        select source_type, 10 seq, null series_name, region_source source',
'        from apex_application_page_regions',
'        where application_id = :APP_ID',
'            and page_id = :APP_PAGE_ID',
'            and static_id = d_region_static_id',
'            and ( source_type_code like ''PLUGIN%''',
'                or source_type_code like ''STATIC_TEXT%''',
'                or source_type in (',
'                    ''Calendar'',',
'                    ''Easy Calendar'',',
'                    ''Interactive Report'',',
'                    ''Interactive Grid'',',
'                    ''List View'',',
'                    ''Report'',',
'                    ''PL/SQL'',',
'                    ''Tabular Form''',
'                )',
'            )',
'        union all',
'        select reg.source_type, 10 seq, null series_name, to_clob(tr.tree_query) source',
'        from apex_application_page_regions reg,',
'            apex_application_page_trees tr',
'        where reg.application_id = :APP_ID',
'            and reg.page_id = :APP_PAGE_ID',
'            and reg.static_id = d_region_static_id',
'            and tr.application_id = reg.application_id',
'            and tr.page_id = reg.page_id',
'            and tr.region_id = reg.region_id',
'            and reg.source_type in (''JavaScript Tree'')',
'        union all',
'        select reg.source_type, 10 seq, null series_name, to_clob(list_query) source',
'        from apex_application_page_regions reg,',
'            apex_application_lists li',
'        where reg.application_id = :APP_ID',
'            and reg.page_id = :APP_PAGE_ID',
'            and reg.static_id = d_region_static_id',
'            and li.application_id = reg.application_id',
'            and li.list_id = reg.list_id',
'            and reg.source_type in ( ''List'' )',
'        order by 1, 2;',
'    sql_rec sql_csr%ROWTYPE;',
'begin',
'    if c_highlight_page_item is not null then',
'        l_highlight_term := apex_escape.html(trim(lower(v(c_highlight_page_item))));',
'    end if;',
'',
'    for sql_rec in sql_csr( c_region_static_id ) loop',
'        if sql_rec.series_name is not null then',
'            sys.htp.p(''<p><strong>''||apex_escape.html(sql_rec.series_name)||'':</strong></p>'');',
'        end if;',
'        sys.htp.p(''<pre>'');',
'        if l_highlight_term is not null then',
'            sys.htp.p(replace(apex_escape.html(sql_rec.source),',
'                l_highlight_term,''<span class="highlight">''||l_highlight_term||''</span>''));',
'        else',
'            sys.htp.p(apex_escape.html(sql_rec.source));',
'        end if;',
'        sys.htp.p(''</pre>'');',
'    end loop;',
'',
'    return null;',
'end render;'))
,p_api_version=>1
,p_render_function=>'render'
,p_substitute_attributes=>true
,p_reference_id=>1305119942933551255
,p_subscribe_plugin_settings=>true
,p_help_text=>'This region plug-in is used to display the SQL Source region of an accompanying region.'
,p_version_identifier=>'5.0.1'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(649481782877589600)
,p_plugin_id=>wwv_flow_imp.id(1362647091099198596)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'attribute_01'
,p_prompt=>'Region Static ID'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>'Enter the static ID as defined in the target region''s attributes section.'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(649482171855589600)
,p_plugin_id=>wwv_flow_imp.id(1362647091099198596)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'attribute_02'
,p_prompt=>'Highlight Term Page Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'If you wish to have a term in your region source highlighted, create a page item and select it here.'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_sampleappfooter
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(1701899719476527633)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.SAMPLEAPPFOOTER'
,p_display_name=>'Sample Apps Footer'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('REGION TYPE','COM.ORACLE.APEX.SAMPLEAPPFOOTER'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function render (   p_region in apex_plugin.t_region,',
'                    p_plugin in apex_plugin.t_plugin,',
'                    p_is_printer_friendly in boolean )',
'        return apex_plugin.t_region_render_result is',
'begin',
'    sys.htp.p(''<ul class="t-Cards t-Cards--sampleAppsFooter t-Cards--featured force-fa-lg t-Cards--displayIcons t-Cards--hideBody t-Cards--animColorFill">'');',
'    sys.htp.p(''<li class="t-Cards-item">'');',
'    sys.htp.p(''  <div class="t-Card">'');',
'    sys.htp.p(''    <a href="https://apex.oracle.com/twitter" target="_blank" class="t-Card-wrap">'');',
'    sys.htp.p(''      <div class="t-Card-icon"><span class="t-Icon fa fa-twitter" style="color: #1da1f2"></span></div>'');',
'    sys.htp.p(''      <div class="t-Card-titleWrap"><h3 class="t-Card-title">Twitter</h3></div>'');',
'    sys.htp.p(''    </a>'');',
'    sys.htp.p(''  </div>'');',
'    sys.htp.p(''</li>'');',
'    sys.htp.p(''<li class="t-Cards-item">'');',
'    sys.htp.p(''  <div class="t-Card">'');',
'    sys.htp.p(''    <a href="https://apex.oracle.com/linkedin" target="_blank" class="t-Card-wrap">'');',
'    sys.htp.p(''      <div class="t-Card-icon"><span class="t-Icon fa fa-linkedin" style="color: #0077b5"></span></div>'');',
'    sys.htp.p(''      <div class="t-Card-titleWrap"><h3 class="t-Card-title">LinkedIn</h3></div>'');',
'    sys.htp.p(''    </a>'');',
'    sys.htp.p(''  </div>'');',
'    sys.htp.p(''</li>'');',
'    sys.htp.p(''<li class="t-Cards-item">'');',
'    sys.htp.p(''  <div class="t-Card">'');',
'    sys.htp.p(''    <a href="https://apex.oracle.com/facebook" target="_blank" class="t-Card-wrap">'');',
'    sys.htp.p(''      <div class="t-Card-icon"><span class="t-Icon fa fa-facebook" style="color: #3b5998"></span></div>'');',
'    sys.htp.p(''      <div class="t-Card-titleWrap"><h3 class="t-Card-title">Facebook</h3></div>'');',
'    sys.htp.p(''    </a>'');',
'    sys.htp.p(''  </div>'');',
'    sys.htp.p(''</li>'');',
'    sys.htp.p(''<li class="t-Cards-item">'');',
'    sys.htp.p(''  <div class="t-Card">'');',
'    sys.htp.p(''    <a href="https://apex.oracle.com/youtube" target="_blank" class="t-Card-wrap">'');',
'    sys.htp.p(''      <div class="t-Card-icon"><span class="t-Icon fa fa-youtube" style="color: red"></span></div>'');',
'    sys.htp.p(''      <div class="t-Card-titleWrap"><h3 class="t-Card-title">YouTube</h3></div>'');',
'    sys.htp.p(''    </a>'');',
'    sys.htp.p(''  </div>'');',
'    sys.htp.p(''</li>'');',
'    sys.htp.p(''<li class="t-Cards-item">'');',
'    sys.htp.p(''  <div class="t-Card">'');',
'    sys.htp.p(''    <a href="https://apex.oracle.com/" target="_blank" class="t-Card-wrap">'');',
'    sys.htp.p(''      <div class="t-Card-icon"><span class="t-Icon fa fa-apex" style="color: #707070"></span></div>'');',
'    sys.htp.p(''      <div class="t-Card-titleWrap"><h3 class="t-Card-title">apex.oracle.com</h3></div>'');',
'    sys.htp.p(''    </a>'');',
'    sys.htp.p(''  </div>'');',
'    sys.htp.p(''</li>'');',
'    sys.htp.p(''<li class="t-Cards-item">'');',
'    sys.htp.p(''  <div class="t-Card">'');',
'    sys.htp.p(''    <a href="https://apex.oracle.com/community" target="_blank" class="t-Card-wrap">'');',
'    sys.htp.p(''      <div class="t-Card-icon"><span class="t-Icon fa fa-users" style="color: #707070"></span></div>'');',
'    sys.htp.p(''      <div class="t-Card-titleWrap"><h3 class="t-Card-title">Oracle APEX Community</h3></div>'');',
'    sys.htp.p(''    </a>'');',
'    sys.htp.p(''  </div>'');',
'    sys.htp.p(''</li>'');',
'    sys.htp.p(''<li class="t-Cards-item">'');',
'    sys.htp.p(''  <div class="t-Card">'');',
'    sys.htp.p(''    <a href="https://apex.oracle.com/forum" target="_blank" class="t-Card-wrap">'');',
'    sys.htp.p(''      <div class="t-Card-icon"><span class="t-Icon fa fa-comments-o" style="color: #707070"></span></div>'');',
'    sys.htp.p(''      <div class="t-Card-titleWrap"><h3 class="t-Card-title">Discussion Forums</h3></div>'');',
'    sys.htp.p(''    </a>'');',
'    sys.htp.p(''  </div>'');',
'    sys.htp.p(''</li>'');',
'    sys.htp.p(''<li class="t-Cards-item">'');',
'    sys.htp.p(''  <div class="t-Card">'');',
'    sys.htp.p(''    <a href="https://apex.oracle.com/autonomous" target="_blank" class="t-Card-wrap">'');',
'    sys.htp.p(''      <div class="t-Card-icon"><span class="t-Icon fa fa-cloud" style="color: #707070"></span></div>'');',
'    sys.htp.p(''      <div class="t-Card-titleWrap"><h3 class="t-Card-title">Autonomous Database + APEX</h3></div>'');',
'    sys.htp.p(''    </a>'');',
'    sys.htp.p(''  </div>'');',
'    sys.htp.p(''</li>'');',
'    sys.htp.p(''</ul>'');',
'    return null;',
'end render;'))
,p_api_version=>1
,p_render_function=>'render'
,p_substitute_attributes=>true
,p_reference_id=>1660759070362076804
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>This region plug-in is used to display a custom footer at the bottom of pages with large icons for navigating to other sites such as twitter and linkedin.</p>',
'<p>Note: This plug-in should be customized to meet your specific requirements, rather than used as is.</p>'))
,p_version_identifier=>'5.0.1'
);
end;
/
prompt --application/user_interfaces/combined_files
begin
null;
end;
/
prompt --application/pages/page_00000
begin
wwv_flow_imp_page.create_page(
 p_id=>0
,p_name=>'0'
,p_alias=>'0'
,p_step_title=>'0'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_nav_list_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_page_component_map=>'14'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1338173797045903369)
,p_plug_name=>'CSS Override'
,p_escape_on_http_output=>'Y'
,p_plug_display_sequence=>10
,p_plug_display_point=>'AFTER_HEADER'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style type="text/css">',
'.infoTextRegion.padded {',
'  padding: 8px 0;',
'  margin: 8px 8px 12px 8px;',
'}',
'',
'.infoTextRegion {',
'  padding: 0;',
'}',
'.infoTextRegion p,',
'.infoTextRegion li {',
'  font-size: 14px;',
'  color: #707070;',
'  padding: 0 0 12px 0;',
'  margin: 0;',
'  line-height: 20px;',
'}',
'.infoTextRegion ul,',
'.infoTextRegion ol {',
'margin: 8px 8px 8px 24px !important;',
'padding-bottom: 12px;',
'}',
'.infoTextRegion ul {',
'list-style: disc outside;',
'}',
'.infoTextRegion ol {',
'list-style: decimal outside;',
'}',
'.infoTextRegion li {',
'padding-bottom: 0;',
'}',
'',
'</style>'))
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_imp_page.create_page(
 p_id=>2
,p_name=>'File Upload'
,p_alias=>'FILE-UPLOAD'
,p_step_title=>'File Upload'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_imp_page.create_page(
 p_id=>3
,p_name=>'Home'
,p_alias=>'FILE-LIST'
,p_step_title=>'Home'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.t-Chat .t-Chat--own .t-Comments-icon {',
'  margin-right: 0;',
'  margin-left: 12px;',
'}',
'',
'.t-Comments-userIcon {',
'margin-top: 10px;',
'}',
'',
'',
'',
'.t-Chat .t-Chat--own {',
'  flex-direction: row-reverse;',
'}',
' ',
'.t-Chat .t-Chat--own .t-Comments-body {',
'  align-items: flex-end;',
'}',
' ',
'.t-Chat .t-Chat--own .t-Comments-comment:after {',
'  border-left-color: var(--ut-comment-chat-background-color);',
'  border-right-color: rgba(0,0,0,0);',
'  right: none;',
'  left: 100%;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_deep_linking=>'Y'
,p_page_component_map=>'13'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(33143389512755930)
,p_plug_name=>'Chat'
,p_region_name=>'functional-chat'
,p_region_css_classes=>'t-Chat'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>90
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(33743321852811698)
,p_plug_name=>'Buttons'
,p_parent_plug_id=>wwv_flow_imp.id(33143389512755930)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949388027252220400)
,p_plug_display_sequence=>40
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(33743896492811704)
,p_name=>'New'
,p_region_name=>'chat-messages'
,p_parent_plug_id=>wwv_flow_imp.id(33143389512755930)
,p_template=>wwv_flow_imp.id(1980278263172869311)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'        CASE ',
'        WHEN user_name = :P3_USER ',
'            THEN INITCAP(user_name)',
'        WHEN user_name = ''CHATGPT'' || :P3_USER',
'            THEN ''Chat Gpt''',
'        END AS user_name,',
'       CASE ',
'        WHEN user_name = :P3_USER ',
'            THEN ''<span class="fa fa-user" style="margin-top:8px;" aria-hidden="true"></span>'' ',
'        WHEN user_name = ''CHATGPT'' || :P3_USER',
'            THEN ''<span class="fa fa-smile" style="margin-top:8px;" aria-hidden="true"></span>''',
'        END AS user_icon,',
'       FILE_NAME,',
'       comment_date,',
'       CREATED,',
'       CREATED_BY,',
'       UPDATED,',
'       UPDATED_BY,',
'       COMMENT_TEXT,',
'       null                     as actions,',
'       null                     as attribute_1,',
'       null                     as attribute_2,',
'       null                     as attribute_3,',
'       null                     as attribute_4,',
'       case ',
'        when user_name = :P3_USER then ''t-Chat--own''',
'        else null',
'       end comment_modifiers',
'  from VEC_CHAT',
'  Where file_name = :P3_FILE_NAME',
'  and (user_name = :P3_USER or user_name = ''CHATGPT'' || :P3_USER)',
'  order by comment_date ASC'))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P3_USER,P3_LINK'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(1949409987720220457)
,p_query_num_rows=>5
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.set_region_column_width(
 p_id=>wwv_flow_imp.id(33743896492811704)
,p_plug_column_width=>'<div style="overflow: auto; min-height: 250px; max-height: 250px;"'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33746314250811728)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>10
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33746369198811729)
,p_query_column_id=>2
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'User Name'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33817042163355093)
,p_query_column_id=>3
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>160
,p_column_heading=>'User Icon'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33746459676811730)
,p_query_column_id=>4
,p_column_alias=>'FILE_NAME'
,p_column_display_sequence=>30
,p_column_heading=>'File Name'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33747691602811742)
,p_query_column_id=>5
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>150
,p_column_heading=>'Comment Date'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33817126805355094)
,p_query_column_id=>6
,p_column_alias=>'CREATED'
,p_column_display_sequence=>170
,p_column_heading=>'Created'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33746682191811732)
,p_query_column_id=>7
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>50
,p_column_heading=>'Created By'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33746792813811733)
,p_query_column_id=>8
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>60
,p_column_heading=>'Updated'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33746851628811734)
,p_query_column_id=>9
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>70
,p_column_heading=>'Updated By'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33747004398811735)
,p_query_column_id=>10
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>80
,p_column_heading=>'Comment Text'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33747093040811736)
,p_query_column_id=>11
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>90
,p_column_heading=>'Actions'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33747211611811737)
,p_query_column_id=>12
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>100
,p_column_heading=>'Attribute 1'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33747249414811738)
,p_query_column_id=>13
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>110
,p_column_heading=>'Attribute 2'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33747387382811739)
,p_query_column_id=>14
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>120
,p_column_heading=>'Attribute 3'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33747445173811740)
,p_query_column_id=>15
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>130
,p_column_heading=>'Attribute 4'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(33747611972811741)
,p_query_column_id=>16
,p_column_alias=>'COMMENT_MODIFIERS'
,p_column_display_sequence=>140
,p_column_heading=>'Comment Modifiers'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(33818031886355103)
,p_plug_name=>'Document Viewer'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>95
,p_plug_new_grid_row=>false
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<iframe',
'      id="frameName"',
'      srcax="&P3_FILE_NAME."',
'      src=""',
'      width="100%"',
'      height="600px"',
'      loading="lazy"',
'      title="PDF-file"',
'  ></iframe>',
'',
'  '))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(240737719811426709)
,p_plug_name=>'Container'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>2
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281813084368257571)
,p_plug_name=>'Test'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949403479597220436)
,p_plug_display_sequence=>40
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(14835042392726770281)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(1949427078141220517)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(33743513438811700)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(33743321852811698)
,p_button_name=>'Send_Message'
,p_button_static_id=>'post-message-btn'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--padTop'
,p_button_template_id=>wwv_flow_imp.id(1949426445798220509)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Send Message'
,p_button_alignment=>'RIGHT'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-chevron-circle-right '
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(33745360524811719)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(33143389512755930)
,p_button_name=>'CLEAR_CHAT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_image_alt=>'Clear Chat'
,p_button_position=>'EDIT'
,p_button_alignment=>'RIGHT'
,p_warn_on_unsaved_changes=>null
,p_confirm_message=>'This will reset the current chat'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281849994662577570)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(240737719811426709)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--tiny:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_button_image_alt=>'Reset'
,p_button_position=>'PREVIOUS'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3,RIR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281850296178587470)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(240737719811426709)
,p_button_name=>'ADD_FILE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--tiny:t-Button--iconRight'
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Upload File'
,p_button_position=>'PREVIOUS'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RP,12::'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(29674287316078330)
,p_name=>'P3_QUESTION'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(33143389512755930)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Question'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(29674460468078331)
,p_name=>'P3_ANSWER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(33143389512755930)
,p_prompt=>'Answer'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>300
,p_cHeight=>30
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(29675664717078343)
,p_name=>'P3_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(240737719811426709)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(29676033951078347)
,p_name=>'P3_SHOW_PREVIEW'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(240737719811426709)
,p_prompt=>'Show Preview'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33743372838811699)
,p_name=>'P3_MESSAGE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(33743321852811698)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Message'
,p_placeholder=>'Enter Message'
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''list 5 new features'' d  from dual',
'union',
'select ''list 2 new features'' d  from dual',
'union',
'select ''list 1 new features'' d  from dual',
'union',
'select ''list 3 new features'' d  from dual'))
,p_cSize=>30
,p_grid_column=>1
,p_grid_label_column_span=>0
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_imp.id(1949425654686220498)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'Y'
,p_attribute_05=>'7'
,p_attribute_09=>'1'
,p_attribute_10=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33743797953811703)
,p_name=>'P3_USER'
,p_item_sequence=>40
,p_source=>'&APP_USER.'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33745281650811718)
,p_name=>'P3_LINK'
,p_item_sequence=>80
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33817711093355099)
,p_name=>'P3_STORAGE_ITEMS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(240737719811426709)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Object Storage'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'BUCKET_ITEMS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-Select File-'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(1949426297686220507)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33819966235355122)
,p_name=>'P3_FILE_NAME'
,p_item_sequence=>70
,p_use_cache_before_default=>'NO'
,p_prompt=>'File Selected'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLAIN'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(33744865142811714)
,p_computation_sequence=>10
,p_computation_item=>'P3_USER'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'&APP_USER.'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(33743570889811701)
,p_name=>'Send Message on Button Press'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(33743513438811700)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33743630872811702)
,p_event_id=>wwv_flow_imp.id(33743570889811701)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Execute Send Message'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' insert into VEC_CHAT (user_name, comment_text,file_name,comment_date)',
'   values (:P3_USER, :P3_MESSAGE,:P3_FILE_NAME,systimestamp);',
'    COMMIT;',
'end;'))
,p_attribute_02=>'P3_MESSAGE,P3_USER'
,p_attribute_05=>'PLSQL'
,p_stop_execution_on_error=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33745600998811721)
,p_event_id=>wwv_flow_imp.id(33743570889811701)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'Execute Send Message'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.showPageSuccess("Message sent.");',
'apex.region("chat-messages").refresh();',
'apex.item("P3_MESSAGE").setValue("");',
'apex.item("P3_MESSAGE").enable();',
'apex.item("P3_MESSAGE").setFocus();'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(33817819326355100)
,p_name=>'Show Regions on change'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_STORAGE_ITEMS'
,p_condition_element=>'P3_STORAGE_ITEMS'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33818161792355104)
,p_event_id=>wwv_flow_imp.id(33817819326355100)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Show Chat'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(33143389512755930)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33820310893355125)
,p_event_id=>wwv_flow_imp.id(33817819326355100)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Show File Name'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_FILE_NAME'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33818359483355106)
,p_event_id=>wwv_flow_imp.id(33817819326355100)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'Hide Chat'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(33143389512755930)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33820201818355124)
,p_event_id=>wwv_flow_imp.id(33817819326355100)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'Show File Name'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_FILE_NAME'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(33819696215355119)
,p_name=>'New'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_STORAGE_ITEMS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33820115621355123)
,p_event_id=>wwv_flow_imp.id(33819696215355119)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_FILE_NAME'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select',
' :P3_STORAGE_ITEMS',
'from dual'))
,p_attribute_07=>'P3_STORAGE_ITEMS'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33819775861355120)
,p_event_id=>wwv_flow_imp.id(33819696215355119)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_LINK'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select',
':BUCKET_PAR || :P3_STORAGE_ITEMS',
'from dual',
''))
,p_attribute_07=>'P3_STORAGE_ITEMS'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(33819898087355121)
,p_event_id=>wwv_flow_imp.id(33819696215355119)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'document.getElementById(''frameName'').src = apex.item( "P3_LINK" ).getValue();'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(29674174062078328)
,p_name=>'Set question to item'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_MESSAGE'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(29674213070078329)
,p_event_id=>wwv_flow_imp.id(29674174062078328)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_QUESTION'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'SELECT :P3_MESSAGE FROM DUAL'
,p_attribute_07=>'P3_MESSAGE'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(29674618581078333)
,p_name=>'Clear Question and Answer'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(33745360524811719)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(29675559535078342)
,p_event_id=>wwv_flow_imp.id(29674618581078333)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_ANSWER,P3_QUESTION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(29674989571078337)
,p_name=>'Set Answer'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_QUESTION'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(29675151930078338)
,p_event_id=>wwv_flow_imp.id(29674989571078337)
,p_event_result=>'TRUE'
,p_action_sequence=>1
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_ANSWER'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(29674550147078332)
,p_event_id=>wwv_flow_imp.id(29674989571078337)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  result_clob CLOB;',
'BEGIN',
'  APEX_DEBUG.ENABLE(apex_debug.c_log_level_info);',
'  apex_debug.message(p_message => ''entered plsql code'');',
'  apex_debug.message(p_message => :P3_QUESTION);',
'  apex_debug.message(p_message => :P3_ID);',
'  apex_debug.message(p_message => ''no P3_ID'');',
'  result_clob := generate_text_response2(:P3_QUESTION,:P3_ID,7);',
'  ',
' ',
'  -- Print the result',
'  /* DBMS_OUTPUT.ENABLE(buffer_size => 100000);',
'  DBMS_OUTPUT.PUT_line(''The Answer  is '');',
'  DBMS_OUTPUT.PUT_line(result_clob);*/',
'  :P3_ANSWER := case when :P3_QUESTION is null then null else result_clob end;',
'END;',
''))
,p_attribute_02=>'P3_QUESTION,P3_ID'
,p_attribute_03=>'P3_ANSWER'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(29675237796078339)
,p_name=>'Hide Answer On page load'
,p_event_sequence=>90
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(29675338168078340)
,p_event_id=>wwv_flow_imp.id(29675237796078339)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_ANSWER'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(29675742047078344)
,p_name=>'Set Id of item '
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_STORAGE_ITEMS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(29675860569078345)
,p_event_id=>wwv_flow_imp.id(29675742047078344)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_ID'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id from my_books',
'where file_name = :P3_STORAGE_ITEMS;'))
,p_attribute_07=>'P3_STORAGE_ITEMS'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(29676139849078348)
,p_name=>'Show Preview'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_SHOW_PREVIEW'
,p_condition_element=>'P3_SHOW_PREVIEW'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'Y'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(29676241339078349)
,p_event_id=>wwv_flow_imp.id(29676139849078348)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(33818031886355103)
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(29676448088078351)
,p_event_id=>wwv_flow_imp.id(29676139849078348)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(33818031886355103)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(29676541217078352)
,p_name=>'Hide PDF viewer on page load'
,p_event_sequence=>120
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(29676634506078353)
,p_event_id=>wwv_flow_imp.id(29676541217078352)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(33818031886355103)
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(33745490785811720)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'New'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'    usercmnt Varchar2(4000);',
'    gptcmnt Varchar2(4000);',
'BEGIN ',
'',
'Select ''CHATGPT;''||listagg(COMMENT_TEXT, '';'')',
'into gptcmnt ',
'from vec_chat',
'where user_name = ''CHATGPT'' || :P3_USER',
'and   file_name = :P3_FILE_NAME;',
'',
'Select ''USER;''||listagg(COMMENT_TEXT, '';'')',
'into usercmnt ',
'from vec_chat',
'where user_name = :P3_USER ',
'and   file_name = :P3_FILE_NAME;',
'',
'INSERT INTO vec_chat_history (USER_NAME, COMMENT_STRING ,FILE_NAME)',
'       VALUES (:P3_USER,usercmnt||gptcmnt,:P3_FILE_NAME);',
'',
'DELETE FROM vec_chat',
'where user_name = :P3_USER ',
'and   file_name = :P3_FILE_NAME;',
'',
'DELETE FROM vec_chat',
'where user_name = ''CHATGPT'' || :P3_USER',
'and   file_name = :P3_FILE_NAME;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(33745360524811719)
,p_internal_uid=>8471665691499028
);
end;
/
prompt --application/pages/page_00004
begin
wwv_flow_imp_page.create_page(
 p_id=>4
,p_tab_set=>'TS1'
,p_name=>'Help'
,p_alias=>'HELP'
,p_step_title=>'Help'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_html_page_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>',
'div.helpContainer{width:960px;margin:16px auto;zoom:1}',
'div.helpContainer:before,div.helpContainer:after{content:"\0020";display:block;height:0;overflow:hidden}',
'div.helpContainer:after{clear:both}',
'div.helpContainer div.helpSide{float:left;width:300px}',
'div.helpContainer div.helpSide h1.appNameHeader{position:relative;font:bold 22px/36px Arial,sans-serif;color:#404040;padding:0;margin:0}',
'',
'form#wwvFlowForm div#uBodyContainer div#uOneCol div.helpContainer div.helpSide h1.appNameHeader {margin:0;padding:0;}',
'',
'div.helpContainer div.helpSide h1.appNameHeader img{display:block;position:absolute;left:0;top:0}',
'div.helpContainer div.helpMain{float:right;border-left:1px solid #EEE;width:632px;padding-left:16px}',
'div.helpContainer div.helpMain h2{font:bold 20px/32px Arial,sans-serif;color:#404040;margin:0 0 8px 0}',
'div.helpContainer div.helpMain h3{font:bold 16px/24px Arial,sans-serif;color:#404040;margin:0 0 8px 0}',
'div.helpContainer div.helpMain h4{font:bold 12px/16px Arial,sans-serif;color:#404040;margin:0 0 8px 0}',
'div.helpContainer div.helpMain p{font:normal 12px/16px Arial,sans-serif;color:#404040;margin:0 0 8px 0}',
'div.helpContainer div.helpMain ul{list-style:outside disc;margin:0 0 0 24px}',
'div.helpContainer div.helpMain ul li{font:normal 12px/20px Arial,sans-serif;color:#404040}',
'div.helpContainer div.helpMain .aboutApp,div.helpContainer div.helpMain .textRegion{border-bottom:1px solid #EEE;padding-bottom:16px;margin-bottom:16px}',
'</style>'))
,p_page_template_options=>'#DEFAULT#'
,p_nav_list_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(2089843573879838622)
,p_name=>'&APP_NAME.'
,p_template=>wwv_flow_imp.id(1949394124666220412)
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_css_classes=>'t-HeroRegion--featured'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-AVPList--rightAligned'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select aa.version app_version,',
'       to_char(aa.pages,''999G999G990'') pages,',
'       ''Oracle'' vendor',
'from apex_applications aa',
'where aa.application_id = :APP_ID'))
,p_ajax_enabled=>'Y'
,p_region_image=>'#APP_FILES#icons/app-icon-512.png'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(1949412517353220469)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2089843745441838623)
,p_query_column_id=>1
,p_column_alias=>'APP_VERSION'
,p_column_display_sequence=>1
,p_column_heading=>'App version'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2089843829075838624)
,p_query_column_id=>2
,p_column_alias=>'PAGES'
,p_column_display_sequence=>2
,p_column_heading=>'Pages'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(2089843899742838625)
,p_query_column_id=>3
,p_column_alias=>'VENDOR'
,p_column_display_sequence=>3
,p_column_heading=>'Vendor'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281807485601225032)
,p_plug_name=>'Help Container'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281807898163225034)
,p_plug_name=>'Quick Start'
,p_parent_plug_id=>wwv_flow_imp.id(3281807485601225032)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<H2>Getting Started</h2>',
'<p>Run the application as a developer; at the bottom of the page will be buttons for viewing the page in the Application Express Application Builder. Click on the "Edit Page X" button to see how the pages are defined.</p>',
'<p>If you have questions, ask them on the <a href="https://forums.oracle.com/forums/forum.jspa?forumID=137">OTN Forum</a>.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281808108526225034)
,p_plug_name=>'Features'
,p_parent_plug_id=>wwv_flow_imp.id(3281807485601225032)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>Features</h2>',
'<p>',
'  <ul>',
'    <li>File Upload to Application Table BLOB Column</li>',
'    <li>File Upload to APEX_APPLICATION_TEMP_FILES table</li>',
'    <li>Display a "Download" Link in a "File Browse" Page Item</li>',
'    <li>Display an Image File Inline</li>',
'    <li>File Download from Interactive Report</li>',
'    <li>File Download from Classic Report</li>',
'    <li>File Download from PL/SQL Generated Link</li>',
'    <li>File Size Reporting "FILESIZE" format mask</li>',
'  </ul>',
'</p>'))
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281808306866225035)
,p_plug_name=>'About this Application'
,p_parent_plug_id=>wwv_flow_imp.id(3281807485601225032)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>About this Application</h2>',
'<p>Learn how to create Oracle Application Express applications that include file upload and download. Upload files using dialogs as well as dedicated pages. See how to download files stored in Oracle database BLOB columns within database tables. Spec'
||'ifically see how to produce file download links from interactive reports, classic reports, forms, and dynamically created HTML content.</p>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281808903262225039)
,p_plug_name=>'Help'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949403479597220436)
,p_plug_display_sequence=>1
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(14835042392726770281)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(1949427078141220517)
,p_plug_display_condition_type=>'NEVER'
);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_imp_page.create_page(
 p_id=>5
,p_name=>'Home Testing Iframe'
,p_alias=>'HOME-TESTING-IFRAME'
,p_step_title=>'Home Testing Iframe'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let pdfUrl = $(this.triggeringElement).data(''fileUrl'');',
'',
'console.log(pdfUrl);',
'',
'fetch(pdfUrl)',
'    .then(response => {',
'        if (response.ok) {',
'            console.log(response);',
'            return response.blob();',
'        }',
'    })',
'    .then(file => {',
'        let src = URL.createObjectURL(file);',
'        $(''#pdfPreviewContainer'').dialog(''open'');',
'        $(''#embeddedPDF'').attr(''data'', src );',
'    })',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.t-Chat .t-Chat--own .t-Comments-icon {',
'  margin-right: 0;',
'  margin-left: 12px;',
'}',
'',
'.t-Comments-userIcon {',
'margin-top: 10px;',
'}',
'',
'',
'',
'.t-Chat .t-Chat--own {',
'  flex-direction: row-reverse;',
'}',
' ',
'.t-Chat .t-Chat--own .t-Comments-body {',
'  align-items: flex-end;',
'}',
' ',
'.t-Chat .t-Chat--own .t-Comments-comment:after {',
'  border-left-color: var(--ut-comment-chat-background-color);',
'  border-right-color: rgba(0,0,0,0);',
'  right: none;',
'  left: 100%;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_deep_linking=>'Y'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(28657577202321963)
,p_plug_name=>'Document Viewer new'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>105
,p_plug_new_grid_row=>false
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="cc-actions-column">',
'   ',
'    <span data-file-url= "/ords/r/aidemo/vector-application-upload-download/0?request=APPLICATION_PROCESS%3DPREVIEW_BLOB&session=305864924877567" aria-hidden="true" class="fa fa-eye t-Button t-Button--primary t-Button--simple cc-preview-pdf"></span>',
'</div>',
'',
'<object id="embeddedPDF" data="" class="cc-object-style"></object>'))
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(258956077451949226)
,p_plug_name=>'Container'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader js-removeLandmark:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>2
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(28268466184619753)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(258956077451949226)
,p_button_name=>'RESET_REPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--tiny:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_button_image_alt=>'Reset'
,p_button_position=>'PREVIOUS'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RP,3,RIR::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(28268931079619754)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(258956077451949226)
,p_button_name=>'ADD_FILE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--tiny:t-Button--iconRight'
,p_button_template_id=>wwv_flow_imp.id(1949426512066220512)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Upload File'
,p_button_position=>'PREVIOUS'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RP,12::'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47904987640600936)
,p_name=>'P5_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(258956077451949226)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(47905356874600940)
,p_name=>'P5_SHOW_PREVIEW'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(258956077451949226)
,p_prompt=>'Show Preview'
,p_display_as=>'NATIVE_SINGLE_CHECKBOX'
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51974879509334322)
,p_name=>'P5_USER'
,p_item_sequence=>40
,p_source=>'&APP_USER.'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(51976363206334337)
,p_name=>'P5_LINK'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(258956077451949226)
,p_use_cache_before_default=>'NO'
,p_prompt=>'New'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(52047034016877692)
,p_name=>'P5_STORAGE_ITEMS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(258956077451949226)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Object Storage'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'BUCKET_ITEMS'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-Select File-'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(1949426297686220507)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(52051047790877741)
,p_name=>'P5_FILE_NAME'
,p_item_sequence=>70
,p_use_cache_before_default=>'NO'
,p_prompt=>'File Selected'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
,p_attribute_05=>'PLAIN'
);
wwv_flow_imp_page.create_page_computation(
 p_id=>wwv_flow_imp.id(28272046149619786)
,p_computation_sequence=>10
,p_computation_item=>'P5_USER'
,p_computation_point=>'BEFORE_HEADER'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'&APP_USER.'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28274142413619794)
,p_name=>'Show Regions on change'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_STORAGE_ITEMS'
,p_condition_element=>'P5_STORAGE_ITEMS'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28275158651619797)
,p_event_id=>wwv_flow_imp.id(28274142413619794)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Show File Name'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_FILE_NAME'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28276213769619800)
,p_event_id=>wwv_flow_imp.id(28274142413619794)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'Show File Name'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_FILE_NAME'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28276631315619801)
,p_name=>'New'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_STORAGE_ITEMS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28277101959619802)
,p_event_id=>wwv_flow_imp.id(28276631315619801)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_FILE_NAME'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select',
' :P5_STORAGE_ITEMS',
'from dual'))
,p_attribute_07=>'P5_STORAGE_ITEMS'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28277623189619803)
,p_event_id=>wwv_flow_imp.id(28276631315619801)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_LINK'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'',
'SELECT ',
'APEX_PAGE.GET_URL (',
'            p_page   => 0,',
'            p_request => ''APPLICATION_PROCESS=PREVIEW_BLOB'' ) FROM DUAL'))
,p_attribute_07=>'P5_STORAGE_ITEMS'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28278118348619804)
,p_event_id=>wwv_flow_imp.id(28276631315619801)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'document.getElementById(''frameName'').src = apex.item( "P5_LINK" ).getValue();'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28278536415619805)
,p_name=>'Set question to item'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_MESSAGE'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28279004606619806)
,p_event_id=>wwv_flow_imp.id(28278536415619805)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_QUESTION'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'SELECT :P5_MESSAGE FROM DUAL'
,p_attribute_07=>'P5_MESSAGE'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28280300803619809)
,p_name=>'Set Answer'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_QUESTION'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28280830761619810)
,p_event_id=>wwv_flow_imp.id(28280300803619809)
,p_event_result=>'TRUE'
,p_action_sequence=>1
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_ANSWER'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28281296758619811)
,p_event_id=>wwv_flow_imp.id(28280300803619809)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  result_clob CLOB;',
'BEGIN',
'  -- Call the function with the query',
' ',
'  result_clob := admin.generate_text_response2(:P5_QUESTION,:P5_ID ,7);',
'  ',
' ',
'  -- Print the result',
'  /* DBMS_OUTPUT.ENABLE(buffer_size => 100000);',
'  DBMS_OUTPUT.PUT_line(''The Answer  is '');',
'  DBMS_OUTPUT.PUT_line(result_clob);*/',
'  :P5_ANSWER := case when :P5_QUESTION is null then null else result_clob end;',
'END;',
''))
,p_attribute_02=>'P5_QUESTION,P5_ID'
,p_attribute_03=>'P5_ANSWER'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28281701081619812)
,p_name=>'Hide Answer On page load'
,p_event_sequence=>90
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28282174528619813)
,p_event_id=>wwv_flow_imp.id(28281701081619812)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_ANSWER'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28282621638619814)
,p_name=>'Set Id of item '
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_STORAGE_ITEMS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28283120382619815)
,p_event_id=>wwv_flow_imp.id(28282621638619814)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_ID'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select id from ADMIN.my_books',
'where file_name = :P5_STORAGE_ITEMS'))
,p_attribute_07=>'P5_STORAGE_ITEMS'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28283451897619816)
,p_name=>'Show Preview'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_SHOW_PREVIEW'
,p_condition_element=>'P5_SHOW_PREVIEW'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'Y'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28284848557619819)
,p_name=>'Hide PDF viewer on page load'
,p_event_sequence=>120
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(28657689362321964)
,p_name=>'REFRESH PREVIEW'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_STORAGE_ITEMS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(28657759608321965)
,p_event_id=>wwv_flow_imp.id(28657689362321964)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(28657577202321963)
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(28272394462619787)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'New'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'    usercmnt Varchar2(4000);',
'    gptcmnt Varchar2(4000);',
'BEGIN ',
'',
'Select ''CHATGPT;''||listagg(COMMENT_TEXT, '';'')',
'into gptcmnt ',
'from vec_chat',
'where user_name = ''CHATGPT'' || :P5_USER',
'and   file_name = :P5_FILE_NAME;',
'',
'Select ''USER;''||listagg(COMMENT_TEXT, '';'')',
'into usercmnt ',
'from vec_chat',
'where user_name = :P5_USER ',
'and   file_name = :P5_FILE_NAME;',
'',
'INSERT INTO vec_chat_history (USER_NAME, COMMENT_STRING ,FILE_NAME)',
'       VALUES (:P5_USER,usercmnt||gptcmnt,:P5_FILE_NAME);',
'',
'DELETE FROM vec_chat',
'where user_name = :P5_USER ',
'and   file_name = :P5_FILE_NAME;',
'',
'DELETE FROM vec_chat',
'where user_name = ''CHATGPT'' || :P5_USER',
'and   file_name = :P5_FILE_NAME;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>18232457408522625
);
end;
/
prompt --application/pages/page_00006
begin
wwv_flow_imp_page.create_page(
 p_id=>6
,p_name=>'Application Theme Style'
,p_alias=>'APPLICATION-THEME-STYLE'
,p_step_title=>'Application Theme Style'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2167770323614569905)
,p_plug_name=>'Set User Interface Theme Style'
,p_region_template_options=>'#DEFAULT#:t-Region--hiddenOverflow:t-Region--hideHeader'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>20
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2167770670415569906)
,p_plug_name=>'items'
,p_parent_plug_id=>wwv_flow_imp.id(2167770323614569905)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949388027252220400)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_translate_title=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2167771554514569910)
,p_plug_name=>'About this page'
,p_region_css_classes=>'infoTextRegion'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949388027252220400)
,p_plug_display_sequence=>10
,p_plug_source=>'<p>Select the look and feel of the application you would like to use for all users of this application.</p>'
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2167771913554569910)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949403479597220436)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(14835042392726770281)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(1949427078141220517)
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2167772364780569910)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(2167771913554569910)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:settings:&SESSION.::&DEBUG.:::'
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(2167772764052569911)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(2167771913554569910)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(2167774223532569915)
,p_branch_action=>'f?p=&APP_ID.:settings:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(2167772764052569911)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(2167771100298569907)
,p_name=>'P6_DESKTOP_THEME_STYLE_ID'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(2167770670415569906)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Desktop Theme Style'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.theme_style_id',
'from apex_application_theme_styles s, apex_application_themes t',
'where s.application_id = t.application_id',
'and s.theme_number = t.theme_number',
'and s.application_id = :app_id',
'and t.ui_type_name   = ''DESKTOP''',
'and s.is_current = ''Yes'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select s.name d,',
'          s.theme_style_id r',
'from apex_application_theme_styles s, apex_application_themes t',
'where s.application_id = t.application_id',
'and s.theme_number = t.theme_number',
'and s.application_id = :app_id',
'and t.ui_type_name   = ''DESKTOP''',
'and t.is_current = ''Yes''',
'order by 1'))
,p_cHeight=>1
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from apex_application_theme_styles s, apex_application_themes t',
'where s.application_id = t.application_id',
'and s.theme_number = t.theme_number',
'and s.application_id = :app_id',
'and t.ui_type_name   = ''DESKTOP'''))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_imp.id(1949426243331220505)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_restricted_characters=>'WEB_SAFE'
,p_attribute_01=>'NONE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(2167773719083569913)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Theme Style'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P6_DESKTOP_THEME_STYLE_ID is not null then',
'    for c1 in (select theme_number',
'               from apex_application_themes',
'               where application_id = :app_id',
'               and ui_type_name   = ''DESKTOP''',
'               and is_current = ''Yes'')',
'    loop',
'        apex_theme.set_current_style (',
'            p_theme_number   => c1.theme_number,',
'            p_id => :P6_DESKTOP_THEME_STYLE_ID',
'            );',
'    end loop;',
'end if;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(2167772764052569911)
,p_process_success_message=>'Theme Style Set for All Users.'
,p_internal_uid=>2127169519542299546
);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_imp_page.create_page(
 p_id=>7
,p_tab_set=>'TS1'
,p_name=>'Administration'
,p_alias=>'SETTINGS'
,p_step_title=>'Administration'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_nav_list_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'06'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281815005256264100)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949403479597220436)
,p_plug_display_sequence=>1
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(14835042392726770281)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(1949427078141220517)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281818596102289687)
,p_plug_name=>'Administration'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Region--hideHeader'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>10
,p_list_id=>wwv_flow_imp.id(3281817780688289680)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_imp.id(1949420499205220482)
);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_imp_page.create_page(
 p_id=>10
,p_tab_set=>'TS1'
,p_name=>'Manage Example Data'
,p_alias=>'MANAGE-EXAMPLE-DATA'
,p_step_title=>'Manage Example Data'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_nav_list_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281819790376295364)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949403479597220436)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(14835042392726770281)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(1949427078141220517)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281825177534336153)
,p_plug_name=>'Manage Sample Data'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949388027252220400)
,p_plug_display_sequence=>10
,p_plug_source=>'<span class="infoTextRegion"><p>Manage the sample data that ships with this application for demonstration purposes.</p></span>'
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281825789654339559)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(3281819790376295364)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281826007483339560)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(3281819790376295364)
,p_button_name=>'recreate'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Recreate'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(3281826676972345456)
,p_branch_action=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_comment=>'Created 27-APR-2012 07:42 by MIKE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3281826405931344321)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'recreate data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'EBA_DEMO_FILE_DATA.remove_data;',
'EBA_DEMO_FILE_DATA.load_data;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Sample data re-created.'
,p_internal_uid=>3241222206390073954
);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_imp_page.create_page(
 p_id=>11
,p_tab_set=>'TS1'
,p_name=>'Delete Files'
,p_alias=>'DELETE-FILES'
,p_step_title=>'Delete Files'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_nav_list_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281820898255299660)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949403479597220436)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(14835042392726770281)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(1949427078141220517)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281822094110312532)
,p_plug_name=>'Delete Files'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949388027252220400)
,p_plug_display_sequence=>10
,p_plug_source=>'<span class="infoTextRegion"><p>This action will delete all files used by this application.  Project data will not be deleted.  You may wish to delete sample files to conserve space.</p></span>'
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281822499651314147)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(3281820898255299660)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281822696940314149)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(3281820898255299660)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--simple:t-Button--danger'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_image_alt=>'Delete Files'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(3281824304976325143)
,p_branch_action=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_comment=>'Created 27-APR-2012 07:39 by MIKE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3281823076925316975)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'delete files'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'delete from EBA_DEMO_FILES;',
'commit;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(3281822696940314149)
,p_process_success_message=>'All rows deleted from files table.'
,p_internal_uid=>3241218877384046608
);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_imp_page.create_page(
 p_id=>12
,p_name=>'Add File'
,p_alias=>'FILE'
,p_page_mode=>'MODAL'
,p_step_title=>'Add File'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40622462931588432)
,p_plug_name=>'Body'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949388027252220400)
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40622969360588437)
,p_plug_name=>'OCI Storage Bucket'
,p_parent_plug_id=>wwv_flow_imp.id(40622462931588432)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Region--hideHeader'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_condition_type=>'NEVER'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(33139851265755895)
,p_plug_name=>'Files in Bucket'
,p_parent_plug_id=>wwv_flow_imp.id(40622969360588437)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949397075503220418)
,p_plug_display_sequence=>10
,p_location=>'WEB_SOURCE'
,p_web_src_module_id=>wwv_flow_imp.id(38947239158065438)
,p_query_type=>'SQL'
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Files in Bucket'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(33139996219755896)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'ZACK'
,p_internal_uid=>7866171125443204
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(33140243994755899)
,p_db_column_name=>'NAME'
,p_display_order=>10
,p_column_identifier=>'C'
,p_column_label=>'Name'
,p_column_link=>'f?p=&APP_ID.:999:&SESSION.::&DEBUG.::P999_BUCKET,P999_FILENAME:&G_OCI_DEFAULT_BUCKET.,#NAME#'
,p_column_linktext=>'#NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(33820380945355126)
,p_db_column_name=>'MD5'
,p_display_order=>20
,p_column_identifier=>'D'
,p_column_label=>'Md5'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(33820459003355127)
,p_db_column_name=>'SIZE_'
,p_display_order=>30
,p_column_identifier=>'E'
,p_column_label=>'Size'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(33820590706355128)
,p_db_column_name=>'TIMECREATED'
,p_display_order=>40
,p_column_identifier=>'F'
,p_column_label=>'Timecreated'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(33146745444762526)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'78730'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NAME'
);
wwv_flow_imp_shared.create_web_source_comp_param(
 p_id=>wwv_flow_imp.id(33820633551355129)
,p_page_id=>12
,p_web_src_param_id=>wwv_flow_imp.id(38947848441065439)
,p_page_plug_id=>wwv_flow_imp.id(33139851265755895)
,p_value_type=>'DEFAULT'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281841708331516872)
,p_plug_name=>'Local File'
,p_parent_plug_id=>wwv_flow_imp.id(40622462931588432)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Region--hideHeader'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281845780865516911)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_plug_template=>wwv_flow_imp.id(1949403479597220436)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281841900878516874)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(3281845780865516911)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add File'
,p_button_position=>'COPY'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P12_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281842005061516874)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(3281845780865516911)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'COPY'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P12_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281842097316516874)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(3281845780865516911)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--simple:t-Button--danger'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_image_alt=>'Delete'
,p_button_position=>'COPY'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P12_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281842286654516874)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(3281845780865516911)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_image_alt=>'Cancel'
,p_button_position=>'COPY'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(3281842889944516876)
,p_branch_action=>'f?p=&APP_ID.:3:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40622400784588431)
,p_name=>'P12_SELECT_FROM'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(40622462931588432)
,p_item_default=>'1'
,p_prompt=>'Upload To'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Local Storage;1,OCI Object Storage Bucket;2'
,p_cHeight=>1
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281843092157516881)
,p_name=>'P12_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(3281841708331516872)
,p_use_cache_before_default=>'NO'
,p_source=>'ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281844103545516904)
,p_name=>'P12_FILE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(3281841708331516872)
,p_use_cache_before_default=>'NO'
,p_post_element_text=>'<p><em>Files must be under 15M in size.</em></p>'
,p_source=>'FILE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>64
,p_cMaxlength=>255
,p_display_when=>'P12_ID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_imp.id(1949426243331220505)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'N'
,p_attribute_12=>'DROPZONE_INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281844299475516904)
,p_name=>'P12_FILE_COMMENTS'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(3281841708331516872)
,p_use_cache_before_default=>'NO'
,p_source=>'FILE_COMMENTS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3282209904036189146)
,p_name=>'P12_DOWNLOAD_LINK'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(3281841708331516872)
,p_prompt=>'Download'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P12_ID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'PLSQL'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  sys.htp.p(''<a href="'' || apex_util.get_blob_file_src(''P12_FILE_BLOB'',:P12_ID,:P12_PROJECT_ID) || ''">''||apex_escape.html(:P12_FILENAME)||''</a>'');',
'end;'))
,p_attribute_04=>'N'
,p_attribute_05=>'PLAIN'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(3282201899263093187)
,p_validation_name=>'P12_FILE'
,p_validation_sequence=>10
,p_validation=>'P12_FILE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please select a file to upload.'
,p_validation_condition=>'P12_ID'
,p_validation_condition_type=>'ITEM_IS_NULL'
,p_when_button_pressed=>wwv_flow_imp.id(3281841900878516874)
,p_associated_item=>wwv_flow_imp.id(3281844103545516904)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(29675956088078346)
,p_validation_name=>'Check for duplicates'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from MY_BOOKS WHERE FILE_NAME = (SELECT filename',
'FROM apex_application_temp_files',
'WHERE name = :P12_FILE);'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'File Already Exists'
,p_associated_item=>wwv_flow_imp.id(3281844103545516904)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3281845277670516906)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from EBA_DEMO_FILES'
,p_attribute_02=>'VEC_LOCAL_FILE_STORAGE'
,p_attribute_03=>'P12_ID'
,p_attribute_04=>'ID'
,p_internal_uid=>3241241078129246539
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(33142293429755919)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload to Object storage'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  l_url         VARCHAR2(1000);',
'  l_length      NUMBER;',
'  l_response    CLOB;    ',
'  failed_upload EXCEPTION;',
'BEGIN',
'  FOR lr_files in (SELECT * FROM apex_application_temp_files WHERE name = :P12_FILE) ',
'  LOOP',
'    --l_url := :G_OCI_BASE_URL || ''/o/'' || apex_util.url_encode(lr_files.filename);',
'    --l_url := :BUCKET_PAR || apex_util.url_encode(lr_files.filename);',
'    l_url := :BUCKET_PAR || lr_files.filename;',
'    apex_web_service.g_request_headers(1).name := ''Content-Type'';',
'    apex_web_service.g_request_headers(1).value := lr_files.mime_type;',
'    l_response := apex_web_service.make_rest_request(p_url                  => l_url,',
'                                                     p_http_method          => ''PUT'',',
'                                                     p_body_blob            => lr_files.blob_content,',
'                                                     p_credential_static_id => :G_OCI_CREDENTIALS);',
'',
'',
'    IF apex_web_service.g_status_code != 200 then',
'      RAISE failed_upload;',
'    END IF;',
'  END LOOP;',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(3281841900878516874)
,p_process_success_message=>'Action Processed.'
,p_internal_uid=>7868468335443227
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3281845500126516907)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Store In Local DB'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'      ',
'INSERT INTO MY_BOOKS',
'(FILE_NAME, file_type,FILE_CONTENT,FILE_SIZE)',
'SELECT filename, mime_type,blob_content, dbms_lob.getlength(blob_content)',
'FROM apex_application_temp_files',
'WHERE name = :P12_FILE;',
''))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(3281841900878516874)
,p_process_success_message=>'Action Processed.'
,p_internal_uid=>3241241300585246540
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3281845707422516907)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(3281842097316516874)
,p_internal_uid=>3241241507881246540
);
end;
/
prompt --application/pages/page_00013
begin
wwv_flow_imp_page.create_page(
 p_id=>13
,p_name=>'Project'
,p_alias=>'PROJECT'
,p_step_title=>'Project'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_html_page_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>',
'table.uReport,',
'table.uReportContainer {',
'  width: 100%;',
'}',
'table.uReportContainer {',
'  margin-bottom: 8px;',
'}',
'',
'img.projectIcon {',
'max-width: 100%;',
'border-radius: 3px;',
'display: block;',
'margin-bottom: 16px;',
'}',
'</style>'))
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1359076878923602197)
,p_plug_name=>'Upload a file to the WWV_FLOW_FILES table'
,p_region_css_classes=>'infoTextRegion'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(1949401472031220432)
,p_plug_display_sequence=>30
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul style="margin: 8px 24px;">',
'  <li>Create a "File Browse" page item with a storage type of "Table APEX_APPLICATION_TEMP_FILES" (e.g. P13_FILE).  When APEX_APPLICATION_TEMP_FILES view used, Oracle Application Express automatically deletes the file at the end of the session or at '
||'the end of the upload request, depending on what you choose for Purge File At.</li>',
'  <li>If your application''s files table has a description (or comments) column, add a textarea page item for capturing this information</li>',
'  <li>To move the file from the APEX_APPLICATION_TEMP_FILES view to your application''s "files" table, create a PL/SQL page process.</li>',
'  <li>The process to move the record should select the necessary row from APEX_APPLICATION_TEMP_FILES view, insert that data into the application''s "files" table (see "Upload file" process).</li>',
'</ul>'))
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1374938695840309192)
,p_plug_name=>'Display an Image File Inline'
,p_region_css_classes=>'infoTextRegion'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(1949401472031220432)
,p_plug_display_sequence=>40
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul style="margin: 8px 24px;">',
'  <li>Create a "Display Image" page item waith a "Based On" value of "BLOB Column specified in Item Source" (e.g. P13_ICON_IMG)</li>',
'  <li>Ensure the page item''s source has it''s "Source Type" set to "Database Column" and it''s "Source value or expression" value is the column name of the blob column in the table the file resides</li>',
'  <li>Ensure the "Settings" section''s "Alternative Text Column" value is column name that holds file comments (e.g. "ICON_COMMENTS")</li>',
'  <li>Ensure the "Settings" section''s "Filename Column" value is the column name that holds filename (e.g. "ICON_NAME")</li>',
'  <li>Ensure the "Settings" section''s "BLOB Last Updated Column" value is the column name that holds the file''s last_updated_on value (e.g. "ICON_LAST_UPDATED")</li>',
'</ul>'))
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(1374938998957310065)
,p_plug_name=>'Display a "Download" Link in a "File Browse" Page Item'
,p_region_css_classes=>'infoTextRegion'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(1949401472031220432)
,p_plug_display_sequence=>50
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<ul style="margin: 8px 24px;">',
'  <li>Create a "File Browse" page item with a storage type of "BLOB column specified in Item Source attribute" (e.g. P13_PROJECT_ICON)</li>',
'  <li>Ensure the page item''s source has it''s "Source Type" set to "Database Column" and it''s "Source value or expression" value is the column name of the blob column in the table the file resides</li>',
'  <li>Ensure the "Settings" section''s "Display Download Link" dropdown value is set to "Yes"</li>',
'  <li>Ensure the "Settings" section''s "Download Link Text" text field is populated with text descriptive of the file that will be downloaded when clicked (e.g. "Download File")</li>',
'  <li>Ensure the "Settings" section''s "Content Disposition" is set to "Attachment"</li>',
'</ul>'))
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281851504207615295)
,p_plug_name=>'Project'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(1949398930020220427)
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(3281904785394606354)
,p_name=>'Project Attachments'
,p_parent_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_template=>wwv_flow_imp.id(1949394665889220415)
,p_display_sequence=>70
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:is-collapsed:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'    ID,',
'    FILENAME,',
'    FILE_MIMETYPE,',
'    FILE_CHARSET,',
'    FILE_BLOB,',
'    CREATED,',
'    CREATED_BY,',
'    UPDATED,',
'    UPDATED_BY,',
'    dbms_lob.getlength(file_blob) file_size,',
'    dbms_lob.getlength(file_blob) download',
'from EBA_DEMO_FILES',
'where project_id = :P13_ID',
'order by created desc'))
,p_display_when_condition=>'P13_ID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_fixed_header=>'NONE'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(1949410800764220464)
,p_query_num_rows=>100
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>' - '
,p_query_no_data_found=>'No files are attached to this project.'
,p_query_row_count_max=>100
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_query_asc_image=>'apex/builder/dup.gif'
,p_query_asc_image_attr=>'width="16" height="16" alt="" '
,p_query_desc_image=>'apex/builder/ddown.gif'
,p_query_desc_image_attr=>'width="16" height="16" alt="" '
,p_plug_query_strip_html=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281905395837606360)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281905681520606360)
,p_query_column_id=>2
,p_column_alias=>'FILENAME'
,p_column_display_sequence=>2
,p_column_heading=>'Filename'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:12:P12_ID:#ID#'
,p_column_linktext=>'#FILENAME#'
,p_heading_alignment=>'LEFT'
,p_lov_show_nulls=>'NO'
,p_lov_display_extra=>'YES'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281905808710606360)
,p_query_column_id=>3
,p_column_alias=>'FILE_MIMETYPE'
,p_column_display_sequence=>3
,p_column_heading=>'File Mimetype'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281905883110606360)
,p_query_column_id=>4
,p_column_alias=>'FILE_CHARSET'
,p_column_display_sequence=>4
,p_column_heading=>'File Charset'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281906000645606360)
,p_query_column_id=>5
,p_column_alias=>'FILE_BLOB'
,p_column_display_sequence=>5
,p_column_heading=>'File Blob'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281906279150606360)
,p_query_column_id=>6
,p_column_alias=>'CREATED'
,p_column_display_sequence=>6
,p_column_heading=>'Created'
,p_use_as_row_header=>'N'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_lov_show_nulls=>'NO'
,p_lov_display_extra=>'YES'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281906392903606360)
,p_query_column_id=>7
,p_column_alias=>'CREATED_BY'
,p_column_display_sequence=>8
,p_column_heading=>'Created By'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281904995458606359)
,p_query_column_id=>8
,p_column_alias=>'UPDATED'
,p_column_display_sequence=>9
,p_column_heading=>'Updated'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281905101695606359)
,p_query_column_id=>9
,p_column_alias=>'UPDATED_BY'
,p_column_display_sequence=>7
,p_column_heading=>'Updated By'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_hidden_column=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281905181260606359)
,p_query_column_id=>10
,p_column_alias=>'FILE_SIZE'
,p_column_display_sequence=>10
,p_column_heading=>'File Size'
,p_use_as_row_header=>'N'
,p_column_format=>'FILESIZE'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_lov_show_nulls=>'NO'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(3281905294959606360)
,p_query_column_id=>11
,p_column_alias=>'DOWNLOAD'
,p_column_display_sequence=>11
,p_column_heading=>'Download'
,p_use_as_row_header=>'N'
,p_column_format=>'DOWNLOAD:EBA_DEMO_FILES:FILE_BLOB:ID::FILE_MIMETYPE:FILENAME:UPDATED:FILE_CHARSET:attachment:Download:'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3282069189952942607)
,p_plug_name=>'File Upload'
,p_parent_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_plug_display_sequence=>60
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3281856192334615313)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949403479597220436)
,p_plug_display_sequence=>80
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(14835042392726770281)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(1949427078141220517)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(3282763895077683141)
,p_plug_name=>'Application features demonstrated on this page'
,p_region_css_classes=>'infoTextRegion'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949388027252220400)
,p_plug_display_sequence=>20
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p><strong>This page shows how to:</strong>',
'</p>'))
,p_plug_query_headings_type=>'QUERY_COLUMNS'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_plug_query_show_nulls_as=>' - '
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281851781589615297)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(3281856192334615313)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'CHANGE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P13_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281852107792615297)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(3281856192334615313)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281851699485615297)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(3281856192334615313)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Project'
,p_button_position=>'CREATE'
,p_button_alignment=>'RIGHT'
,p_button_condition=>'P13_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3281851887341615297)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(3281856192334615313)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--simple:t-Button--danger'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_image_alt=>'Delete'
,p_button_position=>'DELETE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P13_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(3281852698647615299)
,p_branch_action=>'f?p=&APP_ID.:2:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281852908113615304)
,p_name=>'P13_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_source=>'ID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281853104277615304)
,p_name=>'P13_PROJECT'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Project'
,p_post_element_text=>'&P13_ICON_IMG.'
,p_source=>'PROJECT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>30
,p_field_template=>wwv_flow_imp.id(1949426243331220505)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281853292142615305)
,p_name=>'P13_TASK_NAME'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Task'
,p_source=>'TASK_NAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>64
,p_cMaxlength=>255
,p_field_template=>wwv_flow_imp.id(1949426243331220505)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281853508052615307)
,p_name=>'P13_START_DATE'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Start'
,p_source=>'START_DATE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>64
,p_cMaxlength=>255
,p_field_template=>wwv_flow_imp.id(1949426243331220505)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281853689001615307)
,p_name=>'P13_END_DATE'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'End'
,p_source=>'END_DATE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>64
,p_cMaxlength=>255
,p_field_template=>wwv_flow_imp.id(1949426243331220505)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281853897546615307)
,p_name=>'P13_STATUS'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Status'
,p_source=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select distinct status d, status r from eba_demo_file_projects order by 1'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(1949426243331220505)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_attribute_01=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281854107673615307)
,p_name=>'P13_ASSIGNED_TO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Assignee'
,p_source=>'ASSIGNED_TO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281854295727615307)
,p_name=>'P13_COST'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cost'
,p_source=>'COST'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>64
,p_cMaxlength=>255
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_03=>'right'
,p_attribute_04=>'text'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3281854489336615308)
,p_name=>'P13_BUDGET'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Budget'
,p_source=>'BUDGET'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>64
,p_cMaxlength=>255
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attribute_03=>'right'
,p_attribute_04=>'text'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3282068886705932184)
,p_name=>'P13_FILE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(3282069189952942607)
,p_prompt=>'Upload File'
,p_post_element_text=>'<p><em>Attachments must be under 15M in size.</em></p>'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>64
,p_cMaxlength=>4000
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_12=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3282071199621068326)
,p_name=>'P13_FILE_DESCRIPTION'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(3282069189952942607)
,p_prompt=>'File Description'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>80
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3283266007131138179)
,p_name=>'P13_PROJECT_ICON'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Project Icon'
,p_post_element_text=>'<p><em>Icons must be under 200K and a valid image file.</em></p>'
,p_source=>'ICON_BLOB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>64
,p_cMaxlength=>4000
,p_field_template=>wwv_flow_imp.id(1949425987980220501)
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'ICON_MIMETYPE'
,p_attribute_03=>'ICON_NAME'
,p_attribute_04=>'ICON_CHARSET'
,p_attribute_05=>'ICON_LAST_UPDATED'
,p_attribute_06=>'Y'
,p_attribute_07=>'Download Icon Image'
,p_attribute_08=>'attachment'
,p_attribute_12=>'INLINE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3283276393698089928)
,p_name=>'P13_ICON_COMMENTS'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_item_default=>'Project Icon'
,p_source=>'ICON_COMMENTS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(3283276599155110422)
,p_name=>'P13_ICON_IMG'
,p_item_sequence=>115
,p_item_plug_id=>wwv_flow_imp.id(3281851504207615295)
,p_use_cache_before_default=>'NO'
,p_source=>'ICON_BLOB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_attributes=>'class="projectIcon"'
,p_protection_level=>'S'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_03=>'ICON_COMMENTS'
,p_attribute_04=>'ICON_NAME'
,p_attribute_05=>'ICON_LAST_UPDATED'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3281855703526615313)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from EBA_DEMO_FILE_PROJECTS'
,p_attribute_02=>'EBA_DEMO_FILE_PROJECTS'
,p_attribute_03=>'P13_ID'
,p_attribute_04=>'ID'
,p_attribute_11=>'I:U:D'
,p_internal_uid=>3241251503985344946
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3281855885417615313)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of EBA_DEMO_FILE_PROJECTS'
,p_attribute_02=>'EBA_DEMO_FILE_PROJECTS'
,p_attribute_03=>'P13_ID'
,p_attribute_04=>'ID'
,p_attribute_09=>'P13_ID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed.'
,p_return_key_into_item1=>'P13_ID'
,p_internal_uid=>3241251685876344946
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3282075708718127723)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload File'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    for c1 in (select *',
'               from apex_application_temp_files',
'               where name = :P13_FILE)',
'    loop',
'        insert into eba_demo_files (',
'            project_id,',
'            filename,',
'            file_blob,',
'            file_comments,',
'            file_mimetype)',
'        values (',
'            :P13_ID,',
'            c1.filename,',
'            c1.blob_content,',
'            :P13_FILE_DESCRIPTION,',
'            c1.mime_type);',
'    end loop;',
'',
'    :P13_FILE_DESCRIPTION := null;',
'    :P13_FILE  := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'There was a problem encountered while uploading the file: #SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(3281851781589615297)
,p_process_when=>'P13_FILE'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'File uploaded.'
,p_internal_uid=>3241471509176857356
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(3281856102130615313)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(3281851887341615297)
,p_internal_uid=>3241251902589344946
);
end;
/
prompt --application/pages/page_00101
begin
wwv_flow_imp_page.create_page(
 p_id=>101
,p_name=>'Login'
,p_alias=>'LOGIN'
,p_step_title=>'Sign In | &APP_NAME.'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>wwv_flow_imp.id(1949373694717220360)
,p_navigation_list_position=>'TOP'
,p_nav_list_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_protection_level=>'U'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(14835041588682770275)
,p_plug_name=>'&APP_NAME.'
,p_region_name=>'file-upload-download'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(1949397421054220421)
,p_plug_display_sequence=>10
,p_region_image=>'#APP_FILES#icons/app-icon-512.png'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'N')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(3206350408587874529)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(14835041588682770275)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(1949427006011220515)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'NEXT'
,p_button_alignment=>'RIGHT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(14835041701285770279)
,p_name=>'P101_USERNAME'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(14835041588682770275)
,p_prompt=>'Username'
,p_placeholder=>'username'
,p_post_element_text=>'<span class="t-Login-iconValidation a-Icon icon-check"></span>'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>64
,p_cMaxlength=>100
,p_field_template=>wwv_flow_imp.id(1949425654686220498)
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_restricted_characters=>'WEB_SAFE'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(14835041801011770279)
,p_name=>'P101_PASSWORD'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(14835041588682770275)
,p_prompt=>'Password'
,p_placeholder=>'password'
,p_post_element_text=>'<span class="t-Login-iconValidation a-Icon icon-check"></span>'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>64
,p_cMaxlength=>100
,p_field_template=>wwv_flow_imp.id(1949425654686220498)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(3284558984129546241)
,p_name=>'Set Focus'
,p_event_sequence=>10
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'( $v( "P101_USERNAME" ) === "" )'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3284559290335546243)
,p_event_id=>wwv_flow_imp.id(3284558984129546241)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P101_USERNAME'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(3284559478207546243)
,p_event_id=>wwv_flow_imp.id(3284558984129546241)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P101_PASSWORD'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(14835042076197770281)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P101_USERNAME) );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>14794437876656499914
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(14835041983101770280)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P101_USERNAME,',
'    p_password => :P101_PASSWORD );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>14794437783560499913
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(14835042278021770281)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>14794438078480499914
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(14835042173703770281)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>':P101_USERNAME := apex_authentication.get_login_username_cookie;'
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>14794437974162499914
);
end;
/
prompt --application/pages/page_00999
begin
wwv_flow_imp_page.create_page(
 p_id=>999
,p_name=>'File Download'
,p_alias=>'FILE-DOWNLOAD'
,p_step_title=>'File Download'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33141010911755906)
,p_name=>'P999_BUCKET'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33141114340755907)
,p_name=>'P999_FILENAME'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(33141135491755908)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Download'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  l_response     BLOB;',
'  l_url          VARCHAR2(32000);',
'  l_type         VARCHAR2(32000);',
'  l_length       VARCHAR2(32000);',
'  download_error EXCEPTION;',
'BEGIN',
'  l_url      := :G_OCI_BASE_URL || :P999_BUCKET || ''/o/'' || :P999_FILENAME;',
'  l_response := apex_web_service.make_rest_request_b(p_url                  => l_url,',
'                                                     p_http_method          => ''GET'',',
'                                                     p_credential_static_id => :G_OCI_CREDENTIALS);',
'  IF apex_web_service.g_status_code = 200 THEN',
'    FOR hdrloop in 1..apex_web_service.g_headers.count ',
'    LOOP',
'      IF apex_web_service.g_headers(hdrloop).name = ''Content-Length'' THEN',
'        l_length := apex_web_service.g_headers(hdrloop).value;',
'      END IF;',
'      IF apex_web_service.g_headers(hdrloop).name = ''Content-Type'' THEN',
'        l_type := apex_web_service.g_headers(hdrloop).value;',
'      END IF;',
'    END LOOP;',
'',
'    sys.htp.init;',
'    sys.owa_util.mime_header(TRIM(l_type),FALSE);',
'    sys.htp.p(''Content-length: '' || l_length);',
'    sys.htp.p(''Content-Disposition: attachment; filename="'' || :P999_FILENAME || ''"'' );',
'    sys.htp.p(''Cache-Control: max-age=3600'');',
'    sys.owa_util.http_header_close;',
'    sys.wpg_docload.download_file(l_response);',
'    apex_application.stop_apex_engine;',
'  ELSE  ',
'    RAISE download_error;',
'  END IF;   ',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>7867310397443216
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(33141315289755909)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Download_to_local'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  l_response     BLOB;',
'  l_url          VARCHAR2(32000);',
'  l_type         VARCHAR2(32000);',
'  l_length       VARCHAR2(32000);',
'  download_error EXCEPTION;',
'BEGIN',
'  l_url      := :G_OCI_BASE_URL || :P999_BUCKET || ''/o/'' || :P999_FILENAME;',
'  l_response := apex_web_service.make_rest_request_b(p_url                  => l_url,',
'                                                     p_http_method          => ''GET'',',
'                                                     p_credential_static_id => :G_OCI_CREDENTIALS);',
'  IF apex_web_service.g_status_code = 200 THEN',
'    FOR hdrloop in 1..apex_web_service.g_headers.count ',
'    LOOP',
'      IF apex_web_service.g_headers(hdrloop).name = ''Content-Length'' THEN',
'        l_length := apex_web_service.g_headers(hdrloop).value;',
'      END IF;',
'      IF apex_web_service.g_headers(hdrloop).name = ''Content-Type'' THEN',
'        l_type := apex_web_service.g_headers(hdrloop).value;',
'      END IF;',
'    END LOOP;',
'',
'    sys.htp.init;',
'    sys.owa_util.mime_header(TRIM(l_type),FALSE);',
'    sys.htp.p(''Content-length: '' || l_length);',
'    sys.htp.p(''Content-Disposition: attachment; filename="'' || :P999_FILENAME || ''"'' );',
'    sys.htp.p(''Cache-Control: max-age=3600'');',
'    sys.owa_util.http_header_close;',
'    sys.wpg_docload.download_file(l_response);',
'    apex_application.stop_apex_engine;',
'  ELSE  ',
'    RAISE download_error;',
'  END IF;   ',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_when_type=>'NEVER'
,p_internal_uid=>7867490195443217
);
end;
/
prompt --application/deployment/definition
begin
wwv_flow_imp_shared.create_install(
 p_id=>wwv_flow_imp.id(3232862383307660358)
,p_deinstall_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'drop table EBA_DEMO_FILES cascade constraints;',
'drop table EBA_DEMO_FILE_PROJECTS cascade constraints; ',
'drop package EBA_DEMO_FILE_DATA;'))
,p_required_free_kb=>100
,p_required_sys_privs=>'CREATE PROCEDURE:CREATE TABLE:CREATE TRIGGER:CREATE VIEW'
,p_required_names_available=>'EBA_DEMO_FILE_DATA:EBA_DEMO_FILE_PROJECTS:EBA_DEMO_FILES'
);
end;
/
prompt --application/deployment/install/install_set_plscope_settings
begin
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(3382930585778205520)
,p_install_id=>wwv_flow_imp.id(3232862383307660358)
,p_name=>'Set plscope_settings'
,p_sequence=>5
,p_script_type=>'INSTALL'
,p_script_clob=>'ALTER SESSION SET PLSCOPE_SETTINGS = ''IDENTIFIERS:NONE'';'
);
end;
/
prompt --application/deployment/install/install_projects
begin
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(3281793602703785115)
,p_install_id=>wwv_flow_imp.id(3232862383307660358)
,p_name=>'projects'
,p_sequence=>10
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'CREATE TABLE EBA_DEMO_FILE_PROJECTS',
'   (',
'    ID NUMBER, ',
'    row_version_number number,',
'    PROJECT            VARCHAR2(30) not null, ',
'    TASK_NAME          VARCHAR2(255) not null, ',
'    START_DATE         date not null, ',
'    END_DATE           date not null, ',
'    STATUS             VARCHAR2(30) not null, ',
'    ASSIGNED_TO        VARCHAR2(30), ',
'    COST               NUMBER, ',
'    BUDGET             NUMBER, ',
'    created_on         timestamp,',
'    created_by         varchar2(255),',
'    browser_env        varchar2(4000),',
'    icon_name          varchar2(4000),',
'    icon_comments      varchar2(4000),',
'    icon_blob          blob,',
'    icon_mimetype      varchar2(512),',
'    icon_charset       varchar2(512),',
'    icon_last_updated  timestamp,',
'    CONSTRAINT EBA_DEMO_FILE_PROJECTS_PK PRIMARY KEY (ID) ENABLE',
'   ) ;',
'',
'CREATE OR REPLACE TRIGGER  BIU_EBA_DEMO_FILE_PROJECTS',
'   before insert or update on EBA_DEMO_FILE_PROJECTS',
'   for each row',
'begin',
'   if :new.ID is null then',
'     select to_number(sys_guid(),''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') into :new.id from dual;',
'   end if;',
'',
'    -- Icon Validations',
'    -- Size (200KB limit)',
'    if updating and :NEW.ICON_NAME is not null and nvl(dbms_lob.getlength(:NEW.ICON_BLOB),0) > 204800 then',
'        raise_application_error(-20000, ''The size of the uploaded icon image was over 200kb. Please upload a smaller sized image.'');',
'    end if;',
'    -- Mimetype (must be image)',
'    if (inserting or updating) and :NEW.ICON_NAME is not null and nvl(:NEW.ICON_MIMETYPE,''NULL'') not like ''image%'' then',
'       raise_application_error(-20000, ''The uploaded file was not an image. Please upload an image file.'');',
'    end if;',
'',
'   if inserting then',
'       :new.row_version_number := 1;',
'   elsif updating then',
'       :new.row_version_number := nvl(:old.row_version_number,1) + 1;',
'   end if;',
'end;',
'/',
'show errors    ',
'    ',
' ',
'ALTER TRIGGER BIU_EBA_DEMO_FILE_PROJECTS ENABLE',
'/',
''))
);
end;
/
prompt --application/deployment/install/install_files
begin
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(3281793985649799080)
,p_install_id=>wwv_flow_imp.id(3232862383307660358)
,p_name=>'files'
,p_sequence=>20
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'CREATE TABLE EBA_DEMO_FILES ',
'   (   ',
'    -- primary key and row number for lost update detection',
'    ID                   NUMBER constraint EBA_DEMO_FILES_PK primary key, ',
'    ROW_VERSION_NUMBER   NUMBER, ',
'    --',
'    -- foreign key',
'    PROJECT_ID           NUMBER constraint eba_demo_files_fk',
'                         references EBA_DEMO_FILE_PROJECTS (id)',
'                         on delete cascade, ',
'    --',
'    -- standard columns',
'    FILENAME             VARCHAR2(4000 BYTE), ',
'    FILE_MIMETYPE        VARCHAR2(512 BYTE), ',
'    FILE_CHARSET         VARCHAR2(512 BYTE), ',
'    FILE_BLOB            BLOB, ',
'    --',
'    -- optional columns',
'    FILE_COMMENTS        VARCHAR2(4000 BYTE), ',
'    TAGS                 VARCHAR2(4000 BYTE), ',
'    CREATED              timestamp, ',
'    CREATED_BY           VARCHAR2(255 BYTE), ',
'    UPDATED              timestamp, ',
'    UPDATED_BY           VARCHAR2(255 BYTE)',
'   )  ;',
'',
'create index EBA_DEMO_FILES_i2 on EBA_DEMO_FILES(project_id);',
'',
'CREATE OR REPLACE TRIGGER BIU_EBA_DEMO_FILES ',
'   before insert or update on EBA_DEMO_FILES',
'   for each row',
'begin',
'   if :new.ID is null then',
'     select to_number(sys_guid(),''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'') into :new.id from dual;',
'   end if;',
'',
'   if inserting then',
'       :new.created := localtimestamp;',
'       :new.created_by := nvl(wwv_flow.g_user,user);',
'       :new.updated := localtimestamp;',
'       :new.updated_by := nvl(wwv_flow.g_user,user);',
'       :new.row_version_number := 1;',
'   elsif updating and :new.filename is not null and nvl(dbms_lob.getlength(:new.file_blob),0) > 15728640 then',
'       raise_application_error(-20000, ''The size of the uploaded file was over 15MB. Please upload a smaller sized file.'');',
'   elsif updating then',
'       :new.row_version_number := nvl(:old.row_version_number,1) + 1;',
'   end if;',
'   if inserting or updating then',
'       :new.updated := localtimestamp;',
'       :new.updated_by := nvl(wwv_flow.g_user,user);',
'   end if;',
'end;',
'/',
'ALTER TRIGGER BIU_EBA_DEMO_FILES ENABLE;',
'',
''))
);
end;
/
prompt --application/deployment/install/install_data_load_spec
begin
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(3281800080417195054)
,p_install_id=>wwv_flow_imp.id(3232862383307660358)
,p_name=>'data load spec'
,p_sequence=>30
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace package  EBA_DEMO_FILE_DATA',
'as',
'procedure remove_data;',
'procedure load_data;',
'end;',
'/',
'show errors'))
);
wwv_flow_imp_shared.create_install_object(
 p_id=>wwv_flow_imp.id(1702969863996936816)
,p_script_id=>wwv_flow_imp.id(3281800080417195054)
,p_object_owner=>'#OWNER#'
,p_object_type=>'PACKAGE'
,p_object_name=>'EBA_DEMO_FILE_DATA'
);
end;
/
prompt --application/deployment/install/install_demo_load_body
begin
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(3281800681587204774)
,p_install_id=>wwv_flow_imp.id(3232862383307660358)
,p_name=>'demo load body'
,p_sequence=>40
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'create or replace package body EBA_DEMO_FILE_DATA',
'as',
'procedure remove_data',
'is',
'begin',
'delete from EBA_DEMO_FILE_PROJECTS;',
'end remove_data;',
'',
'procedure load_data',
'is',
'begin',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''ACME Web Express Configuration'',''Identify server requirements'',to_date(''12/20/2015'',''MM/DD/YYYY''),to_date(''12/21/2015'',''MM/DD/YYYY''),'
||'''Closed'',''John Watson'',''200'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''ACME Web Express Configuration'',''Determine Web listener configuration(s)'',to_date(''12/22/2015'',''MM/DD/YYYY''),to_date(''12/22/2015'',''MM'
||'/DD/YYYY''),''Closed'',''James Cassidy'',''600'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''ACME Web Express Configuration'',''Run installation'',to_date(''12/25/2015'',''MM/DD/YYYY''),to_date(''12/25/2015'',''MM/DD/YYYY''),''Closed'',''Ja'
||'mes Cassidy'',''200'',''200'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''ACME Web Express Configuration'',''Create pilot workspace'',to_date(''12/27/2015'',''MM/DD/YYYY''),to_date(''12/27/2015'',''MM/DD/YYYY''),''Close'
||'d'',''John Watson'',''100'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''ACME Web Express Configuration'',''Specify security authentication scheme(s)'',to_date(''01/01/2015'',''MM/DD/YYYY''),to_date(''01/01/2015'','''
||'MM/DD/YYYY''),''Open'',''John Watson'',''200'',''300'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''ACME Web Express Configuration'',''Configure Workspace provisioning'',to_date(''01/02/2015'',''MM/DD/YYYY''),to_date(''01/02/2015'',''MM/DD/YYY'
||'Y''),''Open'',''John Watson'',''200'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''ACME Web Express Configuration'',''Select servers for Development, Test, Production'',to_date(''01/05/2015'',''MM/DD/YYYY''),to_date(''01/07/'
||'2015'',''MM/DD/YYYY''),''Open'',''James Cassidy'',''200'',''600'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Bug Tracker'',''Document quality assurance procedures'',to_date(''11/05/2015'',''MM/DD/YYYY''),to_date(''11/08/2015'',''MM/DD/YYYY''),''Closed'','''
||'Myra Sutcliff'',''3000'',''2000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Bug Tracker'',''Review automated testing tools'',to_date(''11/09/2015'',''MM/DD/YYYY''),to_date(''11/11/2015'',''MM/DD/YYYY''),''Closed'',''Myra Su'
||'tcliff'',''750'',''1500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Bug Tracker'',''Implement bug tracking software'',to_date(''11/24/2015'',''MM/DD/YYYY''),to_date(''11/24/2015'',''MM/DD/YYYY''),''Closed'',''Myra S'
||'utcliff'',''100'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Bug Tracker'',''Train developers on tracking bugs'',to_date(''12/01/2015'',''MM/DD/YYYY''),to_date(''12/06/2015'',''MM/DD/YYYY''),''On-Hold'',''Myr'
||'a Sutcliff'',''1000'',''2000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Bug Tracker'',''Measure effectiveness of improved QA'',to_date(''12/13/2015'',''MM/DD/YYYY''),to_date(''12/13/2015'',''MM/DD/YYYY''),''Pending'','''
||'Myra Sutcliff'',''0'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Convert Spreadsheets'',''Collect mission-critical spreadsheets'',to_date(''12/19/2015'',''MM/DD/YYYY''),to_date(''12/20/2015'',''MM/DD/YYYY''),'''
||'Closed'',''Pam King'',''2500'',''4000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Convert Spreadsheets'',''Lock spreadsheets'',to_date(''12/22/2015'',''MM/DD/YYYY''),to_date(''12/22/2015'',''MM/DD/YYYY''),''Closed'',''Pam King'','''
||'300'',''800'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Convert Spreadsheets'',''Create ACME Web Express applications from spreadsheets'',to_date(''12/30/2015'',''MM/DD/YYYY''),to_date(''01/03/2016'
||''',''MM/DD/YYYY''),''Open'',''Pam King'',''6000'',''10000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Convert Spreadsheets'',''Send links to previous spreadsheet owners'',to_date(''01/05/2016'',''MM/DD/YYYY''),to_date(''01/05/2016'',''MM/DD/YYYY'
||'''),''Pending'',''Pam King'',''0'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Discussion Forum'',''Identify owners'',to_date(''11/25/2015'',''MM/DD/YYYY''),to_date(''11/25/2015'',''MM/DD/YYYY''),''Closed'',''Hank Davis'',''250'''
||',''300'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Discussion Forum'',''Install ACME Web Express application on internet server'',to_date(''12/01/2015'',''MM/DD/YYYY''),to_date(''12/01/2015'','''
||'MM/DD/YYYY''),''Closed'',''Hank Davis'',''100'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Discussion Forum'',''Monitor participation'',to_date(''12/31/2015'',''MM/DD/YYYY''),to_date(''01/01/2016'',''MM/DD/YYYY''),''Open'',''Hank Davis'','''
||'450'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Email Integration'',''Complete plan'',to_date(''12/12/2015'',''MM/DD/YYYY''),to_date(''12/13/2015'',''MM/DD/YYYY''),''Closed'',''Bob Nile'',''3000'','''
||'1500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Email Integration'',''Check software licenses'',to_date(''12/15/2015'',''MM/DD/YYYY''),to_date(''12/15/2015'',''MM/DD/YYYY''),''Closed'',''Bob Nile'
||''',''200'',''200'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Email Integration'',''Get RFPs for new server'',to_date(''12/29/2015'',''MM/DD/YYYY''),to_date(''12/30/2015'',''MM/DD/YYYY''),''Closed'',''Bob Nile'
||''',''2000'',''1000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Email Integration'',''Purchase backup server'',to_date(''01/15/2016'',''MM/DD/YYYY''),to_date(''01/17/2016'',''MM/DD/YYYY''),''Pending'',''Bob Nile'
||''',''0'',''3000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Employee Satisfaction Survey'',''Complete questionnaire'',to_date(''12/05/2015'',''MM/DD/YYYY''),to_date(''12/06/2015'',''MM/DD/YYYY''),''Closed'''
||',''Irene Jones'',''1200'',''800'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Employee Satisfaction Survey'',''Review with legal'',to_date(''12/07/2015'',''MM/DD/YYYY''),to_date(''12/07/2015'',''MM/DD/YYYY''),''On-Hold'',''Ir'
||'ene Jones'',''200'',''400'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Employee Satisfaction Survey'',''Plan rollout schedule'',to_date(''12/08/2015'',''MM/DD/YYYY''),to_date(''12/08/2015'',''MM/DD/YYYY''),''On-Hold'''
||',''Irene Jones'',''0'',''750'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Client Server Conversion'',''Identify pilot Client Server applications'',to_date(''12/17/2015'',''MM/DD/YYYY''),to_date(''12/17/2015'',''MM/DD/'
||'YYYY''),''Closed'',''Scott Spencer'',''200'',''200'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Client Server Conversion'',''Migrate pilot Client Server to ACME Web Express'',to_date(''12/19/2015'',''MM/DD/YYYY''),to_date(''12/22/2015'','''
||'MM/DD/YYYY''),''Closed'',''Scott Spencer'',''4500'',''5000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Client Server Conversion'',''Post-migration review'',to_date(''12/23/2015'',''MM/DD/YYYY''),to_date(''12/23/2015'',''MM/DD/YYYY''),''Closed'',''Pam'
||' King'',''500'',''300'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Client Server Conversion'',''Plan migration schedule'',to_date(''12/26/2015'',''MM/DD/YYYY''),to_date(''12/26/2015'',''MM/DD/YYYY''),''Closed'',''P'
||'am King'',''1000'',''1000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Client Server Conversion'',''Migrate Client Server applications'',to_date(''12/31/2015'',''MM/DD/YYYY''),to_date(''01/03/2016'',''MM/DD/YYYY''),'
||'''Open'',''Pam King'',''300'',''12000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Client Server Conversion'',''Test migrated applications'',to_date(''01/05/2016'',''MM/DD/YYYY''),to_date(''01/06/2016'',''MM/DD/YYYY''),''Pending'
||''',''Russ Saunders'',''0'',''6000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Client Server Conversion'',''User acceptance testing'',to_date(''01/09/2016'',''MM/DD/YYYY''),to_date(''01/11/2016'',''MM/DD/YYYY''),''Pending'','''
||'Russ Saunders'',''0'',''2500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Client Server Conversion'',''End-user Training'',to_date(''01/15/2016'',''MM/DD/YYYY''),to_date(''01/15/2016'',''MM/DD/YYYY''),''Pending'',''Myra S'
||'utcliff'',''0'',''2500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Client Server Conversion'',''Rollout migrated Client Server in ACME Web Express'',to_date(''01/16/2016'',''MM/DD/YYYY''),to_date(''01/16/2016'
||''',''MM/DD/YYYY''),''Pending'',''Pam King'',''0'',''200'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Load Packaged Apps'',''Identify point solutions required'',to_date(''12/19/2015'',''MM/DD/YYYY''),to_date(''12/19/2015'',''MM/DD/YYYY''),''Closed'
||''',''John Watson'',''200'',''300'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Load Packaged Apps'',''Install in development'',to_date(''12/20/2015'',''MM/DD/YYYY''),to_date(''12/20/2015'',''MM/DD/YYYY''),''Closed'',''John Wat'
||'son'',''100'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Load Packaged Apps'',''Customize solutions'',to_date(''12/23/2015'',''MM/DD/YYYY''),to_date(''12/25/2015'',''MM/DD/YYYY''),''Open'',''John Watson'','
||'''1500'',''4000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Load Packaged Apps'',''Implement in Production'',to_date(''12/26/2015'',''MM/DD/YYYY''),to_date(''12/26/2015'',''MM/DD/YYYY''),''On-Hold'',''John W'
||'atson'',''200'',''1500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Load Packaged Apps'',''Train Administrators of Packaged Apps'',to_date(''12/28/2015'',''MM/DD/YYYY''),to_date(''12/28/2015'',''MM/DD/YYYY''),''Pe'
||'nding'',''John Watson'',''0'',''1000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Maintain Support Systems'',''HR software upgrades'',to_date(''11/28/2015'',''MM/DD/YYYY''),to_date(''12/01/2015'',''MM/DD/YYYY''),''Closed'',''Pam '
||'King'',''8000'',''7000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Maintain Support Systems'',''Apply Billing System updates'',to_date(''12/02/2015'',''MM/DD/YYYY''),to_date(''12/04/2015'',''MM/DD/YYYY''),''Close'
||'d'',''Russ Saunders'',''9500'',''7000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Maintain Support Systems'',''Arrange for vacation coverage'',to_date(''12/06/2015'',''MM/DD/YYYY''),to_date(''12/06/2015'',''MM/DD/YYYY''),''Open'
||''',''Al Bines'',''300'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Maintain Support Systems'',''Investigate new Virus Protection software'',to_date(''01/15/2016'',''MM/DD/YYYY''),to_date(''01/16/2016'',''MM/DD/'
||'YYYY''),''Open'',''Pam King'',''1700'',''1500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate Desktop Application'',''Identify pilot desktop applications'',to_date(''12/10/2015'',''MM/DD/YYYY''),to_date(''12/10/2015'',''MM/DD/YYY'
||'Y''),''Closed'',''Bob Nile'',''300'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate Desktop Application'',''Migrate pilot applications to ACME Web Express'',to_date(''12/12/2015'',''MM/DD/YYYY''),to_date(''12/13/2015'''
||',''MM/DD/YYYY''),''Closed'',''Bob Nile'',''1250'',''1500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate Desktop Application'',''Plan migration schedule'',to_date(''12/16/2015'',''MM/DD/YYYY''),to_date(''12/16/2015'',''MM/DD/YYYY''),''Closed'''
||',''Bob Nile'',''600'',''200'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate Desktop Application'',''Migrate desktop applications'',to_date(''01/08/2016'',''MM/DD/YYYY''),to_date(''01/12/2016'',''MM/DD/YYYY''),''Op'
||'en'',''Bob Nile'',''1000'',''8000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate Desktop Application'',''User acceptance testing'',to_date(''01/14/2016'',''MM/DD/YYYY''),to_date(''01/15/2016'',''MM/DD/YYYY''),''Open'','''
||'Bob Nile'',''1500'',''6000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate Desktop Application'',''End-user Training'',to_date(''01/18/2016'',''MM/DD/YYYY''),to_date(''01/19/2016'',''MM/DD/YYYY''),''Open'',''John W'
||'atson'',''0'',''2000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate Desktop Application'',''Post-migration review'',to_date(''02/01/2016'',''MM/DD/YYYY''),to_date(''02/02/2016'',''MM/DD/YYYY''),''Pending'','
||'''Bob Nile'',''100'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Obtain Legacy Server credentials'',to_date(''01/20/2016'',''MM/DD/YYYY''),to_date(''01/20/2016'',''MM/DD/YYYY''),'
||'''Pending'',''James Cassidy'',''0'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Map data usage'',to_date(''01/22/2016'',''MM/DD/YYYY''),to_date(''01/24/2016'',''MM/DD/YYYY''),''Pending'',''Bob Nil'
||'e'',''0'',''8000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Identify integration points'',to_date(''01/25/2016'',''MM/DD/YYYY''),to_date(''01/26/2016'',''MM/DD/YYYY''),''Pend'
||'ing'',''Bob Nile'',''0'',''2000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Create DB Connection to new server'',to_date(''01/25/2016'',''MM/DD/YYYY''),to_date(''01/25/2016'',''MM/DD/YYYY'''
||'),''Pending'',''Scott Spencer'',''0'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Migrate table structures'',to_date(''01/19/2016'',''MM/DD/YYYY''),to_date(''01/20/2016'',''MM/DD/YYYY''),''Pending'
||''',''John Watson'',''0'',''2500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Import data'',to_date(''01/31/2016'',''MM/DD/YYYY''),to_date(''02/01/2016'',''MM/DD/YYYY''),''Pending'',''John Watso'
||'n'',''0'',''1000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Convert processes'',to_date(''01/31/2016'',''MM/DD/YYYY''),to_date(''02/02/2016'',''MM/DD/YYYY''),''Pending'',''Pam '
||'King'',''0'',''3000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Notify users'',to_date(''02/05/2016'',''MM/DD/YYYY''),to_date(''02/05/2016'',''MM/DD/YYYY''),''Pending'',''Bob Nile'''
||',''0'',''200'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Cut over to new database'',to_date(''02/06/2016'',''MM/DD/YYYY''),to_date(''02/06/2016'',''MM/DD/YYYY''),''Pending'
||''',''Bob Nile'',''0'',''1500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Migrate from Legacy Server'',''Decommission Legacy Server'',to_date(''02/20/2016'',''MM/DD/YYYY''),to_date(''02/20/2016'',''MM/DD/YYYY''),''Pendi'
||'ng'',''Al Bines'',''0'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Public Website'',''Determine host server'',to_date(''12/05/2015'',''MM/DD/YYYY''),to_date(''12/05/2015'',''MM/DD/YYYY''),''Closed'',''Tiger Scott'','
||'''200'',''200'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Public Website'',''Check software licenses'',to_date(''12/05/2015'',''MM/DD/YYYY''),to_date(''12/05/2015'',''MM/DD/YYYY''),''Closed'',''Tom Suess'','
||'''100'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Public Website'',''Purchase additional software licenses, if needed'',to_date(''12/06/2015'',''MM/DD/YYYY''),to_date(''12/07/2015'',''MM/DD/YYY'
||'Y''),''On-Hold'',''Al Bines'',''300'',''1000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Public Website'',''Develop web pages'',to_date(''01/01/2016'',''MM/DD/YYYY''),to_date(''01/02/2016'',''MM/DD/YYYY''),''Open'',''Tiger Scott'',''0'',''2'
||'000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Public Website'',''Plan rollout schedule'',to_date(''01/03/2016'',''MM/DD/YYYY''),to_date(''01/03/2016'',''MM/DD/YYYY''),''Open'',''Tom Suess'',''0'','
||'''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Software Project Tracking'',''Conduct project kickoff meeting'',to_date(''12/28/2015'',''MM/DD/YYYY''),to_date(''12/28/2015'',''MM/DD/YYYY''),''C'
||'losed'',''Pam King'',''100'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Software Project Tracking'',''Customize Software Projects software'',to_date(''12/31/2015'',''MM/DD/YYYY''),to_date(''01/01/2016'',''MM/DD/YYYY'
||'''),''Open'',''Tom Suess'',''600'',''1000'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Software Project Tracking'',''Enter base data (Projects, Milestones, etc.)'',to_date(''01/02/2016'',''MM/DD/YYYY''),to_date(''01/02/2016'',''MM'
||'/DD/YYYY''),''Open'',''Tom Suess'',''200'',''200'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Software Project Tracking'',''Load current tasks and enhancements'',to_date(''01/04/2016'',''MM/DD/YYYY''),to_date(''01/04/2016'',''MM/DD/YYYY'''
||'),''Open'',''Tom Suess'',''400'',''500'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Training for ACME Web Express'',''Create training workspace'',to_date(''12/17/2015'',''MM/DD/YYYY''),to_date(''12/18/2015'',''MM/DD/YYYY''),''Clo'
||'sed'',''James Cassidy'',''500'',''700'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Training for ACME Web Express'',''Publish links to self-study courses'',to_date(''12/19/2015'',''MM/DD/YYYY''),to_date(''12/19/2015'',''MM/DD/Y'
||'YYY''),''Closed'',''John Watson'',''100'',''100'');',
'  insert into eba_demo_file_projects (project,task_name,start_date,end_date,status,assigned_to,cost,budget) values (''Training for ACME Web Express'',''Publish development standards'',to_date(''12/19/2015'',''MM/DD/YYYY''),to_date(''12/20/2015'',''MM/DD/YYYY''),'
||'''On-Hold'',''John Watson'',''1000'',''2000'');',
'',
'update EBA_DEMO_FILE_projects',
'set start_date = start_date + (SYSDATE - TO_DATE(''01012016'',''MMDDYYYY''))',
',   end_date = end_date + (SYSDATE - TO_DATE(''01012016'',''MMDDYYYY''));',
'end load_data;',
'end;',
'/',
'show errors',
'',
'begin',
'  EBA_DEMO_FILE_DATA.load_data;',
'end;',
'',
'',
''))
);
wwv_flow_imp_shared.create_install_object(
 p_id=>wwv_flow_imp.id(1702969908151936826)
,p_script_id=>wwv_flow_imp.id(3281800681587204774)
,p_object_owner=>'#OWNER#'
,p_object_type=>'PACKAGE BODY'
,p_object_name=>'EBA_DEMO_FILE_DATA'
);
end;
/
prompt --application/deployment/checks
begin
null;
end;
/
prompt --application/deployment/buildoptions
begin
null;
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
