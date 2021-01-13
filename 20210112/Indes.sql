-- 인덱스

SELECT * FROM user_ind_columns WHERE table_name IN ('EMP', 'EMP01'); 

--인덱스 조회
SELECT * FROM user_indexes;
SELECT * FROM user_ind_columns;

DROP TABLE emp01;

CREATE TABLE emp01 
AS
SELECT * FROM emp;

--emp인덱스 확인
--emp01 인덱스 확인
SELECT * FROM USER_IND_COLUMNS WHERE table_name IN ('EMP', 'EMP01');

--emp01에 데이터 삽입
INSERT INTO emp01 SELECT * FROM emp01;

INSERT INTO emp01 (empno, ename) VALUES (2222,'syj');

SET TIMING ON SELECT DISTINCT empno, ename FROM emp01 WHERE ename = 'syj';


--인덱스 생성
CREATE INDEX idx_emp01_ename ON emp01(ename);

-- 인덱스 제거
DROP INDEX idx_emp01_ename;

-- 인덱스 종류

CREATE TABLE dept10
AS
SELECT * FROM dept where 1=0;

desc dept10;

INSERT INTO dept10 VALUES (10, '인사과', '서울');
INSERT INTO dept10 VALUES (20, '총무과', '대전');
INSERT INTO dept10 VALUES (30, '교육팀', '대전');

-- 고유 인덱스 지정
CREATE UNIQUE INDEX idx_dept10_deptno ON dept10 (deptno);
CREATE UNIQUE INDEX idx_dept10_loc ON dept10 (loc);  -- loc에는 중복된 값이 있기 때문에 고유 인덱스 지정 불가
CREATE UNIQUE INDEX idx_dept10_dname ON dept10 (dname);
-- 비고유 인덱스 지정
CREATE INDEX idx_dept10_loc ON dept10 (loc);

DROP INDEX idx_dept10_deptno;
DROP INDEX idx_dept10_dname;
DROP INDEX idx_dept10_loc;

-- 결합 인덱스 
CREATE INDEX idx_dept10_deptno_dname ON dept10(deptno, dname);
SELECT * FROM user_ind_columns WHERE table_name IN('DEPT10');

-- 함수 기반 인덱스
CREATE INDEX idx_emp01_annsal ON emp01 (sal*12);
SELECT * FROM emp01;