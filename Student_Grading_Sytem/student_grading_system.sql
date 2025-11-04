CREATE DATABASE student_grading_system;
USE student_grading_system;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  username VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('teacher','student') NOT NULL
);

CREATE TABLE students (
  student_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
  course_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  course_name VARCHAR(100) NOT NULL,
  teacher_id INT NOT NULL,
  FOREIGN KEY (teacher_id) REFERENCES users(id)
);

CREATE TABLE grades (
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  grade VARCHAR(5),
  date_submitted DATE,
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE attendance (
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  status ENUM('Present','Absent','Late') NOT NULL,
  date DATE NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


