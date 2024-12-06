<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Reservations by Customer</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        .container {
            margin-bottom: 20px;
        }
        .back-btn {
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #f0f0f0;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>

<h1>Search Reservations by Customer Name</h1>

<form action="searchReservationsByCustomer.jsp" method="get">
    <label for="username">Enter Customer Username:</label>
    <input type="text" id="username" name="username" required>
    <button type="submit">Search</button>
</form>

<% 
    String username = request.getParameter("username");
    if (username != null && !username.isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            ApplicationDB db = new ApplicationDB();
            conn = db.getConnection();

            String query = "SELECT r.reservation_number, r.date, r.total_fare, r.username, " +
                           "       s.transit_line, s.origin_station, s.dest_station, s.origin_datetime " +
                           "FROM reservationreserveshas r " +
                           "JOIN schedule s ON r.tid = s.tid AND r.origin_datetime = s.origin_datetime " +
                           "WHERE r.username = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            // Display the reservations for the specified customer
            if (rs.next()) {
%>
                <table>
                    <thead>
                        <tr>
                            <th>Reservation Number</th>
                            <th>Date</th>
                            <th>Total Fare</th>
                            <th>Username</th>
                            <th>Transit Line</th>
                            <th>Origin Station</th>
                            <th>Destination Station</th>
                            <th>Origin Date/Time</th>
                        </tr>
                    </thead>
                    <tbody>
<%
                do {
%>
                        <tr>
                            <td><%= rs.getInt("reservation_number") %></td>
                            <td><%= rs.getDate("date") %></td>
                            <td><%= rs.getDouble("total_fare") %></td>
                            <td><%= rs.getString("username") %></td>
                            <td><%= rs.getString("transit_line") %></td>
                            <td><%= rs.getString("origin_station") %></td>
                            <td><%= rs.getString("dest_station") %></td>
                            <td><%= rs.getTimestamp("origin_datetime") %></td>
                        </tr>
<%
                } while (rs.next());
%>
                    </tbody>
                </table>
<%
            } else {
%>
                <p>No reservations found for customer <%= username %>.</p>
<%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<div class="container">
    <form action="adminPage.jsp" method="post">
        <button class="back-btn" type="submit">Back to Admin Dashboard</button>
    </form>
</div>

</body>
</html>
