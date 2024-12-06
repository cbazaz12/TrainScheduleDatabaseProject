<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
    <li>
        <a href="manageCustomerReps.jsp">Add, edit, and delete information for a customer representative</a>
    </li>
    <li>
        <a href="salesReport.jsp">Obtain sales reports per month</a>
    </li>

    <!-- Produce list of reservations button -->
    <li>
        <form action="listAllReservations.jsp" method="post">
            <button type="submit">View All Reservations</button>
        </form>
    </li>

    <!-- Search reservations by transit line button -->
    <li>
        <form action="searchReservationsByLine.jsp" method="post">
            <button type="submit">Search Reservations by Transit Line</button>
        </form>
    </li>

    <!-- Search reservations by customer name button -->
    <li>
        <form action="searchReservationsByCustomer.jsp" method="post">
            <button type="submit">Search Reservations by Customer Name</button>
        </form>
    </li>

    <li>Produce a listing of revenue per:
        <ul>
            <li><a href="revenueByLine.jsp">Transit line</a></li>
            <li><a href="revenueByCustomer.jsp">Customer name</a></li>
        </ul>
    </li>
    <li>
        <a href="bestCustomerAndLines.jsp">Best customer and best 5 most active transit lines</a>
    </li>
</ul>

<form action="logout.jsp" method="post">
    <button type="submit">Logout</button>
</form>

</body>
</html>
