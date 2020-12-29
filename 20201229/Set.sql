
CREATE TABLE group_star (name VARCHAR2(8));

INSERT INTO group_star VALUES('A');
INSERT INTO group_star VALUES('B');
INSERT INTO group_star VALUES('C');
INSERT INTO group_star VALUES('D');
INSERT INTO group_star VALUES('E');
INSERT INTO group_star VALUES('F');
INSERT INTO group_star VALUES('G');
INSERT INTO group_star VALUES('H');

SELECT * FROM group_star;

CREATE TABLE single_star (NAME VARCHAR2(8));
INSERT INTO single_star VALUES('E');
INSERT INTO single_star VALUES('F');
INSERT INTO single_star VALUES('G');
INSERT INTO single_star VALUES('H');
INSERT INTO single_star VALUES('I');
INSERT INTO single_star VALUES('J');
INSERT INTO single_star VALUES('K');
INSERT INTO single_star VALUES('L');

-- 합집합
-- 중복되는 거 제거
SELECT * FROM group_star UNION SELECT * FROM single_star;
-- 중복되는 거까지 다 
SELECT * FROM group_star UNION ALL SELECT * FROM single_star;

-- 교집합 (중복되는 거만 있는 것)
SELECT * FROM group_star INTERSECT SELECT *FROM single_star;

-- 차집합 (교집합을 뺀 것)
SELECT * FROM group_star MINUS SELECT *FROM single_star;
SELECT * FROM single_star MINUS SELECT *FROM group_star;