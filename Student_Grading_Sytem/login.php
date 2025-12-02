<?php
include 'db_connect.php';
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $username = $_POST['username'];
  $password = $_POST['password'];
  $role = $_POST['role'];

  $stmt = $conn->prepare("SELECT * FROM users WHERE username=? AND role=?");
  $stmt->bind_param("ss", $username, $role);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    if ($password === $user['password']) {
      $_SESSION['user_id'] = $user['id'];
      $_SESSION['role'] = $user['role'];
      header("Location: ../" . ($role === "teacher" ? "teacher_dashboard.html" : "student_dashboard.html"));
      exit();
    } else {
      echo "Invalid password.";
    }
  } else {
    echo "User not found.";
  }
}
?>

