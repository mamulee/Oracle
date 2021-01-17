
SET serveroutput ON;

-- SELECT 문
--SELECT empno, ename
--    INTO vempno, vename
--    FROM emp
--    WHERE ename = '김사랑';
    
-- Q) PL/SQL의 SELECT문으로 emp 테이블에서 사원 번호와 이름 출력

DECLARE
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
BEGIN
    SELECT empno, ename
    INTO vempno, vename
    FROM emp
    WHERE ename = '김사랑';
    DBMS_OUTPUT.PUT_LINE('   ' || VEMPNO || '   ' || vename);
END;
/

SELECT * FROM emp;

-- 오지호의 job, mgr, deptno 출력
DECLARE
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vmgr emp.mgr%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN
    SELECT ename, job, mgr, deptno
    INTO vename, vjob, vmgr, vdeptno
    FROM emp
    WHERE ename = '오지호';
    DBMS_OUTPUT.PUT_LINE('-----------------------');
    DBMS_OUTPUT.PUT_LINE(vename || '   ' || Vjob || '   ' || vmgr || '   ' || vdeptno);
END;
/

-- IF-THEN-END-IF
-- IF-THEN-ELSE-END IF
-- IF-THEN_ELSIF-ELSE-END IF

-- 부서 번호로 부서명 알아내기
DECLARE
    VEMPNO emp.empno%TYPE;
    vename emp.ename%TYPE;
    vdeptno emp.deptno%TYPE;
    vdname VARCHAR2(20) := NULL;
BEGIN
    SELECT empno, ename, deptno
    INTO vempno, vename, vdeptno
    FROM emp
    WHERE empno = 1001;
    
IF (vdeptno = 10) THEN
    vdname := '영업부';
    END IF;
IF (vdeptno = 20) THEN
    vdname := '영업부';
    END IF;
IF (vdeptno = 30) THEN
    vdname := '영업부';
    END IF;
IF (vdeptno = 40) THEN
    vdname := '전산부';
    END IF;
DBMS_OUTPUT.PUT_LINE('-----------------------');
DBMS_OUTPUT.PUT_LINE(vempno || '   ' || vename || '   ' || vdeptno || '   ' || vdname);
END;
/

SELECT * FROM emp;
-- 김사랑의 연봉 구하기 (커미션 받으면 sal*12+comm 아니면 sal*12)
DECLARE
    vename emp.ename%TYPE;
    vsal emp.sal%TYPE;
    vcomm emp.comm%TYPE;
    vasal NUMBER(7, 2);
BEGIN
    SELECT ename, sal, comm
    INTO vename, vsal, vcomm
    FROM emp
    WHERE ename = '김사랑';
IF (vcomm IS NULL) THEN
    vasal := vsal*12;
ELSE
    vasal := vsal*12+vcomm;
    END IF;
DBMS_OUTPUT.PUT_LINE('-----------------------');
DBMS_OUTPUT.PUT_LINE(vename || '   ' || vsal || '   ' || vcomm || '   ' || vasal);
END;
/

-- 선생님 답
DECLARE
  VEMP EMP%ROWTYPE;
  ANNSAL NUMBER(7,2);
BEGIN
  SELECT * INTO VEMP FROM EMP WHERE ENAME='김사랑';
IF(VEMP.COMM IS NULL) THEN
   ANNSAL := VEMP.SAL * 12;
ELSE
   ANNSAL := VEMP.SAL * 12 + VEMP.COMM;
END IF;
  DBMS_OUTPUT.PUT_LINE('사번  이름   연봉');
  DBMS_OUTPUT.PUT_LINE('-----------------');
  DBMS_OUTPUT.PUT_LINE('  ' || VEMP.EMPNO || '  '  || VEMP.ENAME || '  ' || ANNSAL );
END;
/

-- ELSIF
DECLARE
   VEMPNO EMP.EMPNO%TYPE;
   VENAME EMP.ENAME%TYPE;
   VDEPTNO EMP.DEPTNO%TYPE;
   VDNAME VARCHAR2(20) := NULL;
BEGIN
  SELECT EMPNO, ENAME, DEPTNO
  INTO  VEMPNO,VENAME, VDEPTNO
  FROM EMP
  WHERE EMPNO = 1001;
  
  IF ( VDEPTNO = 10) THEN
     VDNAME := '경리부';
  ELSIF ( VDEPTNO = 20) THEN
     VDNAME := '인사부';
  ELSIF ( VDEPTNO = 30) THEN
     VDNAME := '영업부';
  ELSIF ( VDEPTNO = 40) THEN
     VDNAME := '전산부';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE(' 사번   이름  부서명 ');
  DBMS_OUTPUT.PUT_LINE('-------------------');
  DBMS_OUTPUT.PUT_LINE('  ' || VEMPNO || '  ' || VENAME || '   ' ||  VDNAME );
END;
/

-- 반복문 LOOP
DECLARE
BEGIN 
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE( N );
    END LOOP;
END;
/
-- 1 2 3 4 5 5회 돌게 되는 반복문임
DECLARE
    N NUMBER :=1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE ( N );
        N := N+1;
        IF N > 10 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/

-- 1~100 합 
DECLARE
    total NUMBER := 0;
BEGIN
    FOR n IN 1..100 LOOP
        DBMS_OUTPUT.PUT_LINE(n);
        total := total + n;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(total);
END;
/

DECLARE
    n NUMBER := 1;
    total NUMBER := 0;
BEGIN
    WHILE n <= 5 LOOP
    DBMS_OUTPUT.PUT_LINE(n);
    total := total + 1;
    n := n+1;
    END LOOP;
END;
/

-- 문제 S_EMP테이블에서 김사랑 사원의 업무가 영업이면 급여를 10%인상하고, 그렇지 않으면 5%인상시키도록 한다.
--DECLARE
--    vcsal NUMBER(7,2);
--BEGIN
--    SELECT * INTO s_emp FROM emp;




-- 선생님 답
CREATE TABLE s_emp
AS
SELECT * FROM emp;

SELECT * FROM s_emp;

DECLARE
    vemp s_emp%ROWTYPE;
    vdeptno s_emp.deptno%TYPE;
    vpercent NUMBER(2);
BEGIN
    SELECT deptno INTO vdeptno FROM dept WHERE dname LIKE ('%영업%');
    SELECT * INTO vemp FROM s_emp WHERE ename = '김사랑';
    
    IF vemp.deptno = vdeptno THEN
        vpercent := 10;
    ELSE
        vpercent := 5;
    END IF;
    
    UPDATE s_emp SET sal = sal + sal*vpercent/100 WHERE ename = '김사랑';
    COMMIT;
END;
/

SELECT * FROM s_emp WHERE ename = '김사랑';