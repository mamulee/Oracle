-- 서브 쿼리
-- 단일 행 서브 쿼리
SELECT dname FROM dept 
    WHERE deptno = (
        SELECT deptno FROM emp
        WHERE ename = '이문세'
        );
-- 평균 급여보다 더 많은 급여를 받는 사원
SELECT ename FROM emp
    WHERE sal > (
    SELECT avg(sal) FROM emp
    );

SELECT * FROM student;
SELECT * FROM department;

SELECT s.name, d.dname FROM student s JOIN department d
    ON s.deptno1 = d.deptno
    WHERE s.deptno1 = (
    SELECT deptno1 FROM student
    WHERE name = 'Anthony Hopkins'
    );
    
-- 다중행 서브 쿼리
-- IN
-- 급여가 500을 초과하는 사원과 같은 부서에 근무하는 사원 구하기
SELECT ename, sal, deptno FROM emp
    WHERE deptno IN (
    SELECT DISTINCT deptno
    FROM emp
    WHERE sal > 500
    );

-- 30번 부서의 최대 급여보다 많은 급여를 받는 사원 출력
SELECT ename, sal FROM emp
    WHERE sal > (
    SELECT max(sal) FROM emp
    WHERE deptno = 30
    );
-- ALL 연산자
SELECT ename, sal FROM emp
    WHERE sal > ALL (
    SELECT sal FROM emp
    WHERE deptno = 30
    );

-- 30번 부서의 최소 급여보다 많은 급여를 받는 사원 출력
SELECT ename, sal FROM emp
    WHERE sal > (
    SELECT min(sal) FROM emp
    WHERE deptno = 30
    );
-- ANY 연산자
SELECT ename, sal FROM emp
    WHERE sal > ANY (
    SELECT sal FROM emp
    WHERE deptno = 30
    );

-- EXISTS 연산자, 반대 : NOT EXISTS
SELECT * FROM dept
    WHERE EXISTS (
    SELECT * FROM emp WHERE deptno = 50
    );

-- 서브 쿼리를 이용한 테이블 생성
desc emp0202;
SELECT * FROM user_constraints WHERE table_name IN ('EMP02', 'EMP0202');

-- 테이블 전체 복사
CREATE TABLE emp0202 AS SELECT * FROM emp02;

SELECT * FROM emp0202;
SELECT * FROM emp02;

-- 테이블 구조만 복사
CREATE TABLE emp020202 AS SELECT * FROM emp02 WHERE 1=0;
SELECT * FROM emp020202;
