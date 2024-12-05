<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
</head>
<body>

<h1>Welcome, Admin</h1>
<p>Here are your administrative functions:</p>
<ul>
    <li>Add, edit, and delete information for a customer representative</li>
    <li>Obtain sales reports per month</li>
    <li>Produce a list of reservations:
        <ul>
            <li>By transit line</li>
            <li>By customer name</li>
        </ul>
    </li>
    <li>Produce a listing of revenue per:
        <ul>
            <li>Transit line</li>
            <li>Customer name</li>
        </ul>
    </li>
    <li>Best customer and best 5 most active transit lines</li>
</ul>

<form action="logout.jsp" method="post">
    <button type="submit">Logout</button>
</form>

</body>
</html>
