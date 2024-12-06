<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Representative - Process</title>
</head>
<body>
<h1>Adding Customer Representative...</h1>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String firstname = request.getParameter("firstname");
    String lastname = request.getParameter("lastname");
    String ssn = request.getParameter("ssn");
    String role = request.getParameter("role"); // This will be 'rep' as per the form

    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    String message = "";

    try {
        // Check if the username already exists in the employee table
        String checkQuery = "SELECT * FROM employee WHERE username = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
        checkStmt.setString(1, username);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            message = "Username already exists. Please choose a different one.";
        } else {
            // Insert the new representative data into the employee table
            String insertQuery = "INSERT INTO employee (username, password, firstname, lastname, ssn, role) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, username);
            insertStmt.setString(2, password);
            insertStmt.setString(3, firstname);
            insertStmt.setString(4, lastname);
            insertStmt.setString(5, ssn);
            insertStmt.setString(6, role);

            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
                message = "Representative " + username + " added successfully!";
            } else {
                message = "Failed to add representative. Please try again.";
            }

            insertStmt.close();
        }

        checkStmt.close();
        rs.close();
    } catch (SQLException e) {
        e.printStackTrace();
        message = "Error occurred while adding representative.";
    } finally {
        db.closeConnection(conn);
    }
%>

<!-- Display message -->
<p><%= message %></p>

<a href="manageCustomerReps.jsp">Back to Manage Customer Representatives</a>

</body>
</html>
