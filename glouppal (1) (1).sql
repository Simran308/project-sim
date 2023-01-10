
#################### GloUp Pal ####################
########## Fitness & Nutrition Tracking ###########

########### Creation of Database ############

DROP DATABASE IF EXISTS glouppal;
CREATE DATABASE IF NOT EXISTS GloUpPal;
USE GloUpPal;

############# Creation of Tables ############

DROP TABLE IF EXISTS Customers_T;
CREATE TABLE IF NOT EXISTS Customers_T(
	CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustFirstName VARCHAR(20) NOT NULL,
    CustLastName VARCHAR(20) NOT NULL,
    EmailID VARCHAR(40) NOT NULL,
    Phone VARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    IsActive CHAR(1) NOT NULL
);

DROP TABLE IF EXISTS Subscriptions_T;
CREATE TABLE IF NOT EXISTS Subscriptions_T(
	SubscriptionID INT AUTO_INCREMENT PRIMARY KEY,
    SubscriptionType VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS Specializations_T;
CREATE TABLE IF NOT EXISTS Specializations_T ( 
	SpecializationID INT AUTO_INCREMENT PRIMARY KEY,
	SpecializationName VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS CustomerHealth_T;
CREATE TABLE IF NOT EXISTS CustomerHealth_T ( 
	HealthID INT AUTO_INCREMENT PRIMARY KEY,
	CustomerID INT NOT NULL,
	Height DECIMAL(10,2) NOT NULL,
	Weight DECIMAL(10,2) NOT NULL,
	FOREIGN KEY(CustomerID) REFERENCES Customers_T(CustomerID)
);

DROP TABLE IF EXISTS Trainers_T;
CREATE TABLE Trainers_T (
	TrainerID VARCHAR(10) PRIMARY KEY,
	TrainerFName VARCHAR(20) NOT NULL,
	TrainerLName VARCHAR(20) NOT NULL,
	SpecializationID INT NOT NULL,
	EmailID VARCHAR(40) NOT NULL,
	Phone VARCHAR(10) NOT NULL,
	FOREIGN KEY (SpecializationID) REFERENCES Specializations_T (SpecializationID)
);

DROP TABLE IF EXISTS HealthHistory_T;
CREATE TABLE IF NOT EXISTS HealthHistory_T (
	HistoryID INT AUTO_INCREMENT PRIMARY KEY, 
	HealthID INT NOT NULL,
	AilmentName	VARCHAR(20)	NOT NULL, 
	Medication VARCHAR(40) NOT NULL,
	FOREIGN KEY (HealthID) REFERENCES CustomerHealth_T(HealthID)
);

DROP TABLE IF EXISTS FitnessType_T;
CREATE TABLE IF NOT EXISTS FitnessType_T (
	FitnessTypeID INT AUTO_INCREMENT PRIMARY KEY, 
	FitnessName	VARCHAR(20)	NOT NULL,
	Calories INT NOT NULL
);

DROP TABLE IF EXISTS Nutritionists_T; 
CREATE TABLE IF NOT EXISTS Nutritionists_T( 
	NutritionistID VARCHAR(20) PRIMARY KEY, 
    NutritionistFName VARCHAR(20) NOT NULL, 
    NutritionistLName VARCHAR(20) NOT NULL, 
    EmailID VARCHAR(40) NOT NULL, 
    Phone VARCHAR(10) NOT NULL, 
    SpecializationID INT NOT NULL,
    FOREIGN KEY(SpecializationID) REFERENCES Specializations_T(SpecializationID) 
);

DROP TABLE IF EXISTS Login_T; 
CREATE TABLE IF NOT EXISTS Login_T(
	UserID VARCHAR(20) PRIMARY KEY,
	UserPassword VARCHAR(20) NOT NULL,
	CustomerID INT NOT NULL,
	FOREIGN KEY(CustomerID) REFERENCES Customers_T (CustomerID) 
);

DROP TABLE IF EXISTS ActivityLog_T;
CREATE TABLE IF NOT EXISTS ActivityLog_T ( 
	ActivityID INT AUTO_INCREMENT PRIMARY KEY,
	FitnessTypeID INT NOT NULL,
	StartTime TIME NOT NULL,
	EndTime TIME NOT NULL,
	CustCaloriesBurnt DECIMAL (10,2) NOT NULL,
	LogDate DATE NOT NULL,
	CustomerID INT NOT NULL,
    FOREIGN KEY(FitnessTypeID) REFERENCES FitnessType_T(FitnessTypeID),
    FOREIGN KEY(CustomerID) REFERENCES Customers_T(CustomerID)
);

DROP TABLE IF EXISTS Renewals_T;
CREATE TABLE IF NOT EXISTS Renewals_T (
	RenewalID INT AUTO_INCREMENT PRIMARY KEY,
	CustomerID INT NOT NULL,
    SubscriptionID INT NOT NULL,
	StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY(CustomerID) REFERENCES Customers_T(CustomerID),
    FOREIGN KEY(SubscriptionID) REFERENCES Subscriptions_T(SubscriptionID)
); 

DROP TABLE IF EXISTS Appointments_T;
CREATE TABLE IF NOT EXISTS Appointments_T ( 
	ApptID INT AUTO_INCREMENT PRIMARY KEY,
	CustomerID INT NOT NULL,
	ProfessionalID VARCHAR(20) NOT NULL,
	ApptType VARCHAR(20) NOT NULL,
	ApptDateTime DATETIME NOT NULL,
	FOREIGN KEY(CustomerID) REFERENCES Customers_T(CustomerID)
);

DROP TABLE IF EXISTS Performers;
CREATE TABLE IF NOT EXISTS Performers(
	CustomerID INT NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    Calories DOUBLE
);

################ Data Entry ################

INSERT INTO Customers_T (CustFirstName, CustLastName, EmailID, Phone, DateOfBirth, Gender, IsActive) 
VALUES('Liam', 'Payne', 'LPayne@gmail.com', '2811001234', '1993-08-29', 'M', 'Y'),
    ('Harry', 'Styles', 'HStyles@gmail.com', '2812001234', '1994-02-01', 'M', 'Y'),
    ('Zayn', 'Malik', 'ZMalik@gmail.com', '2813001234', '1993-01-12', 'M', 'N'),
    ('Loius', 'Tomlinson', 'LTomlinson@gmail.com', '2814001234', '1991-12-24', 'M', 'N'),
    ('Niall', 'Horan', 'NHoran@gmail.com', '2815001234', '1993-09-13', 'M', 'N'),
    ('Alicia', 'Keys', 'AKeys@gmail.com', '9721005678', '1981-01-25', 'F', 'Y'),
    ('Taylor', 'Swift', 'TSwift@gmail.com', '9722005678', '1989-12-13', 'F', 'Y'),
    ('Celine', 'Dion', 'CDion@gmail.com', '9723005678', '1968-03-30', 'F', 'N'),
    ('Mariah', 'Carey', 'MCarey@gmail.com', '9724005678', '1970-03-27', 'F', 'N'),
    ('Ariana', 'Grande', 'AGrande@gmail.com', '9725005678', '1993-06-26', 'F', 'Y');
SELECT * FROM Customers_T;

INSERT INTO Login_T 
VALUES('LPayne', '1Direction', 1), ('HStyles', '2Direction', 2), ('ZMalik', '3Direction', 3),
    ('LTomlinson', '4Direction', 4), ('NHoran', '5Direction', 5), ('AKey', 'GirlonFire', 6),
    ('TSwift', 'AntiHero', 7), ('CDion', 'MyHeartWillGoOn', 8), ('MCarey', 'AllIWantForXmas', 9),
    ('AGrande', '7Rings', 10);
SELECT * FROM Login_T;

INSERT INTO CustomerHealth_T (CustomerID, Height, Weight) 
VALUES(1, 5.9, 164), (2, 6.0, 180),	(3, 5.9, 150), (4, 5.8, 200), (5, 5.8, 198),
	(6, 5.6, 130), (7, 5.11, 139), (8, 5.7, 125), (9, 5.8, 120), (10, 5.3, 104);
SELECT * FROM CustomerHealth_T;
  
INSERT INTO HealthHistory_T (HealthID, AilmentName, Medication)
VALUES(3, 'Allergies', 'Zyrtec'), (4, 'Asthma', 'Theophylline'), (5,'Epilepsy', 'Clobazam'),
	(7, 'High Cholesterol', 'Lipitor'),	(8, 'Insomnia', 'Ativan'), (9, 'Lupus', 'Methotrexate'),
	(10, 'Migraine', 'Execedrin');
SELECT * FROM HealthHistory_T;
    
INSERT INTO FitnessType_T (FitnessName, Calories)
VALUES('Yoga', 200), ('Swimming', 600), ('Jogging', 410), ('Boxing', 600), ('Kick Boxing', 550),
    ('Pilates', 500), ('Weight Lifting', 450), ('Zumba', 600), ('Biking', 550), ('Cardio', 450);
SELECT * FROM FitnessType_T;

INSERT INTO Subscriptions_T (SubscriptionType)
VALUES('Free 1 Week'), ('3 Month'), ('6 Month'), ('9 Month'), ('12 Month');
SELECT * FROM Subscriptions_T;
    
INSERT INTO Specializations_T (SpecializationName)
VALUES('Fat Loss'), ('Muscle Gain'), ('Flexibility'), ('High Impact'), ('Eating Disorder'),
    ('Vegetarian'), ('Keto'), ('Balanced Diet');
SELECT * FROM Specializations_T;
    
INSERT INTO Trainers_T
VALUES('TR1', 'Bruce', 'Willis', 1, 'BWillis@gmail.com', '2341001234'),    
    ('TR2', 'Alan', 'Rickman', 4, 'ARickman@gmail.com', '2342001234'),
    ('TR3', 'Daniel', 'Radcliff', 2, 'DRadcliff@gmail.com', '2343001234'),
    ('TR4', 'Emma', 'Watson', 3, 'EWatson@gmail.com', '2344001234');
SELECT * FROM Trainers_T;

INSERT INTO Nutritionists_T
VALUES('NU1', 'Rupert', 'Grint', 'RGrint@gmail.com', '6381001234', 6),
    ('NU2', 'Tom', 'Felton', 'TFelton@gmail.com', '6382001234', 8),
    ('NU3', 'Maggie', 'Smith', 'MSmith@gmail.com','6383001234', 5),
    ('NU4', 'Without', 'Appt', 'NP@gmail.com','6380001234', 7);
SELECT * FROM Nutritionists_T;

INSERT INTO Appointments_T (CustomerID, ProfessionalID, ApptType, ApptDateTime)
VALUES(1,'TR1', 'Consultation', '2023-02-01 08:00:00'),
    (2, 'TR3', '1st Workout', '2023-02-02 08:00:00'),
    (4, 'TR4', '2nd Workout:Yoga', '2023-02-04 08:00:00'),
    (5, 'NU1', 'Consultation', '2023-02-05 08:00:00'),
    (6, 'NU2', '2nd Meeting:Diet', '2023-02-06 08:00:00'),
    (8, 'NU1', 'Consultation', '2023-02-08 08:00:00'),
    (9, 'NU2', 'Consultation', '2023-02-09 08:00:00');
SELECT * FROM Appointments_T;

INSERT INTO Renewals_T (CustomerID, SubscriptionID, StartDate, EndDate)
VALUES(4, 2, '2022-01-01', '2022-04-01'), (5, 3, '2022-02-02', '2022-08-02'), (8, 2, '2022-09-12', '2022-12-12'), 
	(9, 4, '2022-03-01', '2022-12-01'), (5, 3, '2022-08-03', '2023-02-03');
SELECT * FROM Renewals_T;

INSERT INTO ActivityLog_T (FitnessTypeID, StartTime, EndTime, CustCaloriesBurnt, LogDate, CustomerID)
VALUES (2, '13:45:21', '16:55:20', 353.67,'2022-10-15',1), (10, '08:20:30','10:30:30', 500.03,'2023-10-16',1),
	(4, '16:10:01','17:43:45', 305.00,'2022-10-17',1), (5,'09:10:20', '11:45:54', 245.90,'2022-10-15',2),
    (10, '14:45:34', '16:04:05', 432.77, '2022-10-16',2), (8, '07:02:32','09:35:43', 289.76, '2022-10-17',2),
	(6,'10:12:22', '11:11:21', 185.90,'2022-10-15',6), (10, '14:38:32', '17:45:07', 503.79, '2022-10-16',6),
    (3,'08:43:45', '10:00:00', 400.00,'2022-10-17',7), (10, '13:21:56', '15:43:34', 456.90, '2022-10-16',10);
SELECT * FROM ActivityLog_T;

##################### QUERIES ######################

# Get health history of all the customers
SELECT Customers_T.CustomerID, Customers_T.CustFirstName, Customers_T.CustLastName, Customers_T.Gender,
HealthHistory_T.AilmentName
FROM ((Customers_T INNER JOIN CustomerHealth_T ON Customers_T.CustomerID=CustomerHealth_T.CustomerID)
INNER JOIN HealthHistory_T ON HealthHistory_T.HealthID=CustomerHealth_T.HealthID);

# A trainer wants to find out how many appointments they have on a particular date
# Ex: Find the list of customers and their appointment types on 2nd February for trainer 3
SELECT CustomerID, ApptType FROM Appointments_T
WHERE ApptDateTime LIKE '2023-02-02%' and ProfessionalID = 'TR3';

# How many customers have renewed their subscriptions
Select Count(Renewals_T.CustomerID)
From Renewals_T Join Subscriptions_T
On Subscriptions_T.SubscriptionID = Renewals_T.SubscriptionID
where Subscriptions_T.SubscriptionType not like 'Free 1 Week';

# List the customers whose average height is greater than or equal to the overall average height.
Select c.CustFirstName, c.CustLastName, avg(cs.Height) from Customers_T c
inner join CustomerHealth_T cs on c.CustomerID = cs.CustomerID
group by c.CustomerID
having avg(cs.Height) > (select avg(CustomerHealth_T.Height) from CustomerHealth_T);

# List the customers whose average weight is greater than or equal to the overall average weight.
Select c.CustFirstName, c.CustLastName, avg(cs.Weight) from Customers_T c
inner join CustomerHealth_T cs on c.CustomerID = cs.CustomerID
group by c.CustomerID
having avg(cs.Weight) > (select avg(CustomerHealth_T.Weight) from CustomerHealth_T);

# List the fitness types with fewer than 2 customers 
select f.FitnessName, count(c.CustomerID) from FitnessType_T f
inner join ActivityLog_T a on f.FitnessTypeID = a.FitnessTypeID
inner join Customers_T c on a.CustomerID = c.CustomerID
group by f.FitnessName
having count(c.CustomerID) <2;

################ TABLES FOR TRIGGERS ################

CREATE TABLE CustomersAudit_T(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    CustFirstName VARCHAR(20) NOT NULL,
    CustLastName VARCHAR(20) NOT NULL,
    EmailID VARCHAR(40) NOT NULL,
    Phone VARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    IsActive CHAR(1) NOT NULL,
    ChangeDat DATETIME DEFAULT NULL,
    Action VARCHAR(10) DEFAULT NULL
);

CREATE TABLE CustomerPromotions_T(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    CustFirstName VARCHAR(20) NOT NULL,
    CustLastName VARCHAR(20) NOT NULL,
    EmailID VARCHAR(40) NOT NULL,
    Phone VARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    ChangeDat DATETIME DEFAULT NULL
);

CREATE TABLE AppointmentsAudit_T(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    ApptID INT NOT NULL,
	CustomerID INT NOT NULL,
	ProfessionalID VARCHAR(20) NOT NULL,
	ApptType VARCHAR(20) NOT NULL,
	ApptDateTime DATETIME NOT NULL,
	ChangeDat DATETIME DEFAULT NULL,
    Action VARCHAR(10) DEFAULT NULL
);

CREATE TABLE RenewalsAudit_T(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    RenewalID INT NOT NULL,
    CustomerID INT NOT NULL,
    SubscriptionID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
	ChangeDat DATETIME DEFAULT NULL,
    Action VARCHAR(10) DEFAULT NULL
);

################ TRIGGERS ################

# DROP TRIGGER Before_Customer_Insert;
CREATE TRIGGER Before_Customer_Insert
BEFORE INSERT ON Customers_T
FOR EACH ROW
INSERT INTO CustomerPromotions_T
SET CustomerID=NEW.CustomerID,
CustFirstName=NEW.CustFirstName,
CustLastName=NEW.CustLastName,
EmailID=NEW.EmailID,
Phone=NEW.Phone,
DateOfBirth=NEW.DateOfBirth,
Gender=NEW.Gender,
ChangeDat=NOW();

# DROP TRIGGER After_Customer_Update;
CREATE TRIGGER After_Customer_Update
AFTER UPDATE ON Customers_T
FOR EACH ROW
INSERT INTO CustomersAudit_T
SET Action='Update',
CustomerID=OLD.CustomerID,
CustFirstName=OLD.CustFirstName,
CustLastName=OLD.CustLastName,
EmailID=OLD.EmailID,
Phone=OLD.Phone,
DateOfBirth=OLD.DateOfBirth,
Gender=OLD.Gender,
IsActive=OLD.IsActive,
ChangeDat=NOW();

# DROP TRIGGER After_Customer_Delete;
CREATE TRIGGER After_Customer_Delete
AFTER DELETE ON Customers_T
FOR EACH ROW
INSERT INTO CustomersAudit_T
SET Action='Delete',
CustomerID=OLD.CustomerID,
CustFirstName=OLD.CustFirstName,
CustLastName=OLD.CustLastName,
EmailID=OLD.EmailID,
Phone=OLD.Phone,
DateOfBirth=OLD.DateOfBirth,
Gender=OLD.Gender,
IsActive=OLD.IsActive,
ChangeDat=NOW();

CREATE TRIGGER After_Appointment_Update
AFTER UPDATE ON Appointments_T
FOR EACH ROW
INSERT INTO AppointmentsAudit_T
SET Action='Update',
ApptID=OLD.ApptID,
CustomerID=OLD.CustomerID,
ProfessionalID=OLD.ProfessionalID,
ApptType=OLD.ApptType,
ApptDateTime=OLD.ApptDateTime,
ChangeDat=NOW();

CREATE TRIGGER After_Renewal_Insert
AFTER INSERT ON Renewals_T
FOR EACH ROW
INSERT INTO RenewalsAudit_T
SET RenewalID=NEW.RenewalID,
CustomerID=NEW.CustomerID,
SubscriptionID=NEW.SubscriptionID,
StartDate=NEW.StartDate,
EndDate=NEW.EndDate,
ChangeDat=NOW();

SHOW TRIGGERS;

############# TESTING THE TRIGGERS #############

# BEFORE CUSTOMER INSERT
INSERT INTO Customers_T (CustFirstName, CustLastName, EmailID, Phone, DateofBirth, Gender, IsActive) 
VALUES ('Joe', 'Alwyn', 'joe.alwyn22@gmail.com', '9453381265', '1984-08-23', 'M', 'Y');
SELECT * FROM CustomerPromotions_T;

# AFTER CUSTOMER UPDATE
UPDATE Customers_T SET CustLastName = "Pho" WHERE CustomerID = 11;
SELECT * FROM CustomersAudit_T;

# AFTER CUSTOMER DELETE
DELETE FROM Customers_T WHERE CustomerID = 11;
SELECT * FROM CustomersAudit_T;

# AFTER RENEWAL INSERT
INSERT INTO Renewals_T (CustomerID, SubscriptionID, StartDate, EndDate)
VALUES(4, 2, '2022-04-02', '2022-07-02');
SELECT * FROM RenewalsAudit_T;

# AFTER APPOINTMENT UPDATE
UPDATE Appointments_T SET ApptDateTime = "2023-02-05 12:00:00" WHERE CustomerID = 5;
SELECT * FROM AppointmentsAudit_T;

############### STORED FUNCTIONS ###############

# function 1 - to get total calories burnt by a customer
DELIMITER $$
CREATE FUNCTION GetTotalCalories(CustID INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE cal DOUBLE;
	SELECT SUM(CustCaloriesBurnt) INTO cal FROM ActivityLog_T GROUP BY CustomerID HAVING CustomerID = CustID;
    RETURN (cal);
END $$
DELIMITER ;

SELECT GetTotalCalories(2);

# function 2 - to get customer BMI
DELIMITER $$
CREATE FUNCTION GetCustomerBMI(CustID INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
	DECLARE bmi DOUBLE;
    DECLARE hgt DOUBLE;
    DECLARE wgt DOUBLE;
    SELECT Height INTO hgt FROM CustomerHealth_T WHERE CustomerID = CustID;
    SELECT Weight INTO wgt FROM CustomerHealth_T WHERE CustomerID = CustID;
    SET bmi = wgt/(hgt*hgt*144)*703;
    RETURN (bmi);
END $$
DELIMITER ;

SELECT GetCustomerBMI(2);

############## STORED PROCEDURES ###############

# procedure 1 - to get the top five performers
DELIMITER $$
CREATE PROCEDURE GetBestBurners()
BEGIN
	DECLARE custId INT;
    DECLARE cfname VARCHAR(20);
    DECLARE cal DOUBLE;
    DECLARE row_not_found TINYINT DEFAULT FALSE;
	DECLARE cust_cursor CURSOR FOR SELECT CustomerID, CustFirstName FROM Customers_T;
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
	SET row_not_found = TRUE;
    TRUNCATE TABLE Performers;
    OPEN cust_cursor;
	WHILE row_not_found = FALSE DO
		FETCH cust_cursor INTO custId, cfname;
        SELECT GetTotalCalories(custId) INTO cal;
        INSERT INTO Performers VALUES (custId, cfname, cal);
	END WHILE;
	CLOSE cust_cursor;
    SELECT * FROM Performers ORDER BY Calories DESC LIMIT 5;
END $$
DELIMITER ;

CALL GetBestBurners();

# procedure 2 - to categorize customers into different weight categories
DELIMITER $$
CREATE PROCEDURE CustomerWeightType(IN CustID INT, OUT WgtCategory VARCHAR(20))
BEGIN
    DECLARE bmi DOUBLE;
    SET bmi = GetCustomerBMI(CustID);
	IF bmi < 18.5 THEN
		SET WgtCategory = 'Underweight';
	ELSEIF bmi >= 18.5 AND bmi < 24.9 THEN
		SET WgtCategory = 'Normal Range';
	ELSEIF bmi >= 25 AND bmi < 29.9 THEN
		SET WgtCategory = 'Overweight';
	ELSE
		SET WgtCategory = 'Obese';
	END IF;
END $$
DELIMITER ;

CALL CustomerWeightType(2, @WgtCategory);
SELECT @WgtCategory;
