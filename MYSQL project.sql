CREATE DATABASE MentalHealthSupportSystem;
USE MentalHealthSupportSystem;

CREATE TABLE Users (
    User_ID INT PRIMARY KEY AUTO_INCREMENT,
    User_Name VARCHAR(50) 
        DEFAULT (CONCAT('User_', FLOOR(RAND()*10000))),
    Email VARCHAR(100) UNIQUE NOT NULL,
    Date_Joined DATE
);


CREATE TABLE Volunteers (
    Volunteer_ID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID INT UNIQUE NOT NULL,
    Speciality VARCHAR(100),
    Status VARCHAR(20) DEFAULT 'Available' CHECK (Status IN ('Available','Busy','Unavailable')),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);

CREATE TABLE Organizations (
    Organization_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(150) NOT NULL,
    Contact TEXT,
    Org_Type VARCHAR(50) CHECK (Org_Type IN ('NGO','Hospital','Clinic','Government','Private')),
    Website VARCHAR(255)
);

CREATE TABLE Resources (
    Resource_ID INT PRIMARY KEY AUTO_INCREMENT,
    Organization_ID INT,
    Title VARCHAR(200) NOT NULL,
    Topic VARCHAR(100),
    Resource_Type VARCHAR(50) CHECK (Resource_Type IN ('Article','Video','Podcast','Book','Tool','Course')),
    FOREIGN KEY (Organization_ID) REFERENCES Organizations(Organization_ID)
);

CREATE TABLE Sessions (
    Session_ID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Volunteer_ID INT NOT NULL,
    Session_Type VARCHAR(50) CHECK (Session_Type IN ('Consultation','Therapy','Support Group','Assessment','Follow-up')),
    Duration INT NOT NULL,
    Date_Time DATETIME NOT NULL,
    Status VARCHAR(20) DEFAULT 'Scheduled' CHECK (Status IN ('Scheduled','Completed','Cancelled','No-show')),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Volunteer_ID) REFERENCES Volunteers(Volunteer_ID)
);

CREATE TABLE Notes (
    Note_ID INT PRIMARY KEY AUTO_INCREMENT,
    Session_ID INT NOT NULL,
    Content TEXT NOT NULL,
    FOREIGN KEY (Session_ID) REFERENCES Sessions(Session_ID)
);

CREATE TABLE Assessments (
    Assessment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Session_ID INT UNIQUE NOT NULL,
    SeverityLevel VARCHAR(20) CHECK (SeverityLevel IN ('Low','Medium','High','Critical')),
    Summary TEXT,
    FOREIGN KEY (Session_ID) REFERENCES Sessions(Session_ID)
);

CREATE TABLE Plans (
    Plan_ID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID INT NOT NULL,
    Volunteer_ID INT NOT NULL,
    Plan_Description TEXT NOT NULL,
    Status VARCHAR(20) DEFAULT 'Active' CHECK (Status IN ('Active','Completed','Cancelled','On Hold')),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Volunteer_ID) REFERENCES Volunteers(Volunteer_ID)
);

CREATE TABLE Volunteer_Organization (
    Volunteer_ID INT NOT NULL,
    Organization_ID INT NOT NULL,
    PRIMARY KEY (Volunteer_ID, Organization_ID),
    FOREIGN KEY (Volunteer_ID) REFERENCES Volunteers(Volunteer_ID),
    FOREIGN KEY (Organization_ID) REFERENCES Organizations(Organization_ID)
);

INSERT INTO Users (Email, Date_Joined) VALUES
('ali@gmail.com','2024-01-01'),
('sara@gmail.com','2024-01-02'),
('usman@gmail.com','2024-01-03'),
('ayesha@gmail.com','2024-01-04'),
('bilal@gmail.com','2024-01-05'),
('hina@gmail.com','2024-01-06'),
('hamza@gmail.com','2024-01-07'),
('zara@gmail.com','2024-01-08'),
('omar@gmail.com','2024-01-09'),
('maham@gmail.com','2024-01-10');


INSERT INTO Volunteers (User_ID, Speciality, Status) VALUES
(1,'Anxiety','Available'),
(2,'Depression','Busy'),
(3,'Stress','Available'),
(4,'Trauma','Unavailable'),
(5,'Counseling','Available'),
(6,'Therapy','Busy'),
(7,'Youth Support','Available'),
(8,'Family Therapy','Available'),
(9,'Addiction','Unavailable'),
(10,'Mental Wellness','Available');

