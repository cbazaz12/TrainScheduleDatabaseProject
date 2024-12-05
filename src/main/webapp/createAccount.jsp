<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Account</title>
</head>
<body>

<h2>Create Account</h2>
<form action="createAccountResult.jsp" method="post">
    <label for="newUsername">Username:</label>
    <input type="text" id="newUsername" name="newUsername" required><br><br>

    <label for="newPassword">Password:</label>
    <input type="password" id="newPassword" name="newPassword" required><br><br>

    <label for="firstName">First Name:</label>
    <input type="text" id="firstName" name="firstName" required><br><br>

    <label for="lastName">Last Name:</label>
    <input type="text" id="lastName" name="lastName" required><br><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br><br>

    <input type="submit" value="Create Account">
</form>

<br>
<!-- Add a Back button to return to login page -->
<form action="login.jsp" method="get">
    <input type="submit" value="Back to Login">
</form>

</body>
</html>
