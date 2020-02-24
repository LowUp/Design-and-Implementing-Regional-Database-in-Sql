/*Drop table*/
DROP TABLE subscription cascade constraints;


alter session set NLS_DATE_FORMAT = 'DD-MON-RR';


/*SUBSCRIPTION TABLE*/
CREATE TABLE subscription(
subCode VARCHAR2(6),
subStart_Date DATE,
subEnd_Date DATE,
userNum VARCHAR2(10),
chanNum VARCHAR2(10),
CONSTRAINT pk_subCode PRIMARY KEY (subCode));


/*INSERT VALUES*/
INSERT INTO subscription VAlUES ('A1', '03-JAN-2020','24-JAN-2020', 'Brosey21','Kiwezzee');
INSERT INTO subscription VAlUES ('A2', '04-JAN-2020','02-FEB-2020', 'Lolipop','YOYA');
INSERT INTO subscription VAlUES ('A3', '04-JAN-2020',NULL, 'Witcher','TossACoin');