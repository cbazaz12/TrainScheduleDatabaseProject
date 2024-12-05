<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Account Result</title>
</head>
<body>

<%
    String newUsername = request.getParameter("newUsername");
    String newPassword = request.getParameter("newPassword");
    boolean userExists = false;

    ApplicationDB db = new ApplicationDB();
    Connection connection = db.getConnection();

    try {
        // Prepare a SQL statement to check if the username already exists
        String checkQuery = "SELECT * FROM user WHERE username = ?";
        PreparedStatement checkStatement = connection.prepareStatement(checkQuery);
        checkStatement.setString(1, newUsername);

        ResultSet resultSet = checkStatement.executeQuery();

        if (resultSet.next()) {
            userExists = true;
        }

        resultSet.close();
        checkStatement.close();

        // If the user doesn't exist, insert the new user
        if (!userExists) {
            String insertQuery = "INSERT INTO user (username, password) VALUES (?, ?)";
            PreparedStatement insertStatement = connection.prepareStatement(insertQuery);
            insertStatement.setString(1, newUsername);
            insertStatement.setString(2, newPassword);

            int rowsAffected = insertStatement.executeUpdate();
            insertStatement.close();

            if (rowsAffected > 0) {
                out.println("<h3>Account created successfully!</h3>");
                out.println("<a href='login.jsp'>Go to Login</a>");
            } else {
                out.println("<h3>Error creating account. Please try again.</h3>");
            }
        } else {
            out.println("<h3>Username already exists. Please choose a different username.</h3>");
            out.println("<a href='createAccount.jsp'>Return to Create Account</a>");
        }

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        db.closeConnection(connection);
    }
%>

</body>
</html>
