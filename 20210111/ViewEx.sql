--1. 사원 테이블을 기본 테이블로 하여 부서별 최대 급여와 최소급여을 출력하는 뷰를 SAL_VIEW란 이름으로 작성하시오

CREATE OR REPLACE VIEW sal_view 
AS
SELECT MAX(sal) 최대급여, MIN(sal) 최소급여, deptno
FROM emp GROUP BY deptno;

SELECT * FROM sal_view;

--2. 인라인 뷰를 사용하여 급여를 많이 받는 순서대로 3명만 출력하시오

SELECT ename, sal FROM (
    SELECT ename, sal FROM emp ORDER BY sal desc
    )
    WHERE ROWNUM <=3;
    
--3. professor테이블과 department테이블을 조인하여 교수번호와 교수이름, 소속 학과이름을 조회하는 view를 생성하시오. view 이름은 v_prof_dept2로 하세요
SELECT * FROM professor;
SELECT * FROM department;

CREATE VIEW v_prof_dept2
AS
SELECT p.profno, p.name, d.dname FROM professor p JOIN department d ON p.deptno = d.deptno;

--3. inline view를 사용하여 student테이블과 departmant테이블을 사용하여 학과별로 학생들의 최대키와 최대 몸무게, 학과 이름을 출력하세요.
SELECT DISTINCT deptno1 FROM student;
SELECT * FROM department;

SELECT d.dname, s.maxHeight, s.maxWeight FROM (
    SELECT deptno1, max(height) maxHeight, max(weight) maxWeight
    FROM student GROUP BY deptno1) s, department d
    WHERE s.deptno1 = d.deptno;

--4. student테이블과 departmemt테이블을 사용하여 학과 이름, 학과별 최대키, 학과별로 가장 키가 큰 학생들의 이름과 키를 inline view를 사용하여 출력하세요.

SELECT d.dname, a.maxHeight, s.name, s.height FROM (
    SELECT deptno1, max(height) maxHeight 
    FROM student GROUP BY deptno1) a JOIN department d
    ON a.deptno1 = d.deptno
    JOIN student s on a.maxHeight = s.height;
    
-- 선생님 답
SELECT  s.deptno1, a.deptno1, d.deptno,  d.dname, a.max_height, s.name, s.height 
FROM ( SELECT deptno1, max(height) as max_height from student group by deptno1) a, 
      department d, student s
WHERE s.deptno1 = a.deptno1 and s.height = a.max_height and s.deptno1 = d.deptno;

--5. student테이블에서 학생의 키가 동일 학년의 평균 키보다 큰 학생들의 학년과 이름 키, 해당 학년의 평균키를 출력하되 inline view를 사용해서 출력하세요.
-- (학년 컬럼으로 오름차순 정렬해서 출력하세요)

SELECT s.grade, s.name, s.height, a.avgHeight FROM (
    SELECT avg(height) avgHeight, grade FROM student GROUP BY grade
    ) a,
    student s WHERE s.grade = a.grade AND s.height > a.avgheight
    ORDER BY s.grade;


--6. professor테이블을 조회하여 교수들의 급여 순위와 이름과 급여을 출력하시오. 단 급여 순위는 급여가 많은 사람부터 1~5위까지 출력하세요
SELECT * FROM professor;

SELECT ROWNUM ranking, name, pay FROM (
    SELECT name, pay FROM professor
    ORDER BY pay desc)
    WHERE ROWNUM <=5;

--7. 아래 화면과 같이 교수 테이블을 교수 번호로 정렬하되 3건씩 분리해서 급여 합계와 급여 평균을 출력하세요

SELECT profno, NAME, pay, SUM(pay), round(AVG(pay), 1)
    FROM (SELECT profno, NAME, pay, ROWNUM NUM FROM professor)
    GROUP BY ceil(NUM/3), ROLLUP((profno, NAME, pay, NUM))
    ORDER BY ceil(NUM/3);
    
SELECT CEIL(ROWNUM/3) FROM professor;



