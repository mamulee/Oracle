--테이블 만들기
CREATE TABLE MEMBER(
        NAME VARCHAR2(10) PRIMARY KEY,
        age NUMBER(3),
        weight NUMBER(3),
        hieght NUMBER(3),
        sex CHAR(3));
--drop table member;

--데이터 삽입
INSERT INTO MEMBER VALUES('유관순',17,50,160,'여');
INSERT INTO MEMBER VALUES('홍길동',20,60,175,'남');
INSERT INTO MEMBER VALUES('이순신',20,60,180,'남');
INSERT INTO MEMBER VALUES('이영미',30,55,165,'여');

--데이터베이스에 확정(저장)

ALTER TABLE MEMBER RENAME COLUMN hieght TO height;

COMMIT;

SELECT * FROM MEMBER;