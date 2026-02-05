<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ page import="model.Customer"%>

<%
// Check if a user happens to be logged in (unlikely for password reset, but good for safety)
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>

<!DOCTYPE html>
<html>
<head>
<title>本人確認 | Mesa</title>

<style>
/* =====================
   GLOBAL LAYOUT
===================== */
html, body {
	height: 100%;
}

body {
	background-color: #f8f9fa;
	display: flex;
	flex-direction: column;
}

main {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 40px 15px;
}

/* =====================
   FORM CARD
===================== */
.auth-card {
	max-width: 500px;
	width: 100%;
	background: white;
	border: 1px solid #dee2e6;
	border-radius: 12px;
	padding: 40px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.form-label {
	font-weight: 600;
	color: #495057;
	font-size: 0.9rem;
}

.input-group-text {
	background-color: #f8f9fa;
	border-right: none;
	color: #6c757d;
}

.form-control {
	border-left: none;
	padding-left: 0;
}

.form-control:focus {
	box-shadow: none;
	border-color: #dee2e6;
}

/* Focus ring on the group */
.input-group:focus-within {
	box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
	border-radius: 0.375rem;
}

.input-group:focus-within .input-group-text, .input-group:focus-within .form-control
	{
	border-color: #dc3545;
	color: #495057;
}

.btn-submit {
	font-weight: bold;
	letter-spacing: 0.5px;
}
</style>
</head>

<body>

	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<!-- Brand -->
			<a class="navbar-brand fw-bold text-white" href="index.jsp"> <img
				src="img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png" height="40"
				width="40" alt="Logo" class="me-2"> Welcome From Mesa
			</a>

			<!-- Toggler button -->
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- Navbar links and login -->
			<div class="collapse navbar-collapse justify-content-end"
				id="navbarSupportedContent">
				<ul class="navbar-nav gap-4">
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/index.jsp"><i
							class="bi bi-house-fill me-1"></i>Home</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/MenuListServlet"><i
							class="bi bi-menu-down me-1"></i>Menu</a></li>
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
				<a class="nav-link active text-white fw-bold ms-lg-3 mt-2 mt-lg-0"
					href="<%=request.getContextPath()%>/login.jsp"> <i
					class="bi bi-box-arrow-in-right me-1"></i>Login
				</a>
			</div>
		</div>
	</nav>
	<main>
		<div class="auth-card shadow">

			<div class="text-center mb-4">
				<h3 class="fw-bold text-dark">本人確認</h3>
				<p class="text-muted small">
					パスワードを再設定するために、<br>ご登録のメールアドレスと電話番号を入力してください。
				</p>
			</div>

			<form action="passwordResetMailServlet" method="post">

				<div class="mb-4">
					<label class="form-label">メールアドレス</label>
					<div class="input-group input-group-lg">
						<span class="input-group-text"><i class="bi bi-envelope"></i></span>
						<input type="email" name="usermail" class="form-control"
							placeholder="example@email.com" required>
					</div>
				</div>

				<div class="mb-4">
					<label class="form-label">電話番号</label>
					<div class="input-group input-group-lg">
						<span class="input-group-text"><i class="bi bi-telephone"></i></span>
						<input type="tel" name="phone" class="form-control"
							placeholder="09012345678" required>
					</div>
				</div>

				<div class="d-grid gap-2 mt-5">
					<button type="submit"
						class="btn btn-primary btn-lg rounded-pill shadow-sm btn-submit">
						再設定用メールを送信 <i class="bi bi-send ms-2"></i>
					</button>
				</div>

				<div class="text-center mt-4">
					<a href="<%=request.getContextPath()%>/login.jsp"
						class="text-decoration-none text-muted small"> <i
						class="bi bi-arrow-left"></i> ログイン画面に戻る
					</a>
				</div>

			</form>
		</div>
	</main>

	<%@ include file="footer.jsp"%>

</body>
</html>