<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Train Schedules</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        .button { padding: 10px 15px; background-color: #4CAF50; color: white; text-decoration: none; border: none; cursor: pointer; }
    </style>
</head>
<body>

<h1>Search Train Schedules by Station</h1>

<!-- Search form -->
<form method="get" action="searchTrainSchedules.jsp">
    <label for="station">Enter Station Name:</label>
    <input type="text" name="station" id="station" required>
    <button type="submit" class="button">Search</button>
</form>

<% 
    String station = request.getParameter("station");
    if (station != null && !station.trim().isEmpty()) {
        Connection connection = null;
        ResultSet rs = null;

        try {
        	ApplicationDB db = new ApplicationDB();
            connection = db.getConnection();

            // SQL query to get schedules where the station is either origin or destination
            String query = "SELECT s.tid, s.origin_datetime, s.fare, s.travel_time, s.transit_line, " +
                           "s.dest_datetime, s.origin_station, s.dest_station, s.type " +
                           "FROM schedule s " +
                           "WHERE s.origin_station LIKE ? OR s.dest_station LIKE ?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, "%" + station + "%");
            pstmt.setString(2, "%" + station + "%");

            rs = pstmt.executeQuery();

            if (rs.next()) {
%>

<h2>Train Schedules for <%= station %></h2>
<table>
    <tr>
        <th>Train ID</th>
        <th>Origin DateTime</th>
        <th>Fare</th>
        <th>Travel Time</th>
        <th>Transit Line</th>
        <th>Destination DateTime</th>
        <th>Origin Station</th>
        <th>Destination Station</th>
        <th>Type</th>
    </tr>

<% 
                // Displaying the schedules
                do {
                    int tid = rs.getInt("tid");
                    String originDatetime = rs.getString("origin_datetime");
                    float fare = rs.getFloat("fare");
                    String travelTime = rs.getString("travel_time");
                    String transitLine = rs.getString("transit_line");
                    String destDatetime = rs.getString("dest_datetime");
                    String originStation = rs.getString("origin_station");
                    String destStation = rs.getString("dest_station");
                    String type = rs.getString("type");
%>
    <tr>
        <td><%= tid %></td>
        <td><%= originDatetime %></td>
        <td><%= fare %></td>
        <td><%= travelTime %></td>
        <td><%= transitLine %></td>
        <td><%= destDatetime %></td>
        <td><%= originStation %></td>
        <td><%= destStation %></td>
        <td><%= type %></td>
    </tr>
<%
                } while (rs.next());
            } else {
%>
    <p>No train schedules found for the station <%= station %>.</p>
<% 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (connection != null) connection.close(); // No need to close stmt as we use pstmt
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!-- Back to Dashboard Button -->
<form action="repPage.jsp" method="get">
    <button type="submit" class="button">Back to Dashboard</button>
</form>

</body>
</html>
