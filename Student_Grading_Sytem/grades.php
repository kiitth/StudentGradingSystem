<?php
include 'db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $grades = $_POST['grade'];
  $student_ids = [1, 2]; // Demo only
  $course_id = 1;

  for ($i = 0; $i < count($student_ids); $i++) {
    $sql = "INSERT INTO grades (student_id, course_id, grade, date_submitted)
            VALUES (?, ?, ?, CURDATE())";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iis", $student_ids[$i], $course_id, $grades[$i]);
    $stmt->execute();
  }
  echo "Grades saved successfully!";
}
?>
