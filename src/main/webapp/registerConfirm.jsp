
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Confirm Registration</title>
</head>
<body>

<h1>Confirm Your Details</h1>

<%
    Customer temp = (Customer) session.getAttribute("tempUser");
    if(temp == null) {
%>
<p>No data found. Please go back to <a href="registerForm.jsp">register form</a>.</p>
<%
    } else {
%>

<p>Name: <%= temp.getName() %></p>
<p>Furikana: <%= temp.getNameKana() %></p>
<p>Email: <%= temp.getEmail() %></p>
<p>Phone: <%= temp.getPhone() %></p>
<p>Password: <%= temp.getPassword().replaceAll(".", "*") %></p>

<form action="Registerinsertionservlet" method="post">
    <input type="submit" value="Confirm & Register">
</form>

<form action="registerForm.jsp" method="get">
    <input type="submit" value="Back to Edit">
</form>

<%
    }
%>

</body>
</html>