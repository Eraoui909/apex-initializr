prompt create table app_settings
begin
    execute immediate q'!
create table app_settings (
    id number default on null to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
    setting_code                varchar2(50)    not null,
    setting_name                varchar2(60)    not null,
    data_type                   varchar2(15)    not null,
    build_option_name           varchar2(20),
    editable_yn                 varchar2(1),
    default_value               varchar2(4000),
    custom_value                varchar2(4000),
    default_value_clob          clob,
    custom_value_clob           clob,
    json_merge_default_yn       varchar2(1)     default on null 'N',
    setting_desc                varchar2(4000),
    developer_desc              varchar2(4000),
    row_version number default on null 1,
    created timestamp (6) with local time zone default on null localtimestamp, 
    created_by varchar2(255) default on null
        coalesce(
            sys_context('APEX$SESSION','app_user'),
            regexp_substr(sys_context('userenv','client_identifier'),'^[^:]*'),
            sys_context('userenv','session_user')
        )
    ,
    updated timestamp (6) with local time zone default on null localtimestamp,
    updated_by varchar2(255) default on null
        coalesce(
            sys_context('APEX$SESSION','app_user'),
            regexp_substr(sys_context('userenv','client_identifier'),'^[^:]*'),
            sys_context('userenv','session_user')
        )
)
!';
exception when others then
    if sqlcode = -955 then -- ORA-00955: name is already used by an existing object
        dbms_output.put_line('info: app_settings already exists');
    else
        raise;
    end if;
end;
/

prompt alter table app_settings add constraint app_settings_pk
begin
    execute immediate q'!alter table app_settings add constraint app_settings_pk primary key (id)!';
exception when others then
    if sqlcode = -2260 then -- ORA-02260: table can have only one primary key
        dbms_output.put_line('info: app_settings_pk primary key already exists');
    else
        raise;
    end if;
end;
/


prompt alter table app_settings add constraint app_settings_ck1
begin
    execute immediate q'!
        alter table app_settings add constraint app_settings_ck1
        check(data_type in (
            'BUILD_OPTION',
            'CLOB',
            'CLOB_JSON',
            'INTEGER',
            'JSON',
            'STRING',
            'YN'
        ))
    !';
exception when others then
    if sqlcode = -2264 then -- ORA-02264: name already used by an existing constraint
        dbms_output.put_line('info: app_settings_ck1 already exists');
    else
        raise;
    end if;
end;
/

prompt alter table app_settings add constraint app_settings_ck2
begin
    execute immediate q'!
        alter table app_settings add constraint app_settings_ck2
        check(editable_yn in (
            'Y',
            'N'
        ))
    !';
exception when others then
    if sqlcode = -2264 then -- ORA-02264: name already used by an existing constraint
        dbms_output.put_line('info: app_settings_ck2 already exists');
    else
        raise;
    end if;
end;
/

prompt alter table app_settings add constraint app_settings_ck3
begin
    execute immediate q'!
        alter table app_settings add constraint app_settings_ck3
        check(json_merge_default_yn in (
            'Y',
            'N'
        ))
    !';
exception when others then
    if sqlcode = -2264 then -- ORA-02264: name already used by an existing constraint
        dbms_output.put_line('info: app_settings_ck3 already exists');
    else
        raise;
    end if;
end;
/
