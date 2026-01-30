<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Customer"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン・会員登録のお願い</title>



<style>
:root {
	--bg: #f6f2fb;
	--card: #ffffff;
	--text: #212529;
	--muted: #6c757d;
	--accent1: #e64980;
	--accent2: #ae3ec9;
	--line: #e8e3f6;
}

body {
	background: var(--bg);
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

/* ===== Page Centering ===== */
.page-wrap {
	flex: 1; /* ⭐ key line */
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 48px 12px;
}

/* ===== Main Card ===== */
.notice-card {
	max-width: 760px;
	width: 100%;
	background: var(--card);
	border-radius: 20px;
	border: 1px solid var(--line);
	padding: 48px 32px;
	box-shadow: 0 18px 40px rgba(0, 0, 0, .10);
}

/* ===== Icon ===== */
.notice-icon {
	width: 72px;
	height: 72px;
	border-radius: 50%;
	background: black;
	color: #fff;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 32px;
	margin: 0 auto 24px;
}

/* ===== Text ===== */
.notice-title {
	font-weight: 800;
	color: var(--text);
	margin-bottom: 16px;
}

.notice-text {
	color: var(--muted);
	line-height: 1.9;
	font-weight: 600;
}

/* ===== Buttons ===== */
.btn-wine {
	border: none;
	background: linear-gradient(135deg, var(--accent1), var(--accent2));
	color: #fff;
	font-weight: 700;
	box-shadow: 0 8px 18px rgba(174, 62, 201, .28);
	transition: all .2s ease;
}

.btn-wine:hover {
	transform: translateY(-2px);
	box-shadow: 0 12px 28px rgba(174, 62, 201, .40);
	color: #fff;
}

.btn-outline-wine {
	background: #fff;
	border: 1.5px solid #d7d7e2;
	color: #555;
	font-weight: 700;
	transition: all .2s ease;
}

.btn-outline-wine:hover {
	background: #f3f0ff;
	border-color: rgba(174, 62, 201, .30);
	color: #333;
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

	<!-- ===== Main Content ===== -->
	<div class="page-wrap">
		<div class="notice-card text-center">

			<div class="notice-icon">🔒</div>

			<h2 class="notice-title">アンケートに回答するにはログインが必要です</h2>

			<div class="notice-text mb-4">
				<div>
					商品アンケートは <strong>会員限定サービス</strong> です。
				</div>
				<div>ログイン後に、再度アンケートへお進みください。</div>
				<div class="mt-2">まだ会員でない方は、新規会員登録をお願いします。</div>
			</div>

			<div
				class="d-flex flex-column flex-sm-row gap-3 justify-content-center mt-4">
				<button type="button"
					class="btn btn-outline-wine rounded-pill px-5 py-2"
					onclick="location.href='login.jsp'">ログイン</button>

				<button type="button" class="btn btn-dark rounded-pill px-5 py-2"
					onclick="location.href='registerForm.jsp'">新規会員登録</button>

			</div>

		</div>
	</div>


</body>
<%@ include file="footer.jsp"%>
</html>
