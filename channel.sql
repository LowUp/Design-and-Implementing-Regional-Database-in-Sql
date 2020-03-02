alter session set NLS_DATE_FORMAT = 'DD-MON-RR';

set echo off
set feedback off



DROP TABLE CHANNEL cascade constraints;
DROP TABLE TABLE2 cascade constraints;

CREATE TABLE CHANNEL (
 CHANNEL_NUMBER	 		NUMBER(6) NOT NULL,
 NAME					varchar2(12) NOT NULL,
 USER_NAME				VARCHAR2(12) NOT NULL,
 REGISTRATION_DATE		DATE NOT NULL,
 TOPIC_CODE				varchar2(2) NOT NULL, /* Still need to finish topic code (read through breif to find out) */
 CONSTRAINT CHK_TOPIC	CHECK (REGEXP_LIKE(TOPIC_CODE, '[^I, O, Q, V, Z]', 'c')),
 CONSTRAINT WETUBE_CHANNEL_PRIMARY_KEY PRIMARY KEY (CHANNEL_NUMBER));
 
INSERT INTO CHANNEL VALUES ('1', 'channel1', 'Old_man', '17-FEB-2020', 'I');
INSERT INTO CHANNEL VALUES ('1', 'channel1', 'The_Legend27', '17-FEB-2020', 'A1');


CREATE TABLE TABLE2 (
TABLE2_ID				NUMBER(2),
somerandominfo			varchar2(20),
CHANNEL_NUMBER	NUMBER(6),
CONSTRAINT FK_CHANNEL FOREIGN KEY (CHANNEL_NUMBER) REFERENCES CHANNEL (CHANNEL_NUMBER));

INSERT INTO TABLE2 VALUES ('1', 'idkwhatimdoing', '1');
INSERT INTO TABLE2 VALUES ('2', 'hahahahaha', '1');
INSERT INTO TABLE2 VALUES ('3', 'hello', '1');
 
set feedback on