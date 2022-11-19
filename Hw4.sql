CREATE TABLE StudentNew(
StudentId INT AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
Lastname VARCHAR(50) NOT NULL,
Marks DECIMAL (10,2) NOT NULL
);
INSERT INTO StudentNew values('1001', 'Simran', 'Sharma', '80.5');

CREATE TRIGGER Extra_Score
AFTER INSERT  
on StudentNew
for each row
INSERT INTO StudentNew
SET Marks ='update';
SHOW TRIGGERS;

UPDATE StudentNew
SET Marks= Marks+'5.00'
WHERE StudentID like '10%';
select * from StudentNew;

CREATE TABLE SalaryBudgets(

    total DECIMAL(15,2) NOT NULL

);
 
INSERT INTO SalaryBudgets(total)

SELECT SUM(salary)

FROM Salaries;
CREATE TRIGGER delete_salaries  
AFTER DELETE
ON salaries FOR EACH ROW  
UPDATE total_salary_budget 
SET total_budget = total_budget - old.amount;  







