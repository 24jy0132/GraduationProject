<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>パスワード再設定メール送信完了画面</title>
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


		<h1>パスワード再設定メール送信完了</h1>

    <p>
        <%= request.getAttribute("message") %>
    </p>

    <p class="note">
        ※メールが届かない場合は、迷惑メールフォルダをご確認ください。<br>
        しばらく待っても届かない場合は、再度お手続きを行ってください。
    </p>

    <a href="<%= request.getContextPath() %>/login.jsp" class="btn">
        ログイン画面へ戻る
    </a>
		<%@ include file="footer.jsp"%>
	</div>

</body>

</html>