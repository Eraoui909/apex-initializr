prompt app_qa_questions
create table app_qa_questions (
    app_qa_questions_id    number generated always as identity not null,
    app_qa_questions_code  varchar2(30) not null,
    app_qa_questions_name  varchar2(30) not null,
    app_qa_questions_seq   number not null,
    created_on      date default sysdate not null,
    created_by      varchar2(255 byte) default
    coalesce(
        sys_context('APEX$SESSION','app_user'),
        regexp_substr(sys_context('userenv','client_identifier'),'^[^:]*'),
        sys_context('userenv','session_user')
    )               not null,
    updated_on      date,
    updated_by      varchar2(255 byte)
);

comment on table app_qa_questions is 'CHANGEME';
comment on column app_qa_questions.CHANGEME is 'CHANGEME';

alter table app_qa_questions 
add constraint app_qa_questions_pk 
primary key (app_qa_questions_id);

alter table app_qa_questions 
add constraint app_qa_questions_uk1 
unique(app_qa_questions_code);

alter table app_qa_questions 
add constraint app_qa_questions_ck1 
check(app_qa_questions_code = trim(upper(app_qa_questions_code)));

alter table app_qa_questions 
add constraint app_qa_questions_ck2 
check(app_qa_questions_seq = trunc(app_qa_questions_seq));

alter table app_qa_questions 
add constraint app_qa_questions_fk1 
foreign key (changeme) 
references changeme_dest(changeme);

create index app_qa_questions_idx1 
on app_qa_questions(changeme);