<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reservations</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1, h2 { text-align: center; }
        .container { max-width: 800px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .form-container { margin: 20px 0; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }
        .form-container input, .form-container select, .form-container button { display: block; width: 100%; margin: 10px 0; padding: 10px; }
        .btn { display: inline-block; padding: 10px 20px; background-color: #4CAF50; color: white; text-decoration: none; border: none; border-radius: 5px; text-align: center; cursor: pointer; }
        .btn.cancel { background-color: #ff4c4c; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Reservations</h1>

        <!-- Form to make a reservation -->
        <div class="form-container">
            <h2>Make a Reservation</h2>
            <form action="make_reservation.jsp" method="post">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" required>

                <label for="route">Route:</label>
                <select name="route" id="route" required>
                    <% 
                        ApplicationDB db = new ApplicationDB();
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        try {
                            conn = db.getConnection();
                            String query = "SELECT tid, origin_station, dest_station, origin_datetime FROM schedule";
                            stmt = conn.prepareStatement(query);
                            rs = stmt.executeQuery();

                            while (rs.next()) {
                                String tid = rs.getString("tid");
                                String origin = rs.getString("origin_station");
                                String dest = rs.getString("dest_station");
                                String time = rs.getString("origin_datetime");
                    %>
                    <option value="<%= tid %>,<%= time %>"><%= origin %> to <%= dest %> (Departure: <%= time %>)</option>
                    <% 
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); if (stmt != null) stmt.close(); db.closeConnection(conn); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>

                <label for="discount">Discount:</label>
                <select name="discount" id="discount">
                    <option value="0">None</option>
                    <option value="0.10">Child (10%)</option>
                    <option value="0.15">Senior (15%)</option>
                    <option value="0.20">Disabled (20%)</option>
                </select>

                <button type="submit" class="btn">Make Reservation</button>
            </form>
        </div>

        <!-- Current Reservations -->
        <h2>Current Reservations</h2>
        <table>
            <tr>
                <th>Reservation Number</th>
                <th>Route</th>
                <th>Departure Time</th>
                <th>Total Fare</th>
                <th>Actions</th>
            </tr>
            <%
                try {
                    conn = db.getConnection();
                    String query = "SELECT r.reservation_number, r.total_fare, s.origin_station, s.dest_station, r.origin_datetime FROM reservationreserveshas r JOIN schedule s ON r.tid = s.tid WHERE r.username = ? AND r.date >= CURDATE()";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, "user1"); // Replace with session-based username
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int resNum = rs.getInt("reservation_number");
                        String origin = rs.getString("origin_station");
                        String dest = rs.getString("dest_station");
                        String departure = rs.getString("origin_datetime");
                        float fare = rs.getFloat("total_fare");
            %>
            <tr>
                <td><%= resNum %></td>
                <td><%= origin %> to <%= dest %></td>
                <td><%= departure %></td>
                <td>$<%= fare %></td>
                <td>
                    <form action="cancel_reservation.jsp" method="post" style="margin: 0;">
                        <input type="hidden" name="reservation_number" value="<%= resNum %>">
                        <button type="submit" class="btn cancel">Cancel</button>
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
                <th>Route</th>
                <th>Departure Time</th>
                <th>Total Fare</th>
            </tr>
            <%
                try {
                    conn = db.getConnection();
                    String query = "SELECT r.reservation_number, r.total_fare, s.origin_station, s.dest_station, r.origin_datetime FROM reservationreserveshas r JOIN schedule s ON r.tid = s.tid WHERE r.username = ? AND r.date < CURDATE()";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, "user1"); // Replace with session-based username
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int resNum = rs.getInt("reservation_number");
                        String origin = rs.getString("origin_station");
                        String dest = rs.getString("dest_station");
                        String departure = rs.getString("origin_datetime");
                        float fare = rs.getFloat("total_fare");
            %>
            <tr>
                <td><%= resNum %></td>
                <td><%= origin %> to <%= dest %></td>
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
    </div>
</body>
</html>
