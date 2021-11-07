drop table member;

create table member(
user_id		varchar2(20) not null,
user_pass	varchar2(20) not null,
user_name	varchar2(20) not null,
user_birth	varchar2(20) not null,
user_phone	varchar2(20) not null,
user_email	varchar2(30) not null,
user_file	varchar2(50) not null,
primary key(user_id)
);

select * from member;

