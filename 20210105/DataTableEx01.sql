CREATE TABLE dept01 (
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR(13)
    );

    
INSERT INTO dept01 (deptno, dname, loc) VALUES (10, '경리부', '서울');
INSERT INTO dept01 (deptno, loc, dname) VALUES (20, '인천', '인사부');
-- 생략하면 원래 순서대로
INSERT INTO dept01 VALUES (30, '영업부', '부산');


SELECT * FROM dept01;

INSERT INTO dept01 VALUES (40, '인사부', NULL);
INSERT INTO dept01 VALUES (50, '인사부', '');

CREATE TABLE emp02 (
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    hiredate date,
    deptno number(2)
    );
    
INSERT INTO emp02 VALUES (1001, '김사랑', '사원', '10/JAN/2021', 20);
INSERT INTO emp02 VALUES (1002, '한예슬', '대리', to_date('2021/01/10', 'YYYY/MM/DD'), 10);

SELECT * FROM emp02;

INSERT INTO emp02 VALUES (1003, '최경희', '사원', SYSDATE, 30);

-- 데이터 수정하기 UPDATE
UPDATE dept01
    SET dname = '생산부'
    WHERE deptno = 10;
    
UPDATE dept01
    SET dname = '총무부'
    WHERE deptno = 50;

UPDATE dept01
    SET loc = '서울';

COMMIT;

-- 커밋 지점으로 복원
ROLLBACK;

-- 삭제
DELETE FROM dept01 WHERE deptno = 50;
SELECT * FROM dept01;

------------------------------------
-- DML 예제

CREATE TABLE employee03 (
    empno NUMBER(4) NOT NULL,
    ename VARCHAR2(20),
    job VARCHAR2(20),
    SAL NUMBER(7,3)
    );
    
INSERT INTO employee03 VALUES(1000, '홍길동', '사원', 100);
INSERT INTO employee03 VALUES(1010, '이순신', '대리', 150);
INSERT INTO employee03 VALUES(1020, '홍명진', '과장', 200);
INSERT INTO employee03 VALUES(1030, '박경미', '대리', 150);
INSERT INTO employee03 VALUES(1040, '김병진', '', 50);
INSERT INTO employee03 VALUES(1050, '박인수', '', 35);

COMMIT;
SELECT * FROM employee03;

UPDATE employee03
    SET sal = sal + 50
    WHERE sal < 200;

DELETE FROM employee03 WHERE job IS NULL;
