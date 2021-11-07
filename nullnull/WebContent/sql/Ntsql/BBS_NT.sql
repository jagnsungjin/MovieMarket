drop table bbs_nt;

create table bbs_nt(
nt_no		number			not null,
nt_pass		varchar2(20)	not null,
nt_subject 	varchar2(40)	not null,
user_id		varchar2(20)	not null,
nt_date		date			not null,
nt_read		number			not null,
nt_content	varchar2(4000),
nt_file		varchar2(50),
primary key(nt_no),
foreign key(user_id) references member
);

alter table bbs_nt 
drop column nt_fix;

alter table bbs_nt
add nt_fix number(1) default 0;

select * from bbs_nt;

select count(*) from bbs_nt

delete from bbs_nt;


							 
insert into member values('user1', '1234', '»ç¿ëÀÚ', '4/30','010-6322-4825','ja97324@hanmail.net','image');
						
						
					

