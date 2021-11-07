drop table BBS_RCM cascade constraints;
create table BBS_RCM(
 RCM_NO		number			primary key,
 RCM_ID			varchar2(30)	references member(USER_ID),
 RCM_CONTENT	varchar2(200),
 RCM_REG_DATE	date,
 RCM_COMMENT_BOARD_NUM	number	references BBS_RV(RV_NO) on delete cascade,
 												-- comm 테이블이 참조하는 보드 글 번호
 RCM_COMMENT_RE_LEV number check(RCM_COMMENT_RE_LEV in (0,1,2)), --원문이면 0 답글이면 1
 RCM_COMMENT_RE_SEQ number, --원문이면 0 
 RCM_COMMENT_RE_REF number -- 원문은 자신 글번호 , 답글이면 원문 글번호
);
-- 게시판 글이 삭제되면 참조하는 댓글도 삭제됩니다. --

drop sequence RCM_SEQ;

-- 시퀀스를 생성합니다.
create sequence RCM_SEQ;

select * from BBS_RCM;

update BBS_RCM 
set RCM_ID= 'ADMIN' ;

UPDATE MEMBER
SET USER_ID = 'ADMIN'


