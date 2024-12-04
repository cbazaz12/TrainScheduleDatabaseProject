<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Train Schedule Browser</title>
    <style>
        body { font-family: Arial, sans-serif; }
        header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .search-form { margin-bottom: 20px; }
        .logout-button {
            padding: 10px 20px;
            background-color: #ff4c4c;
            color: black;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <header>
        <h1>Train Schedule Browser</h1>
        <form action="logout.jsp" method="post" style="margin: 0;">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </header>

    <form method="get" class="search-form">
        <label for="origin">Origin:</label>
        <input type="text" name="origin" id="origin" required>
        <label for="destination">Destination:</label>
        <input type="text" name="destination" id="destination" required>
        <label for="date">Date of Travel:</label>
        <input type="date" name="date" id="date" required>
        <label for="sort">Sort by:</label>
        <select name="sort" id="sort">
            <option value="departure_time">Departure Time</option>
            <option value="arrival_time">Arrival Time</option>
            <option value="fare">Fare</option>
        </select>
        <button type="submit">Search</button>
    </form>

    <%
        // Use ApplicationDB to get a database connection
        ApplicationDB db = new ApplicationDB();
        Connection conn = null;

        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String date = request.getParameter("date");
        String sort = request.getParameter("sort");

        if (origin != null && destination != null && date != null) {
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                conn = db.getConnection();

                // Build SQL query dynamically with sorting
                String query = "SELECT * FROM train_schedule WHERE origin = ? AND destination = ? AND date = ? ORDER BY " + sort;
                stmt = conn.prepareStatement(query);
                stmt.setString(1, origin);
                stmt.setString(2, destination);
                stmt.setString(3, date);

                rs = stmt.executeQuery();

                %>
                <table>
                    <tr>
                        <th>Train Number</th>
                        <th>Train Name</th>
                        <th>Departure Time</th>
                        <th>Arrival Time</th>
                        <th>Fare</th>
                        <th>Stops</th>
                        <th>Action</th>
                    </tr>
                <%
                while (rs.next()) {
                    String trainNumber = rs.getString("train_number");
                    String trainName = rs.getString("train_name");
                    String departureTime = rs.getString("departure_time");
                    String arrivalTime = rs.getString("arrival_time");
                    double fare = rs.getDouble("fare");
                    String stops = rs.getString("stops");
                    %>
                    <tr>
                        <td><%= trainNumber %></td>
                        <td><%= trainName %></td>
                        <td><%= departureTime %></td>
                        <td><%= arrivalTime %></td>
                        <td><%= fare %></td>
                        <td><%= stops %></td>
                        <td>
                            <form action="reserve.jsp" method="get" style="margin: 0;">
                                <input type="hidden" name="train_number" value="<%= trainNumber %>">
                                <input type="hidden" name="train_name" value="<%= trainName %>">
                                <input type="hidden" name="departure_time" value="<%= departureTime %>">
                                <input type="hidden" name="arrival_time" value="<%= arrivalTime %>">
                                <input type="hidden" name="fare" value="<%= fare %>">
                                <button type="submit">Reserve</button>
                            </form>
                        </td>
                    </tr>
                    <%
                }
                %>
                </table>
                <%
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p style='color: red;'>Error fetching train schedules. Please try again later.</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
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
