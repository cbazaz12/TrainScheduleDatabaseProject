<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Reservation</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-container { max-width: 500px; margin: 0 auto; }
        .form-container input, .form-container select, .form-container button { width: 100%; padding: 10px; margin: 10px 0; }
        h1, h2 { text-align: center; }
        .logout-button {
            padding: 10px 20px;
            background-color: #ff4c4c;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Confirm Your Reservation</h1>

    <div class="form-container">
        <form action="reserving.jsp" method="post">
            <input type="hidden" name="train_number" value="<%= request.getParameter("train_number") %>">
            <input type="hidden" name="departure_time" value="<%= request.getParameter("departure_time") %>">
            <input type="hidden" name="arrival_time" value="<%= request.getParameter("arrival_time") %>">
            <input type="hidden" name="fare" value="<%= request.getParameter("fare") %>">

            <label>Train Number: <%= request.getParameter("train_number") %></label><br>
            <label>Departure Time: <%= request.getParameter("departure_time") %></label><br>
            <label>Arrival Time: <%= request.getParameter("arrival_time") %></label><br>
            <label>Fare: $<%= request.getParameter("fare") %></label><br>

            <label for="reservation_date">Reservation Date:</label>
            <input type="date" name="reservation_date" id="reservation_date" required>

            <label for="discount">Discount:</label>
            <select name="discount" id="discount">
                <option value="0">None</option>
                <option value="10">Child (10% off)</option>
                <option value="15">Senior (15% off)</option>
                <option value="20">Disabled (20% off)</option>
            </select>

            <button type="submit">Confirm Reservation</button>
        </form>

        <form action="browsing.jsp" method="get">
            <button class="logout-button" type="submit">Go Back</button>
        </form>
    </div>

    <% 
        // Process form submission to save the reservation
        if (request.getMethod().equalsIgnoreCase("post")) {
            ApplicationDB db = new ApplicationDB();
            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                String trainNumber = request.getParameter("train_number");
                String departureTime = request.getParameter("departure_time");
                String reservationDate = request.getParameter("reservation_date");
                float fare = Float.parseFloat(request.getParameter("fare"));
                int discount = Integer.parseInt(request.getParameter("discount"));
                String username = "user1"; // Replace with session-based username

                // Apply discount
                float finalFare = fare - (fare * discount / 100);

                conn = db.getConnection();

                // Insert reservation into the database
                String query = "INSERT INTO reservationreserveshas (reservation_number, date, total_fare, username, tid, origin_datetime) " +
                               "VALUES (?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(query);

                // Generate a unique reservation number
				int reservationNumber = (int) (new java.util.Date().getTime() % 100000);

                stmt.setInt(1, reservationNumber);
                stmt.setString(2, reservationDate);
                stmt.setFloat(3, finalFare);
                stmt.setString(4, username);
                stmt.setInt(5, Integer.parseInt(trainNumber));
                stmt.setString(6, departureTime);

                stmt.executeUpdate();

                out.println("<p style='color: green; text-align: center;'>Reservation confirmed! Reservation Number: " + reservationNumber + "</p>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p style='color: red; text-align: center;'>Error processing reservation. Please try again.</p>");
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    db.closeConnection(conn);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
