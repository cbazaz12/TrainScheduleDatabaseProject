<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reservations History</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1, h2 { text-align: center; }
        .container { max-width: 800px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .cancel-button {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            text-align: center;
        }
        .back-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Reservations History</h1>

        <!-- Current Reservations -->
        <h2>Current Reservations</h2>
        <table>
            <tr>
                <th>Reservation Number</th>
                <th>Departure Time</th>
                <th>Total Fare</th>
                <th>Action</th> <!-- Added Action Column -->
            </tr>
            <%
                ApplicationDB db = new ApplicationDB();
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                String username = (String) session.getAttribute("username"); // Fetching username from session

                try {
                    conn = db.getConnection();
                    String query = "SELECT reservation_number, total_fare, origin_datetime " +
                                   "FROM reservationreserveshas " +
                                   "WHERE username = ? AND origin_datetime >= CURDATE() " + // Checking future reservations
                                   "ORDER BY origin_datetime";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, username); // Use the session username for the query
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int resNum = rs.getInt("reservation_number");
                        String departure = rs.getString("origin_datetime");
                        float fare = rs.getFloat("total_fare");
            %>
            <tr>
                <td><%= resNum %></td>
                <td><%= departure %></td>
                <td>$<%= fare %></td>
                <td>
                    <!-- Form for Cancelling Reservation -->
                    <form action="reservation.jsp" method="post" onsubmit="return confirm('Are you sure you want to cancel this reservation?');">
                        <input type="hidden" name="cancel_reservation_number" value="<%= resNum %>">
                        <button type="submit" class="cancel-button">Cancel</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); if (stmt != null) stmt.close(); db.closeConnection(conn); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </table>

        <!-- Past Reservations -->
        <h2>Past Reservations</h2>
        <table>
            <tr>
                <th>Reservation Number</th>
                <th>Departure Time</th>
                <th>Total Fare</th>
            </tr>
            <%
                try {
                    conn = db.getConnection();
                    String query = "SELECT reservation_number, total_fare, origin_datetime " +
                                   "FROM reservationreserveshas " +
                                   "WHERE username = ? AND origin_datetime < CURDATE() " + // Checking past reservations
                                   "ORDER BY origin_datetime DESC";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, username); // Use the session username for the query
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int resNum = rs.getInt("reservation_number");
                        String departure = rs.getString("origin_datetime");
                        float fare = rs.getFloat("total_fare");
            %>
            <tr>
                <td><%= resNum %></td>
                <td><%= departure %></td>
                <td>$<%= fare %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); if (stmt != null) stmt.close(); db.closeConnection(conn); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </table>

        <!-- Back Button -->
        <form action="browsing.jsp" method="get">
            <button class="back-button" type="submit">Back to Reserving</button>
        </form>

    </div>

    <% 
        // Handle reservation cancellation
        if (request.getMethod().equalsIgnoreCase("post")) {
            // Check if it's a cancellation request
            String cancelReservationNumber = request.getParameter("cancel_reservation_number");
            if (cancelReservationNumber != null) {
                int reservationNumber = Integer.parseInt(cancelReservationNumber);

                ApplicationDB dbCancel = new ApplicationDB();
                Connection connCancel = null;
                PreparedStatement stmtCancel = null;

                try {
                    connCancel = dbCancel.getConnection();
                    String cancelQuery = "DELETE FROM reservationreserveshas WHERE reservation_number = ? AND username = ?";
                    stmtCancel = connCancel.prepareStatement(cancelQuery);
                    stmtCancel.setInt(1, reservationNumber);
                    stmtCancel.setString(2, username); // Use session username for the cancellation
                    int rowsAffected = stmtCancel.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p style='color: green; text-align: center;'>Reservation " + reservationNumber + " has been successfully cancelled.</p>");
                    } else {
                        out.println("<p style='color: red; text-align: center;'>Error: Could not cancel the reservation. Please try again.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p style='color: red; text-align: center;'>Error: Could not cancel the reservation. Please try again.</p>");
                } finally {
                    try { if (stmtCancel != null) stmtCancel.close(); dbCancel.closeConnection(connCancel); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        }
    %>
</body>
</html>
