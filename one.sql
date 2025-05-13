-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS StudentRecordsDB;

-- Use the StudentRecordsDB database
USE StudentRecordsDB;

-- Drop tables if they exist (Good for development and testing, REMOVE in production)
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS CourseAssignment;
DROP TABLE IF EXISTS Grade;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Instructor;


-- Create the Department table
CREATE TABLE Department (
    DeptID INT AUTO_INCREMENT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    DeptCode VARCHAR(10) NOT NULL UNIQUE
);

-- Create the Instructor table
CREATE TABLE Instructor (
    InstructorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DeptID INT,
    Email VARCHAR(100) UNIQUE,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Create the Course table
CREATE TABLE Course (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    CourseCode VARCHAR(20) NOT NULL UNIQUE,
    Credits INT NOT NULL,
    DeptID INT,
    InstructorID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID),
    CONSTRAINT CHK_Credits CHECK (Credits > 0)
);

-- Create the Student table
CREATE TABLE Student (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Email VARCHAR(100) UNIQUE,
    MajorID INT,
    FOREIGN KEY (MajorID) REFERENCES Department(DeptID)
);

-- Create the Grade table
CREATE TABLE Grade (
    GradeID INT AUTO_INCREMENT PRIMARY KEY,
    Grade VARCHAR(3) NOT NULL,
    CONSTRAINT CHK_Grade CHECK (Grade IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F', 'I'))
);
-- Create the CourseAssignment table
CREATE TABLE CourseAssignment (
    CourseAssignmentID INT AUTO_INCREMENT PRIMARY KEY,
    CourseID INT,
    InstructorID INT,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

-- Create the Enrollment table (Many-to-Many relationship between Student and Course)
CREATE TABLE Enrollment (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    GradeID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (GradeID) REFERENCES Grade(GradeID),
    UNIQUE (StudentID, CourseID) -- Prevent a student from enrolling in the same course twice
);
