create table department (
  deptname varchar(30),
  building varchar(15),
  primary key (deptname,building)
);

create table professor (
  profname varchar(20),
  deptname varchar(30),
  primary key (profname,deptname)
);

create table committee (
  commname varchar(20),
  profname varchar(20),
  primary key(commname, profname)
);

create table government (
  name varchar(25) primary key,
  ranking varchar(20),
  salary int
);

create table politician (
  name varchar(30) primary key,
  party varchar(25),
  gender varchar(20)
);

create table donation (
  name varchar(30),
  organization varchar(30),
  amount int,
  primary key(name, organization)
);

create table employee(
  enum float(5,0) primary key,
  name varchar(30),
  age float(2,0),
  ranking varchar(30),
  deptnum float(3,0),
  salary int
);

create table projects(
  pnum float(3,0) primary key,
  pname varchar(50)
);

create table works(
  enum float(5,0),
  pnum float(3,0),
  primary key(enum, pnum),
  foreign key(enum) references employee(enum),
  foreign key(pnum) references projects(pnum)
);


insert into professor values('Piper','Computer Science');
insert into professor values('James','Computer Science');
insert into professor values('George','Computer Science');
insert into professor values('William','Electrical Engineering');
insert into professor values('Matthew','Electrical Engineering');
insert into professor values('Oliver','Mechanical Engineering');
insert into professor values('Lewis','Mechanical Engineering');

insert into department values ('Computer Science','ICICS/CS');
insert into department values ('Electrical Engineering','KAIS');
insert into department values ('Mechanical Engineering','CEME');

insert into committee values('Operation','James');
insert into committee values('Operation','William');
insert into committee values('Communication','James');
insert into committee values('Communication','Piper');
insert into committee values('Communication','Oliver');
insert into committee values('Communication','Lewis');
insert into committee values('Teaching','James');
insert into committee values('Teaching','Piper');
insert into committee values('Teaching','Matthew');
insert into committee values('Teaching','Lewis');
insert into committee values('Graduate Admissions','William');
insert into committee values('Graduate Admissions','George');
insert into committee values('Computing','Matthew');

insert into government values('Albert', 'minister',150000);
insert into government values('Bobbie', 'clerk',50000);
insert into government(name,ranking) values('Don', 'clerk');

insert into politician values('Albert', 'Republic','male');
insert into politician values('Charlie', 'Democrat','male');

insert into donation values('Charlie', 'American Red Cross',150000);
insert into donation values('Charlie', 'National AIDS Fund',80000);
insert into donation values('Charlie', 'UNICEF',80000);
insert into donation values('Don', 'NineMillion',50000);
insert into donation values('Don', 'American Red Cross',60000);
insert into donation values('Campbell', 'American Red Cross',70000);
insert into donation values('Campbell', 'National AIDS Fund',60000);
insert into donation values('Mike', 'NineMillion',90000);

insert into employee values (10258,'Ella',36,'manager',210,120000);
insert into employee values (22011,'Charlie',33,'manager',210,150000);
insert into employee values (11234,'Ben',25,'clerk',210,60000);
insert into employee values (14978,'Nathan',30,'clerk',210,60000);
insert into employee values (38457,'Ruby',40,'manager',211,160000);
insert into employee values (80644,'Adam',38,'manager',211,120000);
insert into employee values (57392,'Joseph',42,'manager',211,120000);
insert into employee values (28475,'Amelia',28,'clerk',211,75000);
insert into employee values (50204,'Daniel',30,'clerk',211,70000);
insert into employee values (02378,'Happy',36,'manager',212,120000);
insert into employee values (64259,'Shphie',38,'manager',212,115000);
insert into employee values (77684,'Jessica',28,'clerk',212,55000);
insert into employee values (17265,'Molly',35,'clerk',212,65000);

insert into projects values(101,'Eastern Pacific Investigations of Climate');
insert into projects values(102,'NAME Model Assessment Project');

insert into works values(10258,101);
insert into works values(10258,102);
insert into works values(38457,101);
insert into works values(38457,102);
insert into works values(28475,101);
insert into works values(28475,102);
insert into works values(22011,101);
insert into works values(11234,101);
insert into works values(02378,102);
insert into works values(77684,102);
insert into works values(50204,102);
