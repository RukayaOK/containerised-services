-- CREATE DATABASE 
CREATE DATABASE $(APPLICATION_DB);
GO

USE $(APPLICATION_DB);
GO

-- CRETE USER TO ACCESS DATABASE 
CREATE LOGIN $(APPLICATION_DB_USER) WITH PASSWORD = '$(APPLICATION_DB_PASSWORD)';
GO
CREATE USER $(APPLICATION_DB_USER) FOR LOGIN $(APPLICATION_DB_USER);
GO
ALTER SERVER ROLE sysadmin ADD MEMBER [$(APPLICATION_DB_USER)];
GO

-- CREATE SCHEMA 
CREATE SCHEMA MyFirstSchema;
GO

-- CREATE TABLE 
CREATE TABLE MyFirstSchema.MyFirstTable
(
    MyFirstPK        int          PRIMARY KEY, 
    MyFirstInt       int          NOT NULL,
    MyFirstVarchar   varchar(20)  NOT NULL
)
GO 

-- INSERT DATA INTO TABLE 
INSERT INTO MyFirstSchema.MyFirstTable VALUES (1, 1000, '1 Thousand') 
INSERT INTO MyFirstSchema.MyFirstTable VALUES (2, 2000, '2 Thousand') 
INSERT INTO MyFirstSchema.MyFirstTable VALUES (3, 3000, '3 Thousand') 
INSERT INTO MyFirstSchema.MyFirstTable VALUES (4, 4000, '4 Thousand') 
INSERT INTO MyFirstSchema.MyFirstTable VALUES (5, 5000, '5 Thousand')
GO 

-- CREATE SCHEMA 
CREATE SCHEMA MySecondSchema;
GO

-- CREATE TABLE 
CREATE TABLE MySecondSchema.MySecondTable
(
    MySecondPK        int          PRIMARY KEY, 
    MySecondInt       int          NOT NULL,
    MySecondVarchar   varchar(20)  NOT NULL
)
GO 

-- INSERT DATA INTO TABLE 
INSERT INTO MySecondSchema.MySecondTable VALUES (1, 1000, '1 Thousand') 
INSERT INTO MySecondSchema.MySecondTable VALUES (2, 2000, '2 Thousand') 
INSERT INTO MySecondSchema.MySecondTable VALUES (3, 3000, '3 Thousand') 
INSERT INTO MySecondSchema.MySecondTable VALUES (4, 4000, '4 Thousand') 
INSERT INTO MySecondSchema.MySecondTable VALUES (5, 5000, '5 Thousand')
GO 
