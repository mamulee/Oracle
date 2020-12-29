--1. 그룹함수를 사용하여 통계데이터를 구하라
--1) 모든 사원의 급여최고액, 최저액, 총액 및 평균 급여를 출력하시오. 
--   평균에 대해서는 정수로 반올림하시오
--   출력 결과
--   Maximum    Minimum    Sum     Average
--     1000           250          6490     646

SELECT MAX(sal) 급여최고액, MIN(sal) 급여최저액, SUM(sal) 총액, round(AVG(sal)) FROM emp;

-- 2) 각 담당 업무 유형별로 급여 최고액, 최저액, 총액 및 평균액을 출력하시오.
SELECT JOB, MAX(sal) 급여최고액, MIN(sal) 급여최저액, SUM(sal) 총액, round(AVG(sal)) FROM emp GROUP BY JOB;

-- 3) count(*)함수를 이용하여 담당 업무별 사원수를 출력하시오
SELECT JOB, COUNT(*) FROM emp GROUP BY JOB ORDER BY JOB ASC;
--     Job   count(*)
--     과장     3
--     대리     1
--     ...         ..

--  4) 과장 수를 나열하시오
SELECT COUNT(*) 과장수 FROM emp WHERE JOB = '과장';

--  5) 급여 최고액, 급여 최저액의 차액을 출력하시오.
SELECT MAX(sal) 최고, MIN(sal) 최저, MAX(sal) - MIN(sal) 차액 FROM emp;

--  6) 직급별 사원의 최저 급여을 출력하시오. 최저 급여가 500미만인 그룹은 제외시키고, 결과를 급여에 대한 내림차순으로 정렬하여 출력하시오
SELECT JOB, MIN(sal) FROM emp GROUP BY JOB HAVING MIN(sal) >=500 ORDER BY MIN(sal) DESC;

--  7) 각 부서에 대한 부서번호, 사원수, 부서내의 모든 사원 평균 급여를 출력하시오. 평균 급여는 소수점 둘째자리로 반올림하시오
SELECT deptno 부서번호, COUNT(*) 사원수, round(AVG(sal), 2) 부서내평균급여 FROM emp GROUP BY deptno;

--  8) 각 부서에 대해 부서번호 이름, 지역명, 사원수, 부서 내의 모든 사원의 평균 급여를 출력하시오.
--     평균 급여는 정수로 소수점 둘째 자리로 반올림하시오.
SELECT deptno, decode(deptno, 10, '경리부',
                           20, '인사부',
                           30, '영업부',
                           40, '전산부') AS dname, 
         decode (deptno, 10, '서울', 20, '인천', 30, '용인', 40, '수원') AS 지역, 
                           COUNT(*) 부서별_사원수, round(AVG(sal), 1) 평균_급여 
                           FROM emp GROUP BY deptno, decode(deptno, 10, '경리부', 20, '인사부', 30, '영업부', 40, '전산부'), decode (deptno, 10, '서울', 20, '인천', 30, '용인', 40, '수원');