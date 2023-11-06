create or replace package app_setting as

c_data_type_build_option    constant varchar2(20)   := 'BUILD_OPTION';
c_data_type_clob            constant varchar2(20)   := 'CLOB';
c_data_type_clob_json       constant varchar2(20)   := 'CLOB_JSON';
c_data_type_integer         constant varchar2(20)   := 'INTEGER';
c_data_type_json            constant varchar2(20)   := 'JSON';
c_data_type_string          constant varchar2(20)   := 'STRING';
c_data_type_yn              constant varchar2(20)   := 'YN';


procedure populate_settings;


end app_setting;
/