-- 데이터베이스 구현 시험
CREATE TABLE doctor (
    id NUMBER(4) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    gender VARCHAR2(1),
    tel VARCHAR2(20),
    email VARCHAR2(40),
    position VARCHAR2(20),
    subject VARCHAR(20) NOT NULL
    );
    
CREATE TABLE nurse (
    id NUMBER(4) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    gender VARCHAR2(1),
    tel VARCHAR2(20),
    email VARCHAR2(40),
    position VARCHAR2(20),
    task VARCHAR(20)
    );

CREATE TABLE patient (
    id NUMBER(4) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    gender VARCHAR2(1),
    pID VARCHAR2(20) NOT NULL,
    tel VARCHAR2(20),
    email VARCHAR2(40),
    address VARCHAR2(40),
    job VARCHAR2(10),
    doctor NUMBER(4) NOT NULL,
    nurse NUMBER(4) NOT NULL,
    CONSTRAINT patient_doctor_FK FOREIGN KEY (doctor) REFERENCES doctor(id),
    CONSTRAINT patient_nurse_FK FOREIGN KEY (nurse) REFERENCES nurse(id)
    );

CREATE TABLE exam (
    id NUMBER(4) PRIMARY KEY,
    doctor NUMBER(4) NOT NULL,
    nurse NUMBER(4) NOT NULL,
    patient NUMBER(4) NOT NULL,
    notes VARCHAR2(40),
    exam_date DATE,
    CONSTRAINT exam_doctor_FK FOREIGN KEY (doctor) REFERENCES doctor(id),
    CONSTRAINT exam_nurse_FK FOREIGN KEY (nurse) REFERENCES nurse(id),
    CONSTRAINT exam_patient_FK FOREIGN KEY (patient) REFERENCES patient(id)
    );

CREATE TABLE chart (
    id NUMBER(4) PRIMARY KEY,
    doctor NUMBER(4) NOT NULL,
    nurse NUMBER(4) NOT NULL,
    patient NUMBER(4) NOT NULL,
    exam NUMBER(4) NOT NULL,
    doctor_notes VARCHAR2(40),
    CONSTRAINT chart_doctor_FK FOREIGN KEY (doctor) REFERENCES doctor(id),
    CONSTRAINT chart_nurse_FK FOREIGN KEY (nurse) REFERENCES nurse(id),
    CONSTRAINT chart_patient_FK FOREIGN KEY (patient) REFERENCES patient(id),
    CONSTRAINT chart_exam_FK FOREIGN KEY (exam) REFERENCES exam(id)
    );
    


INSERT INTO doctor VALUES (1, '홍의사', 'M', '01012341234', 'h@h.com', '레지던트', '외과');
INSERT INTO doctor VALUES (2, '김의사', 'M', '01012341234', 'h@h.com', '인턴', '내과');
INSERT INTO doctor VALUES (3, '박의사', 'F', '01012341234', 'h@h.com', '원장', '신경과');
SELECT * FROM doctor;

INSERT INTO nurse VALUES (1, '홍간호', 'M', '01012341234', 'h@h.com', '대리', '진료 접수');
INSERT INTO nurse VALUES (2, '김간호', 'M', '01012341234', 'h@h.com', '대리', '진료 접수');
INSERT INTO nurse VALUES (3, '박간호', 'M', '01012341234', 'h@h.com', '과장', '차트 관리');
SELECT * FROM nurse;

INSERT INTO patient (id, name, pID, doctor, nurse) VALUES (1, '이환자', '0001104000120', 1, 1);
INSERT INTO patient (id, name, pID, doctor, nurse) VALUES (2, '김환자', '0001202000120', 2, 2);
INSERT INTO patient (id, name, pID, doctor, nurse) VALUES (3, '최환자', '0001603000120', 3, 3);
SELECT * FROM patient;

INSERT INTO exam VALUES (1, 1, 1, 1, '발목 골절', to_date('2021-01-01','yyyy-mm-dd'));
INSERT INTO exam VALUES (2, 2, 2, 2, '갈비뼈 사진', to_date('2021-01-02','yyyy-mm-dd'));
INSERT INTO exam VALUES (3, 3, 3, 3, '내시경', to_date('2021-01-03','yyyy-mm-dd'));
SELECT * FROM exam;

INSERT INTO chart VALUES (1, 1, 1, 1, 1, '수술 필요');
INSERT INTO chart VALUES (2, 2, 2, 2, 2, '이상 없음');
INSERT INTO chart VALUES (3, 3, 3, 3, 3, '약 처방');
SELECT * FROM chart;