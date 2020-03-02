alter session set NLS_DATE_FORMAT = 'DD-MON-RR';

DROP TABLE USER_TABLE cascade constraints; 
DROP SEQUENCE seq_userNumber; 



 /* User Table*/
 CREATE TABLE USER_TABLE(
  userNumber 		NUMBER,
  userName			VARCHAR2(20) NOT NULL UNIQUE,
  firstName		    VARCHAR2(10) NOT NULL,
  lastName			VARCHAR2(10) NOT NULL,
  emailAddress		VARCHAR2(30) NOT NULL,
  dateOfBirth		DATE NOT NULL,
  CONSTRAINT pk_userNumber PRIMARY KEY(userNumber));
  
CREATE SEQUENCE seq_userNumber
MINVALUE 1
START WITH 1 
INCREMENT BY 1
NOCACHE;

  
 /* Add values to User Database*/
 INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user1', 'Asim', 'Rai', 'asimraii@yahoo.com', '23-AUG-1996');
 INSERT INTO USER_TABLE VALUES (seq_userNumber.nextval, 'user2', 'Misa', 'Iar', 'ar605@canterbury.ac.uk', '24-AUG-1997');
 


 
/*set feedback on;*/

/* ERROR at line 1:
ORA-00001: unique constraint (AR605.PK_USERNUMBER) violated */