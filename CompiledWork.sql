alter session set NLS_DATE_FORMAT = 'DD-MON-RR';

set echo off
set feedback off


DROP TABLE subscription cascade constraints;
DROP TABLE VIDEO cascade constraints;
DROP TABLE CHANNEL cascade constraints;
DROP TABLE USER_TABLE cascade constraints;

DROP SEQUENCE seq_subNumber;
DROP SEQUENCE seq_userNumber; 
DROP SEQUENCE seq_videoIDNumber;
DROP SEQUENCE seq_ArtificialID;
DROP SEQUENCE seq_channelID;


CREATE TABLE CHANNEL (
 CHANNEL_NUMBER	 		NUMBER(6) NOT NULL,
 CHANNEL_NAME					varchar2(12) NOT NULL,
 OWNER				VARCHAR2(12) NOT NULL,
 REGISTRATION_DATE		DATE NOT NULL,
 TOPIC_CODE				varchar2(2) NOT NULL,
 CONSTRAINT CHK_TOPIC	CHECK (REGEXP_LIKE(TOPIC_CODE, '[^I, O, Q, V, Z]', 'c')),
 CONSTRAINT WETUBE_CHANNEL_PRIMARY_KEY PRIMARY KEY (CHANNEL_NUMBER));


 CREATE TABLE USER_TABLE(
  userNumber 		NUMBER,
  userName			VARCHAR2(20) NOT NULL UNIQUE, 
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
userNum NUMBER NOT NULL,
chanNum NUMBER NOT NULL,
CONSTRAINT pk_subCode PRIMARY KEY (subCode),
FOREIGN KEY (userNum) REFERENCES USER_TABLE(userNumber),
FOREIGN KEY (chanNum) REFERENCES CHANNEL(CHANNEL_NUMBER));
  

CREATE SEQUENCE seq_subNumber 
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
NOCYCLE
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
NOCYCLE
NOCACHE;

CREATE SEQUENCE seq_channelID
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;

--FORMAT TABLE COLUMN--

COLUMN userName FORMAT A10;
COLUMN firstName FORMAT A10;
COLUMN lastName FORMAT A10;
COLUMN emailAddress FORMAT A24;
COLUMN dateOfBirth FORMAT A10;




INSERT INTO CHANNEL VALUES (seq_channelID.NEXTVAL, 'DOTA', 'The_Legend27', '17-FEB-2020', 'A1');
INSERT INTO CHANNEL VALUES (seq_channelID.NEXTVAL, 'LOL', 'omar21', '17-FEB-2020', 'A1');
INSERT INTO CHANNEL VALUES (seq_channelID.NEXTVAL, 'DARK SOULS 1', 'undeadxx', '17-FEB-2020', 'A1');
INSERT INTO CHANNEL VALUES (seq_channelID.NEXTVAL, 'Mario Kart', 'Mario21', '17-FEB-2020', 'A1');


INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user1', 'Asim', 'Rai', 'asimraii@yahoo.com', '23-AUG-1996');
INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user2', 'Misa', 'Iar', 'ar605@canterbury.ac.uk', '24-AUG-1997');
INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user3', 'Juan', 'Mendoza', 'juan@canterbury.ac.uk', '24-JAN-2007');



INSERT INTO subscription VAlUES (CONCAT('SUB', seq_subNumber.NEXTVAL), '03-JAN-2020','24-JAN-2020', 1,1);
INSERT INTO subscription VAlUES (CONCAT('SUB', seq_subNumber.NEXTVAL), '04-JAN-2020',NULL, 2,3);
INSERT INTO subscription VAlUES (CONCAT('SUB', seq_subNumber.NEXTVAL), '04-JAN-2020','25-JAN-2020', 1,3);
INSERT INTO subscription VAlUES (CONCAT('SUB', seq_subNumber.NEXTVAL), '04-JAN-2020',NULL, 2,3);
INSERT INTO subscription VAlUES (CONCAT('SUB', seq_subNumber.NEXTVAL), '05-JAN-2020',NULL, 3,4);



INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), seq_videoIDNumber.NEXTVAL) , CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, seq_ArtificialID.NEXTVAL);  
INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), seq_videoIDNumber.NEXTVAL), CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, seq_ArtificialID.NEXTVAL);  


 
 

set feedback on