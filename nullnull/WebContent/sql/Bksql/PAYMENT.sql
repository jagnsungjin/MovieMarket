CREATE TABLE CINEMA(
	CINEMA_NO		NUMBER,
	CINEMA_NAME		VARCHAR2(20) NOT NULL, 
	CINEMA_PLACE		VARCHAR2(30) NOT NULL,
	PRIMARY KEY(CINEMA_PLACE)
	);
	
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGV�б���');
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGV����');
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGVû�㾾�׽�Ƽ');
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGVõȣ');
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGV�̾�');
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGV����');
	
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGV�ϻ�');
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGVȭ��');
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGV������');
	
	insert into CINEMA values(CINEMA_SEQ.NEXTVAL,'CGV','CGV����');
	
	SELECT *FROM CINEMA
drop sequence CINEMA_SEQ;
	
--�������� �����մϴ�.
create sequence CINEMA_SEQ;
	
	select *from CINEMA
	delete from CINEMA 
	drop table CINEMA

CREATE TABLE PAYMENT(
	PAY_NO NUMBER,
	USER_ID VARCHAR2(20) NOT NULL REFERENCES member(USER_ID) ON DELETE CASCADE,
	PAY_NAME VARCHAR2(50) NOT NULL,
	CINEMA_PLACE VARCHAR2(30) NOT NULL REFERENCES CINEMA(CINEMA_PLACE) ON DELETE CASCADE,
	PAY_DATE VARCHAR2(40) NOT NULL,
	PAY_TIME VARCHAR2(30) NOT NULL,
	PAY_COUNT VARCHAR2(10) NOT NULL,
	PAY_SEAT VARCHAR2(40) NOT NULL,
	PRIMARY KEY(PAY_NO)
	);
	
	

	drop sequence PAYMENT_SEQ;
	
--�������� �����մϴ�.
	create sequence PAYMENT_SEQ;
	
	select *from PAYMENT
	delete from PAYMENT 
	drop table PAYMENT
	
	insert into PAYMENT();
insert into BBS_BK(BK_NO, BK_PASS, BK_CSFC, BK_SUBJECT,
BK_PRICE, USER_ID, BK_DATE, BK_READ, BK_CONTENT, BK_FILE, BK_RE_REF, BK_RE_LEV, BK_RE_SEQ)
					 values(bk_seq.NEXTVAL,'123','�Ⱦƿ�','����',
					6000,'admin',SYSDATE,
							0,'����','����',
							bk_seq.NEXTVAL,0,0);
							
							
	 

	 