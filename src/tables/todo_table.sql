prompt create table CHANGE_ME
begin
    execute immediate q'!
create table CHANGE_ME (
    id number default on null to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),
    -- ...
    -- ADDITIONAL_COLUMNS
    -- ...
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
        dbms_output.put_line('info: CHANGE_ME already exists');
    else
        raise;
    end if;
end;
/

prompt alter table CHANGE_ME add constraint CHANGE_ME_pk
begin
    execute immediate q'!alter table CHANGE_ME add constraint CHANGE_ME_pk primary key (PK_COLUMN)!';
exception when others then
    if sqlcode = -2260 then -- ORA-02260: table can have only one primary key
        dbms_output.put_line('info: CHANGE_ME_pk primary key already exists');
    else
        raise;
    end if;
end;
/

prompt alter table CHANGE_ME add constraint CHANGE_ME_uqCONSTRAINT_NUM
begin
    execute immediate 'alter table CHANGE_ME add constraint CHANGE_ME_uqCONSTRAINT_NUM unique(COLUMNS)';
exception when others then
    if sqlcode = -2261 then -- ORA-02261: such unique or primary key already exists in the table
        dbms_output.put_line('info: CHANGE_ME_uqCONSTRAINT_NUM already exists');
    else
        raise;
    end if;
end;
/

prompt alter table CHANGE_ME add constraint CHANGE_ME_ckCONSTRAINT_NUM
begin
    execute immediate q'!
        alter table CHANGE_ME add constraint CHANGE_ME_ckCONSTRAINT_NUM
        check(CONSTRAINT_CODE)
    !';
exception when others then
    if sqlcode = -2264 then -- ORA-02264: name already used by an existing constraint
        dbms_output.put_line('info: CHANGE_ME_ckCONSTRAINT_NUM already exists');
    else
        raise;
    end if;
end;
/


prompt alter table CHANGE_ME add constraint CHANGE_ME_fkCONSTRAINT_NUM
begin
    execute immediate 'alter table CHANGE_ME add constraint CHANGE_ME_fkCONSTRAINT_NUM foreign key (COLUMNS) references FK_TABLE(FK_TABLE_COLUMNS)';
exception when others then
    if sqlcode = -2275 then -- ORA-02275: such a referential constraint already exists in the table
        dbms_output.put_line('info: CHANGE_ME_fkCONSTRAINT_NUM already exists');
    else
        raise;
    end if;
end;
/

prompt create UNIQUE index CHANGE_ME_idxINDEX_NUM
begin
    execute immediate q'!create UNIQUE index CHANGE_ME_idxINDEX_NUM on CHANGE_ME(COLUMNS)!';
exception when others then
    if sqlcode = -955 then -- ORA-00955: name is already used by an existing object
        dbms_output.put_line('info: CHANGE_ME_idxINDEX_NUM already exists');
    else
        raise;
    end if;
end;
/