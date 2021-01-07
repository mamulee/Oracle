
SELECT * FROM dept01;

DROP TABLE emp01;
CREATE TABLE emp01(
  empno NUMBER(4),
  ename VARCHAR2(10) CONSTRAINT emp01_ename_nn NOT NULL,
  JOB VARCHAR2(9),
  deptno NUMBER(2),
  CONSTRAINT emp01_empno_pk PRIMARY KEY(empno),
  CONSTRAINT emp01_job_uk UNIQUE(JOB),
  CONSTRAINT emp01_deptno_fk FOREIGN KEY(deptno) REFERENCES dept01(deptno) );
  
INSERT INTO emp01 VALUES (1000, '허준', '사원', 10);

DELETE FROM dept01 WHERE deptno = 10;

-- foreign key 비활성화 => 부모 테이블에서 referenced 된 거 삭제나 암튼 뭐 하려고
ALTER TABLE emp02
    DISABLE CONSTRAINT emp02_deptno_fk;

INSERT INTO dept01 VALUES (10, '생산부', '이천');
-- 활성화 
ALTER TABLE emp01
    ENABLE CONSTRAINT emp01_deptno_fk;

SELECT * FROM emp01;
    
--------------------------------------------------
-- 부모 테이블의 기본키 제약조건 비활성화 => 연결된 자식 것까지 같이
-- Alter table dept01
    -- disable primary key; -- 자식이 있어서 안 됨
ALTER TABLE dept01
    DISABLE PRIMARY KEY CASCADE; -- 이러면 가능

ALTER TABLE dept01
    ENABLE PRIMARY KEY;

SELECT * FROM user_constraints WHERE table_name IN ('DEPT01', 'EMP01');

-----------------------------------------------
-- 문제

CREATE TABLE  employee01(
    emp_no NUMBER(4),
    emp_name VARCHAR2(20),
    salary  NUMBER(6),
    birthday  DATE );

CREATE TABLE  project01(
     pro_no NUMBER(4),
     pro_content VARCHAR2(100),
     start_date  DATE,
     finish_date DATE );

CREATE TABLE  specialty01(
     emp_no NUMBER(4),
     specialty   VARCHAR2(20)
);

CREATE TABLE assign01(
   emp_no NUMBER(4),
   pro_no NUMBER(4) );

ALTER TABLE employee01 
    ADD CONSTRAINT employee01_pk PRIMARY KEY(emp_no);
    
ALTER TABLE project01
    ADD CONSTRAINT project01_pk PRIMARY KEY (pro_no);
    
ALTER TABLE specialty01 
    ADD CONSTRAINT specialty01_pk PRIMARY KEY (specialty);
    
ALTER TABLE specialty01
    ADD CONSTRAINT specialty01_fk FOREIGN KEY (emp_no) REFERENCES employee01 (emp_no);

ALTER TABLE assign01
    ADD CONSTRAINT assign01_project_fk FOREIGN KEY (emp_no) REFERENCES employee01 (emp_no);

ALTER TABLE assign01
    ADD CONSTRAINT assign01_employee_fk FOREIGN KEY (pro_no) REFERENCES project01 (pro_no);

ALTER TABLE assign01
    ADD CONSTRAINT assign01_pk PRIMARY KEY (emp_no, pro_no);