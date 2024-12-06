<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Representative</title>
</head>
<body>
<h1>Updating Representative...</h1>

<%
    String username = request.getParameter("username");
    String firstname = request.getParameter("firstname");
    String lastname = request.getParameter("lastname");
    String role = request.getParameter("role");

    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();

    try {
        String query = "UPDATE employee SET firstname = ?, lastname = ?, role = ? WHERE username = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, firstname);
        pstmt.setString(2, lastname);
        pstmt.setString(3, role);
        pstmt.setString(4, username);

        int rowsUpdated = pstmt.executeUpdate();

        if (rowsUpdated > 0) {
%>
    <p>Representative <strong><%= username %></strong> has been updated successfully.</p>
<%
        } else {
%>
    <p>Failed to update representative <strong><%= username %></strong>. Please try again.</p>
<%
        }

        pstmt.close();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        db.closeConnection(conn);
    }
%>

<a href="manageCustomerReps.jsp">Back to Manage Customer Representatives</a>
</body>
</html>
