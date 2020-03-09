alter session set NLS_DATE_FORMAT = 'DD-MON-RR';

set echo off
set feedback off



DROP TABLE subscription cascade constraints;
DROP TABLE VIDEO cascade constraints;
DROP TABLE CHANNEL cascade constraints;
DROP TABLE USER_TABLE cascade constraints;

DROP SEQUENCE SubNumber;
DROP SEQUENCE seq_userNumber; 
DROP SEQUENCE ID01;
DROP SEQUENCE ArtificialID;


CREATE TABLE CHANNEL (
 CHANNEL_NUMBER	 		NUMBER(6) NOT NULL,
 NAME					varchar2(12) NOT NULL,
 USER_NAME				VARCHAR2(12) NOT NULL,
 REGISTRATION_DATE		DATE NOT NULL,
 TOPIC_CODE				varchar2(2) NOT NULL,
 CONSTRAINT CHK_TOPIC	CHECK (REGEXP_LIKE(TOPIC_CODE, '[^I, O, Q, V, Z]', 'c')),
 CONSTRAINT WETUBE_CHANNEL_PRIMARY_KEY PRIMARY KEY (CHANNEL_NUMBER));


 CREATE TABLE USER_TABLE(
  userNumber 		NUMBER,
  userName			VARCHAR2(20) NOT NULL, 
  firstName		    VARCHAR2(10) NOT NULL,
  lastName			VARCHAR2(10) NOT NULL,
  emailAddress		VARCHAR2(30) NOT NULL,
  dateOfBirth		DATE NOT NULL,
  CONSTRAINT pk_userNumber PRIMARY KEY(userNumber));
  
  

CREATE TABLE VIDEO (
 vidARTIFICIAL 	NUMBER NOT NULL,
 ID					varchar(4) NOT NULL,
 TITLE				varchar(14) NOT NULL,
 UPLOAD_DATE		DATE NOT NULL,
 TAGS				varchar(10) NOT NULL,
 NUMBER_OF_VIEWS	NUMBER NOT NULL,
 CHANNEL_NUM		NUMBER NOT NULL,
CONSTRAINT VideoUniqueKey UNIQUE (ID),
CONSTRAINT VIDEO_PRIMARY_KEY PRIMARY KEY (vidARTIFICIAL));

 

CREATE TABLE subscription(
subCode VARCHAR2(6),
subStart_Date DATE,
subEnd_Date DATE,
userNum NUMBER,
chanNum VARCHAR2(10),
CONSTRAINT pk_subCode PRIMARY KEY (subCode),
FOREIGN KEY (userNum) REFERENCES USER_TABLE(userNumber));
  

CREATE SEQUENCE SubNumber 
START WITH 100
INCREMENT BY 1
MINVALUE 100
MAXVALUE 999
NOCYCLE;

CREATE SEQUENCE seq_userNumber 
MINVALUE 1
MAXVALUE 99
START WITH 1 
INCREMENT BY 1
CYCLE
NOCACHE;

CREATE SEQUENCE ID01 
START WITH 10
INCREMENT BY 1
MINVALUE 10
MAXVALUE 99
CYCLE
NOCACHE;

CREATE SEQUENCE ArtificialID 
START WITH 1
INCREMENT BY 1
NOCYCLE;



INSERT INTO CHANNEL VALUES ('1', 'channel1', 'The_Legend27', '17-FEB-2020', 'A1');

INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user1', 'Asim', 'Rai', 'asimraii@yahoo.com', '23-AUG-1996');
INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user2', 'Misa', 'Iar', 'ar605@canterbury.ac.uk', '24-AUG-1997');

INSERT INTO subscription VAlUES (CONCAT('SUB', SubNumber.NEXTVAL), '03-JAN-2020','24-JAN-2020', 1,'Kiwezzee');
INSERT INTO subscription VAlUES (CONCAT('SUB', SubNumber.NEXTVAL), '04-JAN-2020',NULL, 2,'YOYA');
INSERT INTO subscription VAlUES (CONCAT('SUB', SubNumber.NEXTVAL), '04-JAN-2020',NULL, 1,'TossACoin');
INSERT INTO subscription VAlUES (CONCAT('SUB', SubNumber.NEXTVAL), '04-JAN-2020',NULL, 2,'TossACoin');

INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), ID01.NEXTVAL) , CONCAT('Video No', ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, ArtificialID.NEXTVAL);  
INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), ID01.NEXTVAL), CONCAT('Video No', ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, ArtificialID.NEXTVAL);  


 
 

 
set feedback on