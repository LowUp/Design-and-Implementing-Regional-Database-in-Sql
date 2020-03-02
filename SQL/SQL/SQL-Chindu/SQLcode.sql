alter session set NLS_DATE_FORMAT = 'DD-MON-RR';
set feedback off
set term on
 
prompt
prompt Tables and sequences for Video database dropped.

prompt
prompt Creating and populating tables and sequences for Video database.  
prompt Please wait.
set term off

DROP TABLE VIDEO cascade constraints;
DROP SEQUENCE ID01;
DROP SEQUENCE ArtificialID;
DROP SEQUENCE NumViews;


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



INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), ID01.NEXTVAL) , CONCAT('Video No', ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, ArtificialID.NEXTVAL);  
INSERT INTO VIDEO VALUES (dbms_random.value(1000000, 9999999), CONCAT(dbms_random.string('U', 2), ID01.NEXTVAL), CONCAT('Video No', ArtificialID.NEXTVAL), TO_CHAR(SYSDATE, 'DD-MON-RR'), 'Nature', 0, ArtificialID.NEXTVAL);  


/*CREATE VIEW REL AS
SELECT REPID, ORD.CUSTID, CUSTOMER.NAME CUSTNAME, PRODUCT.PRODID,
*/


set term on
set feedback on
prompt
prompt Tables and sequences for Video database 
prompt created and populated.
prompt
