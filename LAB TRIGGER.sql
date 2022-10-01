--1.Create INSERT, UPDATE & DELETE Stored Procedures for Person table.
CREATE PROCEDURE PR_PERSON_INSERT
(
@PID INT,
@NAME VARCHAR(100),
@SAL DECIMAL(8,2),
@JOIN DATETIME,
@CITY VARCHAR(50),
@AGE INT,
@BIRTHDATE DATETIME
)
AS
BEGIN
	INSERT INTO PERSON VALUES 
	(@PID,@NAME,@SAL,@JOIN,@CITY,@AGE,@BIRTHDATE)
END
------------------------------------------------------------------
CREATE PROCEDURE PR_PERSON_DELETE
@DEPTID INT
AS
BEGIN 
	DELETE FROM PERSON WHERE PERSONID=@DEPTID
END
------------------------------------------------------------------
CREATE PROCEDURE PR_PERSON_UPDATE
@PID INT,
@NAME VARCHAR(50)
AS
BEGIN
	UPDATE PERSON SET PERSONNAME=@NAME WHERE PERSONID=@PID
END
----------------------------------------------------------------
--2.Create a trigger that fires on INSERT, UPDATE and DELETE operation on the Person table. For that,
--create a new table PersonLog to log (enter) all operations performed on the Person table.
CREATE TRIGGER TR_PERSON_INSERT
ON PERSON
AFTER INSERT
AS
BEGIN
	DECLARE @PERSONID INT,@PERSONNAME VARCHAR(50)
	SELECT @PERSONID=PERSONID FROM INSERTED
	SELECT @PERSONNAME=PERSONNAME FROM INSERTED
	INSERT INTO PERSONLOG 
	VALUES(@PERSONID,@PERSONNAME,'CE',GETDATE())
END
INSERT INTO PERSON VALUES(1,'ABC',200000,'2022-01-02','RAJKOT',30,'1990-01-01')
INSERT INTO PERSON VALUES(2,'ABC1',200000,'2022-01-02','RAJKOT',30,'1990-01-01')
SELECT * FROM PERSONLOG
--------------------------------------------------------------------------
CREATE TRIGGER TR_PERSON_UPDATE
ON PERSON
AFTER UPDATE
AS
BEGIN
	DECLARE @PERSONID INT,@PERSONNAME VARCHAR(50)
	SELECT @PERSONID=PERSONID FROM INSERTED
	SELECT @PERSONNAME=PERSONNAME FROM INSERTED
	INSERT INTO PERSONLOG 
	VALUES(@PERSONID,@PERSONNAME,'EC',GETDATE())
END
UPDATE PERSON SET PERSONNAME='XYZ' WHERE PERSONNAME='ABC'
-----------------------------------------------------------
CREATE TRIGGER TR_PERSON_DELETE
ON PERSON
AFTER DELETE
AS
BEGIN
	DECLARE @PERSONID INT,@PERSONNAME VARCHAR(50)
	SELECT @PERSONID=PERSONID FROM INSERTED
	SELECT @PERSONNAME=PERSONNAME FROM INSERTED
	INSERT INTO PERSONLOG 
	VALUES(@PERSONID,@PERSONNAME,'ME',GETDATE())
END

------------------------------------------------------
--3.Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Person
--table. For that, log all operation performed on the Person table into PersonLog.
CREATE TRIGGER TR_PERSON_INSERTIO
ON PERSON
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @PERSONID INT,@PERSONNAME VARCHAR(50)
	SELECT @PERSONID=PERSONID FROM INSERTED
	SELECT @PERSONNAME=PERSONNAME FROM INSERTED
	INSERT INTO PERSONLOG 
	VALUES(@PERSONID,@PERSONNAME,'ME',GETDATE())
END
------------------------------------------
CREATE TRIGGER TR_PERSON_UPDATEIO
ON PERSON
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @PERSONID INT,@PERSONNAME VARCHAR(50)
	SELECT @PERSONID=PERSONID FROM INSERTED
	SELECT @PERSONNAME=PERSONNAME FROM INSERTED
	INSERT INTO PERSONLOG 
	VALUES(@PERSONID,@PERSONNAME,'ME',GETDATE())
END
-----------------------------------
CREATE TRIGGER TR_PERSON_DELETEIO
ON PERSON
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @PERSONID INT,@PERSONNAME VARCHAR(50)
	SELECT @PERSONID=PERSONID FROM INSERTED
	SELECT @PERSONNAME=PERSONNAME FROM INSERTED
	INSERT INTO PERSONLOG 
	VALUES(@PERSONID,@PERSONNAME,'ME',GETDATE())
END
---------------------------------------------
--4.Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints
--�Record deleted successfully from PersonLog�.
CREATE TRIGGER TR_PERSONLOG
ON PERSONLOG
AFTER DELETE
AS
BEGIN
	PRINT 'Record deleted successfully from PersonLog'
END
----------------------------------------------------------------------
--5.Create INSERT trigger on person table, which calculates the age and update that age in Person table.
CREATE TRIGGER TR_PERSON_AGE
ON PERSON
AFTER INSERT
AS
BEGIN
	DECLARE @PERSONID INT,@DOB DATETIME
	SELECT @PERSONID=PERSONID FROM INSERTED
	SELECT @DOB=BIRTHDATE FROM INSERTED
	UPDATE PERSON SET AGE=DATEDIFF(YEAR,@DOB,GETDATE())
	WHERE PERSONID=@PERSONID
END
SELECT * FROM PERSON
-----------------------------------------------------------------