-- PL/SQL

SET serveroutput ON;


BEGIN
   dbms_output.put_line('Hello');
END;
/


DECLARE
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(10);

BEGIN
    VEMPNO := 1001;
    VENAME := '김사랑';
    DBMS_OUTPUT.PUT_LINE('    사 번     이 름    ');
    DBMS_OUTPUT.PUT_LINE('----------------------');
    DBMS_OUTPUT.PUT_LINE('   ' || VEMPNO || '    ' || VENAME);
END;
/
    
-- 스칼라 변수
VEMPNO NUMBER(4);

-- 레퍼런스 변수 
VEMPNO EMP.EMPNO%TYPE;
-- %ROWTYPE
VEMP EMP%ROWTYPE;

