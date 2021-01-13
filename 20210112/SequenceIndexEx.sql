---- 인덱스 문제
--1. 부서 번호를 생성하는 시퀀스 객체를 생성하여 시퀀스 객체를 이용하여 부서 번호를 자동으로 생성하도록 해보세요.

--1) 부서테이블에 부서 번호를 자동으로 부여하기 위해서 부서 테이블을 생성합니다.

CREATE TABLE emp10
AS
SELECT * FROM emp;

DROP TABLE emp10;

SELECT * FROM dept10;

--2) 생성된 부서 테이블에 기본키 제약 조건이 설정되었는지 살펴 보기

SELECT * FROM user_constraints WHERE table_name IN ('DEPT10');

--3) 부서 번호를 저장하는 deptno 컬럼을 기본키로 설정하였으므로 중복된 값을 가질 수 없습니다.

ALTER TABLE dept10
    ADD CONSTRAINT deptno_PK PRIMARY KEY (deptno);

--새로운 row를 추가할 때마다 시퀀스에 의해서 부서 번호가 자동으로 부여되도록 하기

CREATE SEQUENCE deptno_seq;


--4) 사원 정보 삽입해 보기

INSERT INTO dept10 VALUES (deptno_seq.NEXTVAL, '부서이름', '위치');

--2. 사원테이블의 직급 인덱스를 생성하기

SELECT * FROM emp;

CREATE INDEX idx_emp_job ON emp(job);
SELECT * FROM user_ind_columns WHERE table_name IN('EMP');