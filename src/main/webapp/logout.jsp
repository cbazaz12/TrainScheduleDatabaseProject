<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session to log the user out
    session.invalidate();
    // Redirect back to the login page
    response.sendRedirect("login.jsp");
%>
