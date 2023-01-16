/* Question No:-1. To gain a comprehensive understanding of the factors influencing hospitalization costs, it is
necessary to combine the tables provided. Merge the two tables by first identifying the columns in the data tables 
that will help you in merging.
a. In both tables, add a Primary Key constraint for these columns */ 

/* Hint: You can remove duplicates and null values from the column and then use ALTER TABLE to add a Primary Key 
constraint. */

create database job_readiness;
use job_readiness;
select * from hospital_detail;
select * from medical_detail;

-- Lets Deal with the null value.
SET SQL_SAFE_UPDATES = 0;
delete from hospital_detail where `State ID`='?';
delete from hospital_detail where `City tier`='?';

-- Now lets assign the primary key to the column in the table.
ALTER TABLE `job_readiness`.`hospital_detail` 
CHANGE COLUMN `Customer ID` `Customer ID` varchar(20),
ADD PRIMARY KEY (`Customer ID`);

ALTER TABLE `job_readiness`.`medical_detail` 
CHANGE COLUMN `Customer ID` `Customer ID` varchar(20),
ADD PRIMARY KEY (`Customer ID`);

-- Now lets merge the both table for better understanding of hospitalisation cost.
select * from hospital_detail as h inner join medical_detail as m
on h.`Customer ID` = m.`Customer ID`;

/* Question No:-2. Retrieve information about people who are diabetic and have heart problems with their average age,
 the average number of dependent children, average BMI, and average hospitalization costs */

select m.HBA1C, m.`Heart Issues`, avg(h.children), avg(m.BMI), avg(h.charges) 
from medical_detail as m 
inner join hospital_detail as h 
on h.`Customer ID` = m.`Customer ID`
where m.HBA1C>6.5 and m.`Heart Issues`= 'yes'; 

/* Question NO.3:- Find the average hospitalization cost for each hospital tier and each city level.*/  

select `Hospital tier`, avg(charges) as avg_cost from hospital_detail group by `Hospital tier`;
select `City tier`, avg(charges) as avg_cost from hospital_detail group by `City tier`;

/* Question No4:- Determine the number of people who have had major surgery with a history of cancer. */

select count(`Customer ID`) from medical_detail where `Cancer history`='Yes' and NumberOfMajorSurgeries>0;

/* Question No5:- Determine the number of tier-1 hospitals in each state. */

select `State ID`, count(`Hospital tier`) from hospital_detail where `Hospital tier`='tier - 1' group by `State ID`;




