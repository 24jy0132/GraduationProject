<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

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
	max-width: 420px;
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

.login-btn {
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
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/index.jsp"><i
							class="bi bi-house-fill me-1"></i>Home</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="MenuListServlet"><i class="bi bi-menu-down me-1"></i>Menu</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/reserve/form"> <i
							class="bi bi-calendar-check me-1"></i>Reservation
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/contact.jsp"><i
							class="bi bi-telephone-fill me-1"></i>Contact</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/map.jsp"><i
							class="bi bi-pin-map-fill me-1"></i>Map</a></li>
				</ul>

			</div>
		</div>
	</nav>

	<!-- ===== MAIN ===== -->
	<main>
		<div class="glass-card">

			<h3 class="fw-bold text-center mb-4">会員ログイン</h3>


			<form action="Userloginservlet" method="post">

				<div class="mb-3">
					<label class="form-label">メールアドレス</label> <input type="email"
						name="usermail" class="form-control"
						placeholder="example@mail.com" required>
				</div>

				<div class="mb-4">
					<label class="form-label">パスワード</label> <input type="password"
						name="userpassword" class="form-control" placeholder="••••••••"
						required>
				</div>

				<button type="submit" class="btn btn-dark w-100 login-btn">
					ログイン</button>
			</form>

			<div class="d-flex justify-content-between mt-4">
				<a href="passwordResetForm.jsp" class="link text-muted">
					パスワードを忘れた方 </a> <a href="registerForm.jsp" class="link fw-bold">
					新規登録 </a>
			</div>

		</div>
	</main>

	<!-- ===== FOOTER ===== -->
	<%@ include file="footer.jsp"%>

</body>
</html>
