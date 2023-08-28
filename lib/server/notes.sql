--create new database named "test"
CREATE DATABASE test;

--create new table named "test" with variable of type int
CREATE TABLE test (
	id int,
);

--create new table named "test" with constraints
CREATE TABLE test (
	id int NOT NULL PRIMARY KEY,
	num int NOT NULL,
);

--insert into table "test"
INSERT INTO test (num) VALUES (42);

--\c test   connects to database "test"
--CTRL+L clears console
