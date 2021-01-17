-- 저장 프로시저

CREATE TABLE emp10
AS
SELECT * FROM emp;

-- 저장 프로시저 생성 
CREATE OR REPLACE PROCEDURE del_all
IS
BEGIN
    DELETE FROM emp10;
    COMMIT;
END;
/

SELECT * FROM emp10;

-- 저장 프로시저 실행
EXECUTE del_all;

-- 저장 프로시저 조회
SELECT name, text FROM user_source;

-- 저장 프로시저 매개 변수
DROP TABLE emp10;
CREATE TABLE emp10
AS
SELECT * FROM emp;

CREATE OR REPLACE PROCEDURE del_ename (vename emp10.ename%TYPE)
IS
BEGIN
    DELETE FROM emp10 WHERE ename LIKE vename;
    COMMIT;
END;
/
-- 이름에 '이'가 들어간 사람 삭제
SELECT * FROM emp10;
EXECUTE del_ename('%이%');

-- IN, OUT, INOUT 매개 변수 
-- IN : 데이터를 전달 받을 때 쓰임
-- OUT : 수행된 결과를 받아갈 때 사용
-- INOUT : IN + OUT

-- IN (모드가 생략될 경우는 다 IN 매개변수)
--CREATE OR REPLACE PROCEDURE del_ename (vename emp10.ename%TYPE)

-- OUT
SELECT * FROM emp10;
CREATE OR REPLACE PROCEDURE sel_empno
(   vempno IN emp10.empno%TYPE,
    vename OUT emp10.ename%TYPE,
    vsal OUT emp10.sal%TYPE,
    vjob OUT emp10.job%TYPE
    )
IS
BEGIN
    SELECT ename, sal, job INTO vename, vsal, vjob
    FROM emp10
    WHERE empno=vempno;
END;
/

VARIABLE vename VARCHAR2(15);
VARIABLE vsal NUMBER;
VARIABLE vjob varchar2(9);

EXECUTE sel_empno(1001, :vename, :vsal, :vjob);

PRINT vename
PRINT vsal
PRINT vjob

--2) OUT 매개변수
--CREATE OR REPLACE PROCEDURE SEL_EMPNO 
--    (VEMPNO IN EMP.EMPNO%TYPE,
--    VENAME OUT EMP.ENAME%TYPE,
--    VSAL OUT EMP.SAL%TYPE,
--    VJOB OUT EMP.JOB%TYPE)
--IS
--BEGIN
--    SELECT ENAME,SAL,JOB INTO VENAME, VSAL, VJOB FROM EMP WHERE EMPNO = VEMPNO;
--END;
--/
--
----바운드 변수선언
--VARIABLE VAR_ENAME VARCHAR2(15);
--VARIABLE VAR_SAL NUMBER;
--VARIABLE VAR_JOB VARCHAR2(9);
--
----저장 프로시저 실행
--EXECUTE SEL_EMPNO(1001,:VAR_ENAME,:VAR_SAL,:VAR_JOB);
--
----바운드 변수의 값을 출력하기
--PRINT VAR_ENAME
--PRINT VAR_SAL
--PRINT VAR_JOB
