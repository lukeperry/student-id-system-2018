/*
   Tuesday, December 11, 20183:31:55 PM
   User: 
   Server: .\SQLEXPRESS
   Database: 
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Students
	(
	LRN nvarchar(50) NOT NULL,
	First_Name nvarchar(50) NULL,
	Middle_Name nvarchar(50) NULL,
	Last_Name nvarchar(50) NULL,
	Birthdate nvarchar(50) NULL,
	Gender nvarchar(50) NULL,
	Grade_level nvarchar(50) NULL,
	Strand nvarchar(50) NULL,
	Adviser nvarchar(50) NULL,
	Contact_person nvarchar(50) NULL,
	Relationship nvarchar(50) NULL,
	Contact_person_number nvarchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Students SET (LOCK_ESCALATION = TABLE)
GO
IF EXISTS(SELECT * FROM dbo.Students)
	 EXEC('INSERT INTO dbo.Tmp_Students (LRN, First_Name, Middle_Name, Last_Name, Birthdate, Gender, Grade_level, Strand, Adviser, Contact_person, Relationship, Contact_person_number)
		SELECT LRN, First_Name, Middle_Name, Last_Name, Birthdate, Gender, Grade_level, Strand, Adviser, Contact_person, Relationship, Contact_person_number FROM dbo.Students WITH (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.Students
GO
EXECUTE sp_rename N'dbo.Tmp_Students', N'Students', 'OBJECT' 
GO
ALTER TABLE dbo.Students ADD CONSTRAINT
	PK_Students PRIMARY KEY CLUSTERED 
	(
	LRN
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX IX_Students ON dbo.Students
	(
	LRN
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
COMMIT
