<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Customer"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会員登録</title>

<style>
/* ===== PAGE LAYOUT ===== */
html, body {
	height: 100%;
}

body {
	margin: 0;
	display: flex;
	flex-direction: column;
}

/* ===== MAIN CENTER ===== */
main {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 40px 15px;
}

/* ===== GLASS CARD ===== */
.glass-card {
	width: 100%;
	max-width: 520px;
	padding: 35px;
	border-radius: 16px;
	backdrop-filter: blur(12px);
	-webkit-backdrop-filter: blur(12px);
	border: 1px solid rgba(255, 255, 255, 0.3);
	box-shadow: 0 20px 40px rgba(0, 0, 0, .15);
}

/* ===== FORM ===== */
.form-control {
	border-radius: 10px;
}

.register-btn {
	padding: 12px;
	font-size: 1.1rem;
}

/* ===== LINKS ===== */
.link {
	text-decoration: none;
	font-size: 0.9rem;
	color: black;
}

.link:hover {
	text-decoration: underline;
}
</style>
</head>

<body>

	<!-- ===== NAVBAR ===== -->
	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<a class="navbar-brand fw-bold text-white"
				href="<%=request.getContextPath()%>/index.jsp"> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" class="me-2"> Welcome From Mesa
			</a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse justify-content-end"
				id="navbarSupportedContent">
				<ul class="navbar-nav gap-4">
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/index.jsp"> <i
							class="bi bi-house-fill me-1"></i>Home
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="MenuListServlet"> <i class="bi bi-menu-down me-1"></i>Menu
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/reserve/form"> <i
							class="bi bi-calendar-check me-1"></i>Reservation
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/contact.jsp"> <i
							class="bi bi-telephone-fill me-1"></i>Contact
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/map.jsp"> <i
							class="bi bi-pin-map-fill me-1"></i>Map
					</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- ===== MAIN ===== -->
	<main>

		<%
		/* ===== ERROR DISPLAY ===== */
		List<String> errors = (List<String>) request.getAttribute("errors");
		if (errors != null && !errors.isEmpty()) {
		%>
		<div class="position-absolute top-0 mt-3">
			<div class="alert alert-danger">
				<ul class="mb-0">
					<%
					for (String e : errors) {
					%>
					<li><%=e%></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
		<%
		}

		/* ===== PREFILL ===== */
		Customer temp = (Customer) session.getAttribute("tempUser");
		%>

		<div class="glass-card">

			<h3 class="fw-bold text-center mb-4">会員登録</h3>

			<form action="Registerconfirmationservlet" method="post">

				<div class="mb-3">
					<label class="form-label">お名前</label> <input type="text"
						name="username" class="form-control"
						value="<%=request.getAttribute("username") != null
		? request.getAttribute("username")
		: (temp != null ? temp.getName() : "")%>"
						required>
				</div>

				<div class="mb-3">
					<label class="form-label">フリガナ</label> <input type="text"
						name="furikana" class="form-control"
						value="<%=request.getAttribute("furikana") != null
		? request.getAttribute("furikana")
		: (temp != null ? temp.getNameKana() : "")%>"
						required>
				</div>

				<div class="mb-3">
					<label class="form-label">メールアドレス</label> <input type="email"
						name="usermail" class="form-control"
						value="<%=request.getAttribute("usermail") != null
		? request.getAttribute("usermail")
		: (temp != null ? temp.getEmail() : "")%>"
						required>
				</div>

				<div class="mb-3">
					<label class="form-label">電話番号</label> <input type="tel"
						name="usertel" class="form-control"
						value="<%=request.getAttribute("usertel") != null
		? request.getAttribute("usertel")
		: (temp != null ? temp.getPhone() : "")%>"
						required>
				</div>

				<div class="mb-3">
					<label class="form-label">パスワード</label> <input type="password"
						name="userpass" class="form-control" required>
				</div>

				<div class="mb-4">
					<label class="form-label">パスワード（確認）</label> <input type="password"
						name="repassword" class="form-control" required>
				</div>

				<button type="submit" class="btn btn-dark w-100 register-btn">
					次へ</button>

			</form>

			<div class="text-center mt-4">
				<a href="login.jsp" class="link fw-bold">すでにアカウントをお持ちの方</a>
			</div>

		</div>
	</main>

	<!-- ===== FOOTER ===== -->
	<%@ include file="footer.jsp"%>

</body>
</html>
