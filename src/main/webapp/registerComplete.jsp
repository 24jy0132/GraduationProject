<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Complete</title>
</head>
<body>

<%
    String message = (String) session.getAttribute("message");
%>

<% if(message != null) { %>
<h2 style="color:green;"><%= message %></h2>
<% session.removeAttribute("message"); %>
<% } else { %>
<h2>No registration information found.</h2>
<% } %>

<p><a href="login.jsp">Go to Login</a></p>

</body>
</html>