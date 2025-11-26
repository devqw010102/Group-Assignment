CREATE TABLE member(
    id VARCHAR2(20) PRIMARY KEY,
    password VARCHAR2(20) NOT NULL,
    name VARCHAR2(10) NOT NULL,
    gender VARCHAR2(10),
    birth VARCHAR2(10),
    mail VARCHAR2(30),
    phone VARCHAR2(20),
    address VARCHAR2(90),
    regist_day DATE DEFAULT SYSDATE
);

SELECT * FROM MEMBER;

DESC member;

INSERT INTO member VALUES('admin', 'admin1234', '관리자', null, null, null, null, null, null);
INSERT INTO member(id, password, name, gender, birth, mail, phone, address) VALUES('TEST', 'TEST1234', '테스트', '남', '2001-01-02', 'test@gmail.com', '010-1234-5678', '울산');

SELECT * FROM MEMBER WHERE ID = 'admin';

UPDATE MEMBER SET gender = '미입력' WHERE ID = 'test';



ALTER TABLE member
    MODIFY gender VARCHAR2(10);

commit;

--DROP TABLE MEMBER;

