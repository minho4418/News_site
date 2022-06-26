DROP TABLE member CASCADE CONSTRAINTS;
CREATE TABLE member(
email VARCHAR2(50), --�̸���
passwd VARCHAR2(64) not null, --�н������ȣȭ(bcrypt)
name VARCHAR2(50) not null, --�̸�
simplejoin CHAR(1) DEFAULT '0', --0:�Ϲݰ���, 1:���̹�, 2:īī��,3:����
regidate DATE DEFAULT sysdate, --�������
modidate DATE DEFAULT sysdate, --��������
PRIMARY KEY (email)
);

--�Խù����̺�(board)
--�÷�:bnum(�Խù���ȣ:pk: b_seq(��������)), email(�ۼ���email), subject(����), content(����),
--readcnt(��ȸ��),ip(�ۼ�����ip),likecnt(���ƿ�), dislikecnt(�Ⱦ��), regidate(�������),modidate(��������)
DROP TABLE board CASCADE CONSTRAINTS;
CREATE TABLE board(
bnum NUMBER(5),
email VARCHAR2(50),
subject VARCHAR2(100),
content VARCHAR2(1000),
readcnt NUMBER(5) DEFAULT 0, --��ȸ��
likecnt NUMBER(5) DEFAULT 0, --���ƿ�
dislikecnt NUMBER(5) DEFAULT 0, --�Ⱦ��
ip VARCHAR2(50), --�ۼ�����ip
regidate DATE DEFAULT sysdate, --�ۼ�����
modidate DATE DEFAULT sysdate, --��������,
removeyn CHAR(1) DEFAULT 'n', --��������(y/n) 
PRIMARY KEY (bnum)
);
ALTER TABLE board ADD FOREIGN KEY (email) REFERENCES MEMBER(email); --���̺��� ���� �ٲٱ�

DROP SEQUENCE b_seq;
CREATE SEQUENCE b_seq;

select * from board;
--�Խù��������̺�(boardfile)
--�÷�:bfnum(���Ϲ�ȣ:pk:bf_seq), bnum(�Խù���ȣ:fk), filename(�����̸�)
DROP TABLE boardfile CASCADE CONSTRAINTS;
CREATE TABLE boardfile(
bfnum NUMBER(5),
bnum NUMBER(5),
filename VARCHAR2(50),
PRIMARY KEY(bfnum),
FOREIGN KEY (bnum) REFERENCES board(bnum)
);
DROP SEQUENCE bf_seq;
CREATE SEQUENCE bf_seq;

--������̺�(reply)
--�÷�:rnum(��۹�ȣ:pk: r_seq), bnum(�Խù���ȣ:fk), email(�ۼ���:fk), content(����ǳ���), 
--     ip(�ۼ�����ip), restep(����Ǽ���), relevel(����Ƿ���),  regidate(�������),modidate(��������)
DROP TABLE reply CASCADE CONSTRAINTS;
CREATE TABLE reply(
rnum NUMBER(5), --��۹�ȣ
bnum NUMBER(5), --�Խù���ȣ
email VARCHAR2(50), --�ۼ���
content VARCHAR2(1000), --����ǳ���
ip VARCHAR2(50), --�ۼ�����ip
restep NUMBER(3), --�ۼ���
relevel NUMBER(3), --�۷���
regidate DATE DEFAULT sysdate,
modidate DATE DEFAULT sysdate,
PRIMARY KEY(rnum),
FOREIGN KEY(bnum) REFERENCES board(bnum)
);
ALTER TABLE reply ADD FOREIGN KEY (email) REFERENCES MEMBER(email); --���̺��� ���� �ٲٱ�

DROP SEQUENCE r_seq; 
CREATE SEQUENCE r_seq; 

drop table seoul;
create table seoul(
location varchar2(20)
);
select * from seoul;

