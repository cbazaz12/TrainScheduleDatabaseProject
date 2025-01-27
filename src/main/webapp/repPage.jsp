<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Representative Dashboard</title>
<style>
    body { font-family: Arial, sans-serif; }
    ul { list-style-type: none; padding: 0; }
    li { margin-bottom: 10px; }
    .button {
        padding: 10px 15px;
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
    }
    .button:hover {
        background-color: #45a049;
    }
    form {
        margin-top: 20px;
    }
</style>
</head>
<body>

<h1>Welcome, Customer Representative</h1>
<p>Here are your available functions:</p>
<ul>
    <li>
        <form action="manageSchedules.jsp" method="get" style="display: inline;">
            <button type="submit" class="button">Edit Train Schedule</button>
        </form>
    </li>
    <li>
        <form action="repAnswers.jsp" method="get" style="display: inline;">
            <button type="submit" class="button">Customer QNA</button>
        </form>
    </li>
    <li>
        <form action="searchTrainSchedules.jsp" method="get" style="display: inline;">
            <button type="submit" class="button">Train Schedule List List</button>
        </form>
    </li>
    <li>
        <form action="repReservationViewer.jsp" method="get" style="display: inline;">
            <button type="submit" class="button">Customer Reservation List</button>
        </form>
    </li>
</ul>

<form action="logout.jsp" method="post">
    <button type="submit" class="button" style="background-color: #ff4c4c;">Logout</button>
</form>

</body>
</html>
