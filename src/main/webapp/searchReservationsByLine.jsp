<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Reservations by Transit Line</title>
</head>
<body>

<h1>Search Reservations by Transit Line</h1>

<form action="searchReservationsByLine.jsp" method="get">
    <label for="transitLine">Enter Transit Line:</label>
    <input type="text" id="transitLine" name="transitLine" required>
    <button type="submit">Search</button>
</form>

<% 
    String transitLine = request.getParameter("transitLine");
    if (transitLine != null && !transitLine.isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            ApplicationDB db = new ApplicationDB();
            conn = db.getConnection();

            String query = "SELECT * FROM reservationreserveshas r " +
                           "JOIN schedule s ON r.tid = s.tid AND r.origin_datetime = s.origin_datetime " +
                           "WHERE s.transit_line = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, transitLine);
            rs = stmt.executeQuery();

            // Display the reservations for the specified transit line
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
                <p>No reservations found for transit line <%= transitLine %>.</p>
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

<form action="adminPage.jsp" method="post">
    <button type="submit">Back to Admin Dashboard</button>
</form>

</body>
</html>
