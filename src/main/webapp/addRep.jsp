<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Representative</title>
</head>
<body>
<h1>Add Customer Representative</h1>

<form action="addRepProcess.jsp" method="post">
    Username: <input type="text" name="username" required><br>
    Password: <input type="password" name="password" required><br>
    First Name: <input type="text" name="firstname" required><br>
    Last Name: <input type="text" name="lastname" required><br>
    SSN: <input type="text" name="ssn" required><br>
    Role: <input type="text" name="role" value="rep" readonly><br>
    <button type="submit">Add Representative</button>
</form>

</body>
</html>
