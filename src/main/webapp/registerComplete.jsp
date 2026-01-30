<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="header.jsp"%>
<%@ page import="model.Customer"%>


<%
String message = (String) session.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>会員登録完了</title>



<style>
:root {
	--bg: #f6f2fb;
	--card: #ffffff;
	--text: #212529;
	--muted: #6c757d;
	--accent1: #e64980;
	--accent2: #ae3ec9;
	--line: #ece8f7;
}

body {
	background: var(--bg);
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

/* wrapper */
.page-wrap {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 48px 12px;
}

/* card */
.complete-card {
	max-width: 560px;
	width: 100%;
	background: var(--card);
	border-radius: 20px;
	padding: 42px 32px;
	border: 1px solid var(--line);
	box-shadow: 0 18px 40px rgba(0, 0, 0, .10);
	text-align: center;
}

/* icon */
.complete-icon {
	font-size: 3rem;
	color: #28a745; /* success green */
	margin-bottom: 16px;
}

/* title */
.complete-title {
	font-weight: 800;
	color: var(--text);
	margin-bottom: 12px;
}

/* message */
.complete-text {
	color: var(--muted);
	font-size: 0.95rem;
	line-height: 1.8;
	margin-bottom: 28px;
}

/* button */
.btn-primary {
	border: none;
	background: black;
	font-weight: 700;
	box-shadow: 0 8px 18px rgba(174, 62, 201, .28);
}

.btn-primary:hover {
	transform: translateY(-1px);
	box-shadow: 0 12px 26px rgba(174, 62, 201, .38);
}
</style>
</head>

<body>
	<%
	Customer loginCustomer = (Customer) session.getAttribute("customer");
	%>

	<!-- ===== Navbar (unchanged) ===== -->
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
					<%
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/index.jsp"> <i
							class="bi bi-house-fill me-1"></i>Home
					</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/member_index.jsp"> <i
							class="bi bi-house-fill me-1"></i>Home
					</a></li>
					<%
					}
					%>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/MenuListServlet"> <i class="bi bi-menu-down me-1"></i>Menu
					</a></li>


					<%
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/reserve/form"> <i
							class="bi bi-calendar-check me-1"></i>Reservation
					</a></li>
					<%
					}
					%>

					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/contact.jsp"> <i
							class="bi bi-telephone-fill me-1"></i>Contact
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/map.jsp"> <i
							class="bi bi-pin-map-fill me-1"></i>Map
					</a></li>

					<%
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a
						class="nav-link active text-white fw-bold ms-lg-3"
						href="<%=request.getContextPath()%>/login.jsp"> <i
							class="bi bi-box-arrow-in-right me-1"></i>Login
					</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link text-white ms-lg-3"
						href="<%=request.getContextPath()%>/Customer_LogOut"> <i
							class="bi bi-box-arrow-right me-1"></i>LogOut
					</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>


	<div class="page-wrap">

		<%
		if (message != null) {
		%>
		<!-- ===== Success ===== -->
		<div class="complete-card">

			<div class="complete-icon">✓</div>

			<h3 class="complete-title">会員登録が完了しました</h3>

			<p class="complete-text">
				<%=message%><br> ログインしてサービスをご利用ください。
			</p>

			<a href="login.jsp" class="btn btn-primary px-5"> ログイン画面へ </a>

		</div>

		<%
		session.removeAttribute("message");
		} else {
		%>
		<!-- ===== No message ===== -->
		<div class="complete-card">

			<h3 class="complete-title text-danger">登録情報が見つかりません</h3>

			<p class="complete-text">
				セッション情報が確認できませんでした。<br> もう一度最初から操作してください。
			</p>

			<a href="registerForm.jsp" class="btn btn-outline-secondary px-5">
				新規会員登録へ </a>

		</div>
		<%
		}
		%>

	</div>

	<%@ include file="footer.jsp"%>


</body>
</html>
