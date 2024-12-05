<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Question</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        .message { margin: 20px auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; width: 50%; }
        .success { color: green; }
        .error { color: red; }
        a { text-decoration: none; color: #4CAF50; }
    </style>
</head>
<body>
<%
    String username = request.getParameter("username");
    String question = request.getParameter("question");

    if (username != null && question != null) {
        ApplicationDB db = new ApplicationDB();
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = db.getConnection();
            String query = "INSERT INTO qna (username, question) VALUES (?, ?)";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, question);
            stmt.executeUpdate();
%>
    <div class="message success">
        <p>Question submitted successfully!</p>
        <p><a href="qna.jsp">Go back to QNA</a></p>
    </div>
<%
        } catch (SQLException e) {
            e.printStackTrace();
%>
    <div class="message error">
        <p>Error submitting the question. Please try again later.</p>
    </div>
<%
        } finally {
            try {
                if (stmt != null) stmt.close();
                db.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
%>
    <div class="message error">
        <p>Invalid input. Please provide both username and question.</p>
        <p><a href="qna.jsp">Go back to QNA</a></p>
    </div>
<%
    }
%>
</body>
</html>
