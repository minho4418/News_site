DROP TABLE member CASCADE CONSTRAINTS;
CREATE TABLE member(
email VARCHAR2(50), --이메일
passwd VARCHAR2(64) not null, --패스워드암호화(bcrypt)
name VARCHAR2(50) not null, --이름
simplejoin CHAR(1) DEFAULT '0', --0:일반가입, 1:네이버, 2:카카오,3:구글
regidate DATE DEFAULT sysdate, --등록일자
modidate DATE DEFAULT sysdate, --수정일자
PRIMARY KEY (email)
);

--게시물테이블(board)
--컬럼:bnum(게시물번호:pk: b_seq(시퀀스명)), email(작성자email), subject(제목), content(내용),
--readcnt(조회수),ip(작성자의ip),likecnt(좋아요), dislikecnt(싫어요), regidate(등록일자),modidate(수정일자)
DROP TABLE board CASCADE CONSTRAINTS;
CREATE TABLE board(
bnum NUMBER(5),
email VARCHAR2(50),
subject VARCHAR2(100),
content VARCHAR2(1000),
readcnt NUMBER(5) DEFAULT 0, --조회수
likecnt NUMBER(5) DEFAULT 0, --좋아요
dislikecnt NUMBER(5) DEFAULT 0, --싫어요
ip VARCHAR2(50), --작성자의ip
regidate DATE DEFAULT sysdate, --작성일자
modidate DATE DEFAULT sysdate, --수정일자,
removeyn CHAR(1) DEFAULT 'n', --삭제여부(y/n) 
PRIMARY KEY (bnum)
);
ALTER TABLE board ADD FOREIGN KEY (email) REFERENCES MEMBER(email); --테이블의 구조 바꾸기

DROP SEQUENCE b_seq;
CREATE SEQUENCE b_seq;

select * from board;
--게시물파일테이블(boardfile)
--컬럼:bfnum(파일번호:pk:bf_seq), bnum(게시물번호:fk), filename(파일이름)
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

--댓글테이블(reply)
--컬럼:rnum(댓글번호:pk: r_seq), bnum(게시물번호:fk), email(작성자:fk), content(댓글의내용), 
--     ip(작성자의ip), restep(댓글의순서), relevel(댓글의레벨),  regidate(등록일자),modidate(수정일자)
DROP TABLE reply CASCADE CONSTRAINTS;
CREATE TABLE reply(
rnum NUMBER(5), --댓글번호
bnum NUMBER(5), --게시물번호
email VARCHAR2(50), --작성자
content VARCHAR2(1000), --댓글의내용
ip VARCHAR2(50), --작성자의ip
restep NUMBER(3), --글순서
relevel NUMBER(3), --글레벨
regidate DATE DEFAULT sysdate,
modidate DATE DEFAULT sysdate,
PRIMARY KEY(rnum),
FOREIGN KEY(bnum) REFERENCES board(bnum)
);
ALTER TABLE reply ADD FOREIGN KEY (email) REFERENCES MEMBER(email); --테이블의 구조 바꾸기

DROP SEQUENCE r_seq; 
CREATE SEQUENCE r_seq; 

drop table seoul;
create table seoul(
location varchar2(20)
);
select * from seoul;

insert into seoul(location) values ('중랑구');
--게시물---------------------------------------------------------------------------------
--게시물 추가
SELECT b_seq.nextval FROM dual; --더미테이블을 이용해서 bnum을 구한다
INSERT INTO board(bnum,email,subject,content,ip)
VALUES (b_seq.nextval, 'hong', '제목1', '내용1', '192.168.0.10');

--게시물 수정
UPDATE board
SET email ='',
subject = '',
content ='',
ip = '',
modidate = sysdate
WHERE bnum = 1;

--게시물 삭제
DELETE FROM board
WHERE bnum = 1;

--게시물 삭제필드 변경(y)
UPDATE board
SET removeyn = 'y'
WHERE bnum = 172;

--게시물 한건조회
SELECT  * FROM board
WHERE bnum = 80;

--게시물 리스트
SELECT  * FROM board
WHERE subject LIKE '%' || '게' ||'%'
OR content LIKE '%' || '게' ||'%';

--게시물 조회수+1
UPDATE board
SET readcnt = readcnt +1
WHERE bnum = 6;

--게시물 좋아요+1
UPDATE board
SET likecnt = likecnt +1
WHERE bnum = 1;



SELECT  * FROM board order by bnum desc;

--게시물 리스트
SELECT * 
FROM(SELECT ROWNUM rnum, b.* 
           FROM(SELECT * FROM board
                    WHERE removeyn = 'n'
                     AND (email LIKE '%' || '' || '%'
                       OR content LIKE '%' || '' ||'%')
                     ORDER BY bnum DESC) b)
WHERE rnum BETWEEN 1 AND 10;                      


--전체게시물수
SELECT COUNT(*) totalCnt FROM board
WHERE email LIKE '%' || 'java' || '%';

-----------------------------------------------------------------------------------
--게시물 파일
--게시물 파일 추가
INSERT INTO boardfile(bfnum, bnum, filename)
VALUES(bf_seq.nextval, 1, 'a.png');
--게시물 파일 수정
UPDATE boardfile
SET filename = 'b.png'
WHERE bfnum = 1;

--게시물 파일 한건삭제
DELETE FROM boardfile
WHERE bfnum = 1;

--bnum의 파일들 삭제
DELETE FROM boardfile
WHERE bnum = 1;

--게시물 파일 한건조회
SELECT * FROM boardfile
WHERE bfnum = 1;
--게시물 파일 리스트
SELECT * FROM boardfile
WHERE bnum = 3;
---------------------------------------------------------------------------------------
--댓글추가
INSERT INTO reply(rnum, bnum ,email, content, ip, restep, relevel)
VALUES(r_seq.nextval,8, 'java@gmail.com', '댓글1','192.168.0.1', 1,1);

--댓글수정
UPDATE reply
SET content='댓글수정',
ip = '192.168.0.100',
modidate = sysdate
WHERE rnum = 2;

--글순서를 재수정(restep+1)
UPDATE reply
SET restep= restep+1
WHERE bnum = 169
AND restep >= 1;

--댓글삭제
DELETE FROM reply
WHERE rnum = 1;

--게시물한건의 모든 댓글 삭제
DELETE FROM reply
WHERE bnum = 1;

--댓글 한건 조회
SELECT * FROM reply
WHERE rnum = 1;

--댓글리스트(게시물의 댓글, restep: 순서)
SELECT * FROM reply
WHERE bnum = 10
ORDER BY restep;

rollback;

---------------------------------------------------------------------------------------
--게시물데이터 추가 익명 프로시저
BEGIN
    FOR i IN 1..55 LOOP
        INSERT INTO board(bnum,email,subject,content,ip)
        VALUES (b_seq.nextval, 'kim', '제목3', '내용3', '192.168.0.10');
    END LOOP;
END;


COMMIT;
rollback;
