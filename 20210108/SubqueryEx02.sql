---- 서브 쿼리 문제
--
--1. Student 테이블과 department테이블을 사용하여 'Anthony  Hopkins'학생과 전공(deptno1)이 동일한 학생들의 이름과 전공1 이름을 출력하시오

SELECT s.name "STUD_NAME" , d.dname "DEPT_NAME" FROM student s , department d
    WHERE s.deptno1=d.deptno and s.deptno1 = ( 
    SELECT deptno1 FROM student 
    WHERE name='Anthony Hopkins') ;

--2. professor테이블과 department테이블을 조회하여 'Meg Ryan'교수보다 나중에 입사한 사람의 이름과 입사일 학과명을 출력하세요
SELECT * FROM professor;
SELECT * FROM department;

SELECT p.name "교수명", p.hiredate "입사일", d.dname "학과명" FROM professor p JOIN department d
    ON p.deptno = d.deptno AND p.hiredate > (
    SELECT hiredate FROM professor
    WHERE name = 'Meg Ryan'
    );

--3. student 테이블에서 전공1이 201번인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 이름과 몸무게를 출력하세요
SELECT * FROM student;
SELECT name "이름", weight "몸무게" FROM student 
    WHERE weight > (
    SELECT avg(weight) FROM student
    WHERE deptno1 = 201
    );

--4. emp2테이블을 사용하여 전체 직원 중 'Section Head'직급의 최소 연봉자보다 연봉이 높은 사람의 이름과 직급 연봉을 출력하시오.
--단 연봉 출력 형식은 천단위 구분기호와 $표시를 하세요.

SELECT name, position, to_char(pay, '$999,999,999') FROM emp2
    WHERE pay > ANY (
    SELECT pay FROM emp2
    WHERE position = 'Section head'
    );

SELECT * FROM emp2;

--5. student테이블을 조회하여 전체 학생 중에서 체중이 2학년 체중에서 가장 적게 나가는 학생보다 몸무게가 적은 학생의 이름과 학년과 몸무게를 출력하세요.

SELECT name, weight FROM student
    WHERE weight < ALL (
    SELECT weight FROM student
    WHERE grade = 2
    );

--6. emp2테이블과 dept2테이블을 조회하여 각 부서별 평균 연봉을 구하고 그중에서 평균 연봉이 가장 적은 부서의 평균 연봉보다 적게 받는 직원들의 부서명, 직원명, 연봉을 출력하세요.
SELECT * FROM dept2;
SELECT avg(pay), deptno FROM emp2 GROUP BY deptno;

SELECT d.dname, e.name, e.pay FROM emp2 e JOIN dept2 d
    ON e.deptno = d.dcode
    WHERE e.pay < ALL (
    SELECT avg(pay) FROM emp2
    GROUP BY deptno
    );

-- 선생님 답
SELECT d.dname, e.name, to_char(pay, '$999,999,999') FROM emp2 e, dept2 d
    WHERE e.deptno = d.dcode
    AND pay < ALL (
    SELECT avg(pay) FROM emp2
    GROUP BY deptno);

-- 이건 뭐가 다를까
SELECT d.dname, e.name, to_char(pay, '$999,999,999'), e.deptno FROM emp2 e, dept2 d
    WHERE e.deptno = d.dcode
    AND pay < ALL (
    SELECT avg(pay) FROM emp2
    WHERE deptno = e.deptno);

--7. professor테이블과 department테이블을 조회하여 각 학과별로 입사일이 가장 오래된 교수의 교수번호와 이름, 학과명을 출력하세요.(입사일 순으로 오름차순 정렬하세요)

SELECT p.profno, p.name, d.dname, d.deptno, p.hiredate FROM professor p JOIN department d
    ON p.deptno = d.deptno
    WHERE p.hiredate IN (
    SELECT min(hiredate) FROM professor
    GROUP BY deptno
    )
    ORDER BY p.hiredate;

-- 선생님 답
SELECT p.profno, p.name, d.dname, d.deptno FROM professor p, department d
    WHERE p.deptno = d.deptno
    AND (p.deptno, p.hiredate) IN (
    SELECT deptno, min(hiredate) FROM professor
    GROUP BY deptno
    )
    ORDER BY p.hiredate;

    
--8. emp2 테이블을 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 연봉을 출력하세요. 연봉순으로 오름차순 정렬하세요.

SELECT name, position, pay FROM emp2
    WHERE pay IN (
    SELECT max(pay) FROM emp2
    GROUP BY position
    ) ORDER BY pay;

-- 선생님 답
SELECT name, position, to_char(pay, '$999,999,999') FROM emp2
    WHERE (position, pay) IN (
    SELECT position, max(pay) FROM emp2
    GROUP BY position) ORDER BY pay;