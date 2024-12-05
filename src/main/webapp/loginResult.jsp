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
    boolean isAdmin = false;
    boolean isRep = false;

    ApplicationDB db = new ApplicationDB();
    Connection connection = db.getConnection();

    try {
        // First, check if the user is an admin or rep
        String empQuery = "SELECT role FROM employee WHERE username = ? AND password = ?";
        PreparedStatement empStatement = connection.prepareStatement(empQuery);
        empStatement.setString(1, username);
        empStatement.setString(2, password);

        ResultSet empResultSet = empStatement.executeQuery();

        if (empResultSet.next()) {
            userExists = true;
            String role = empResultSet.getString("role");

            if ("admin".equalsIgnoreCase(role)) {
                isAdmin = true;
            } else if ("rep".equalsIgnoreCase(role)) {
                isRep = true;
            }
        }

        empResultSet.close();
        empStatement.close();

        // If not an admin or rep, check the `user` table
        if (!userExists) {
            String userQuery = "SELECT * FROM user WHERE username = ? AND password = ?";
            PreparedStatement userStatement = connection.prepareStatement(userQuery);
            userStatement.setString(1, username);
            userStatement.setString(2, password);

            ResultSet userResultSet = userStatement.executeQuery();

            if (userResultSet.next()) {
                userExists = true;
                // Regular user detected
                session.setAttribute("username", username);
                response.sendRedirect("browsing.jsp");
                return;
            }

            userResultSet.close();
            userStatement.close();
        }

        // Redirect based on role
        if (isAdmin) {
            session.setAttribute("username", username);
            session.setAttribute("role", "admin");
            response.sendRedirect("adminPage.jsp");
            return;
        } else if (isRep) {
            session.setAttribute("username", username);
            session.setAttribute("role", "rep");
            response.sendRedirect("repPage.jsp");
            return;
        }
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
