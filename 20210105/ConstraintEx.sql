-- 데이터 무결성 제약 조건
-- Data Integrity Constraint Rule

DESC user_constraints;
SELECT constraint_name, constraint_type, table_name FROM user_constraints;

CREATE TABLE emp03 (
    empno NUMBER(4) UNIQUE,
    ename VARCHAR2(10) NOT NULL,
    JOB VARCHAR2 (9),
    hiredate DATE,
    deptno NUMBER(2));
    
SELECT * FROM user_constraints WHERE table_name = 'EMP03';

ALTER TABLE emp03 DROP COLUMN hiredate;

SELECT * FROM emp03;

INSERT INTO emp03 VALUES(1010, '홍길동', '사원', 10);
INSERT INTO emp03 VALUES(1010, NULL, '사원', 10); -- 안 됨

-- 제약조건 이름 명시
CREATE TABLE emp04 (
    empno NUMBER(4)
        CONSTRAINT EMP04_EMPNO_UK UNIQUE,
    ename VARCHAR2(10)
        CONSTRAINT EMP04_ENAME_NN NOT NULL,
    job VARCHAR2(9),
    deptno NUMBER(2)
    );

-- 제약 조건 걸린 COLUMN 다 보기
SELECT * FROM user_cons_columns;

-- CHECK
CREATE TABLE emp07 (
    EMPNO NUMBER(4)
        CONSTRAINT EMP07_EMPNO_PK PRIMARY KEY,
    ENMAE VARCHAR2(10) 
        CONSTRAINT EMP07_ENAME_NN NOT NULL,
    SAL NUMBER(7,2) 
        CONSTRAINT EMP07_SAL_CK 
        CHECK (SAL BETWEEN 500 AND 5000),
    GENDER VARCHAR2(1) 
        CONSTRAINT EMP08_GENDER_CK 
        CHECK (GENDER IN ('M', 'm', 'F', 'f'))
);  

INSERT INTO emp07 VALUES (1010, '홍길동', 1000, 'm');

-- DEFAULT
CREATE TABLE dept05 (
        deptno NUMBER(2) primary key,
        dname VARCHAR2(14),
        loc VARCHAR2(13) DEFAULT '서울'
        );

INSERT INTO dept05 VALUES (10, '인사부', '');
INSERT INTO dept05 (deptno, dname) VALUES(20, '생산부');
SELECT * FROM dept05;

-- 테이블 레벨 방식
CREATE TABLE emp08 (
    empno NUMBER(4),
    ename VARCHAR2(10) NOT NULL,
    JOB VARCHAR2 (9),
    deptno NUMBER(2),
    
    PRIMARY KEY (empno),--constraint emp08_empno_pk는 생략가능함
    UNIQUE(JOB),
    FOREIGN KEY (deptno) REFERENCES dept01(deptno));
    
SELECT * FROM dept01;
ALTER TABLE dept01
    MODIFY deptno CONSTRAINT dept01_deptno_PK PRIMARY KEY;
    
-- 복합키 지정
create table member01 (
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    constraint member01_name_phone_pk primary key (name, phone) );

INSERT INTO member01 VALUES ('a', '홍길동', '123');
INSERT INTO member01 VALUES ('a', '홍길동', '1234');
INSERT INTO member01 VALUES ('123', '홍길동', 'a');
