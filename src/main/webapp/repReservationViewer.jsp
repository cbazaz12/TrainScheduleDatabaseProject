<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %> <!-- Import the ApplicationDB class -->
<!DOCTYPE html>
<html>
<head>
    <title>Customer Reservations Viewer</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .form-container { margin-top: 20px; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .form-container input, .form-container select, .form-container button {
            display: block; margin: 10px 0; padding: 10px; width: 100%;
        }
        .button { padding: 10px 15px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .button:hover { background-color: #45a049; }
    </style>
</head>
<body>

<h1>Customer Reservations Viewer</h1>
<div class="form-container">
    <form method="get">
        <label for="transitLine">Transit Line:</label>
        <input type="text" name="transitLine" id="transitLine" required>
        
        <label for="date">Date:</label>
        <input type="date" name="date" id="date" required>
        
        <button type="submit" class="button">View Reservations</button>
    </form>
</div>

<%
    String transitLine = request.getParameter("transitLine");
    String date = request.getParameter("date");

    if (transitLine != null && date != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Create an instance of ApplicationDB and get a connection
            ApplicationDB applicationDB = new ApplicationDB(); // Fix: instantiate ApplicationDB correctly
            conn = applicationDB.getConnection(); // Get connection from ApplicationDB
            
            String query = "SELECT r.username, r.reservation_number, s.transit_line, s.origin_station, s.dest_station, r.date, r.total_fare " +
                           "FROM reservationreserveshas r " +
                           "JOIN schedule s ON r.tid = s.tid AND r.origin_datetime = s.origin_datetime " +
                           "WHERE s.transit_line = ? AND r.date = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, transitLine);
            stmt.setString(2, date);
            rs = stmt.executeQuery();
%>

<table>
    <tr>
        <th>Username</th>
        <th>Reservation Number</th>
        <th>Transit Line</th>
        <th>Origin Station</th>
        <th>Destination Station</th>
        <th>Date</th>
        <th>Total Fare</th>
    </tr>
<%
            while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getInt("reservation_number") %></td>
        <td><%= rs.getString("transit_line") %></td>
        <td><%= rs.getString("origin_station") %></td>
        <td><%= rs.getString("dest_station") %></td>
        <td><%= rs.getDate("date") %></td>
        <td><%= rs.getFloat("total_fare") %></td>
    </tr>
<%
            }
%>
</table>

<%
        } catch (Exception e) {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            out.println("<pre style='color: red;'>" + sw.toString() + "</pre>");
            out.println("<p style='color: red;'>An error occurred while retrieving data. Please try again.</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                StringWriter sw = new StringWriter();
                PrintWriter pw = new PrintWriter(sw);
                e.printStackTrace(pw);
                out.println("<pre style='color: red;'>" + sw.toString() + "</pre>");
            }
        }
    }
%>

</body>
</html>
