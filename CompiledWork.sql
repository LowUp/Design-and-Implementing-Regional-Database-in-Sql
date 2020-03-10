alter session set NLS_DATE_FORMAT = 'DD-MON-RR';

set echo off
set feedback off



DROP TABLE subscription cascade constraints;
DROP TABLE VIDEO cascade constraints;
DROP TABLE CHANNEL cascade constraints;
DROP TABLE USER_TABLE cascade constraints;

DROP SEQUENCE seq_SubNumber;
DROP SEQUENCE seq_userNumber; 
DROP SEQUENCE seq_videoIDNumber;
DROP SEQUENCE seq_ArtificialID;
DROP SEQUENCE seq_channelID;

CREATE TABLE CHANNEL (
 CHANNEL_NUMBER	 	NUMBER(6) NOT NULL,
 CHANNEL_NAME		varchar2(12) NOT NULL,
 OWNER				VARCHAR2(12) NOT NULL,
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
  CONSTRAINT k_userName UNIQUE (userName),
  CONSTRAINT pk_userNumber PRIMARY KEY(userNumber));
  
  
CREATE TABLE VIDEO (
 vidARTIFICIAL 	NUMBER NOT NULL,
 ID					varchar(4) NOT NULL,
 TITLE				varchar(14) NOT NULL,
 UPLOAD_DATE		DATE NOT NULL,
 TAGS				varchar(10) NOT NULL,
 NUMBER_OF_VIEWS	NUMBER NOT NULL,
 CHANNEL_NUM		NUMBER NOT NULL,
UNIQUE (ID),
FOREIGN KEY (CHANNEL_NUM) REFERENCES CHANNEL(CHANNEL_NUMBER),
CONSTRAINT VIDEO_PRIMARY_KEY PRIMARY KEY (vidARTIFICIAL));

 

CREATE TABLE subscription(
subArtificial NUMBER NOT NULL,
subCode VARCHAR2(6),
subStart_Date DATE,
subEnd_Date DATE,
userNum NUMBER NOT NULL,
chanNum NUMBER NOT NULL,
CONSTRAINT k_subCode UNIQUE(subCode),
FOREIGN KEY (chanNum) REFERENCES CHANNEL(CHANNEL_NUMBER),   
FOREIGN KEY (userNum) REFERENCES USER_TABLE(userNumber),
CONSTRAINT fk_subArtificial PRIMARY KEY (subArtificial));
  

CREATE SEQUENCE seq_SubNumber 
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

CREATE SEQUENCE seq_videoIDNumber 
START WITH 10
INCREMENT BY 1
MINVALUE 10
MAXVALUE 99
CYCLE
NOCACHE;

CREATE SEQUENCE seq_ArtificialID 
START WITH 1
INCREMENT BY 1
NOCYCLE;

CREATE SEQUENCE seq_channelID
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;



--FORMAT USER TABLE COLUMN --

COLUMN userName FORMAT A10;
COLUMN firstName FORMAT A10;
COLUMN lastName FORMAT A10;
COLUMN emailAddress FORMAT A24;
COLUMN dateOfBirth FORMAT A10;





INSERT INTO CHANNEL VALUES (1, 'channel1', 'The_Legend27', '17-FEB-2020', 'A1');


INSERT INTO USER_TABLE VALUES (seq_channelID.nextval, 'user1', 'Asim', 'Rai', 'asimraii@yahoo.com', '23-AUG-1996');
INSERT INTO USER_TABLE VALUES (seq_channelID.nextval, 'user2', 'Misa', 'Iar', 'ar605@canterbury.ac.uk', '24-AUG-1997');
INSERT INTO USER_TABLE VALUES (seq_channelID.nextval, 'user3', 'Juan', 'Mendoza', 'juan@canterbury.ac.uk', '24-JAN-2007');


INSERT INTO subscription VAlUES (1 ,CONCAT('SUB', seq_SubNumber.NEXTVAL), '03-JAN-2020','24-JAN-2020', 1,1);
INSERT INTO subscription VAlUES (2 ,CONCAT('SUB', seq_SubNumber.NEXTVAL), '04-JAN-2020',NULL, 2,1);
INSERT INTO subscription VAlUES (3 ,CONCAT('SUB', seq_SubNumber.NEXTVAL), '04-JAN-2020','25-JAN-2020', 1,1);
INSERT INTO subscription VAlUES (4 ,CONCAT('SUB', seq_SubNumber.NEXTVAL), '04-JAN-2020',NULL, 2,1);
INSERT INTO subscription VAlUES (5 ,CONCAT('SUB', seq_SubNumber.NEXTVAL), '05-JAN-2020',NULL, 3,1);



INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), seq_videoIDNumber.NEXTVAL) , CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, 1);  
INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), seq_videoIDNumber.NEXTVAL), CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, 1);  


 
 

 
set feedback on