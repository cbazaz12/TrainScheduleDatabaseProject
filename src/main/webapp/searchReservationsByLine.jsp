<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Reservations by Transit Line</title>
</head>
<body>
<h1>Search Reservations by Transit Line</h1>
<form action="reservationsByLine.jsp" method="post">
    <label for="transitLine">Transit Line:</label>
    <input type="text" id="transitLine" name="transitLine" required>
    <button type="submit">Search</button>
</form>
</body>
</html>
