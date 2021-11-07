drop table member cascade constraints;

drop table member;

create table MEMBER(
USER_ID		varchar2(20) not null,
USER_PASS	varchar2(20) not null,
USER_NAME	varchar2(20) not null,
USER_BIRTH	varchar2(20) not null,
USER_PHONE	varchar2(20) not null,
USER_EMAIL	varchar2(30) not null,
USER_FILE	varchar2(50) ,
primary key(USER_ID)
);

select * from member;

drop table member cascade constraints;
insert into member values('admin', '1234', '°ü¸®ÀÚ', '4/30','010-6322-4825','ja97324@hanmail.net','image')