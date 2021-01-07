-- JOIN
SELECT * FROM emp;
SELECT * FROM dept;

-- CROSS JOIN
SELECT * FROM emp, dept;
-- 중복되는 컬럼명 보고 싶을 때
SELECT ename, emp.deptno FROM emp, dept;

-- Equi Join
SELECT * FROM emp, dept WHERE emp.deptno = dept.deptno;
SELECT ename, dname FROM emp, dept WHERE emp.deptno = dept.deptno AND ename = '이문세';

-- 테이블 별칭 부여
SELECT e.ename, e.deptno, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno;

-- Non-Equi Join
SELECT * FROM salgrade;

-- 테이블 3개 join
SELECT ename, sal, grade FROM emp e, salgrade s WHERE sal >= LOSAL AND sal <= HISAL;
SELECT ename, dname, sal, grade FROM emp e, dept d, salgrade s
    WHERE e.deptno = d.deptno AND sal between LOSAL AND HISAL ORDER BY grade;
    
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