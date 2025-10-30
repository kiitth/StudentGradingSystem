-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Student_Information
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Student_Information
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Student_Information` DEFAULT CHARACTER SET utf8 ;
USE `Student_Information` ;

-- -----------------------------------------------------
-- Table `Student_Information`.`Students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_Information`.`Students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `student_first_name` VARCHAR(45) NOT NULL,
  `student_last_name` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `student_email` VARCHAR(100) NOT NULL,
  `student_phone` VARCHAR(45) NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `student_email_UNIQUE` (`student_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_Information`.`Teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_Information`.`Teachers` (
  `teacher_id` INT NOT NULL AUTO_INCREMENT,
  `teacher_first_name` VARCHAR(45) NOT NULL,
  `teacher_last_name` VARCHAR(45) NOT NULL,
  `teacher_email` VARCHAR(100) NOT NULL,
  `teacher_phone` VARCHAR(45) NULL,
  PRIMARY KEY (`teacher_id`),
  UNIQUE INDEX `teacher_email_UNIQUE` (`teacher_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_Information`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_Information`.`Courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(45) NOT NULL,
  `course_code` VARCHAR(45) NOT NULL,
  `credits` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE INDEX `course_code_UNIQUE` (`course_code` ASC) VISIBLE,
  INDEX `teacher_id_idx` (`teacher_id` ASC) VISIBLE,
  CONSTRAINT `courses.teacher_id`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `Student_Information`.`Teachers` (`teacher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_Information`.`Enrollments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_Information`.`Enrollments` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `enrollment_date` DATE NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `enrollments.student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student_Information`.`Students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `enrollments.course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `Student_Information`.`Courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_Information`.`Grades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_Information`.`Grades` (
  `grade_id` INT NOT NULL AUTO_INCREMENT,
  `enrollment_id` INT NOT NULL,
  `letter_grade` VARCHAR(10) NOT NULL,
  `date_submitted` DATE NOT NULL,
  PRIMARY KEY (`grade_id`),
  INDEX `enrollment_id_idx` (`enrollment_id` ASC) VISIBLE,
  CONSTRAINT `grades.enrollment_id`
    FOREIGN KEY (`enrollment_id`)
    REFERENCES `Student_Information`.`Enrollments` (`enrollment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_Information`.`Attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_Information`.`Attendance` (
  `attendance_id` INT NOT NULL AUTO_INCREMENT,
  `enrollment_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `status` ENUM('Present', 'Absent', 'Excused') NOT NULL,
  PRIMARY KEY (`attendance_id`),
  INDEX `enrollment_id_idx` (`enrollment_id` ASC) VISIBLE,
  CONSTRAINT `attendance.enrollment_id`
    FOREIGN KEY (`enrollment_id`)
    REFERENCES `Student_Information`.`Enrollments` (`enrollment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student_Information`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student_Information`.`Users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role` ENUM('Student', 'Teacher', 'Admin') NOT NULL,
  `student_id` INT NULL,
  `teacher_id` INT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `teacher_id_idx` (`teacher_id` ASC) VISIBLE,
  CONSTRAINT `users.student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student_Information`.`Students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `users.teacher_id`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `Student_Information`.`Teachers` (`teacher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

