-- 트리거
-- 예제 1)
-- 테이블에 데이터를 입력할 수 있는 시간 지정하기
-- 사용할 테이블 만들기
CREATE TABLE t_order (
    NO NUMBER,
    ord_code VARCHAR2(10),
    or_date DATE
    );
    
-- 생성한 테이블에 데이터를 입력할 때 입력 시간이 13:00 ~ 18:00일 경우에만 허용, 그 외는 에러 발생 트리거 만들기
CREATE OR REPLACE TRIGGER t_order -- 트리거 이름임
BEFORE INSERT ON t_order
BEGIN
    IF (to_char(sysdate, 'HH24:MI') NOT BETWEEN '00:00' AND '18:00') THEN
    raise_application_error (-20100, '허용 시간이 아닙니다.');
    END IF;
END;
/

-- 시스템 날짜 확인하기
SELECT sysdate FROM dual;

-- 삽입 해보기
INSERT INTO t_order VALUES (3, 'c100', sysdate);

SELECT * FROM t_order;

-- 예제 2)
-- 테이블에 입력될 데이터 값을 지정하고 그 값 외에는 에러 발생 트리거 생성 (행레벨 트리거)
-- 제품 코드가 'c100'인 경우만 허용
-- 트리거 생성
CREATE OR REPLACE TRIGGER t_order2
BEFORE INSERT ON t_order
FOR EACH ROW
    BEGIN
        IF (:NEW.ord_code) NOT IN ('c100') THEN
        raise_application_error(-20200, '제품 코드가 틀렸습니다.');
        END IF;
    END;
/

-- 데이터 삽입
INSERT INTO t_order VALUES (4, 'c100', sysdate); -- 입력 성공
INSERT INTO t_order VALUES (4, 'c200', sysdate); -- 에러 남

-- 예제 3)
-- 트리거에 WHERE절로 더 자세한 조건 정의
-- 제품 코드가 'c500'인 경우에만 19:30 ~ 19:35분까지 입력 가능 시간 제한
-- 그 이외는 정상 입력
-- 앞선 트리거들 조건 다 고쳐줘야 됨,,,,
-- 트리거 생성
CREATE OR REPLACE TRIGGER t_order3
BEFORE INSERT ON t_order
FOR EACH ROW
    WHEN (NEW.ord_code = 'c500')
    BEGIN
        IF(to_char(sysdate, 'HH24:MI') NOT BETWEEN '19:30' AND '19:35') THEN
        raise_application_error(-20300, 'c500 제품의 입력 허용시간이 아닙니다.');
        END IF;
    END;
/

INSERT INTO t_order VALUES (5, 'c500', sysdate);

-- 트리거 삭제
DROP TRIGGER t_order2;

-- 예제 4)
-- 급여 정보 자동으로 추가하는 트리거 생성
-- 급여 테이블 만들기
CREATE TABLE sal01 (
    salno NUMBER(4) PRIMARY KEY,
    sal NUMBER(7, 2),
    empno NUMBER(4) REFERENCES emp02(empno)
    );
    
DROP TABLE emp02;
CREATE TABLE emp02 (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(20),
    job VARCHAR2(20)
    );

-- 급여 번호 자동 생성 시퀀스
CREATE SEQUENCE sal01_salno_seq;

CREATE OR REPLACE TRIGGER trg_02
AFTER INSERT ON emp02
FOR EACH ROW
BEGIN 
    INSERT INTO sal01 VALUES (sal01_salno_seq.NEXTVAL, 100, :NEW.empno);
END;
/

-- emp02 테이블에 행이 추가되면 자동으로 트리거 수행 -> sal01 테이블에도 자동으로 행 추가
INSERT INTO emp02 VALUES (2, 'aaa', '과장');

SELECT * FROM emp02;
SELECT * FROM sal01;

-- 예제 5)
-- 1. 사용할 테이블 만들기
-- 1) 상품 테이블
CREATE TABLE 상품(
   상품코드 CHAR(6) PRIMARY KEY,
   상품명 VARCHAR2(12) NOT NULL,
   제조사 VARCHAR2(12),
   소비자가격 NUMBER(8),
   재고수량 NUMBER DEFAULT 0 );
   
-- 2) 입고 테이블 생성하기
  CREATE TABLE 입고 (
    입고번호 NUMBER(6) PRIMARY KEY, 
    상품코드 CHAR(6) REFERENCES 상품(상품코드),
    입고일자 DATE DEFAULT SYSDATE,
    입고수량 NUMBER(6),
    입고단가 NUMBER(8),
    입고금액 NUMBER(8) );
    
-- 3) 자료 삽입
INSERT INTO 상품 VALUES('A00001','세탁기','LG',200, 0);
INSERT INTO 상품 VALUES('A00002','컴퓨터','LG',700, 0);
INSERT INTO 상품 VALUES('A00003','냉장고','삼성',600, 0);

-- 4) 입고 테이블에 상품이 입력되면 입고수량을 상품테이블의 재고 수량에 추가하는 트리거를 작성

-- (1) 입고 트리거 생성하기
CREATE OR REPLACE TRIGGER TRG_04
  AFTER  INSERT ON 입고
  FOR EACH ROW
BEGIN
  UPDATE 상품 SET 재고수량 = 재고수량 + :NEW.입고수량
  WHERE  상품코드 = :NEW.상품코드;
END;
/

-- 5) 트리거를 실행시킨 후 입고 테이블에 행을 추가합니다. 입고 테이블에는 물론 상품 테이블의 재고 수량이 변경됨을 확인할 수 있습니다.
-- (1) 상품 입고하기
INSERT INTO 입고 (입고번호, 상품코드, 입고수량, 입고단가, 입고금액) VALUES(1,'A00001',5,320,1600);

-- (2) 입고테이블 조회하기
SELECT * FROM 입고;

-- (3) 상품 정보 조회하기
SELECT * FROM 상품;

-- 4) 입고테이블에 상품이 입력되면 자동으로 상품 테이블의 고 수량이 증가하게 됩니다.재