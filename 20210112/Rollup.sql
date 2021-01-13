--풀이1 각각의 sql 만들고 union all 연결
--부서별 평균 급여 및 사원 수
SELECT deptno, NULL JOB, round(AVG(sal), 1) avg_sal, COUNT(*) cnt_emp
FROM emp
GROUP BY deptno
UNION
--부서별 평균 급여와 사원 수
SELECT deptno, JOB, round(AVG(sal), 1) avg_sal, COUNT(*) cnt_emp
FROM emp 
GROUP BY deptno, JOB
UNION ALL 
SELECT NULL deptno, NULL JOB, round(AVG(sal), 1) vag_sal, COUNT(*) cnt_emp
FROM emp 
ORDER BY deptno, JOB;

SELECT deptno, JOB, round(AVG(sal), 1) avg_sal, COUNT(*) cnt_emp FROM emp 
GROUP BY ROLLUP(deptno, JOB);

--부서별 평균 급여와 사원수
--직급별 평균 급여와 사원수
--부서와 직급별 평균 급여와 사원수
--전체 평균 월 급여와 사원수

SELECT deptno, NULL JOB, round(AVG(sal),1) avg_sal, COUNT(*) cnt_emp 
FROM emp
GROUP BY deptno
UNION ALL
SELECT NULL deptno, JOB, round(AVG(sal),1) avg_sal, COUNT(*) cnt_emp FROM emp
GROUP BY JOB
UNION ALL
SELECT deptno, JOB, round(AVG(sal),1) avg_sal, COUNT(*) cnt_emp 
FROM emp 
GROUP BY deptno, JOB
UNION ALL
SELECT NULL deptno, NULL JOB, round(AVG(sal),1) avg_sal, COUNT(*) cnt_emp FROM emp
ORDER BY deptno, JOB;

--풀이2)  CUBE함수로 구하기
SELECT deptno, JOB, round(AVG(sal), 1) avg_sal, COUNT(*) cnt_emp FROM emp
GROUP BY CUBE(deptno, JOB)  ORDER BY deptno, JOB;