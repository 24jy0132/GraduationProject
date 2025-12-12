<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Customer"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Form</title>
</head>
<body>

	<h1>Register Form</h1>

	<%
	// Display errors if any
	List<String> errors = (List<String>) request.getAttribute("errors");
	if (errors != null && !errors.isEmpty()) {
	%>
	<div style="color: red;">
		<ul>
			<%
			for (String e : errors) {
			%>
			<li><%=e%></li>
			<%
			}
			%>
		</ul>
	</div>
	<%
	}
	%>

	<%
	// Pre-fill from request or session
	Customer temp = (Customer) session.getAttribute("tempUser");
	%>

	<form action="Registerconfirmationservlet" method="post">
		Name: <input type="text" name="username"
			value="<%=request.getAttribute("username") != null ? request.getAttribute("username")
		: (temp != null ? temp.getName() : "")%>"><br>
		Furikana: <input type="text" name="furikana"
			value="<%=request.getAttribute("furikana") != null ? request.getAttribute("furikana")
		: (temp != null ? temp.getNameKana() : "")%>"><br>
		Email: <input type="email" name="usermail"
			value="<%=request.getAttribute("usermail") != null ? request.getAttribute("usermail")
		: (temp != null ? temp.getEmail() : "")%>"><br>
		Phone: <input type="tel" name="usertel"
			value="<%=request.getAttribute("usertel") != null ? request.getAttribute("usertel")
		: (temp != null ? temp.getPhone() : "")%>"><br>
		Password: <input type="password" name="userpass"><br>
		Re-password: <input type="password" name="repassword"><br>
		<input type="submit" value="Next">
	</form>

</body>
</html>