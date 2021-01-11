SELECT * FROM dept;
SELECT * FROM emp;
SELECT * FROM salgrade;

UPDATE emp
    SET sal = 300
    Where empno = 1001;
commit;

--2. 경리부에서 근무하는 사원의 이름과 입사일을 출력하기

SELECT e.ename, e.hiredate FROM emp e JOIN dept d 
    ON e.deptno = d.deptno AND d.dname = '경리부';

--3. ANSI JOIN을 사용하여 인천에서 근무하는 사원이름과 급여을 출력하기

SELECT e.ename, e.sal FROM emp e JOIN dept d
    ON e.deptno = d.deptno WHERE d.loc = '인천';

-- 정답
SELECT E.ename, E.sal FROM emp E 
        INNER JOIN dept D ON E.deptno = D.deptno AND D.loc='인천';    

--4. 사원 테이블과 부서 테이블을 조인하여 사원이름과 부서번호, 부서명을 출력하시오

SELECT e.ename, e.deptno, d.dname FROM emp e JOIN dept d
    ON e.deptno = d.deptno;

--5. 경리부 부서 소속 사원의 이름과 입사일을 출력하시오

SELECT e.ename, e.hiredate FROM emp e, dept d
    WHERE e.deptno = d.deptno
    AND d.dname = '경리부';

--6. 직급이 과장인 사원이 이름, 부서명을 출력하시오

SELECT e.ename, d.dname FROM emp e JOIN dept d
    ON e.deptno = d. deptno
    AND e.job = '과장';

--7. 직속상관이 감우성인 사원들의 이름과 직급을 출력하시오

SELECT e.ename, e.job FROM emp e JOIN emp m
    ON e.mgr = m.empno AND m.ename = '감우성';

--8. 감우성과 동일한 근무지에서 근무하는 사원의 이름을 출력하시오
SELECT e2.ename FROM emp e1 JOIN emp e2
    ON e1.deptno = e2.deptno WHERE e1.ename = '감우성' AND e2.ename <> '감우성';
​