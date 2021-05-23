use dbms;

CREATE TABLE SCHOOL(
            SchoolID          INT(10)     NOT NULL,
	        SchoolName        VARCHAR(50)     NOT NULL,
            Dean          VARCHAR(15)    NOT NULL,
PRIMARY KEY (SchoolID)
);

#CONSTRAINT SCHOOL FOREIGN KEY (FacultyID) REFERENCES faculty(FacultyID),
#FOREIGN KEY (FacultyID) REFERENCES faculty(FacultyID)


CREATE TABLE DEPARTMENT(
            DepartmentID          INT(10)     NOT NULL,
	        DepartmentName        VARCHAR(25)     NOT NULL,
            SchoolID INT(10)    ,
            Head          VARCHAR(15)    NOT NULL,
PRIMARY KEY (DepartmentID),
FOREIGN KEY (SchoolID) REFERENCES SCHOOL(SchoolID)
);


CREATE TABLE FACULTY
             (FacultyID          INT(10)    NOT NULL,
              first_name        VARCHAR(15) ,
              last_name     VARCHAR(15) ,
              gender        VARCHAR(10) ,
              dateOfBirth        DATE ,
              email       VARCHAR(15) ,
              address     VARCHAR(30) ,
              phone   INT(15) ,
              DepartmentID  INT(10) ,
PRIMARY KEY (FacultyID),
FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);

CREATE TABLE PROGRAM(
            ProgramID          INT(10)     NOT NULL,
	        ProgramName        VARCHAR(50)     NOT NULL,
            DepartmentID          INT(10)     NOT NULL,

PRIMARY KEY (ProgramID),
FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)

);

CREATE TABLE STUDENT
             (StudentID          INT(10)    NOT NULL,
              first_name        VARCHAR(15) ,
              last_name     VARCHAR(15) ,
              gender        VARCHAR(10) ,
              dateOfBirth        DATE ,
              email       VARCHAR(15) ,
              address     VARCHAR(30) ,
              phone   INT(15) ,
              cgpa   Numeric(5) ,
              DepartmentID  INT(10) ,
              ProgramID  INT(10) ,
              SchoolID INT (10),
PRIMARY KEY (StudentID),
FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID),
FOREIGN KEY (ProgramID) REFERENCES program(ProgramID),
FOREIGN KEY (SchoolID) REFERENCES SCHOOL(SchoolID)
);


CREATE TABLE SEMESTER(
            SemesterID          INT(10)     NOT NULL,
	        semesterName        VARCHAR(50)     NOT NULL,           
PRIMARY KEY (SemesterID)
#FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)

);


CREATE TABLE COURSE
             (CourseID          INT(10)    NOT NULL,
              courseName        VARCHAR(15) ,
              courseType     VARCHAR(10) ,
              noOfCredits   INT(1) ,
              noOfSections  INT(2) ,
              SemesterID          INT(10)     NOT NULL,
              ProgramID          INT(10)     NOT NULL,
PRIMARY KEY (CourseID),
FOREIGN KEY (SemesterID) REFERENCES SEMESTER(SemesterID),
FOREIGN KEY (ProgramID) REFERENCES program(ProgramID)
);

CREATE TABLE SECTION
             (SectionID          INT(10)    NOT NULL,
              sectionNo  INT(2) ,
              noOfStudents INT(3),
              SemesterID INT(10)     NOT NULL,
              FacultyID INT(10)     NOT NULL,
              CourseID INT(10)     NOT NULL,
PRIMARY KEY (SectionID),
FOREIGN KEY (SemesterID) REFERENCES SEMESTER(SemesterID),
FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID),
FOREIGN KEY (FacultyID) REFERENCES FACULTY(FacultyID)
);


CREATE TABLE ENROLLMENT
             (EnrollmentID          INT(10)    NOT NULL AUTO_INCREMENT,
              SemesterID INT(10)     NOT NULL,
              SectionID INT(10)     NOT NULL,
              StudentID INT(10)     NOT NULL,
PRIMARY KEY (EnrollmentID),
FOREIGN KEY (SemesterID) REFERENCES SEMESTER(SemesterID),
FOREIGN KEY (SectionID) REFERENCES SECTION(SectionID),
FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
);

