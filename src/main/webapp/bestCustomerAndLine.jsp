<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.util.ArrayList" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Best Customer and Transit Lines</title>
</head>
<body>

<h1>Best Customer and Best 5 Transit Lines</h1>

<% 
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String bestCustomer = "";
    double highestRevenue = 0.0;
    List<String> topTransitLines = new ArrayList<>();

    try {
        ApplicationDB db = new ApplicationDB();
        conn = db.getConnection();
        stmt = conn.createStatement();

        // Query for the best customer
        String customerQuery = "SELECT username, SUM(total_fare) AS total_revenue FROM reservationreserveshas GROUP BY username ORDER BY total_revenue DESC LIMIT 1";
        rs = stmt.executeQuery(customerQuery);

        if (rs.next()) {
            bestCustomer = rs.getString("username");
            highestRevenue = rs.getDouble("total_revenue");
        }

        // Query for the top 5 transit lines
        String linesQuery = "SELECT s.transit_line, COUNT(r.reservation_number) AS reservation_count FROM schedule s LEFT JOIN reservationreserveshas r ON s.tid = r.tid AND s.origin_datetime = r.origin_datetime GROUP BY s.transit_line ORDER BY reservation_count DESC";
        rs = stmt.executeQuery(linesQuery);

        while (rs.next()) {
            topTransitLines.add(rs.getString("transit_line") + " (" + rs.getInt("reservation_count") + " reservations)");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the result set, statement, and connection
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<h2>Customer with Highest Revenue</h2>
<p><strong>Customer:</strong> <%= bestCustomer %></p>
<p><strong>Total Revenue:</strong> $<%= highestRevenue %></p>

<h2>Top 5 Transit Lines</h2>
<% if (topTransitLines.size() > 0) { %>
    <ul>
    <% for (String line : topTransitLines) { %>
        <li><%= line %></li>
    <% } %>
    </ul>
<% } else { %>
    <p>No transit lines found.</p>
<% } %>

<form action="adminPage.jsp" method="post">
    <button type="submit">Back to Admin Dashboard</button>
</form>

</body>
</html>