insert into seoul(location) values ('�߶���');
--�Խù�---------------------------------------------------------------------------------
--�Խù� �߰�
SELECT b_seq.nextval FROM dual; --�������̺��� �̿��ؼ� bnum�� ���Ѵ�
INSERT INTO board(bnum,email,subject,content,ip)
VALUES (b_seq.nextval, 'hong', '����1', '����1', '192.168.0.10');

--�Խù� ����
UPDATE board
SET email ='',
subject = '',
content ='',
ip = '',
modidate = sysdate
WHERE bnum = 1;

--�Խù� ����
DELETE FROM board
WHERE bnum = 1;

--�Խù� �����ʵ� ����(y)
UPDATE board
SET removeyn = 'y'
WHERE bnum = 172;

--�Խù� �Ѱ���ȸ
SELECT  * FROM board
WHERE bnum = 80;

--�Խù� ����Ʈ
SELECT  * FROM board
WHERE subject LIKE '%' || '��' ||'%'
OR content LIKE '%' || '��' ||'%';

--�Խù� ��ȸ��+1
UPDATE board
SET readcnt = readcnt +1
WHERE bnum = 6;

--�Խù� ���ƿ�+1
UPDATE board
SET likecnt = likecnt +1
WHERE bnum = 1;



SELECT  * FROM board order by bnum desc;

--�Խù� ����Ʈ
SELECT * 
FROM(SELECT ROWNUM rnum, b.* 
           FROM(SELECT * FROM board
                    WHERE removeyn = 'n'
                     AND (email LIKE '%' || '' || '%'
                       OR content LIKE '%' || '' ||'%')
                     ORDER BY bnum DESC) b)
WHERE rnum BETWEEN 1 AND 10;                      


--��ü�Խù���
SELECT COUNT(*) totalCnt FROM board
WHERE email LIKE '%' || 'java' || '%';

-----------------------------------------------------------------------------------
--�Խù� ����
--�Խù� ���� �߰�
INSERT INTO boardfile(bfnum, bnum, filename)
VALUES(bf_seq.nextval, 1, 'a.png');
--�Խù� ���� ����
UPDATE boardfile
SET filename = 'b.png'
WHERE bfnum = 1;

--�Խù� ���� �Ѱǻ���
DELETE FROM boardfile
WHERE bfnum = 1;

--bnum�� ���ϵ� ����
DELETE FROM boardfile
WHERE bnum = 1;

--�Խù� ���� �Ѱ���ȸ
SELECT * FROM boardfile
WHERE bfnum = 1;
--�Խù� ���� ����Ʈ
SELECT * FROM boardfile
WHERE bnum = 3;
---------------------------------------------------------------------------------------
--����߰�
INSERT INTO reply(rnum, bnum ,email, content, ip, restep, relevel)
VALUES(r_seq.nextval,8, 'java@gmail.com', '���1','192.168.0.1', 1,1);

--��ۼ���
UPDATE reply
SET content='��ۼ���',
ip = '192.168.0.100',
modidate = sysdate
WHERE rnum = 2;

--�ۼ����� �����(restep+1)
UPDATE reply
SET restep= restep+1
WHERE bnum = 169
AND restep >= 1;

--��ۻ���
DELETE FROM reply
WHERE rnum = 1;

--�Խù��Ѱ��� ��� ��� ����
DELETE FROM reply
WHERE bnum = 1;

--��� �Ѱ� ��ȸ
SELECT * FROM reply
WHERE rnum = 1;

--��۸���Ʈ(�Խù��� ���, restep: ����)
SELECT * FROM reply
WHERE bnum = 10
ORDER BY restep;

rollback;

---------------------------------------------------------------------------------------
--�Խù������� �߰� �͸� ���ν���
BEGIN
    FOR i IN 1..55 LOOP
        INSERT INTO board(bnum,email,subject,content,ip)
        VALUES (b_seq.nextval, 'kim', '����3', '����3', '192.168.0.10');
    END LOOP;
END;


COMMIT;
rollback;
