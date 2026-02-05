<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ page import="model.Customer"%>

<%
// Standard session check
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>

<!DOCTYPE html>
<html>
<head>
<title>再設定完了 | Mesa</title>

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
   SUCCESS CARD
===================== */
.result-card {
	max-width: 500px;
	width: 100%;
	background: white;
	border: 1px solid #dee2e6;
	border-radius: 12px;
	padding: 50px 30px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	text-align: center;
}

.icon-box {
	width: 100px;
	height: 100px;
	background-color: #d1e7dd;
	color: #198754;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 30px auto;
	font-size: 3.5rem;
	animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

@
keyframes popIn { 0% {
	transform: scale(0);
	opacity: 0;
}

100
%
{
transform
:
scale(
1
);
opacity
:
1;
}
}
.result-title {
	font-weight: 800;
	color: #212529;
	margin-bottom: 20px;
	font-size: 1.5rem;
}

.result-message {
	font-size: 1rem;
	color: #6c757d;
	margin-bottom: 40px;
	line-height: 1.6;
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
		<div class="result-card shadow">

			<div class="icon-box">
				<i class="bi bi-check-lg"></i>
			</div>

			<h2 class="result-title">パスワード再設定完了</h2>

			<div class="result-message">
				パスワードの変更が完了しました。<br> 新しいパスワードでログインしてください。
			</div>

			<a href="<%=request.getContextPath()%>/login.jsp"
				class="btn btn-primary btn-lg rounded-pill px-5 shadow-sm fw-bold">
				ログイン画面へ戻る <i class="bi bi-box-arrow-in-right ms-2"></i>
			</a>

		</div>
	</main>

	<%@ include file="footer.jsp"%>

</body>
</html>