drop table BBS_RCM cascade constraints;
create table BBS_RCM(
 RCM_NO		number			primary key,
 RCM_ID			varchar2(30)	references member(USER_ID),
 RCM_CONTENT	varchar2(200),
 RCM_REG_DATE	date,
 RCM_COMMENT_BOARD_NUM	number	references BBS_RV(RV_NO) on delete cascade,
 												-- comm ���̺��� �����ϴ� ���� �� ��ȣ
 RCM_COMMENT_RE_LEV number check(RCM_COMMENT_RE_LEV in (0,1,2)), --�����̸� 0 ����̸� 1
 RCM_COMMENT_RE_SEQ number, --�����̸� 0 
 RCM_COMMENT_RE_REF number -- ������ �ڽ� �۹�ȣ , ����̸� ���� �۹�ȣ
);
-- �Խ��� ���� �����Ǹ� �����ϴ� ��۵� �����˴ϴ�. --

drop sequence RCM_SEQ;

-- �������� �����մϴ�.
create sequence RCM_SEQ;

select * from BBS_RCM;

update BBS_RCM 
set RCM_ID= 'ADMIN' ;

UPDATE MEMBER
SET USER_ID = 'ADMIN'


