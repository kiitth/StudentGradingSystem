USE student_information;

-- list student names with the courses they are enrolled in

SELECT students.student_id, students.student_first_name, students.student_last_name, courses.course_id, courses.course_name
FROM students
INNER JOIN enrollments ON students.student_id = enrollments.student_id
INNER JOIN courses ON enrollments.course_id = courses.course_id
ORDER BY students.student_id, courses.course_name;

-- show student grades with courses

SELECT students.student_first_name, students.student_last_name, courses.course_name, grades.letter_grade, grades.date_submitted
FROM students
INNER JOIN enrollments ON students.student_id = enrollments.student_id
INNER JOIN courses ON enrollments.course_id = courses.course_id
INNER JOIN grades ON enrollments.enrollment_id = grades.enrollment_id
ORDER BY students.student_last_name, courses.course_name;

-- attendance

SELECT students.student_first_name, students.student_last_name, courses.course_name, attendance.date, attendance.status
FROM students
INNER JOIN enrollments ON students.student_id = enrollments.student_id
INNER JOIN courses ON enrollments.course_id = courses.course_id
INNER JOIN attendance ON enrollments.enrollment_id = attendance.enrollment_id
ORDER BY students.student_last_name, courses.course_name, attendance.date;


