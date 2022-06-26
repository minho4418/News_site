drop table tourism;
CREATE TABLE tourism(
tnum NUMBER(7), --번호
tname VARCHAR2(300) , --상호
taddress VARCHAR2(300), --주소
taddress_new VARCHAR2(300), --신주소
phone VARCHAR2(300), --전화번호
site VARCHAR2(300), --웹사이트
use_time VARCHAR2(1024), --운영시간
bsnde VARCHAR2(300), --운영요일
rstde VARCHAR2(300), --휴무일
subway_info VARCHAR2(300), --교통정보
tag VARCHAR2(300), --태그
BF_DESC VARCHAR2(300) --장애인편의시설
);

select * from tourism;

commit;

create table test(

);

SELECT  * FROM tourism
		WHERE tnum = 6668;

SELECT COUNT(*) totalCnt FROM tourism;