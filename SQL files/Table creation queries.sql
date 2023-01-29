use dma_final;
CREATE TABLE student (
    studentid varchar(20) NOT NULL,
    studentname varchar(100),
    phoneno varchar(20),
	email varchar(500),
    gender varchar(50),
	Date_of_birth date,
    PRIMARY KEY (studentid)
);

CREATE TABLE professor (
    professorid Varchar(20) NOT NULL,
    professorname varchar(50),
	email varchar(50),
	officedays varchar(50),
    PRIMARY KEY (professorid)
);
select * from professor;

CREATE TABLE universityandcollege (
    collegeid int NOT NULL,
	collegename varchar(50),
	campus varchar(50),
    email varchar(50),
    PRIMARY KEY (collegeid)
);

select * from universityandcollege;

CREATE TABLE department (
    departmentid varchar(10) NOT NULL,
    departmentname varchar(50),
    dean_name varchar(50),
    email varchar(100),
    collegeid int,
    primary key(departmentid),
    FOREIGN KEY (collegeid) REFERENCES universityandcollege(collegeid)
);
select * from department;

CREATE TABLE application (
    applicationid varchar(20) ,
    departmentid varchar(10),
    collegeid int,
    studentid varchar(50),
    app_status varchar(20),
    FOREIGN KEY (collegeid) REFERENCES universityandcollege(collegeid),
    FOREIGN KEY (studentid) REFERENCES student(studentid),
    FOREIGN KEY (departmentid) REFERENCES department(departmentid)
);
select * from application;

CREATE TABLE Teaching_assistant (
    taid varchar(20) ,
    taname varchar(50),
    email varchar(50),
    office_days varchar(50),
    primary key(taid)
    );
    select count(*) from teaching_assistant;
    
CREATE TABLE course (
    courseid int ,
    departmentid varchar(10),
    taid varchar(20),
    coursename varchar(50),
    professorid Varchar(20),
    primary key(courseid),
    FOREIGN KEY (departmentid) REFERENCES department(departmentid),
    FOREIGN KEY (taid) REFERENCES teaching_assistant(taid),
    FOREIGN KEY (professorid) REFERENCES professor(professorid)
);
select count(*) from course;
CREATE TABLE classroom (
    courseid int ,
    crnno varchar(10),
    classtype varchar(20),
    classschedule varchar(50),
    studentid varchar(20),
    professorid Varchar(20),
    groupname varchar(150),
    FOREIGN KEY (courseid) REFERENCES course(courseid),
    FOREIGN KEY (studentid) REFERENCES student(studentid),
    FOREIGN KEY (professorid) REFERENCES professor(professorid)
);
select count(*) from classroom;

CREATE TABLE messages (
    crnno varchar(10),
    studentid varchar(20),
    message varchar(300),
    messagedate date,
    FOREIGN KEY (studentid) REFERENCES student(studentid)
);

CREATE TABLE Housingandfood (
    housetype varchar(100),
    foodchoice varchar(200),
    rentpreference varchar(300),
    zipcodepref varchar(20),
    studentid varchar(10),
    FOREIGN KEY (studentid) REFERENCES student(studentid)
);

select * from student where studentid in(select studentid from application where departmentid in (select departmentid from course 
where courseid > 5000));


