<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Customer Representative</title>
</head>
<body>
<h1>Edit Customer Representative</h1>

<%
    String username = request.getParameter("username");
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    String firstname = "", lastname = "", role = "";

    try {
        String query = "SELECT * FROM employee WHERE username = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            firstname = rs.getString("firstname");
            lastname = rs.getString("lastname");
            role = rs.getString("role");
        }

        rs.close();
        pstmt.close();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        db.closeConnection(conn);
    }
%>

<form action="updateRep.jsp" method="post">
    <input type="hidden" name="username" value="<%= username %>">
    <label for="firstname">First Name:</label>
    <input type="text" id="firstname" name="firstname" value="<%= firstname %>"><br><br>
    
    <label for="lastname">Last Name:</label>
    <input type="text" id="lastname" name="lastname" value="<%= lastname %>"><br><br>
    
    <label for="role">Role:</label>
    <input type="text" id="role" name="role" value="<%= role %>"><br><br>
    
    <button type="submit">Update</button>
</form>

<a href="manageCustomerReps.jsp">Cancel</a>
</body>
</html>
