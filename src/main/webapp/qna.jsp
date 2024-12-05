<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Q&A</title>
    <style>
        body { font-family: Arial, sans-serif; }
        header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .logout-button {
            background-color: #ff4c4c;
        }
        .form-container {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .form-container input, .form-container textarea, .form-container button {
            display: block;
            width: 100%;
            margin: 10px 0;
            padding: 10px;
        }
    </style>
</head>
<body>
    <header>
        <h1>Q&A</h1>
        <a href="browsing.jsp" class="button">Back to Train Schedule</a>
    </header>

    <%
        ApplicationDB db = new ApplicationDB();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            // Query to fetch Q&A data
            String query = "SELECT username, question, answer FROM qna";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();
    %>

    <table>
        <tr>
            <th>Username</th>
            <th>Question</th>
            <th>Answer</th>
        </tr>
        <%
            while (rs.next()) {
                String username = rs.getString("username");
                String question = rs.getString("question");
                String answer = rs.getString("answer");
        %>
        <tr>
            <td><%= username %></td>
            <td><%= question %></td>
            <td><%= answer != null ? answer : "No answer yet" %></td>
        </tr>
        <%
            }
        %>
    </table>
    <%
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p style='color: red;'>Error loading Q&A data. Please try again later.</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                db.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>

    <!-- Form to submit a new question -->
    <div class="form-container">
        <form action="submit_question.jsp" method="post">
            <h2>Ask a Question</h2>
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required>
            <label for="question">Question:</label>
            <textarea name="question" id="question" rows="5" required></textarea>
            <button type="submit" class="button">Submit Question</button>
        </form>
    </div>
</body>
</html>
