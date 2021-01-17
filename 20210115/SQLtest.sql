-- SQL 활용 시험
-- 1
SELECT max(sal+NVL(comm, 0)) AS max, min(sal+NVL(comm, 0)) AS min, 
    round(avg(sal+NVL(comm, 0)), 1) AS avg
    FROM EMP
    WHERE job = '사원' ;

-- 2
INSERT INTO emp (empno, deptno, ename, sal) VALUES (1000, 10, '이경자', 3000);
INSERT INTO emp (empno, deptno, ename, sal) VALUES (2000, 10, '최병민', 4000);

SELECT * FROM emp;

-- 3
UPDATE emp
SET sal = sal * 1.1;

-- 4
-- Commit은 모든 작업들을 정상적으로 처리하겠다고 확정하는 명령어
-- Rollaback은 작업 중 문제가 발생하여서 트랜잭션의 처리 과정에서 발생한 변경 사항을 취소하는 명령어

-- 5
--데이터 무결성 제약조건이란 테이블에 부적절한 자료가 입력되는 것을 방지하기 위해서 테이블을 생성할 때
--각 컬럼에 대해서 정의하는 여러가지 규칙을 말합니다.
--그 종류에는 5가지가 있습니다. 
--1. NOT NULL : COLUME의 NULL을 허용하지 않는다.
--2. UNIQUE : 중복된 값을 허용하지 않는다. 즉 항상 유일한 값을 갖도록 한다.
--3. PRIMARY KEY :  NULL을 허용하지 않고 중복된 값을 허용하지 않는다.
--                  NOT NULL 조건과 UNIQUE 조건을 결합한 것.
--4. FOREIGN KEY :  참조되는 테이블의 컬럽의 값이 존재하면 허용한다는 의미다.
--5. CHECK : 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값만을 허용한다.

-- 6
CREATE TABLE department_test (
    deptno NUMBER(4) PRIMARY KEY,
    dname VARCHAR2(10),
    tel VARCHAR2(10)
    );
    
CREATE TABLE professor_test (
    profno NUMBER(4) PRIMARY KEY,
    deptno NUMBER(4),
    subjectno NUMBER(4),
    id VARCHAR2(13),
    address VARCHAR2(20),
    name VARCHAR2(10),
    tel VARCHAR2(11),
    email VARCHAR2(20),
    photo VARCHAR2(20),
    CONSTRAINT prof_dept_FK FOREIGN KEY (deptno) REFERENCES department_test(deptno)
    );

CREATE TABLE student_test(
   stdno NUMBER(3) PRIMARY KEY,
   profno number(3),
   deptno number(3),
   subjectno number(3),
   name varchar2(20),
   id varchar2(20),
   grade varchar2(20),
   address varchar2(20),
   tel varchar2(20),
   email varchar2(20),
   photo varchar2(20),
   FOREIGN KEY (profno) REFERENCES professor_test(profno),
   FOREIGN KEY (deptno) REFERENCES department_test(deptno)
);


-- 7
SELECT ename, sal FROM emp WHERE deptno = (
    SELECT deptno FROM dept WHERE dname = '영업부'
    );

-- 8
SELECT e.ename, e.hiredate, d.dname 
    FROM emp e JOIN dept d ON e.deptno = d.deptno
    WHERE dname = '경리부';

-- 9
SELECT e.ename, e.sal, d.loc
    FROM emp e JOIN dept d ON e.deptno = d.deptno
    WHERE d.loc = '인천';

-- 10

CREATE sequence dept_seq
    START WITH 2000
    INCREMENT BY 500
    MINVALUE 2000
    MAXVALUE 5000
    CYCLE
    CACHE 6;

CREATE TABLE dept_test (
    deptno NUMBER(4)
    );
INSERT INTO dept_test (deptno) VALUES (dept_seq.NEXTVAL);

SELECT * FROM dept_test;

-- 11
--JOIN
--Cross Join
-- 특별한 키워드 없이 SELECT 문의 FROM 절에 테이블 2개를 콤마로 연결해서 연속으로 기술하는 것.
--- SELECT * FROM table1, table2
--- 중복되는 칼럼명 중 특정 하나를 보고 싶으면
--=> SELECT table_name.column_name FROM table1, table2
-- 
--Equi Join
--- 동일 칼럼을 기준으로 조인
--- SELECT * FROM table1, table2 WHERE table1.common = table2.common;
-- 
--Non-Equi Join
--- 동일 칼럼 없이 다른 조건을 사용하여 조인
--
--Outer Join
--- 조인 조건에 만족하지 않는 행도 나타냄
--
--Self Join
--- 한 테이블 내에서 조인

--ANSI JOIN
-- ANSI(미국표준연구소) SQL에서 제시한 표준 JOIN 구문
---Inner Join : Equi Join과 같은 것
---Outer Join: 기존 Outer Join에서 FULL까지 지원
-- 예시)
-- 사용할 테이블:
SELECT * FROM emp;
SELECT * FROM dept;

-- CROSS JOIN
SELECT * FROM emp, dept;

-- Equi Join
SELECT * FROM emp, dept WHERE emp.deptno = dept.deptno;

-- Non-Equi Join
SELECT * FROM salgrade;

SELECT ename, sal, grade FROM emp e, salgrade s WHERE sal >= LOSAL AND sal <= HISAL;
    
-- Self Join
SELECT e.ename as "사원이름", m.ename as "직속상관이름"
    FROM emp e, emp m WHERE e.mgr = m.empno;
    
-- ANSI Join
-- ANSI INNER JOIN
SELECT * FROM emp INNER JOIN dept on emp.deptno = dept.deptno;

-- ANSI OUTER JOIN
SELECT member.ename as "사원이름", manager.ename as "직속상관이름" 
    FROM emp member 
    LEFT OUTER JOIN emp manager ON member.mgr = manager.empno;
    
SELECT * FROM emp FULL OUTER JOIN dept ON emp.deptno = dept.deptno;