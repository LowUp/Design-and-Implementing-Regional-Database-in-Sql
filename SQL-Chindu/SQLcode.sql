alter session set NLS_DATE_FORMAT = 'DD-MON-RR';
set feedback off
set term on
 
prompt
prompt Tables and sequences for Video database dropped.

prompt
prompt Creating and populating tables and sequences for Video database.  
prompt Please wait.
set term off

											/*Drop table*/
DROP TABLE VIDEO cascade constraints;
DROP TABLE SUBSCRIPTION cascade constraints;
DROP TABLE USER_TABLE cascade constraints; 
DROP SEQUENCE ID01;
DROP SEQUENCE ArtificialID;
DROP SEQUENCE NumViews;
DROP SEQUENCE seq_userNumber; 

											/*VIDEO TABLE*/
CREATE TABLE VIDEO (
 vidARTIFICIAL 	NUMBER NOT NULL,
 ID					varchar(4) NOT NULL,
 CHANNEL_NUMBER		NUMBER NOT NULL,
 TITLE				varchar(14) NOT NULL,
 POSTED_DATE		DATE NOT NULL,
 TAGS				varchar(10) NOT NULL,
 NUMBER_OF_VIEWS	NUMBER NOT NULL,
CONSTRAINT CHANNEL_FOREIGN_KEY FOREIGN KEY ( CHANNEL_NUMBER) REFERENCES CHANNEL (CHANNEL_NUMBER),
CONSTRAINT VideoUniqueKey UNIQUE (ID),
CONSTRAINT VIDEO_PRIMARY_KEY PRIMARY KEY (vidARTIFICIAL));


											/*SUBSCRIPTION TABLE*/
CREATE TABLE SUBSCRIPTION(
subArtificial NUMBER NOT NULL,
subCode varchar2(6),
userNum varchar2(10),
chanNum varchar2(10),
subStart_Date DATE,
subEnd_Date DATE,
CONSTRAINT pk_subCode PRIMARY KEY (subArtificial));

											/* User Table*/
											
 CREATE TABLE USER_TABLE(
  userNumber 		NUMBER NOT NULL,
  userName			varchar2(20) NOT NULL, /*MAKES UNIQUE*/
  firstName		    varchar2(10) NOT NULL,
  lastName			varchar2(10) NOT NULL,
  emailAddress		varchar2(30) NOT NULL,
  dateOfBirth		DATE NOT NULL,
  CONSTRAINT pk_userNumber PRIMARY KEY(userNumber));

  
 			/*CHANNEL TABLE*/
CREATE TABLE CHANNEL (
 CHANNEL_NUMBER	 		NUMBER(6) NOT NULL,
 OWNER					VARCHAR2(12) NOT NULL,
 CHANNEL_NAME			varchar2(12) NOT NULL,
 REGISTRATION_DATE		DATE NOT NULL,
 TOPIC_CODE				varchar2(2) NOT NULL,
 CONSTRAINT CHK_TOPIC	CHECK (REGEXP_LIKE(TOPIC_CODE, '[^I, O, Q, V, Z]', 'c')),
 CONSTRAINT WETUBE_CHANNEL_PRIMARY_KEY PRIMARY KEY (CHANNEL_NUMBER));


											/*SEQUENCES*/
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
NOCYCLE
NOCACHE;

CREATE SEQUENCE seq_userNumber
START WITH 1 
INCREMENT BY 1
MINVALUE 1
MAXVALUE 99
CYCLE
NOCACHE;



											/*INSERT VALUES*/
INSERT INTO SUBSCRIPTION VAlUES (3, 'code', 'A1', 'channel2', '17-FEB-2020', '17-FEB-2020');


INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), ID01.NEXTVAL) , ArtificialID.NEXTVAL ,CONCAT('Video No', ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0);  
INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), ID01.NEXTVAL) , ArtificialID.NEXTVAL ,CONCAT('Video No', ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0); 

INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user1', 'Asim', 'Rai', 'asimraii@yahoo.com', '23-AUG-1996');

INSERT INTO CHANNEL VALUES ('1', 'The_Legend27','channel1' , '17-FEB-2020', 'A1');
INSERT INTO CHANNEL VALUES ('1', 'The_Legend27','channel1' , '17-FEB-2020', 'A1');

set term on
set feedback on
prompt
prompt Tables and sequences for Video database 
prompt created and populated.
prompt