INSERT INTO Organizations (Name, Contact, Org_Type, Website) VALUES
('MindCare NGO','0300-1111111','NGO','www.mindcare.org'),
('Hope Clinic','0300-2222222','Clinic','www.hopeclinic.pk'),
('Mental Health Hospital','0300-3333333','Hospital','www.mhhospital.pk'),
('Wellness Center','0300-4444444','Private','www.wellness.pk'),
('Gov Health Dept','0300-5555555','Government','www.health.gov.pk');

INSERT INTO Volunteer_Organization (Volunteer_ID, Organization_ID) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,1),(7,2),(8,3),(9,4),(10,5);

INSERT INTO Resources (Organization_ID, Title, Topic, Resource_Type) VALUES
(1,'Managing Anxiety','Anxiety','Article'),
(2,'Depression Awareness Video','Depression','Video'),
(3,'Stress Management Podcast','Stress','Podcast'),
(4,'Therapy Techniques Book','Therapy','Book'),
(5,'Government Health Guidelines','Mental Health','Tool');

INSERT INTO Sessions (User_ID, Volunteer_ID, Session_Type, Duration, Date_Time, Status) VALUES
(1,1,'Consultation',60,'2024-01-05 10:00:00','Completed'),
(2,2,'Therapy',45,'2024-01-06 11:00:00','Scheduled'),
(3,3,'Support Group',90,'2024-01-07 14:00:00','Scheduled'),
(4,4,'Assessment',30,'2024-01-08 09:00:00','Cancelled'),
(5,5,'Follow-up',60,'2024-01-09 13:00:00','Scheduled'),
(6,6,'Consultation',60,'2024-01-10 10:00:00','Completed'),
(7,7,'Therapy',45,'2024-01-11 11:00:00','Scheduled'),
(8,8,'Support Group',90,'2024-01-12 14:00:00','Scheduled'),
(9,9,'Assessment',30,'2024-01-13 09:00:00','Cancelled'),
(10,10,'Follow-up',60,'2024-01-14 13:00:00','Scheduled');

INSERT INTO Notes (Session_ID, Content) VALUES
(1,'Patient reported mild anxiety, advised breathing exercises.'),
(2,'Depression severity discussed, therapy plan created.'),
(3,'Group session focused on stress management techniques.'),
(4,'Assessment postponed due to patient unavailability.'),
(5,'Follow-up on previous session, progress noted.'),
(6,'Patient showed improvement in anxiety symptoms.'),
(7,'Therapy session focused on coping strategies.'),
(8,'Support group covered stress relief techniques.'),
(9,'Assessment rescheduled due to absence.'),
(10,'Follow-up session, improvement noted.');

INSERT INTO Assessments (Session_ID, SeverityLevel, Summary) VALUES
(1,'Medium','Moderate anxiety symptoms observed.'),
(2,'High','Severe depression symptoms.'),
(3,'Low','Stress levels manageable.'),
(5,'Medium','Follow-up indicates improvement.'),
(6,'Medium','Anxiety symptoms improving.'),
(7,'High','Depression symptoms still high.'),
(8,'Low','Stress relief successful.'),
(10,'Medium','Follow-up shows progress.');

INSERT INTO Plans (User_ID, Volunteer_ID, Plan_Description, Status) VALUES
(1,1,'Daily mindfulness exercises for anxiety reduction.','Active'),
(2,2,'Weekly therapy sessions for depression management.','Active'),
(3,3,'Monthly support group meetings for stress relief.','Active'),
(4,4,'Assessment-based therapy plan.','On Hold'),
(5,5,'Follow-up therapy sessions and coping strategies.','Active'),
(6,6,'Regular anxiety management sessions.','Active'),
(7,7,'Therapy sessions for depression management.','Active'),
(8,8,'Group stress relief activities.','Active'),
(9,9,'Assessment pending, plan preparation.','On Hold'),
(10,10,'Follow-up and mindfulness plan.','Active');


