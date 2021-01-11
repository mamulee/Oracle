CREATE TABLE emp_copy
AS
SELECT * FROM emp;

SELECT * FROM emp_copy; --물리적 테이블

--deptno이 30인 사원의 사번, 이름, 부서번호를 검색 하는 것을 view에 넣기
CREATE VIEW emp_view30
AS
SELECT empno, ename, deptno FROM emp WHERE deptno = 30;

SELECT * FROM emp_view30;
SELECT  ename FROM emp_view30;

SELECT * FROM course;

CREATE VIEW course_view_20 (cou_id, cou_name)
AS
SELECT cou_id, cou_name FROM course WHERE cou_id=20;

SELECT * FROM course_view_20;

desc user_views;

SELECT view_name, text FROM user_views;

-- 뷰를 통한 물리적 데이터 추가
INSERT INTO emp_view30 VALUES (1111, 'aaaa', 30);
SELECT * FROM emp where deptno = 40;

-- 뷰를 통한 데이터 수정
UPDATE emp_view30 SET deptno = 40 WHere ename = 'aaaa';

-- 뷰를 통한 데이터 삭제
DELETE FROM emp_view30 WHERE empno = '1002';

-- Join 된 테이블의 뷰
CREATE VIEW emp_view_dept
as
SELECT e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc FROM emp_copy e, dept d
WHERE e.deptno = d.deptno;

SELECT * FROM emp_view_dept;
DESC user_views;
SELECT * FROM user_views where view_name = 'EMP_VIEW_DEPT';

CREATE VIEW emp_view
AS
SELECT empno, ename, job, mgr, hiredate, deptno FROM emp;

SELECT * FROM user_views;

-- 뷰 삭제
DROP VIEW emp_view;

-- 뷰 다양한 옵션
-- 바꾸기
CREATE OR REPLACE VIEW emp_view30
AS
SELECT empno, ename, sal, deptno FROM emp_copy WHERE deptno = 30;

SELECT * FROM emp_view30;

-- FORCE 기존 테이블 없이 뷰 먼저 만들 때 => 거의 사용하지 않음
-- <-> NOFORCE 테이블이 있어야지만 뷰를 만들 수 있음
CREATE FORCE VIEW employees_view
AS
SELECT empno, ename, deptno FROM employees WHERE deptno = 30; -- 됨

SELECT * FROM employees_view; -- 없음

CREATE NOFORCE VIEW employees_view2
AS
SELECT empno, ename, deptno FROM employees WHERE deptno = 30; -- 안 됨

-- WIHT CHECK OPTION
CREATE OR REPLACE VIEW emp_view30
AS
SELECT empno, ename, sal, deptno FROM emp_copy 
WHERE deptno = 30 WITH CHECK OPTION;

SELECT * FROM emp_view30;
INSERT INTO emp_view30 VALUES (1111, 'aaaa', 350, 30);
UPDATE emp_view30 SET deptno = 40 WHERE ename = 'aaaa'; -- deptno 가 CHECK OPTION이라 수정이 안 됨
UPDATE emp_view30 SET enmae = 'bbbb' WHERE ename = 'aaaa'; -- 다른 건 됨

-- WITH READ ONLY
CREATE OR REPLACE VIEW emp_view30
AS
SELECT empno, ename, sal, deptno FROM emp_copy 
WHERE deptno = 30 WITH READ ONLY;
UPDATE emp_view30 SET deptno = 40;
UPDATE emp_view30 SET ename = 'aaa'; -- 다 안 됨~

-- ROWNUM
SELECT ROWNUM, empno, ename, hiredate FROM emp ORDER BY hiredate;

-- 입사일 최신 5명
CREATE OR REPLACE VIEW view_hire
AS
SELECT empno, ename, hiredate FROM emp ORDER BY hiredate desc;

SELECT ROWNUM, empno, ename, hiredate FROM view_hire WHERE ROWNUM <=5;

-- 뷰를 또 뷰로 만들기
CREATE OR REPLACE VIEW view_view_hire
AS 
SELECT empno, ename, hiredate FROM view_hire WHERE ROWNUM <=5;

SELECT * FROM view_hire;
SELECT * FROM view_view_hire;

-- 인라인 뷰
SELECT e.deptno, d.dname, e.sal FROM (SELECT deptno, max(sal) FROM emp GROUP BY deptno) e, dept d;