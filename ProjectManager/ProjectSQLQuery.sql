USE [MadaoPM_DB];
go

CREATE TABLE [Project](
	[Id] INT NOT NULL PRIMARY KEY IDENTITY
	,[Nom] VARCHAR(50) NOT NULL
	,[Description] VARCHAR(100) NOT NULL
	,[Organisation] VARCHAR(50) NOT NULL
	,[Url] VARCHAR(150) NOT NULL 
)
go

CREATE TABLE [Actor](
	[Id] INT NOT NULL PRIMARY KEY IDENTITY
	,[Nom] VARCHAR(50) NOT NULL
	,[Adresse] VARCHAR(50) NOT NULL
	,[Telephone] VARCHAR(15) NOT NULL
	,[Email] VARCHAR(50) NOT NULL
	,[Role] VARCHAR(20) NOT NULL
)
go

CREATE TABLE [Todo](
	[Id] INT NOT NULL PRIMARY KEY IDENTITY
	,[ProjectID] INT NOT NULL
	,[ActorID] INT NOT NULL
	,[Nom] VARCHAR(50) NOT NULL
	,[Place] VARCHAR(50) NOT NULL
	,[StartDate] DATETIME NOT NULL
	,[EndDate] DATETIME NOT NULL
	,[Priority] VARCHAR(10) NOT NULL
	,[ColorCode] VARCHAR(6) NOT NULL
	,[Delivrable] VARCHAR(200) NOT NULL 
)
go

CREATE TABLE [DateTB](
	[DateKey] INT NOT NULL PRIMARY KEY IDENTITY
	,[Date] DATETIME NOT NULL
	,[DateName] VARCHAR (50)
	,[Month] INT NOT NULL
	,[MonthName] VARCHAR (50) NOT NULL
	,[Quarter] INT NOT NULL
	,[QuarterName] VARCHAR (50) NOT NULL
	,[Year] INT NOT NULL
	,[YearName] VARCHAR (50) NOT NULL
)
go

-- Add Foreign Keys 
ALTER TABLE [MadaoPM_DB].[dbo].[Todo] WITH CHECK
ADD CONSTRAINT [FK_Todo_Project] 
FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Project] ([Id])

GO

ALTER TABLE [MadaoPM_DB].[dbo].[Todo] WITH CHECK
ADD CONSTRAINT [FK_Todo_Actor] 
FOREIGN KEY ([ActorID]) REFERENCES [dbo].[Actor] ([Id])

--Add error value into DateTB tables

SET IDENTITY_INSERT [MadaoPM_DB].[dbo].[DateTB] On

GO

INSERT INTO [dbo].[DateTB]
	([DateKey] 
	,[Date] 
	,[DateName] 
	,[Month] 
	,[MonthName] 
	,[Quarter] 
	,[QuarterName] 
	,[Year] 
	,[YearName] 
	)
SELECT [DateKey] = -1
	,[Date] = CAST ('01/01/1990' AS nVARCHAR(50))
	,[DateName] = CAST ('Unknown Day' AS nVARCHAR(50))
	,[Month] = -1
	,[MonthName] = CAST ('Unknown Month' AS nVARCHAR(50))
	,[Quarter] =-1
	,[QuarterName] = CAST ('Unknown Quarter' AS nVARCHAR(50))
	,[Year] =-1
	,[YearName] = CAST ('Unknown Year' AS nVARCHAR(50)) 

GO

SET IDENTITY_INSERT [MadaoPM_DB].[dbo].[DateTB] Off

-- Since the date table has no associated source table we can fill the data
-- using a SQL script or wait until the ETL process. Either way, here is the 
-- code to use.

-- Create variables to hold the start and end date
DECLARE @StartDate datetime = '01/01/2014'
DECLARE @EndDate datetime = '01/01/2019' 

-- Use a while loop to add dates to the table
DECLARE @DateInProcess datetime
SET @DateInProcess = @StartDate

WHILE @DateInProcess <= @EndDate
 BEGIN
 --Add a row into the date dimension table for this date
 INSERT INTO [dbo].[DateTB] 
 ( [Date], [DateName], [Month], [MonthName], [Quarter], [QuarterName], [Year], [YearName] )
 VALUES ( 
  @DateInProcess -- [Date]
  , DateName( weekday, @DateInProcess )  -- [DateName]  
  , Month( @DateInProcess ) -- [Month]   
  , DateName( month, @DateInProcess ) -- [MonthName]
  , DateName( quarter, @DateInProcess ) -- [Quarter]
  , 'Q' + DateName( quarter, @DateInProcess ) + ' - ' + Cast( Year(@DateInProcess) as nVarchar(50) ) -- [QuarterName] 
  , Year( @DateInProcess )
  , Cast( Year(@DateInProcess ) as nVarchar(50) ) -- [Year] 
  )  
 -- Add a day and loop again
 SET @DateInProcess = DateAdd(d, 1, @DateInProcess)
 END
