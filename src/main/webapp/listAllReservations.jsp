<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Reservations</title>
</head>
<body>

<h1>All Reservations</h1>

<% 
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        ApplicationDB db = new ApplicationDB();
        conn = db.getConnection();
        stmt = conn.createStatement();
        String query = "SELECT * FROM reservationreserveshas";
        rs = stmt.executeQuery(query);

        // Display reservations
        if (rs.next()) {
%>
            <table border="1">
                <tr>
                    <th>Reservation Number</th>
                    <th>Date</th>
                    <th>Total Fare</th>
                    <th>Username</th>
                    <th>Train ID</th>
                    <th>Origin Date/Time</th>
                </tr>
<%
            do {
%>
                <tr>
                    <td><%= rs.getInt("reservation_number") %></td>
                    <td><%= rs.getDate("date") %></td>
                    <td><%= rs.getDouble("total_fare") %></td>
                    <td><%= rs.getString("username") %></td>
                    <td><%= rs.getInt("tid") %></td>
                    <td><%= rs.getTimestamp("origin_datetime") %></td>
                </tr>
<%
            } while (rs.next());
%>
            </table>
<%
        } else {
%>
            <p>No reservations found.</p>
<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<form action="adminPage.jsp" method="post">
    <button type="submit">Back to Admin Dashboard</button>
</form>

</body>
</html>