CREATE TABLE EVALUATION
             (EvaluationID          INT(10)    NOT NULL AUTO_INCREMENT,
              marksObtained INT(3)     ,
              AssessmentID INT(10)     NOT NULL,
              EnrollmentID INT(10)     NOT NULL,
PRIMARY KEY (EvaluationID),
#FOREIGN KEY (AssessmentID) REFERENCES ASSESSMENT(AssessmentID),
FOREIGN KEY (EnrollmentID) REFERENCES ENROLLMENT(EnrollmentID)
);

CREATE TABLE ASSESSMENT
             (AssessmentID          INT(10)    NOT NULL AUTO_INCREMENT,
              marksObtained INT (3),
              COID INT(10)     NOT NULL,
              SectionID INT(10)     NOT NULL,
              StudentID INT(10)     NOT NULL,
              SemesterID INT(10) NOT NULL,
PRIMARY KEY (AssessmentID),
FOREIGN KEY (SemesterID) REFERENCES SEMESTER(SemesterID),
FOREIGN KEY (SectionID) REFERENCES SECTION(SectionID),
FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
);

CREATE TABLE CourseGrade
             ( GradeID   INT(10)    NOT NULL AUTO_INCREMENT,
            StudentID INT(10)     NOT NULL,
            SemesterID INT(10)     NOT NULL,
            SectionID INT(10)     NOT NULL,
            FacultyID int(10) NOT NULL,
            CourseName VARCHAR (10),
            ProgramID INT(10)    ,
            DepartmentName VARCHAR (10),
            SchoolName Varchar (10),
            CourseGrade CHAR(1),
            CourseGradePoint numeric(5),
            PLO1        NUMERIC(10),
            PLO2        NUMERIC(10),
            PLO3        NUMERIC(10),
            PLO4        NUMERIC(10),
            CO1        NUMERIC(10),
            CO2        NUMERIC(10),
            CO3        NUMERIC(10),
            CO4        NUMERIC(10),

PRIMARY KEY (GradeID),
FOREIGN KEY (SemesterID) REFERENCES SEMESTER(SemesterID),
FOREIGN KEY (SectionID) REFERENCES SECTION(SectionID),
FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
FOREIGN KEY (FacultyID) REFERENCES FACULTY(FacultyID)
);


CREATE TABLE TRANSCRIPT(
    TranscriptID INT (10) NOT NULL AUTO_INCREMENT,
    grade Varchar(2),
    gpa NUMERIC(5),
    CourseName VARCHAR(10),
    StudentID INT(10)     NOT NULL,
    SemesterID INT(10)     NOT NULL,
    SectionID INT(10)     NOT NULL,
PRIMARY KEY (TranscriptID),
FOREIGN KEY (SemesterID) REFERENCES SEMESTER(SemesterID),
FOREIGN KEY (SectionID) REFERENCES SECTION(SectionID),
FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
);

CREATE TABLE PLO(
    PLOID INT (10) NOT NULL,
    PLONo varchar(5),
    PLODetails varchar(30),
    ProgramID INT (10),

    PRIMARY KEY (PLOID),
    FOREIGN KEY (ProgramID) REFERENCES PROGRAM(ProgramID)

);

CREATE TABLE CO(
    COID INT (10) NOT NULL,
    CONo varchar(5),
    CODetails varchar(30),
    CourseID INT (10),
    PLOID INT (10),
    PRIMARY KEY (COID),
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID),
    FOREIGN KEY (PLOID) REFERENCES PLO(PLOID)

);
ALTER TABLE Evaluation
ADD FOREIGN KEY (AssessmentID) REFERENCES Assessment(AssessmentID);
ALTER TABLE ASSESSMENT
ADD FOREIGN KEY (COID) REFERENCES CO(COID);