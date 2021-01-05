
CREATE TABLE employee (emp_no NUMBER(4) PRIMARY KEY,
                        emp_name VARCHAR2(20) NOT NULL,
                        salary NUMBER(6),
                        birthday DATE
                        );
                        
-- 이렇게 해도 됨                        
--CREATE TABLE employee (emp_no NUMBER(4) NOT NULL,
--                        emp_name VARCHAR2(20) NOT NULL,
--                        salary NUMBER(6),
--                        birthday DATE
--                        CONSTRAINT employee_PK PRIMARY KEY(emp_no)
--                        );

CREATE TABLE specialty (emp_no NUMBER(4) NOT NULL,
                        specialty VARCHAR2(20) NOT NULL,
                        
                        CONSTRAINT specialty_pk PRIMARY KEY(emp_no, specialty),
                        CONSTRAINT specialty_fk FOREIGN KEY (emp_no) REFERENCES employee(emp_no)
                        );

CREATE TABLE PROJECT (pro_no NUMBER(4) PRIMARY KEY,
                        pro_content VARCHAR2(100) NOT NULL,
                        start_date DATE,
                        finish_date DATE
                        );

CREATE TABLE assign (emp_no NUMBER(4) NOT NULL,
                        pro_no NUMBER(4) NOT NULL,
                        
                        CONSTRAINT assign_FK FOREIGN KEY (emp_no) REFERENCES employee(emp_no),
                        CONSTRAINT assign_FK1 FOREIGN KEY (pro_no) REFERENCES PROJECT(pro_no) 
                        );

-- Oracle ppt P 107 ~

CREATE TABLE emp01 (
            empno NUMBER(4),
            ename VARCHAR2(14),
            sal NUMBER(7, 3)
            );
            
-- 테이블 구조 보기
Desc Emp01;

-- 테이블 수정
-- 추가 (add), 변경 (modify), 삭제 (drop)

ALTER TABLE emp01
    ADD (birth DATE);

ALTER TABLE emp01
    ADD (memo varchar2(100));

ALTER TABLE emp01
    MODIFY (ename varchar2(30));

ALTER TABLE emp01
    DROP COLUMN memo;
ALTER TABLE emp01
    DROP COLUMN birth;

-- 사용하지 않는
ALTER TABLE emp01
    SET UNUSED (empno);
    
-- 테이블 명 바꾸기
RENAME emp01 TO emp02;
DESC emp02;

--alter table 테이블명 rename columne 컬럼명 to 바꿀컬럼명;
RENAME emp02 TO emp01;

INSERT INTO emp01 (ename, sal) VALUES ('홍길동', 200);
INSERT INTO emp01 (ename, sal) VALUES ('김길동', 300);

SELECT * FROM emp01;

--테이블의 레코드 지우기 -> 해당하는 테이블의 레코드를 모두 지움 (잘라냄) truncate 
TRUNCATE TABLE emp01;

-- 데이터 딕셔너리
SELECT table_name FROM user_tables;



