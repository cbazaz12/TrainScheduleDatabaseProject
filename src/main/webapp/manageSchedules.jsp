<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Train Schedules</title>
</head>
<body>

<h1>Manage Train Schedules</h1>

<!-- Back button to return to repPage.jsp -->
<form action="repPage.jsp" method="get">
    <button type="submit">Back to Dashboard</button>
</form>

<table border="1">
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
        <th>Actions</th>
    </tr>
    <%
        Connection connection = null;
        ResultSet rs = null;
        PreparedStatement deleteStmt = null;
        PreparedStatement updateStmt = null;

        try {
            // Get connection from ApplicationDB
            ApplicationDB db = new ApplicationDB();
            connection = db.getConnection();

            // Handle POST actions (edit/delete)
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String action = request.getParameter("action");

                if ("delete".equals(action)) {
                    int tid = Integer.parseInt(request.getParameter("tid"));
                    String originDatetime = request.getParameter("origin_datetime");

                    String deleteQuery = "DELETE FROM schedule WHERE tid = ? AND origin_datetime = ?";
                    deleteStmt = connection.prepareStatement(deleteQuery);
                    deleteStmt.setInt(1, tid);
                    deleteStmt.setString(2, originDatetime);
                    deleteStmt.executeUpdate();
                } else if ("edit".equals(action)) {
                    int tid = Integer.parseInt(request.getParameter("tid"));
                    String originDatetime = request.getParameter("origin_datetime");
                    float fare = Float.parseFloat(request.getParameter("fare"));
                    String travelTime = request.getParameter("travel_time");
                    String transitLine = request.getParameter("transit_line");
                    String destDatetime = request.getParameter("dest_datetime");
                    String originStation = request.getParameter("origin_station");
                    String destStation = request.getParameter("dest_station");
                    String type = request.getParameter("type");

                    String updateQuery = "UPDATE schedule SET fare = ?, travel_time = ?, transit_line = ?, dest_datetime = ?, origin_station = ?, dest_station = ?, type = ? WHERE tid = ? AND origin_datetime = ?";
                    updateStmt = connection.prepareStatement(updateQuery);
                    updateStmt.setFloat(1, fare);
                    updateStmt.setString(2, travelTime);
                    updateStmt.setString(3, transitLine);
                    updateStmt.setString(4, destDatetime);
                    updateStmt.setString(5, originStation);
                    updateStmt.setString(6, destStation);
                    updateStmt.setString(7, type);
                    updateStmt.setInt(8, tid);
                    updateStmt.setString(9, originDatetime);
                    updateStmt.executeUpdate();
                }
            }

            // Query to fetch all train schedules
            String query = "SELECT * FROM schedule";
            Statement stmt = connection.createStatement();
            rs = stmt.executeQuery(query);

            while (rs.next()) {
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
        <form method="post">
            <input type="hidden" name="tid" value="<%= tid %>">
            <input type="hidden" name="origin_datetime" value="<%= originDatetime %>">
            <td><%= tid %></td>
            <td><%= originDatetime %></td>
            <td><input type="text" name="fare" value="<%= fare %>"></td>
            <td><input type="text" name="travel_time" value="<%= travelTime %>"></td>
            <td><input type="text" name="transit_line" value="<%= transitLine %>"></td>
            <td><input type="text" name="dest_datetime" value="<%= destDatetime %>"></td>
            <td><input type="text" name="origin_station" value="<%= originStation %>"></td>
            <td><input type="text" name="dest_station" value="<%= destStation %>"></td>
            <td><input type="text" name="type" value="<%= type %>"></td>
            <td>
                <button type="submit" name="action" value="edit">Save</button>
                <button type="submit" name="action" value="delete">Delete</button>
            </td>
        </form>
    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Clean up resources
            try {
                if (rs != null) rs.close();
                if (deleteStmt != null) deleteStmt.close();
                if (updateStmt != null) updateStmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</table>

</body>
</html>
