-- Join

-- Equi Join
-- 학생 이름, 지도 교수 이름 출력
-- Oracle Join
SELECT s.name "학생이름", p.name "교수이름" FROM student s, professor p WHERE s.profno = p.profno;
-- ANSI Join
SELECT s.name "학생이름", p.name "교수이름" FROM student s JOIN professor p ON s.profno = p.profno;

SELECT s.name "학생이름", p.name "교수이름", d.dname "학과이름" FROM student s, professor p, department d WHERE s.profno = p.profno AND s.deptno1 = d.deptno;
SELECT s.name "학생이름", p.name "교수이름", d.dname "학과이름" FROM student s JOIN professor p ON s.profno = p.profno 
                                                                JOIN department d ON s.deptno1 = d.deptno;

SELECT s.name "학생이름", p.name "교수이름" FROM student s Join professor p ON s.profno = p.profno WHERE s.deptno1 = '101';

-- Non-Equi Join
SELECT * FROM customer;
SELECT * FROM gift;

SELECT c.gname "고객명", to_char(c.point, '999,999') "포인트", g.gname "상품" 
        FROM customer c JOIN gift g 
        ON c.point BETWEEN g.g_start AND g.g_end;
        
-- Outer Join
SELECT * FROM student;
-- Oracle Outer Join
SELECT s.name "학생이름", p.name "지도교수" FROM student s, professor p WHERE s.profno = p.profno(+);
-- ANSI Outer Join
SELECT s.name "학생이름", p.name "지도교수" FROM student s LEFT OUTER JOIN professor p ON s.profno = p.profno;

SELECT s.name "학생이름", p.name "지도교수" FROM student s, professor p WHERE s.profno(+) = p.profno;
SELECT s.name "학생이름", p.name "지도교수" FROM student s RIGHT OUTER JOIN professor p ON s.profno = p.profno;

SELECT s.name "학생이름", p.name "지도교수" FROM student s, professor p WHERE s.profno = p.profno(+)
UNION
SELECT s.name "학생이름", p.name "지도교수" FROM student s, professor p WHERE s.profno(+) = p.profno;
SELECT s.name "학생이름", p.name "지도교수" FROM student s FULL OUTER JOIN professor p ON s.profno = p.profno;