--- 저장 함수
CREATE OR REPLACE FUNCTION cal_bonus (
    vempno IN emp.empno%TYPE)
    RETURN NUMBER
IS
    vsal NUMBER(7, 2);
BEGIN
    SELECT sal INTO vsal
    FROM emp
    WHERE empno = vempno;
    
    RETURN (vsal * 2);
END;
/

-- 바운드 변수 선언
VARIABLE var_res NUMBER;

-- 저장 함수 실행
EXECUTE :var_res := cal_bonus(1001);

-- 바운드 변수 출력
PRINT var_res;

--5. 저장함수를 호출하는 SQL문장
SELECT sal, cal_bonus(1001) FROM emp WHERE empno=1001;