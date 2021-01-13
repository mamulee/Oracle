-- Sequence
CREATE Sequence dept_deptno_seq
    START WITH 10
    INCREMENT BY 10;

desc user_sequences;

SELECT * FROM user_sequences WHERE sequence_name IN ('DEPT_DEPTNO_SEQ');

SELECT dept_deptno_seq.nextVal FROM dual;

SELECT dept_deptno_seq.currVal FROM dual;

CREATE SEQUENCE sample_seq;

SELECT sample_seq.currVal FROM dual;

CREATE SEQUENCE sample_seq1 start with 1;
SELECT sample_seq1.currVal FROM dual;

DROP table emp01;
CREATE TABLE emp01 (
    empno number(4) primary key,
    ename varchar(10),
    hiredate date
    );

CREATE SEQUENCE emp_seq;
INSERT INTO emp01 VALUES (emp_seq.NEXTVAL, '홍길동', sysdate);

SELECT * FROM emp01;

DROP SEQUENCE emp_seq1;
CREATE SEQUENCE emp_seq1 START WITH 1010 INCREMENT BY 10 MAXVALUE 1500;
INSERT INTO emp01 VALUES (emp_seq1.NEXTVAL, '아무개', sysdate);

ALTER SEQUENCE emp_seq
    INCREMENT BY 100
    MAXVALUE 1600
    CYCLE
    CACHE 18;
    
INSERT INTO emp01 VALUES (emp_seq.NEXTVAL, '아무개', sysdate);