<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Answer</title>
</head>
<body>
<%
    ApplicationDB db = new ApplicationDB();
    Connection conn = null;
    PreparedStatement stmt = null;

    String username = request.getParameter("username");
    String question = request.getParameter("question");
    String answer = request.getParameter("answer");

    try {
        conn = db.getConnection();
        // Update the answer in the database
        String updateQuery = "UPDATE qna SET answer = ? WHERE username = ? AND question = ?";
        stmt = conn.prepareStatement(updateQuery);
        stmt.setString(1, answer);
        stmt.setString(2, username);
        stmt.setString(3, question);

        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("<p style='color: green;'>Answer submitted successfully!</p>");
        } else {
            out.println("<p style='color: red;'>Failed to submit the answer. Please try again.</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p style='color: red;'>Error occurred while submitting the answer. Please try again later.</p>");
    } finally {
        try {
            if (stmt != null) stmt.close();
            db.closeConnection(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<a href="repAnswers.jsp" class="button">Back to Answer Questions</a>
</body>
</html>
