CREATE USER gaps
IDENTIFIED BY gaps
DEFAULT TABLESPACE users
QUOTA 10m ON users
/
GRANT create session, create table, create procedure, create view
TO gaps
/

