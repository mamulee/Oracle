-- 복합키
drop table member01;

create table member01 (
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    CONSTRAINT member01_name_phone_pk Primary key(name, phone)
    );

select * from user_constraints where table_name in ('EMP02');
select * from dept01;

alter table emp02
    add constraint emp02_empno_pk primary key (empno);

alter table emp02
   add constraint emp02_deptno_fk foreign key (deptno) references dept01(deptno); -- 이미 존재해서 안 됨, 무튼 형식은 이렇게

alter table emp02
    modify ename constraint emp02_ename_nn NOT NULL;

alter table emp02
    drop constraint emp02_empno_pk;

alter table emp07
    drop primary key;