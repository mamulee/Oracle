-- SQL 응용 시험
-- 1
-- 3번
-- 2
SELECT * FROM emp
    WHERE deptno IN (
    SELECT deptno FROM emp
    WHERE sal > 500
    GROUP BY deptno);
-- 3
-- 2번
-- 4
-- 1번
-- 5
UPDATE emp06
    SET sal = sal + 100
    WHERE job IN (
    SELECT job FROM emp06
    WHERE job = '과장'
    );

SELECT * FROM emp06;

-- 6
SELECT * FROM emp;
SELECT * FROM emp WHERE job = (
    SELECT job FROM emp
    WHERE ename ='박중훈'
    );

-- 7
SELECT ename, sal, job FROM emp
    WHERE mgr IN (
    SELECT empno FROM emp
    WHERE ename = '감우성'
    );

-- 8
SELECT * FROM emp 
    WHERE (deptno, sal) IN (
    SELECT deptno, min(sal)
    FROM emp
    GROUP BY deptno
    );

-- 9
CREATE OR REPLACE VIEW emp_view20
AS
SELECT * FROM emp WHERE deptno = 20;

SELECT * FROM emp_view20;

-- 10
-- 1. 복잡하고 긴 쿼리문을 뷰로 정의하면 접근을 단순화 시킬 수 있다.
-- 2. 보안에 유리하다.

-- 11
--DROP TABLE emp_copy;
--CREATE TABLE emp_copy
--AS
--SELECT * FROM emp;
--
--SELECT * FROM emp_copy;
--
CREATE OR REPLACE VIEW emp_view11
AS
SELECT * FROM emp_copy
WHERE deptno = 10 WITH CHECK OPTION;

SELECT * FROM emp_view11;
UPDATE emp_view11 SET deptno = 30 WHERE ename = '이경자';

-- 12
SELECT * FROM (
    SELECT * FROM EMP 
    ORDER BY HIREDATE DESC)
WHERE ROWNUM<=7;

-- 13. 인덱스 장단점
-- 장점 : 
-- 1) 검색속도가 빨라진다. 
-- 2) 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킨다.
-- 단점 : 
-- 1) 인덱스를 위한 추가적인 공간이 필요하다. 
-- 2) 인덱스를 생성하는데 시간이 걸린다. 
-- 3) 데이터 변경작업이 자주 일어날 경우에는 오히려 성능이 저하된다.

-- 14
CREATE SEQUENCE dept_seq_14
    START WITH 10
    MAXVALUE 100;

CREATE TABLE dept_test_14 (
    deptno NUMBER(4) PRIMARY KEY,
    dname VARCHAR(20)
    );

INSERT INTO dept_test_14 (deptno) VALUES (dept_seq_14.NEXTVAL);
SELECT * FROM dept_test_14;

-- 15
CREATE INDEX idx_emp_job_15 ON emp(JOB);

SELECT index_name, table_name, column_name 
FROM user_ind_columns WHERE table_name = 'EMP';

-- 19
-- 스키마란 객체를 소유한 사용자명을 의미한다. 객체명 앞에 소속 사용자 명을 기술할 때 사용한다.

-- 20
--1. ROLE_SYS_PRIVS : 롤에 부여된 시스템 권한 정보
--2. ROLE_TAB_PRIVS : 롤에 부여된 테이블 관련 권한 정보
--3. USER_ROLE_PRIVS : 접근 가능한 롤정보
--4. USER_TAB_PRIVS_MADE : 해당 사용자 소유의 오브젝트에 대한 오브젝트 권한 정보
--5. USER_TAB_PRIVS_RECD : 사용자에게 부여된 오브젝트 권한 정보
--6. USER_COL_PRIVS_MADE : 사용자 소유의 오브젝트 중 칼럼에 부여된 오브젝트 권한 정보
--7. USER_COL_PRIVS_RECD : 사용자에게 부여된 특정 칼럼에 대한 오브젝트 권한정보

-- 21
CREATE OR REPLACE PROCEDURE CURSOR_EXAMPLE
IS
    VDEPT DEPT%ROWTYPE;
    CURSOR C3
    IS
    SELECT * FROM DEPT WHERE0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호   부서명   지역');
    DBMS_OUTPUT.PUT_LINE('----------------------');
    FOR VDEPT IN C3 LOOP
        EXIT WHEN C3%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO || '    ' || VDEPT.DNAME || '      ' || VDEPT.LOC);
    END LOOP;
   
    
END;
/
SET SERVEROUTPUT ON;
EXECUTE CURSOR_EXAMPLE;

-- 22
DECLARE
    STAR VARCHAR2(20);
BEGIN
    FOR I IN 1..5 LOOP
    STAR := STAR || '*';
    DBMS_OUTPUT.PUT_LINE(STAR);
    END LOOP;
END;
/