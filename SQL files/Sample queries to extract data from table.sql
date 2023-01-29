1.) the query checks whether the student is also a teaching_assistant

select a.studentid,a.studentname,a.email from student a
where exists( select * from teaching_assistant b
where a.studentid = b.taid);

2.)the query fetches the depatmenid with max number of student count by using the with clause.


with max_student_count(max_cn ) as(
(select max(b.MAX_cn)  from (
select a.student_count  as MAX_cn  from
(select count(app.studentid) as student_count, app.departmentid 
from application app group by app.departmentid)as a 
group by a.departmentid) as b)) 
select departmentid 
from (select count(studentid)as count,departmentid  
from application group by departmentid) as table1,max_student_count msv
 where table1.count = msv.max_cn ;
 
3.) The query fetches the details of professor and teaching_assistant of a classroom which has message count more than 10.


select crnno_details.professorid,p.professorname,crnno_details.taid,ta.taname from professor p
INNER JOIN 
(select distinct(cou.professorid), cou.taid from course cou 
Right join 
(select courseid, studentid, professorid, crnno from  classroom where crnno = ANY(
select crnno from (
select count(message)as msg_count,crnno  from messages group by crnno) as msg_count1
where msg_count1.msg_count >10))as msg_details
ON cou.courseid = msg_details.courseid)as crnno_details
ON p.professorid = crnno_details.professorid
INNER join teaching_assistant as ta
ON ta.taid = crnno_details.taid;

4.)The query displays the list of course options avialable for a particular student after enrolling in a department.

select c.courseid,c.coursename from course c
right join
(select departmentid from application
where studentid =ANY(
select studentid from student
where studentid = '29200011')) as temp1
on  c.departmentid LIKE temp1.departmentid ;

5.)the query fetches the number of students living in zipcode wise for a particular department.

select count(studentid),zipcodepref from housingandfood
where studentid in(
select distinct(studentid) from housingandfood
where STUDENTID IN (
select studentid from student
where studentid in
(select studentid from application 
where departmentid like '%AST%'))) group by zipcodepref;

6.)The query helps to filter the data based on the zip code which shows the lifestyle of students based on their spending range in each area.


SELECT zipcodepref as ZIP_CODE, 
COUNT(CASE WHEN rentpreference < 500 THEN 1 else NULL END ) as ECONOMICAL,
COUNT(CASE WHEN rentpreference >=500 AND rentpreference <= 700 THEN 1 else NULL END ) as BUDGET_FRIENDLY,
COUNT(CASE WHEN rentpreference >700 THEN 1 else NULL END  ) as LUXURY,
COUNT(1) as total_students
FROM housingandfood
group by zipcodepref
order by total_students DESC;

7.)The query helps to fetch data of students who suggest a particular Professor for the subject DMA along with their details to contact.

 

select m.message, s.studentid, s.studentname, s.gender,
s.phoneno, count(s.gender) over (partition by s.gender) as TotalGender
FROM messages m
INNER JOIN student s ON m.studentid = s.studentid
WHERE message LIKE '%best for DMA%'
order by gender;

8.)To find the BACKGROUND OF TA and there contact details to communicate

 

select s.studentid, s.studentname, s.gender,c.coursename,c.departmentid,s.phoneno,t.office_days
FROM teaching_assistant t
LEFT JOIN student s ON s.studentid = t.taid
INNER JOIN 
course c ON t.taid = c.taid
order by gender;  

9.) The query returns the output of the total student counts in the boston campus.

select col.collegename,studentcount_table.student_count from universityandcollege col
join 
(select count(studentid)as student_count,collegeid  from application
where collegeid in (select collegeid from universityandcollege where campus = "boston")
 group by collegeid)as studentcount_table
 on col.collegeid = studentcount_table.collegeid
 group by col.collegename ;  
 
10.)the query fetches the Total number of applications for college wise.

select uc.collegename, count(app.applicationid) as total_applications
from application app
join universityandcollege uc
on app.collegeid = uc.collegeid
group by uc.collegename;