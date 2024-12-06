<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue by Transit Line</title>
</head>
<body>
    <h1>Revenue by Transit Line</h1>
    <table border="1">
        <tr>
            <th>Transit Line</th>
            <th>Total Revenue ($)</th>
        </tr>
        <%
            ApplicationDB db = new ApplicationDB();
            Connection conn = db.getConnection();
            try {
                // Query to sum the total revenue per transit line
                String query = "SELECT s.transit_line, COALESCE(SUM(r.total_fare), 0) AS total_revenue " +
                               "FROM schedule s " +
                               "LEFT JOIN reservationreserveshas r ON s.tid = r.tid AND s.origin_datetime = r.origin_datetime " +
                               "GROUP BY s.transit_line";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                // Iterate through the result set and display the revenue per transit line
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("transit_line") %></td>
            <td><%= rs.getDouble("total_revenue") %></td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                db.closeConnection(conn);
            }
        %>
    </table>
    <a href="adminPage.jsp">Back to Admin Dashboard</a>
</body>
</html>
