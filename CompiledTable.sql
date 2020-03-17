alter session set NLS_DATE_FORMAT = 'DD-MON-RR';

set echo off
set feedback off
set serveroutput on;


prompt ***** WELCOME TO WETUBE DATABASE *****
prompt 
prompt - This database is made by Group number 2 
prompt Computing Year 2


prompt
prompt **************************************

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
DROP SEQUENCE seq_VideoID;





--Creating Sequence

CREATE SEQUENCE seq_SubNumber 
START WITH 100
INCREMENT BY 1
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



CREATE SEQUENCE seq_VideoID 
START WITH 1
INCREMENT BY 1 
NOCYCLE
NOCACHE;



CREATE SEQUENCE seq_ArtificialID 
START WITH 1
INCREMENT BY 1
NOCYCLE;




--Creating tables

CREATE TABLE CHANNEL (
 channelID	 	NUMBER NOT NULL,
 channelName		varchar2(20) NOT NULL,
 owner				VARCHAR2(20) NOT NULL,
 registrationDate		DATE NOT NULL,
 topicCode				varchar2(2) NOT NULL,
 CONSTRAINT CHK_TOPIC	CHECK (REGEXP_LIKE(topicCode, '[^I, O, Q, V, Z]', 'i')),
 CONSTRAINT WETUBE_CHANNEL_PRIMARY_KEY PRIMARY KEY (channelID));



 CREATE TABLE USER_TABLE(
  userID 		NUMBER NOT NULL,
  userName			VARCHAR2(20) NOT NULL, 
  firstName		    VARCHAR2(35) NOT NULL,
  lastName			VARCHAR2(35) NOT NULL,
  emailAddress		VARCHAR2(40) NOT NULL,
  dateOfBirth		DATE NOT NULL,
  CONSTRAINT chk_dateAge CHECK((2020 - EXTRACT(year from dateOfBirth) ) >= 13), 
  CONSTRAINT ak_userName UNIQUE (userName),
  CONSTRAINT pk_userNumber PRIMARY KEY(userID));
  
  
  
CREATE TABLE VIDEO (
 vidArtificial_PK 	NUMBER NOT NULL,
 identifier			varchar2(4) NOT NULL,
 title				varchar2(14) NOT NULL,
 postDate		DATE NOT NULL,
 tags				varchar(10) NOT NULL,
 numberOfViews	NUMBER NOT NULL,
 channelID		NUMBER NOT NULL,
CONSTRAINT ak_identifier UNIQUE (identifier),	
FOREIGN KEY (channelID) REFERENCES CHANNEL(channelID),
CONSTRAINT VIDEO_PRIMARY_KEY PRIMARY KEY (vidArtificial_PK));


CREATE TABLE subscription(
subArtificial_PK NUMBER NOT NULL UNIQUE,
subCode VARCHAR2(6) UNIQUE, 
subStart_Date DATE NOT NULL,
subEnd_Date DATE,
userID NUMBER NOT NULL,
channelID NUMBER NOT NULL,
FOREIGN KEY (channelID) REFERENCES CHANNEL(channelID),   
FOREIGN KEY (userID) REFERENCES USER_TABLE(userID),
CONSTRAINT fk_subArtificial PRIMARY KEY (subArtificial_PK,subCode),
CONSTRAINT combineID UNIQUE (userID, channelID, subEnd_Date));





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


--																									ALTER SUBSCRIPTION TABLE.


--Setting default for subCode
ALTER TABLE subscription
Modify subCode VARCHAR2(255) DEFAULT ('SUB' || seq_SubNumber.NEXTVAL);

--Setting default for subStart_Date
ALTER TABLE subscription
Modify subStart_Date DATE DEFAULT TO_CHAR(SYSDATE, 'DD-MON-RR');

--Setting defaukt for subArtificial_PK
ALTER TABLE subscription
Modify subArtificial_PK NUMBER DEFAULT seq_SubscriptionPrimaryID.NEXTVAL;

--																									ALTER VIDEO TABLE


--Setting up default for vidArtificial_PK
ALTER TABLE VIDEO
Modify vidArtificial_PK NUMBER DEFAULT seq_VideoID.NEXTVAL;

--Setting up default for identifier
ALTER TABLE VIDEO
Modify identifier VARCHAR2(255) DEFAULT ('RD' || seq_videoIDNumber.NEXTVAL);

--Setting up default for postDate
ALTER TABLE VIDEO
Modify postDate DATE DEFAULT TO_CHAR(SYSDATE, 'DD-MON-RR');



-- 																									ALTER USER TABLE

