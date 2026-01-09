<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>ユーザ確認画面</title>
</head>
<body>

	<div class="container-fluid">
		<!-- Navbar -->
		<nav class="navbar navbar-expand-lg bg-danger py-3">
			<div class="container">
				<!-- Brand -->
				<a class="navbar-brand fw-bold text-white" href="index.jsp"> <img
					src="img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png" height="40"
					width="40" alt="Logo" class="me-2"> Welcome From Mesa
				</a>
			</div>
		</nav>


		<!-- form -->
		<form action="passwordResetMailservlet" method="post">
		Mail : <input type="mail" name="usermail"> <br>
		Tel:<input type="tel" name="phone"> <br> <input
			type="submit" value="再設定用メールを送信">
		
		<%@ include file="footer.jsp"%>
	</div>

</body>

</html>