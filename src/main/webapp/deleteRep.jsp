<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Representative</title>
</head>
<body>

<%
    String username = request.getParameter("username"); // Get username from the query string
    boolean deleted = false;

    if (username != null && !username.isEmpty()) {
        ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();

        try {
            // SQL query to delete the representative
            String query = "DELETE FROM employee WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                deleted = true;
            }

            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(conn);
        }
    }

    if (deleted) {
        // Redirect back to the manage reps page after deletion
        response.sendRedirect("manageCustomerReps.jsp");
    } else {
        // If no representative was deleted, show an error message
        out.println("<h3>Error: Representative could not be deleted. Please try again.</h3>");
        out.println("<a href='manageCustomerReps.jsp'>Back to Manage Representatives</a>");
    }
%>

</body>
</html>