--Setting up default for userID
ALTER TABLE USER_TABLE
Modify userID NUMBER DEFAULT seq_UserPrimaryID.NEXTVAL;

																										
-- 																									ALTER CHANNEL TABLE
--Setting up default for channelID
ALTER TABLE CHANNEL
Modify channelID NUMBER DEFAULT seq_ChannelPrimaryID.NEXTVAL;


--Setting up default for registrationDate
ALTER TABLE CHANNEL
Modify registrationDate DATE DEFAULT TO_CHAR(SYSDATE, 'DD-MON-RR');

--																									TEST DATA

INSERT INTO CHANNEL VALUES (seq_ChannelPrimaryID.NEXTVAL, 'ClashOfClanz', 'The_Legend27', TO_CHAR(SYSDATE, 'DD-MON-RR'), 'A1');
INSERT INTO CHANNEL VALUES (seq_ChannelPrimaryID.NEXTVAL, 'HowsItGoing', 'PEWDEAPPLE', TO_CHAR(SYSDATE, 'DD-MON-RR'), 'A2');
INSERT INTO CHANNEL VALUES (seq_ChannelPrimaryID.NEXTVAL, 'Fallout4Radio', 'Clinton21', TO_CHAR(SYSDATE, 'DD-MON-RR'), 'A3');

INSERT INTO CHANNEL (channelName, owner, registrationDate, topicCode) 
VALUES ('clanzER', 'Legend45', '19-FEB-2020', 'A4');
INSERT INTO CHANNEL (channelName, owner, topicCode) 
VALUES ('clanzER', 'Legend45', 'A4');

INSERT INTO USER_TABLE VALUES (seq_UserPrimaryID.NEXTVAL, 'user1', 'rooM', 'aRi', 'asimraii@yahoo.com', '23-AUG-1996');
INSERT INTO USER_TABLE VALUES (seq_UserPrimaryID.NEXTVAL, 'user2', 'Misa', 'Iar', 'fr76@room.fr', '24-AUG-1997');
INSERT INTO USER_TABLE VALUES (seq_UserPrimaryID.NEXTVAL, 'user3', 'Juan', 'Mendoza', 'juan@canterbury.ac.uk', '21-AUG-1999');

INSERT INTO USER_TABLE (userName, firstName, lastName, emailAddress, dateOfBirth) 
VALUES ('user67', 'roM', 'Ri', 'asdef@krukru.com', '12-AUG-1999');

INSERT INTO subscription VAlUES (seq_SubscriptionPrimaryID.NEXTVAL, CONCAT('SUB', seq_SubNumber.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'),'24-JAN-2020', 2,1);
INSERT INTO subscription VAlUES (seq_SubscriptionPrimaryID.NEXTVAL, CONCAT('SUB', seq_SubNumber.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'),'25-JAN-2020', 1,1); 
INSERT INTO subscription VAlUES (seq_SubscriptionPrimaryID.NEXTVAL, CONCAT('SUB', seq_SubNumber.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'),NULL, 2,1);
INSERT INTO subscription VAlUES (seq_SubscriptionPrimaryID.NEXTVAL, CONCAT('SUB', seq_SubNumber.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'),NULL, 3,1);

INSERT INTO subscription (subArtificial_PK, subStart_Date, subEnd_Date, userID, channelID) 
VALUES (seq_SubscriptionPrimaryID.NEXTVAL, TO_CHAR(SYSDATE, 'DD-MON-RR'), '28-MAR-2020',3,2);
INSERT INTO subscription (subArtificial_PK, subEnd_Date, userID, channelID) 
VALUES (seq_SubscriptionPrimaryID.NEXTVAL, '12-MAR-2020',1,2);
INSERT INTO subscription (subEnd_Date, userID, channelID) 
VALUES ('14-MAR-2020',1,2);


INSERT INTO VIDEO VALUES (seq_VideoID.NEXTVAL, CONCAT(dbms_random.string('U', 2), seq_videoIDNumber.NEXTVAL), CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, 1);
INSERT INTO VIDEO VALUES (seq_VideoID.NEXTVAL, CONCAT(dbms_random.string('U', 2), seq_videoIDNumber.NEXTVAL), CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, 1);  


INSERT INTO VIDEO (identifier, title, postDate, tags, numberOfViews, channelID) 
VALUES (CONCAT(dbms_random.string('U', 2), seq_videoIDNumber.NEXTVAL) , CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, 1);
INSERT INTO VIDEO (title, postDate, tags, numberOfViews, channelID) 
VALUES (CONCAT('Video No', seq_ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, 1);
INSERT INTO VIDEO (title, tags, numberOfViews, channelID) 
VALUES (CONCAT('Video No', seq_ArtificialID.NEXTVAL), 'Nature', 0, 1);



 
set feedback on