drop table tourism;
CREATE TABLE tourism(
tnum NUMBER(7), --��ȣ
tname VARCHAR2(300) , --��ȣ
taddress VARCHAR2(300), --�ּ�
taddress_new VARCHAR2(300), --���ּ�
phone VARCHAR2(300), --��ȭ��ȣ
site VARCHAR2(300), --������Ʈ
use_time VARCHAR2(1024), --��ð�
bsnde VARCHAR2(300), --�����
rstde VARCHAR2(300), --�޹���
subway_info VARCHAR2(300), --��������
tag VARCHAR2(300), --�±�
BF_DESC VARCHAR2(300) --��������ǽü�
);

select * from tourism;

commit;

create table test(

);

SELECT  * FROM tourism
		WHERE tnum = 6668;

SELECT COUNT(*) totalCnt FROM tourism;