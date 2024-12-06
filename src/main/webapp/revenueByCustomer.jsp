<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue by Customer</title>
</head>
<body>
    <h1>Revenue by Customer</h1>
    <table border="1">
        <tr>
            <th>Customer Username</th>
            <th>Total Revenue ($)</th>
        </tr>
        <%
            ApplicationDB db = new ApplicationDB();
            Connection conn = db.getConnection();
            try {
                // Modified query with LEFT JOIN to include all users
                String query = "SELECT u.username, COALESCE(SUM(r.total_fare), 0) AS total_revenue " +
                               "FROM user u " +
                               "LEFT JOIN reservationreserveshas r ON u.username = r.username " +
                               "GROUP BY u.username";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                // Iterate through the result set and display customer revenue
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("username") %></td>
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
