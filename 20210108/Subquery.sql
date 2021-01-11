CREATE TABLE dept02
AS
SELECT * FROM dept WHERE loc='a';

INSERT INTO dept02 VALUES (50, '보안부', '서울');
--insert도 서브쿼리가 가능하다. 
INSERT INTO dept02 SELECT * FROM dept;

SELECT * FROM dept02;

ALTER TABLE dept02
    ADD memo VARCHAR2(10);

DESC dept02;
DESC dept;

INSERT INTO dept02 SELECT * FROM dept; --두 테이블의 구조가 다르므로 insert 할수가 없다. 

CREATE TABLE dept03 (
    deptno01 NUMBER(2),
    dname VARCHAR2(14),
    locl VARCHAR2(13));
    
INSERT INTO dept03 SELECT * FROM dept;-- dept03과 dept 의 구조가 같으므로 모든 정보가 insert로 복사가 된다. 

--두개 테이블의 구조가 다르면 1. 적으면 dept04 2. 많으면 dept05
--1. 컬럼이 적은 경우 
CREATE TABLE dept04 (
    deptno NUMBER(2),
    dname VARCHAR2(14));

INSERT INTO dept04 SELECT * FROM dept; -- 안 됨

--2. 커럼이 많은 경우

CREATE TABLE dept05 (
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    phone NUMBER(11));

INSERT INTO dept05 SELECT * FROM dept; -- 안 됨

--3. 두개 테이블의 구조순서가 다를 경우

CREATE TABLE dept06 (
    loc VARCHAR2(13),
    dname VARCHAR2(14),
    deptno NUMBER(2));

INSERT INTO dept06 SELECT * FROM dept;

INSERT INTO dept01 SELECT * FROM dept;

SELECT * FROM dept03;

SELECT * FROM dept03 WHERE deptno01=20;

DROP TABLE dept03;
CREATE TABLE dept03
AS
SELECT * FROM dept;

-- 20번 부서 지역명 40번 부서의 지역명으로 바꾸기
-- 그냥 바로 집어넣기
UPDATE dept03 SET loc ='인천' WHERE deptno=20;

SELECT * FROM dept;
SELECT * FROM dept03;

-- 서브 쿼리 이용해서 하기
UPDATE dept03 SET loc = (SELECT loc FROM dept03 WHERE deptno=40) WHERE deptno=20;










    