SELECT
    u.User_Name,
    u.Date_Joined,

    s.Session_Type,
    s.Date_Time,
    s.Status AS Session_Status,
    s.Duration,

    v.Speciality AS Volunteer_Speciality,
    v.Status AS Volunteer_Status,

    a.SeverityLevel,
    a.Summary AS Assessment_Summary,

    n.Content AS Session_Notes,

    p.Plan_Description,
    p.Status AS Plan_Status,

    o.Name AS Organization_Name,
    r.Title AS Resource_Title,
    r.Resource_Type

FROM Users u
LEFT JOIN Sessions s ON u.User_ID = s.User_ID
LEFT JOIN Volunteers v ON s.Volunteer_ID = v.Volunteer_ID
LEFT JOIN Assessments a ON s.Session_ID = a.Session_ID
LEFT JOIN Notes n ON s.Session_ID = n.Session_ID
LEFT JOIN Plans p ON u.User_ID = p.User_ID
LEFT JOIN Volunteer_Organization vo ON v.Volunteer_ID = vo.Volunteer_ID
LEFT JOIN Organizations o ON vo.Organization_ID = o.Organization_ID
LEFT JOIN Resources r ON o.Organization_ID = r.Organization_ID
ORDER BY a.SeverityLevel;

/* =========================================================
   1. INNER JOIN
   Definition:
   Returns only those records that have matching values
   in both tables.
   ========================================================= */

SELECT 
    u.User_Name,
    s.Session_Type,
    s.Date_Time
FROM Users u
INNER JOIN Sessions s
ON u.User_ID = s.User_ID;



/* =========================================================
   2. LEFT JOIN
   Definition:
   Returns all records from the left table and the matched
   records from the right table. If no match exists,
   NULL values are returned for the right table.
   ========================================================= */

SELECT 
    u.User_Name,
    s.Session_Type,
    s.Date_Time
FROM Users u
LEFT JOIN Sessions s
ON u.User_ID = s.User_ID;



/* =========================================================
   3. RIGHT JOIN
   Definition:
   Returns all records from the right table and the matched
   records from the left table. If no match exists,
   NULL values are returned for the left table.
   ========================================================= */

SELECT 
    u.User_Name,
    s.Session_Type,
    s.Date_Time
FROM Users u
RIGHT JOIN Sessions s
ON u.User_ID = s.User_ID;



/* =========================================================
   4. FULL OUTER JOIN (Using UNION in MySQL)
   Definition:
   Returns all records when there is a match in either
   left table or right table. MySQL does not support
   FULL JOIN directly, so it is implemented using UNION.
   ========================================================= */

SELECT 
    u.User_Name,
    s.Session_Type,
    s.Date_Time
FROM Users u
LEFT JOIN Sessions s
ON u.User_ID = s.User_ID

UNION

SELECT 
    u.User_Name,
    s.Session_Type,
    s.Date_Time
FROM Users u
RIGHT JOIN Sessions s
ON u.User_ID = s.User_ID;



/* =========================================================
   5. CROSS JOIN
   Definition:
   Returns the Cartesian product of both tables,
   meaning every row of the first table is combined
   with every row of the second table.
   ========================================================= */

SELECT 
    u.User_Name,
    o.Name AS Organization_Name
FROM Users u
CROSS JOIN Organizations o;

SELECT User_ID, User_Name, Email, Date_Joined 
FROM Users
WHERE User_ID = 7
Group by Date_joined;

SELECT User_ID, User_Name, Email, Date_Joined 
FROM Users
ORDER BY Date_joined DESC;

SELECT Volunteer_ID, User_ID, Speciality, Status 
FROM Volunteers
WHERE Speciality = "Stress";

SELECT Organization_ID, Name, Contact, Org_Type, Website
FROM Organizations;

SELECT Resource_ID, Organization_ID, Title, Topic, Resource_Type
FROM Resources
WHERE Topic = "Depression";

SELECT Session_ID, User_ID,  Volunteer_ID, Session_Type, Duration 
Date_Time, Status
FROM Sessions;

SELECT Note_ID, Session_ID, Content
FROM Notes
HAVING Session_ID = "Depression severity discussed, therapy plan created.";

SELECT Assessment_ID, Session_ID, SeverityLevel, Summary
FROM Assessments;

SELECT Plan_ID, User_ID, Volunteer_ID, Plan_Description, Status
FROM Plans;

SELECT Volunteer_ID, Organization_ID
FROM  Volunteer_Organization;
