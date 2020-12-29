-- 부서 테이블
CREATE TABLE dept ( deptno NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
                    dname VARCHAR2(14),
                    loc VARCHAR2(13)
                    );
 
-- 사원 테이블                   
CREATE TABLE emp ( empno NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
                    ename VARCHAR2(10),
                    job varchar2(9),
                    mgr number(4),
                    hiredate date,
                    sal number(7,2),
                    comm number (7,2),
                    deptno number (2) CONSTRAINT FK_DEPTNO REFERENCES DEPT 
                    );
                
-- 급여 테이블
-- grade 등급, losal 급여 하한값, hisal 급여 상한값
CREATE TABLE salgrde ( grade number, losal number, hisal number);

-- 부서 테이블에 샘플 데이터 넣기
INSERT INTO dept (deptno, dname, loc) VALUES (10, '경리부', '서울');
INSERT INTO dept (deptno, dname, loc) VALUES (20, '인사부', '인천');
INSERT INTO dept VALUES (30, '영업부', '용인');
INSERT INTO dept VALUES (40, '전산부', '수원');
-- 사원 테이블 안에 있는 레코드 (행) 검색
SELECT * FROM dept;

-- 사원 테이블에 데이터 삽입
INSERT INTO emp VALUES (1001, '김사랑', '사원', 1013, to_date('2007-03-01','yyyy-mm-dd'), 3000, NULL, 20);
INSERT INTO EMP VALUES(1002, '한예슬', '대리', 1005, to_date('2007-04-02','yyyy-mm-dd'), 250,   80, 30);
INSERT INTO EMP VALUES(1003, '오지호', '과장', 1005, to_date('2005-02-10','yyyy-mm-dd'), 500,  100, 30);
INSERT INTO EMP VALUES(1004, '이병헌', '부장', 1008, to_date('2003-09-02','yyyy-mm-dd'), 600, NULL, 20);
INSERT INTO EMP VALUES(1005, '신동협', '과장', 1005, to_date('2005-04-07','yyyy-mm-dd'), 450,  200, 30);
INSERT INTO EMP VALUES(1006, '장동건', '부장', 1008, to_date('2003-10-09','yyyy-mm-dd'), 480, NULL, 30);
INSERT INTO EMP VALUES(1007, '이문세', '부장', 1008, to_date('2004-01-08','yyyy-mm-dd'), 520, NULL, 10);
INSERT INTO EMP VALUES(1008, '감우성', '차장', 1003, to_date('2004-03-08','yyyy-mm-dd'), 500,    0, 30);
INSERT INTO EMP VALUES(1009, '안성기', '사장', NULL, to_date('1996-10-04','yyyy-mm-dd'),1000, NULL, 20);
INSERT INTO EMP VALUES(1010, '이병헌', '과장', 1003, to_date('2005-04-07','yyyy-mm-dd'), 500, NULL, 10);
INSERT INTO EMP VALUES(1011, '조향기', '사원', 1007, to_date('2007-03-01','yyyy-mm-dd'), 280, NULL, 30);
INSERT INTO EMP VALUES(1012, '강혜정', '사원', 1006, to_date('2007-08-09','yyyy-mm-dd'), 300, NULL, 20);
INSERT INTO EMP VALUES(1013, '박중훈', '부장', 1003, to_date('2002-10-09','yyyy-mm-dd'), 560, NULL, 20);
INSERT INTO EMP VALUES(1014, '조인성', '사원', 1006, to_date('2007-11-09','yyyy-mm-dd'), 250, NULL, 10);

SELECT * FROM emp;

-- 급여 테이블에 데이터 삽입
INSERT INTO salgrde VALUES (1, 700,1200);
INSERT INTO SALGRDE VALUES (2, 1201,1400);
INSERT INTO SALGRDE VALUES (3, 1401,2000);
INSERT INTO SALGRDE VALUES (4, 2001,3000);
INSERT INTO SALGRDE VALUES (5, 3001,9999);

SELECT * FROM salgrde;

commit;

-- 중복되는 값 한 번씩만 출력
SELECT DISTINCT job as 직위 FROM emp;

select sal from emp;
select sal as 연봉, sal*0.03 as 세금 from emp;

SELECT ename 이름, comm 커미션, sal*12+comm 연봉, NVL(comm, 0) 커미션, sal*12+NVL(comm, 0) 연봉 FROM emp;

-- Concatenation 연산자 ||은 컬럼들을 연결할 때 쓰는 것이다.
SELECT ename || '의 직급은 ' || job || '입니다.' as 직급 from emp;

