-- 3장 오라클 함수

SELECT * FROM dual;
--
SELECT round(2.56, 1) FROM dual;

SELECT 'Welecome to Oracle', 
    UPPER ('Welecome to Oracle'),
    LOWER('Welecome to Oracle'),
    INITCAP('Welecome to Oracle')
    FROM dual;
    
SELECT LENGTH('Welecome to Oracle 한글') FROM dual;

SELECT CONCAT('ab', 'cd') FROM dual;
SELECT SUBSTR ('Welecome to Oracle', 2, 4) FROM dual;
-- INSTR(대상, 찾을 글자, 시작 위치, 몇 번째 발견)
SELECT INSTR ('Welecome to Oracle', 'o', 1, 2) FROM dual;

SELECT sysdate, to_char(sysdate, 'yyyy-mm-dd, AM HH:MI:SS') from dual;
SELECT TO_DATE('2020/12/29', 'yyyy-mm-dd') from dual;
SELECT to_char(123400000, 'L999,999,999.99') FROM dual;
SELECT to_number('542') FROM dual;


--날짜 중요!
SELECT to_char(sysdate, 'yyyy-mm-dd') from dual;
SELECT to_char(hiredate, 'yyyy/mm/dd') as 입사일1, 
        to_char(trunc(hiredate, 'MONTH'), 'yyyy/mm/dd') 입사일2,
                        --trunc : 달을 기준으로 절삭함 ( 모든 일이 다 1일로나옴)
        to_char (round(hiredate, 'MONTH'), 'yyyy/mm/dd') 입사일3,
                        --round : 16일 이후로 월 기준으로 반올림이된다. 흠...MONTH썻으니까
        to_char(round(hiredate,'DAY'), 'yyyy/mm/dd') 입사일4 from emp;
        
SELECT ename, sysdate 오늘, to_char(hiredate, 'yyyy/mm/dd') 입사일,
        round(Months_between(sysdate, hiredate)) 근무달수 from emp;
        
SELECT ename, to_char(add_months(hiredate, 6), 'yyyy/mm/dd') 입사6개월_후 from emp;

SELECT to_char(sysdate, 'yyyy/mm/dd') 오늘,
        to_char(next_day(sysdate, 'WEDNESDAY'), 'yyyy/mm/dd') 수요일
        from dual;
        
--------------------------------------------------------------------------------------------------------
-- comm이 null
INSERT INTO EMP VALUES(1020, '조이성', '사원', 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, NULL, 10);
-- 날짜가 null
INSERT INTO EMP VALUES(1021, '조이성', '사원', 1006, NULL, 250, 500, 10);
-- 문자가 null
INSERT INTO EMP VALUES(1022, NULL, '사원', 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, 500, 10);
INSERT INTO EMP VALUES(1023, '조이성', NULL, 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, 500, 10);
--------------------------------------------------------------------------------------------------------
-- Null 을 다른 값으로 변환하는 함수
SELECT comm, nvl(comm, 0) FROM emp;
SELECT hiredate, nvl(hiredate, to_date(sysdate, 'yyyy-mm-dd')) FROM emp;
SELECT ename, nvl(ename, '홍길동'), job, nvl(job, '사원') FROM emp;
-- nvl2 함수
SELECT ename, sal, comm,
        NVL2(comm, sal*12+comm, sal*12)
        FROM emp ORDER BY deptno;
-- nullif 함수
SELECT nullif('a', 'a'), nullif('a', 'b') FROM dual;

SELECT coalesce(null, 'a', 'b', 'c', 'd') FROM dual;

SELECT ename, deptno, decode(deptno, 10, '경리부',
                                    20, '인사과',
                                    30, '영업부',
                                    40, '전산부') dname FROM emp;

SELECT ename, deptno,
        CASE WHEN deptno = 10 THEN '경리부'
            WHEN deptno = 20 THEN '인사과'
            WHEN deptno = 30 THEN '영업부'
            WHEN deptno = 40 THEN '전산부'
        END dname FROM emp;
---------------------------------------------------------------------------------------------------------
--round(숫자, 반올림하여 나오는 자리수) 즉, 소숫점을 기준으로 왼쪽으로가면 음수 오른쪽로가면 양수를 넣으면 그 기준점으로 반올림된다.
SELECT round(12300.7876, -3) FROM dual;

-- 그룹 함수
-- COUNT, NULL 값은 세지 않음
SELECT COUNT(*) as "전체 사원의 수",
        COUNT (comm) as "커미션 받는 사원 수"
        FROM emp;
        
-- GROUP BY
SELECT deptno, SUM(sal) FROM emp GROUP BY deptno;
SELECT deptno, SUM(sal) FROM emp WHERE JOB = '사원' GROUP BY deptno;
SELECT JOB, AVG(sal) FROM emp GROUP BY JOB;
SELECT JOB, SUM(sal) FROM emp WHERE substr(hiredate, 8,2) BETWEEN '00' AND '07' GROUP BY JOB;
SELECT deptno, MAX(sal) 최대, MIN(sal) 최소 FROM emp GROUP BY deptno ORDER BY deptno;

-- 그룹 결과 제한, HAVING 절
SELECT deptno, AVG(sal) FROM emp GROUP BY deptno HAVING AVG(sal) >= 500;



