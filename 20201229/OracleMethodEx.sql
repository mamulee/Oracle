--1. 문자 조작함수를 시용하여 특정 행만 조회하라
--2. DECODE함수를 사용하여 조건에 따른 서로 다른 결과를 구하라
--3. 형변환 함수를 사용하여 원하는 형태로 출력하라


--1. 문자 조작함수를 시용하여 특정 행만 조회하라
--1) 9월에 입사한 사원을 출력해 보세요 (SUBSTR)함수를 사용한다.
select * from emp where substr(hiredate,4,3) = 'SEP';

--2) 2003년도에 입사한 사원을 알아내기 위한 쿼리문은 다음과 같이 작성할 수 있습니다.
--SELECT * from emp where hiredate >= to_date('2003/01/01', 'yyyy/mm/dd')
--
--                                   add  hiredate <= to_date('2003/12/31', 'yyyy/mm/dd');
--
--SELECT * from emp where hiredate between  to_date('2003/01/01', 'yyyy/mm/dd')
--
--                                   add  to_date('2003/12/31', 'yyyy/mm/dd');
--
--이러한 방법 말고 SUBSTR함수를 이용하여 2003년도 입사한 사원을 검색해 보도록 하시오
SELECT * FROM emp WHERE substr(hiredate, 8, 2) = '03';

--3) 다음은 이름이 '기'로 끝나는 사람을 검색해 보도록 합시다.
--   SELECT * FROM emp WHERE  ename LIKE '%기';
--이러한 방법 말고 SUBSTR함수를 이용하여 ename 컬럼의 마지막 문자 한개만 추출해서 이름이 '기'로 끝나는 사원을 검색해 보도록 하세요.
--힌트 : 시작 위치는 -1로 주고, 추출할 문자 개수를 1로 주면 됩니다
SELECT * FROM emp WHERE substr(ename, -1, 1) = '기';

--4) 이번에는 이름의 두번째 글자에 '동'이 있는 사원을 검색해 보세요
--이런 문제가 주어지면 일반적으로 LIKE연산자와 '_'와일드 카드를 사용해서 구할 수 있습니다.
--SELECT empno, ename FROM emp WHERE ename LIKE '_동%';
--이름의 두번째 글자에 '동'이 있는 사원을 검색하기 위해서 와일드 카드('_')와 LIKE연산자를 사용하여 위와 같이 표현할 수 있지만 INSTR함수를 사용하여 작성해 보세요
SELECT empno, ename FROM emp WHERE instr(ename, '동', 2, 1) = 2;

--2. DECODE함수를 사용하여 조건에 따른 서로 다른 결과를 구하라
--1) 직급에 따라 급여를 인상하도록 합시다. 직급이 '부장'인 사원은 5%, '과장'인 사원은 10%, '대리'인 사원은 13%, '사원'인 사원은 20%인상합니다.
SELECT empno, ename, job, sal,
        decode( job, '부장', sal*1.05,
                        '과장', sal*1.1,
                        '대리', sal*1.13,
                        '사원', sal*1.2,
                        sal) upsal FROM emp;

--3. 형변환 함수를 사용하여 원하는 형태로 출력하라
--입사일 연도는 2자리(YY), 월은 숫자(MON)으로 표시하고, 요일은 약어(DY)로 지정하여 출력하시오
SELECT hiredate, to_char(hiredate, 'yy/mon/dd dy') FROM emp;
