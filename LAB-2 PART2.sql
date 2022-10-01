USE PERSON_INFO_350
--1.Print message like - Error Occur that is: Divide by zero error encountered.
BEGIN TRY
	SELECT 1/0;
END TRY
BEGIN CATCH
	SELECT 'ERROR OCCURED THAT IS:'+ ERROR_MESSAGE() AS ERRORMSF
END CATCH
--2. Print error message in insert statement using Error_Message () function: Conversion failed when
--converting datetime from character string.
BEGIN TRY
	DECLARE @DATETIME VARCHAR(100)='19/06/2016 21:05:04'
	SELECT CONVERT(DATETIME,@DATETIME,5) AS CONVERSION
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERRORMSG
END CATCH
--3.Create procedure which prints the error message that �The PLogID is already taken. Try another one�.
CREATE PROCEDURE PR_PERSONLOG_EXCEPTION
(@ID INT,@NAME VARCHAR(250))
AS
BEGIN
	BEGIN TRY 
	INSERT INTO PERSONLOG VALUES(@ID,@NAME,'INSERT',GETDATE())
	END TRY
	BEGIN CATCH
	PRINT 'The PLogID is already taken. Try another one'
	END CATCH
END
EXEC PR_PERSONLOG_EXCEPTION 1,'JAIMINI'
--4.Create procedure that print the sum of two numbers: take both number as integer & handle
--exception with all error functions if any one enters string value in numbers otherwise print result.
ALTER PROCEDURE PR_PERSONLOG_SUM
@NUM1 VARCHAR(10), @NUM2 INT,@RESULT INT OUTPUT
AS
BEGIN 
	BEGIN TRY
	SET @RESULT=(@NUM1+@NUM2)
	END TRY
	BEGIN CATCH
	SELECT ERROR_LINE() AS ERRORLINE, ERROR_NUMBER() AS ERRORNUMBER, ERROR_MESSAGE() AS ERRORMSG,
	ERROR_PROCEDURE() AS ERRORPROC, ERROR_SEVERITY() AS ERRORSEVERITY, ERROR_STATE() AS ERRORSTATE
	END CATCH
END
DECLARE @A INT
EXEC PR_PERSONLOG_SUM 'A',2,@A OUTPUT
PRINT @A
--5.Throw custom exception using stored procedure which accepts PLogID as input & that throws
--Error like no plogid is available in database.
ALTER PROCEDURE PR_PERSONLOG_THROW
@ID INT
AS
BEGIN
	IF EXISTS(SELECT * FROM PERSONLOG WHERE PLOGID=@ID)
		PRINT 'PLOGID EXISTS'
	ELSE 
	THROW 50000,'Error like no plogid is available in database',1
END
EXEC PR_PERSONLOG_THROW 20
--6.Create cursor with name per_cursor which takes PLogID & PersonName as variable and produce
--combine output with PLogID & Person Name
DECLARE 
@ID INT,
@NAME VARCHAR(250)
DECLARE CURSOR_PERSON CURSOR
FOR SELECT
	PLOGID,
	PERSONNAME
FROM
	PERSONLOG
OPEN CURSOR_PERSON
FETCH NEXT FROM CURSOR_PERSON INTO
		@ID,
		@NAME
WHILE @@FETCH_STATUS=0
	BEGIN
		PRINT CAST(@ID AS VARCHAR(100))+'-'+@NAME
		FETCH NEXT FROM CURSOR_PERSON INTO
		@ID,
		@NAME	
	END
CLOSE CURSOR_PERSON
DEALLOCATE CURSOR_PERSON
SELECT * FROM PERSONLOG
--7.Use Table Student (Id, Rno, EnrollmentNo, Name, Branch, University) - Create cursor that updates
--enrollment column as combination of branch & Roll No. like SOE22CE0001 and so on. (22 is
--admission year)
		@ROLL,
		@BRANCH