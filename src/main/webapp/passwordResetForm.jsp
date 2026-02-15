<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ page import="model.Customer"%>

<%
// Standard session check for Navbar consistency
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>

<!DOCTYPE html>
<html>
<head>
<title>パスワード再設定 | Mesa</title>

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
   RESET CARD
===================== */
.reset-card {
	max-width: 500px;
	width: 100%;
	background: white;
	border: 1px solid #dee2e6;
	border-radius: 12px;
	padding: 40px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.icon-box {
	width: 80px;
	height: 80px;
	background-color: #fff3cd;
	color: #ffc107;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 20px auto;
	font-size: 2.5rem;
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
			<a
				class="navbar-brand d-flex align-items-center gap-3 fw-bold text-white"
				href="<%=request.getContextPath()%>/index.jsp"> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" class="me-1" alt="Logo"> <span>Welcome
					From Mesa</span>
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
						href="<%=request.getContextPath()%>/MenuListServlet"><i
							class="bi bi-menu-down me-1"></i>Menu</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/reserve/form"><i
							class="bi bi-calendar-check me-1"></i>Reservation</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/contact.jsp"><i
							class="bi bi-telephone-fill me-1"></i>Contact</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/map.jsp"><i
							class="bi bi-pin-map-fill me-1"></i>Map</a></li>

					<%
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a
						class="nav-link active text-white fw-bold ms-lg-3"
						href="<%=request.getContextPath()%>/login.jsp"><i
							class="bi bi-box-arrow-in-right me-1"></i>Login</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link text-white ms-lg-3"
						href="<%=request.getContextPath()%>/Customer_LogOut"><i
							class="bi bi-box-arrow-right me-1"></i>LogOut</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>

	<main>
		<div class="reset-card shadow">

			<div class="icon-box">
				<i class="bi bi-shield-lock-fill"></i>
			</div>

			<div class="text-center mb-4">
				<h3 class="fw-bold text-dark">新しいパスワードの設定</h3>
				<p class="text-muted small">セキュリティのため、推測されにくいパスワードを設定してください。</p>
			</div>

			<%
			String error = (String) request.getAttribute("error");
			if (error != null) {
			%>
			<div class="alert alert-danger text-center small mb-4">
				<i class="bi bi-exclamation-circle me-1"></i>
				<%=error%>
			</div>
			<%
			}
			%>

			<form action="PasswordResetServlet" method="post">
				<input type="hidden" name="token" value="${token}">

				<div class="mb-4">
					<label class="form-label">新しいパスワード 「8文字以上、数字一つ以上」</label>
					<div class="input-group input-group-lg">
						<span class="input-group-text"><i class="bi bi-key"></i></span> <input
							type="password" name="password" class="form-control"
							placeholder="8文字以上" required minlength="8">
					</div>
					<div class="form-text small">
						<i class="bi bi-info-circle"></i> 8文字以上で入力してください
					</div>
				</div>

				<div class="mb-4">
					<label class="form-label">新しいパスワード（確認）</label>
					<div class="input-group input-group-lg">
						<span class="input-group-text"><i
							class="bi bi-check-circle"></i></span> <input type="password"
							name="passwordConfirm" class="form-control"
							placeholder="もう一度入力してください" required minlength="8">
					</div>
				</div>

				<div class="d-grid gap-2 mt-5">
					<button type="submit"
						class="btn btn-dark btn-lg rounded-pill shadow-sm btn-submit">
						パスワードを変更する</button>
				</div>

			</form>
		</div>
	</main>

	<%@ include file="footer.jsp"%>

</body>
</html>