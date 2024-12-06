<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Customer Representatives</title>
</head>
<body>
<h1>Manage Customer Representatives</h1>

<table border="1">
    <tr>
        <th>Username</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>

    <%
        ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();
        try {
            String query = "SELECT * FROM employee WHERE role = 'rep'";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("firstname") %></td>
        <td><%= rs.getString("lastname") %></td>
        <td><%= rs.getString("role") %></td>
        <td>
            <a href="editRep.jsp?username=<%= rs.getString("username") %>">Edit</a> |
            <a href="deleteRep.jsp?username=<%= rs.getString("username") %>">Delete</a>
        </td>
    </tr>
    <%
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(conn);
        }
    %>
</table>

<a href="addRep.jsp">Add New Representative</a>

<!-- Button to go back to the admin page -->
<form action="adminPage.jsp" method="get">
    <button type="submit">Back to Admin Page</button>
</form>

</body>
</html>
