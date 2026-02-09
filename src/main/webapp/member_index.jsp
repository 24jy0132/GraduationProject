<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Customer"%>

<%
Customer customer = (Customer) session.getAttribute("customer");
%>

<!DOCTYPE html>
<html>
<head>
<title>会員TOP</title>

<style>
/* =====================
   THEME
===================== */
:root {
	--primary: #dc3545;
	--dark: #212529;
	--light: #f8f9fa;
}

/* =====================
   HERO
===================== */
.hero {
	background: linear-gradient(rgba(0, 0, 0, .55), rgba(0, 0, 0, .55)),
		url("img/h1.jpg") center/cover no-repeat;
	height: 520px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #fff;
}

.hero-card {
	background: rgba(255, 255, 255, .15);
	backdrop-filter: blur(10px);
	border-radius: 18px;
	padding: 40px;
	text-align: center;
	max-width: 520px;
	width: 100%;
}

/* =====================
   MEMBER INFO
===================== */
.avatar {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	background: var(--primary);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 36px;
	color: #fff;
	margin: 0 auto 15px;
}

.point-box {
	margin-top: 20px;
	background: #fff;
	color: var(--dark);
	border-radius: 14px;
	padding: 20px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .15);
}

.point-value {
	font-size: 2rem;
	font-weight: bold;
	color: var(--primary);
}

/* =====================
   QUICK ACTIONS
===================== */
.action-link {
	text-decoration: none;
	color: inherit;
	display: block;
}

.action-card {
	border-radius: 16px;
	padding: 25px;
	transition: .3s;
}

.action-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, .15);
}

.action-icon {
	font-size: 32px;
	color: var(--primary);
}
</style>
</head>

<body>

	<!-- =====================
     NAVBAR (UNCHANGED)
===================== -->
	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<a class="navbar-brand fw-bold text-white" href="<%=request.getContextPath()%>/member_index.jsp">
				<img src="img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
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
						href="member_index.jsp"> <i class="bi bi-house-fill me-1"></i>Home
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/MenuListServlet"> <i class="bi bi-menu-down me-1"></i>Menu
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="contact.jsp"> <i class="bi bi-telephone-fill me-1"></i>Contact
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/MapServlet"> <i class="bi bi-pin-map-fill me-1"></i>Map
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/Customer_LogOut"> <i
							class="bi bi-box-arrow-right me-1"></i>LogOut
					</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- =====================
     HERO
===================== -->
	<div class="hero">
		<div class="hero-card">

			<div class="avatar">
				<i class="fa-solid fa-user"></i>
			</div>

			<%
			if (customer != null) {
			%>
			<h3 class="fw-bold"><%=customer.getName()%>
				様
			</h3>

			<div class="point-box">
				<div class="text-muted">保有ポイント</div>
				<div class="point-value"><%=customer.getPoint()%>
					pt
				</div>
			</div>
			<%
			}
			%>

		</div>
	</div>

	<!-- =====================
     QUICK ACTIONS
===================== -->
	<div class="container my-5">
		<div class="row g-4 text-center">

			<div class="col-md-3">
				<a href="<%=request.getContextPath()%>/reserve/form"
					class="action-link text-decoration-none">
					<div class="action-card bg-light p-4 h-100 rounded shadow-sm">
						<div class="action-icon mb-2">
							<i class="bi bi-calendar-check fs-2 text-danger"></i>
						</div>
						<h5 class="text-dark">予約する</h5>
						<p class="text-muted mb-0">お席・コースの予約</p>
					</div>
				</a>
			</div>

			<div class="col-md-3">
				<a href="<%=request.getContextPath()%>/member/profile"  class="action-link text-decoration-none">
					<div class="action-card bg-light p-4 h-100 rounded shadow-sm">
						<div class="action-icon mb-2">
							<i class="bi bi-person fs-2 text-danger"></i>
						</div>
						<h5 class="text-dark">会員情報</h5>
						<p class="text-muted mb-0">プロフィール確認</p>
					</div>
				</a>
			</div>

			<div class="col-md-3">
				<a href="<%=request.getContextPath()%>/member/reservations"
					class="action-link text-decoration-none">
					<div class="action-card bg-light p-4 h-100 rounded shadow-sm">
						<div class="action-icon mb-2">
							<i class="bi bi-star-fill fs-2 text-danger"></i>
						</div>
						<h5 class="text-dark">予約履歴</h5>
						<p class="text-muted mb-0">過去履歴</p>
					</div>
				</a>
			</div>

			<div class="col-md-3">
				<a href="<%=request.getContextPath()%>/coupons"
					class="action-link text-decoration-none">
					<div class="action-card bg-light p-4 h-100 rounded shadow-sm">
						<div class="action-icon mb-2">
							<i class="fa-solid fa-ticket fs-2 text-danger"></i>
						</div>
						<h5 class="text-dark">ク―ポン</h5>
						<p class="text-muted mb-0">特別割引</p>
					</div>
				</a>
			</div>

		</div>
	</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
