<?php
include 'db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $course = $_POST['course'];
  $statuses = $_POST['status'];
  $student_ids = [1, 2]; // Temporary demo data

  for ($i = 0; $i < count($student_ids); $i++) {
    $sql = "INSERT INTO attendance (student_id, course_id, status, date)
            VALUES (?, ?, ?, CURDATE())";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iss", $student_ids[$i], $course, $statuses[$i]);
    $stmt->execute();
  }
  echo "Attendance submitted successfully!";
}
?>
