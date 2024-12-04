<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reserve Train</title>
    <style>
        body { font-family: Arial, sans-serif; }
        form { margin-top: 20px; }
        label { display: block; margin-top: 10px; }
        input, button { margin-top: 5px; padding: 8px; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>Reserve Train</h1>
    <%
        String trainNumber = request.getParameter("train_number");
        String trainName = request.getParameter("train_name");
        String departureTime = request.getParameter("departure_time");
        String arrivalTime = request.getParameter("arrival_time");
        String fare = request.getParameter("fare");

        if (trainNumber == null || trainName == null || departureTime == null || arrivalTime == null || fare == null) {
            out.println("<p class='error'>Error: Missing train details. Please go back and select a train.</p>");
        } else {
    %>
        <p><strong>Train Number:</strong> <%= trainNumber %></p>
        <p><strong>Train Name:</strong> <%= trainName %></p>
        <p><strong>Departure Time:</strong> <%= departureTime %></p>
        <p><strong>Arrival Time:</strong> <%= arrivalTime %></p>
        <p><strong>Fare:</strong> $<%= fare %></p>

        <form method="post">
            <label for="name">Your Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Your Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="seats">Number of Seats:</label>
            <input type="number" id="seats" name="seats" min="1" required>

            <button type="submit">Reserve</button>
        </form>
    <%
        }

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String seats = request.getParameter("seats");

            if (name != null && email != null && seats != null) {
                ApplicationDB db = new ApplicationDB();
                Connection conn = null;
                PreparedStatement stmt = null;

                try {
                    conn = db.getConnection();

                    String query = "INSERT INTO reservations (train_number, train_name, departure_time, arrival_time, fare, name, email, seats) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1, trainNumber);
                    stmt.setString(2, trainName);
                    stmt.setString(3, departureTime);
                    stmt.setString(4, arrivalTime);
                    stmt.setDouble(5, Double.parseDouble(fare));
                    stmt.setString(6, name);
                    stmt.setString(7, email);
                    stmt.setInt(8, Integer.parseInt(seats));

                    int rows = stmt.executeUpdate();
                    if (rows > 0) {
                        out.println("<p class='success'>Reservation successful! You will receive an email confirmation shortly.</p>");
                    } else {
                        out.println("<p class='error'>Error: Could not complete the reservation. Please try again later.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p class='error'>Database error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p class='error'>Error: All fields are required.</p>");
            }
        }
    %>
</body>
</html>
