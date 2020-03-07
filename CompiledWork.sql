alter session set NLS_DATE_FORMAT = 'DD-MON-RR';

set echo off
set feedback off

			/*Drop table*/
DROP TABLE CHANNEL cascade constraints;
DROP TABLE subscription cascade constraints;
DROP TABLE VIDEO cascade constraints;
DROP SEQUENCE ID01;
DROP SEQUENCE ArtificialID;
DROP SEQUENCE NumViews;
DROP TABLE USER_TABLE cascade constraints; 
DROP SEQUENCE seq_userNumber; 



			/*CHANNEL TABLE*/
CREATE TABLE CHANNEL (
 CHANNEL_NUMBER	 		NUMBER(6) NOT NULL,
 NAME					varchar2(12) NOT NULL,
 USER_NAME				VARCHAR2(12) NOT NULL,
 REGISTRATION_DATE		DATE NOT NULL,
 TOPIC_CODE				varchar2(2) NOT NULL,
 CONSTRAINT CHK_TOPIC	CHECK (REGEXP_LIKE(TOPIC_CODE, '[^I, O, Q, V, Z]', 'c')),
 CONSTRAINT WETUBE_CHANNEL_PRIMARY_KEY PRIMARY KEY (CHANNEL_NUMBER));
 

 
			/*SUBSCRIPTION TABLE*/
CREATE TABLE subscription(
subCode VARCHAR2(6),
subStart_Date DATE,
subEnd_Date DATE,
userNum VARCHAR2(10),
chanNum VARCHAR2(10),
CONSTRAINT pk_subCode PRIMARY KEY (subCode));



			/*VIDEO TABLE*/
CREATE TABLE VIDEO (
 vidARTIFICIAL 	NUMBER NOT NULL,
 ID					varchar(4) NOT NULL,
 TITLE				varchar(14) NOT NULL,
 UPLOAD_DATE		DATE NOT NULL,
 TAGS				varchar(10) NOT NULL,
 NUMBER_OF_VIEWS	NUMBER NOT NULL,
 CHANNEL_NUMBER		NUMBER NOT NULL,
 /*CONSTRAINT CHANNEL_FOREIGN_KEY FOREIGN KEY ( CHANNEL_NUMBER) REFERENCES CHANNEL (CHANNEL_NUMBER),*/
CONSTRAINT VideoUniqueKey UNIQUE (ID),
CONSTRAINT VIDEO_PRIMARY_KEY PRIMARY KEY (vidARTIFICIAL));



			/* User Table*/
 CREATE TABLE USER_TABLE(
  userNumber 		NUMBER,
  userName			VARCHAR2(20) NOT NULL, /*MAKE UNIQUE*/
  firstName		    VARCHAR2(10) NOT NULL,
  lastName			VARCHAR2(10) NOT NULL,
  emailAddress		VARCHAR2(30) NOT NULL,
  dateOfBirth		DATE NOT NULL,
  CONSTRAINT pk_userNumber PRIMARY KEY(userNumber));
  
  

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
NOCYCLE;


CREATE SEQUENCE seq_userNumber
MINVALUE 1
MAXVALUE 99
START WITH 1 
INCREMENT BY 1
CYCLE
NOCACHE;


			/*INSERT VALUES*/
INSERT INTO CHANNEL VALUES ('1', 'channel1', 'The_Legend27', '17-FEB-2020', 'A1');

INSERT INTO subscription VAlUES ('A1', '03-JAN-2020','24-JAN-2020', 'Brosey21','Kiwezzee');
INSERT INTO subscription VAlUES ('A2', '04-JAN-2020','02-FEB-2020', 'Lolipop','YOYA');
INSERT INTO subscription VAlUES ('A3', '04-JAN-2020',NULL, 'Witcher','TossACoin');
 
INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), ID01.NEXTVAL) , CONCAT('Video No', ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, ArtificialID.NEXTVAL);  
INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), ID01.NEXTVAL), CONCAT('Video No', ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, ArtificialID.NEXTVAL);  

INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user1', 'Asim', 'Rai', 'asimraii@yahoo.com', '23-AUG-1996');
INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user2', 'Misa', 'Iar', 'ar605@canterbury.ac.uk', '24-AUG-1997');
 
 
 
			/*VIEWS*/
 /*CREATE VIEW REL AS
SELECT REPID, ORD.CUSTID, CUSTOMER.NAME CUSTNAME, PRODUCT.PRODID,
*/
 
set feedback on