-- 커서
CREATE OR REPLACE PROCEDURE cursor_sample01
IS 
    vdept dept%ROWTYPE;
    CURSOR c1
    IS
    SELECT * FROM dept;

BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호    부서명    지역명');
    DBMS_OUTPUT.PUT_LINE('---------------------');
    
    OPEN c1;
    
    LOOP
        FETCH c1 INTO vdept.deptno, vdept.dname, vdept.loc;
        EXIT WHEN c1%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO ||  '   ' || VDEPT.DNAME || '     ' || VDEPT.LOC );
   END LOOP;
   
   CLOSE c1;
END;
/

-- 저장 프로시저 호출 (실행)
SET SERVEROUTPUT ON;
EXECUTE cursor_sample01;

-- emp 테이블에서 부서 번호가 10인 모든 행 출력하기 
CREATE OR REPLACE PROCEDURE cursor_sample02
IS
    vemp emp%ROWTYPE;
    CURSOR c2
    IS SELECT * FROM emp WHERE deptno = 10;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호    이름    연봉');
    DBMS_OUTPUT.PUT_LINE('---------------------');
    
    OPEN c2;
    
    LOOP
        FETCH c2 INTO vemp.empno, vemp.ename, vemp.job, vemp.mgr, vemp.hiredate, vemp.sal, vemp.comm, vemp.deptno;
        EXIT WHEN c2%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(Vemp.DEPTNO ||  '   ' || Vemp.eNAME || '     ' || Vemp.sal );
   END LOOP;
   
   CLOSE c2;
END;
/

SELECT * FROM emp;

SET SERVEROUTPUT ON;
EXECUTE cursor_sample02;

-- open~fetch~close가 대신에 for-loop ~endloop로 사용할 수도 있다.
-- 간단하게 커서를 처리할 수 있는 방법이 있다.
CREATE OR REPLACE PROCEDURE cursor_sample03
IS
    vdept dept%ROWTYPE;
    CURSOR c3
    IS SELECT * FROM dept;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호    부서명    지역명');
    DBMS_OUTPUT.PUT_LINE('---------------------');
    FOR vdept IN c3 LOOP
        EXIT WHEN c3%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VDEPT.DEPTNO ||  '   ' || VDEPT.DNAME || '     ' || VDEPT.LOC );
    END LOOP;

END;
/

EXECUTE cursor_sample03;