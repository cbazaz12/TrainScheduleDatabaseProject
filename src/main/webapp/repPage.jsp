<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Representative Dashboard</title>
</head>
<body>

<h1>Welcome, Customer Representative</h1>
<p>Here are your available functions:</p>
<ul>
    <li>Edit and delete information for train schedules</li>
    <li>Browse and search customer questions</li>
    <li>Reply to customer questions</li>
    <li>Produce a list of train schedules for a given station (as origin/destination)</li>
    <li>Produce a list of all customers with reservations on a given transit line and date</li>
</ul>

<form action="logout.jsp" method="post">
    <button type="submit">Logout</button>
</form>

</body>
</html>
