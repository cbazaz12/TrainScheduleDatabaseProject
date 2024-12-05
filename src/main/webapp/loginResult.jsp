<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Result</title>
</head>
<body>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    boolean userExists = false;

    ApplicationDB db = new ApplicationDB();
    Connection connection = db.getConnection();

    try {
        // Prepare a SQL statement to check for user credentials
        String query = "SELECT * FROM user WHERE username = ? AND password = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, username);
        statement.setString(2, password);

        ResultSet resultSet = statement.executeQuery();

        // Check if a user with the given credentials exists
        if (resultSet.next()) {
            userExists = true;
            // Store the username in the session to mark the user as logged in
            session.setAttribute("username", username);

            // Redirect to the browsing page
            response.sendRedirect("browsing.jsp"); // Redirect to the browsing page
            return;  // Important: stop further processing after redirect
        }

        resultSet.close();
        statement.close();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        db.closeConnection(connection);
    }

    // If login fails, show an error message
    if (!userExists) {
%>
        <h3>User not found. Please check your username and password.</h3>
        <a href="login.jsp">Return to Login</a>
<%
    }
%>

</body>
</html>
