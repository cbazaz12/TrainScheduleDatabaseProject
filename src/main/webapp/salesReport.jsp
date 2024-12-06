<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales Report by Month</title>
</head>
<body>
<h1>Total Revenue Per Month</h1>

<table border="1">
    <tr>
        <th>Month</th>
        <th>Total Revenue</th>
    </tr>

    <%
        // List of month names
        String[] monthNames = {
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        };

        ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();

        try {
            // Query to get total revenue per month, ensuring all months are included (even with 0 revenue)
            String query = "SELECT MONTH(date) AS month, SUM(total_fare) AS total_revenue " +
                           "FROM reservationreserveshas " +
                           "GROUP BY MONTH(date) " +
                           "ORDER BY MONTH(date)";

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            // Store the revenue by month in an array
            float[] monthlyRevenues = new float[12];
            while (rs.next()) {
                int month = rs.getInt("month");
                float totalRevenue = rs.getFloat("total_revenue");
                monthlyRevenues[month - 1] = totalRevenue;  // Store revenue for each month (0-indexed)
            }

            // Loop through all months (0 to 11) and display the corresponding revenue
            for (int i = 0; i < 12; i++) {
    %>
    <tr>
        <td><%= monthNames[i] %></td>
        <td>$<%= monthlyRevenues[i] %></td>
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

<!-- Button to go back to the Admin Dashboard -->
<form action="adminPage.jsp" method="get">
    <button type="submit">Back to Admin Dashboard</button>
</form>

</body>
</html>
