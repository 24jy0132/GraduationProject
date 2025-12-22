<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
</head>
<body>
	<h1>Login Page</h1>
	<h2>Login here !</h2>

<!--ログインに失敗した際、エラーメッセージを表示-->
	<p style="color: red;">${error}</p>

<!--	メールアドレスとパスワードでログイン-->
	<form action="Userloginservlet" method="post">
		Mail : <input type="mail" name="usermail"> <br> Password
		:<input type="password" name="userpassword"> <br> <input
			type="submit" value="login">

	</form>
	<a href="passwordResetForm.jsp">Forgot Password?</a>
	<br>
	<a href="registerForm.jsp">Create Account?</a>
</body>
</html>