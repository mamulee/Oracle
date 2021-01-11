--1. 서브 쿼리를 이용하여 "영업부"에서 근무하는 모든 사원의 이름과 급여을 출력하라.

SELECT ename, sal FROM emp 
    WHERE deptno = (
    SELECT deptno FROM dept
    WHERE dname = '영업부'
    );

--2. 서브쿼리를 사용하여 emp06에 emp테이블의 모든 데이터를 추가합니다.

CREATE TABLE emp06 AS SELECT * FROM emp;

--3. emp06테이블에 저장된 사원 정보 중 과장들의 최소 급여보다 많은 급여을 받는 사원들의 이름과 급여과 직급을 출력하되 
--  과장은 출력하지 않은 SQL문을 작성하시오

SELECT ename, sal, job FROM emp06
    WHERE sal > ANY (
    SELECT sal FROM emp06
    WHERE job = '과장'
    )
    AND job <> '과장';

--4. emp06 테이블에 저장된 사원 정보 중 인천에 위치한 부서에 소속된 사원들의 급여을 100 인상하는 SQL문을 작성하시오

UPDATE emp06
    SET sal = sal + 100
    WHERE deptno = (
    SELECT deptno FROM dept
    WHERE loc = '인천'
    );

SELECT * FROM emp06;

--5. emp06테이블에서 경리부에 소속된 사원들만 삭제하는 SQL문을 작성하시오

DELETE emp06 WHERE deptno = (
    SELECT deptno FROM dept
    WHERE dname = '경리부'
    );

SELECT * FROM emp06;

--6. '이문세'와 같은 부서에 근무하는 사원의 이름과 부서번호를 출력하는 SQL문을 작성하시오

SELECT ename, deptno FROM emp
    WHERE deptno = (
    SELECT deptno FROM emp
    WHERE ename = '이문세'
    )
    AND ename <> '이문세';

--7. '이문세'와 동일한 직급을 가진 사원을 출력하는 SQL문을 완성하시오.

SELECT ename FROM emp 
    WHERE job = (
    SELECT job FROM emp
    WHERE ename = '이문세'
    ) AND ename <> '이문세';

--8. '이문세'의 급여와 동일하거나 더 많이 받는 사원명과 급여을 출력하는 SQL문을 완성하시오

SELECT ename, sal FROM emp
    WHERE sal >= (
    SELECT sal FROM emp
    WHERE ename = '이문세'
    ) AND ename <> '이문세';

SELECT ename, sal FROM emp WHERE ename = '이문세';

--9. '인천'에서 근무하는 사원의 이름, 부서번호를 출력하는 SQL문을 완성하시오.

SELECT ename, deptno FROM emp
    WHERE deptno = (
    SELECT deptno FROM dept
    WHERE loc = '인천'
    );

--10. 직속상관이 감우성인 사원의 이름과 급여을 출력하는 SQL문을 완성하시오

SELECT ename, sal FROM emp
    WHERE mgr = (
    SELECT empno FROM emp
    WHERE ename = '감우성'
    );
    
SELECT * FROM emp;

--11. 부서별로 가장 급여를 많이 받는 사원의 정보(사원번호, 사원이름, 급여, 부서번호)를 출력하는 SQL문을 완성하시오.

SELECT empno, ename, sal, deptno FROM emp 
    WHERE sal IN (
    SELECT max(sal)
    FROM emp
    GROUP BY deptno
    ); -- 이거는 부서별이 max를 가져와서 거기 해당되는 사람을 다 가져오기 때문에 안 됨.
    -- 예) 30번 부서의 max이 500 이라서 10번 부서의 max는 520이지만, 10번 부서의 500 을 가지는 사람도 출력됨

SELECT empno, ename, sal, deptno FROM emp 
    WHERE (deptno, sal) IN (
    SELECT deptno, max(sal)
    FROM emp
    GROUP BY deptno
    );

-- 선생님 답
SELECT empno, ename, sal, deptno FROM emp e
    WHERE sal = (
    SELECT max(sal) FROM emp
    WHERE deptno = e.deptno
    );

SELECT * FROM emp;
--12. 직급(JOB)이 과장인 사원이 속한 부서의 부서번호와 부서명, 지역을 출력하시오

SELECT deptno, dname, loc FROM dept
    WHERE deptno IN (
    SELECT deptno FROM emp
    WHERE job = '과장'
    );

--13. 과장보다 급여을 많이 받은 사원들의 이름과 급여와 직급을 출력하되 과장은 출력하지 않는 SQL문을 완성하시오

SELECT ename, sal, job FROM emp
    WHERE sal > ALL (
    SELECT sal FROM emp
    WHERE job = '과장'
    );