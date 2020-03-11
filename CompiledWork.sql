alter session set NLS_DATE_FORMAT = 'DD-MON-RR';

set echo off
set feedback off

prompt ***** WELCOME TO WETUBE DATABASE *****
prompt 
prompt - This database is made by Group number 2 
prompt Computing Year 2
prompt


--Drop table and sequence

DROP TABLE subscription cascade constraints;
DROP TABLE VIDEO cascade constraints;
DROP TABLE CHANNEL cascade constraints;
DROP TABLE USER_TABLE cascade constraints;

DROP SEQUENCE seq_SubNumber;
DROP SEQUENCE seq_UserPrimaryID;
DROP SEQUENCE seq_SubscriptionPrimaryID;
DROP SEQUENCE seq_ChannelPrimaryID;
DROP SEQUENCE seq_videoIDNumber;
DROP SEQUENCE seq_ArtificialID;



--Creating tables

CREATE TABLE CHANNEL (
 channelID	 	NUMBER NOT NULL,
 channelName		varchar2(20) NOT NULL,
 owner				VARCHAR2(20) NOT NULL,
 registrationDate		DATE NOT NULL,
 topicCode				varchar2(2) NOT NULL,
 CONSTRAINT CHK_TOPIC	CHECK (REGEXP_LIKE(topicCode, '[^I, O, Q, V, Z]', 'c')),
 CONSTRAINT WETUBE_CHANNEL_PRIMARY_KEY PRIMARY KEY (channelID));



 CREATE TABLE USER_TABLE(
  userID 		NUMBER NOT NULL,
  userName			VARCHAR2(20) NOT NULL, 
  firstName		    VARCHAR2(35) NOT NULL,
  lastName			VARCHAR2(35) NOT NULL,
  emailAddress		VARCHAR2(40) NOT NULL,
  dateOfBirth		DATE NOT NULL CHECK((select trunc((sysdate - dateofbirth)/365) from user_table)=13),
  CONSTRAINT k_userName UNIQUE (userName),
  CONSTRAINT pk_userNumber PRIMARY KEY(userID));
  
  
CREATE TABLE VIDEO (
 vidArtificial_PK 	NUMBER NOT NULL,
 identifier					varchar(4) NOT NULL,
 title				varchar(14) NOT NULL,
 postDate		DATE NOT NULL,
 tags				varchar(10) NOT NULL,
 numberOfViews	NUMBER NOT NULL,
 channelID		NUMBER NOT NULL,
UNIQUE (identifier),
FOREIGN KEY (channelID) REFERENCES CHANNEL(channelID),
CONSTRAINT VIDEO_PRIMARY_KEY PRIMARY KEY (vidArtificial_PK));

 
CREATE TABLE subscription(
subArtificial_PK NUMBER NOT NULL,
subCode VARCHAR2(6),
subStart_Date DATE,
subEnd_Date DATE,
userID NUMBER NOT NULL,
channelID NUMBER NOT NULL,
CONSTRAINT k_subCode UNIQUE(subCode),
FOREIGN KEY (channelID) REFERENCES CHANNEL(channelID),   
FOREIGN KEY (userID) REFERENCES USER_TABLE(userID),
CONSTRAINT fk_subArtificial PRIMARY KEY (subArtificial_PK,subCode));


--Creating Sequence

CREATE SEQUENCE seq_SubNumber 
START WITH 100
INCREMENT BY 1
MINVALUE 100
MAXVALUE 999
NOCYCLE;

CREATE SEQUENCE seq_UserPrimaryID 
START WITH 1 
INCREMENT BY 1
NOCYCLE
NOCACHE;

CREATE SEQUENCE seq_SubscriptionPrimaryID 
START WITH 1 
INCREMENT BY 1
NOCYCLE
NOCACHE;

CREATE SEQUENCE seq_ChannelPrimaryID 
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
NOCYCLE;




--FORMAT USER TABLE COLUMN --

--user table
COLUMN userName FORMAT A10;
COLUMN firstName FORMAT A10;
COLUMN lastName FORMAT A10;
COLUMN emailAddress FORMAT A24;
COLUMN dateOfBirth FORMAT A11;

--video table

COLUMN identifier FORMAT A5;
COLUMN title FORMAT A10;
COLUMN postDate FORMAT A10;
COLUMN tags FORMAT A10;

--subscription table
COLUMN subCode FORMAT A7;
COLUMN subStart_Date FORMAT A13;
COLUMN subEnd_Date FORMAT A11;




--test data

INSERT INTO CHANNEL VALUES (seq_ChannelPrimaryID.NEXTVAL, 'ClashOfClanz', 'The_Legend27', '17-FEB-2020', 'A1');
INSERT INTO CHANNEL VALUES (seq_ChannelPrimaryID.NEXTVAL, 'HowsItGoing', 'PEWDEAPPLE', '18-FEB-2020', 'A2');
INSERT INTO CHANNEL VALUES (seq_ChannelPrimaryID.NEXTVAL, 'Fallout4Radio', 'Clinton21', '18-FEB-2020', 'A3');


INSERT INTO USER_TABLE VALUES (seq_UserPrimaryID.NEXTVAL, 'user1', 'Asim', 'Rai', 'asimraii@yahoo.com', '23-AUG-1996');
INSERT INTO USER_TABLE VALUES (seq_UserPrimaryID.NEXTVAL, 'user2', 'Misa', 'Iar', 'ar605@canterbury.ac.uk', '24-AUG-1997');
INSERT INTO USER_TABLE VALUES (seq_UserPrimaryID.NEXTVAL, 'user3', 'Juan', 'Mendoza', 'juan@canterbury.ac.uk', '24-JAN-2007');


INSERT INTO subscription VAlUES (seq_SubscriptionPrimaryID.NEXTVAL, CONCAT('SUB', seq_SubNumber.NEXTVAL), '03-JAN-2020','24-JAN-2020', 1,1);
INSERT INTO subscription VAlUES (seq_SubscriptionPrimaryID.NEXTVAL, CONCAT('SUB', seq_SubNumber.NEXTVAL), '04-JAN-2020',NULL, 2,1);
INSERT INTO subscription VAlUES (seq_SubscriptionPrimaryID.NEXTVAL, CONCAT('SUB', seq_SubNumber.NEXTVAL), '04-JAN-2020','25-JAN-2020', 1,1); 
INSERT INTO subscription VAlUES (seq_SubscriptionPrimaryID.NEXTVAL, CONCAT('SUB', seq_SubNumber.NEXTVAL), '04-JAN-2020',NULL, 2,1);
INSERT INTO subscription VAlUES (seq_SubscriptionPrimaryID.NEXTVAL, CONCAT('SUB', seq_SubNumber.NEXTVAL), '05-JAN-2020',NULL, 3,1);



INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), seq_videoIDNumber.NEXTVAL) , CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, 1);

INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), seq_videoIDNumber.NEXTVAL), CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, 1);  


 
set feedback on