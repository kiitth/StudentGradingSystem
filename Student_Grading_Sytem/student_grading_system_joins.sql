USE student_grading_system;

-- students and their courses

SELECT students.name, courses.course_name
FROM grades
INNER JOIN students ON grades.student_id = students.student_id
INNER JOIN courses ON grades.course_id = courses.course_id;

-- student course grades

SELECT students.name, courses.course_name, grades.grade, grades.date_submitted
FROM grades
INNER JOIN students ON grades.student_id = students.student_id
INNER JOIN courses ON grades.course_id = courses.course_id;

-- student attendance
SELECT students.name, courses.course_name, attendance.status, attendance.date
FROM attendance
INNER JOIN students ON attendance.student_id = students.student_id
INNER JOIN courses ON attendance.course_id = courses.course_id;

-- list courses with teachers

SELECT courses.course_name, users.username AS teacher_name
FROM courses
INNER JOIN users ON courses.teacher_id = users.id
WHERE users.role = 'teacher';