-- Where 절
-- 숫자 검색
SELECT * from emp WHERE sal >= 500;
SELECT * FROM emp WHERE deptno <> 10; -- != 와 <> 는 같은 의미
-- 문자 검색
SELECT * FROM emp WHERE ename = '한예슬';
-- 날짜 검색
-- 2005년 1월 1일 이전
SELECT * FROM emp WHERE hiredate <= to_date('2005-01-01','yyyy-mm-dd');

-- 논리 연산자
-- 부서 번호가 10이고 과장인 사람
SELECT * FROM emp WHERE deptno = 10 AND job = '과장';
-- 부서 번호가 10이거나 과장인 사람
SELECT * FROM emp WHERE deptno = 10 OR job = '과장';
-- 부서 번호가 10이 아니거나 과장인 사람 
SELECT * FROM emp WHERE NOT deptno = 10 OR job = '과장';
-- 급여가 400 ~ 500인 경우
SELECT * FROM emp WHERE sal >= 400 AND sal <= 500;
-- 급여가 400 미만이거나 500 초과인 경우
SELECT * FROM emp WHERE sal < 400 OR sal > 500;

-- BETWEEN AND 연산자
-- 급여가 400 ~ 500인 경우
SELECT * FROM emp WHERE sal BETWEEN 400 AND 500;

-- IN ~ 안에
select * from emp where comm = 80 or comm = 100 or comm = 200;
select * from emp where comm in (80, 100, 200);

SELECT * FROM emp WHERE comm != 80 AND comm != 100 AND comm != 200;
SELECT * FROM emp WHERE comm NOT IN (80, 100, 200);
L
-- LIKE 연산자
-- 와일드 카드:
-- => % : 문자가 없거나 하나 이상의 어떤 문자가 와도 상관 없다.
-- => _ : 하나의 문자가 어떤 값이 와도 상관 없다.

SELECT * FROM emp WHERE ename LIKE '_우_';
SELECT * FROM emp WHERE ename LIKE '%성';

-- job 에서 '사'로 시작하는 것만 찾기
SELECT * FROM emp WHERE job LIKE '사%';
-- job에서 '사'로 시작하지 않는 것
SELECT * FROM emp WHERE job NOT LIKE '사%';

-- NULL 검색 
SELECT * FROM emp WHERE comm = NULL; -- 하면 안 나옴
SELECT * FROM emp WHERE comm IS NULL;

-- 정렬
SELECT * FROM emp ORDER BY sal DESC, deptno;
-- 사원 중에서 급여 오름차순 정렬
SELECT * FROM emp WHERE job = '사원' ORDER BY sal;
-- 사장을 제외한 최근 입사자 순
SELECT * FROM emp WHERE NOT job = '사장' ORDER BY hiredate DESC;

-- 사원 이름, 급여, 입사일만 출력하기
SELECT ename 사원이름, sal 급여, hiredate 입사일 FROM emp;
-- 부서 번호는 dno, 부서명은 dname, '부서명;
SELECT deptno 부서번호, dname 부서명 FROM dept;
-- 사원 테이블에 존재하는 직급의 종류
SELECT DISTINCT job 직급 FROM emp;
-- 급여가 300 이하인 사원의 사원 번호, 사원 이름, 급여
SELECT empno 사원번호, ename 사원이름, sal 급여 FROM emp WHERE sal <= 300;
-- 이름이 '오지호'인 사원의 사원 번호, 사원명, 급여
SELECT empno 사원번호, ename 사원이름, sal 급여 FROM emp WHERE ename = '오지호';
-- 급여가 250이거나 300이거나 500인 사원들의 사원번호, 사원명, 급여를 출력
SELECT empno 사원번호, ename 사원이름, sal 급여 FROM emp WHERE sal IN (250, 300, 500);
-- 급여가 250도 300도 500도 아닌 사원들을 검색하세요
SELECT * FROM emp WHERE sal NOT IN (250, 300, 500);
-- 사원중에는 이름이 '김'으로 시작하는 사람과 이름중에 '기'를 포함하는 사원의 사원번호와 사원이름을 출력하세요
SELECT empno 사원번호, ename 사원이름 FROM emp WHERE ename LIKE '김%' OR ename LIKE '%기%';
-- 상급자가 없는 사원을 검색하세요
SELECT * FROM emp WHERE mgr IS NULL;
-- 사원테이블의 자료를 입사일을 기준으로 정렬하여 최근에 입사한 직원을 가장 먼저 출력하세요
--  (단, 사원번호, 사원명, 직급, 입사일) 컬럼만 출력
SELECT empno 사원번호, ename 사원이름, sal 급여, hiredate 입사일 FROM emp ORDER BY hiredate DESC;
-- 부서번호가 빠른 사원번호부터 출력하되 같은 부서 내의 사원을 출력할 경우 입사한지 가장 오래된 사원부터 출력하세요
SELECT * FROM emp ORDER BY deptno, hiredate;