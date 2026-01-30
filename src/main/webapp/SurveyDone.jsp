<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Customer"%>
<%@ include file="header.jsp"%>
<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>アンケート完了</title>

<style>
body {
	background: #f6f7fb;
}

.done-wrapper {
	min-height: 70vh;
}

.done-card {
	background: #ffffff;
	border-radius: 18px;
	padding: 40px 32px;
	box-shadow: 0 12px 30px rgba(0, 0, 0, .08);
}

.done-title {
	font-weight: 700;
	font-size: 1.3rem;
}

.done-text {
	color: #666;
	font-size: 0.95rem;
}
/* ✨ Stylish button */
.btn-elegant {
	background: linear-gradient(135deg, #d6336c, #9c36b5);
	color: #fff;
	border: none;
	border-radius: 999px;
	padding: 0.65rem 2.2rem;
	font-weight: 600;
	box-shadow: 0 6px 16px rgba(156, 54, 181, .35);
	transition: all .2s ease;
}

.btn-elegant:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 22px rgba(156, 54, 181, .45);
	color: #fff;
}

.check-icon {
	font-size: 3rem;
	color: #d6336c;
}
</style>
</head>
<body>
	<!-- Navbar -->
	<!-- ===== Navbar ===== -->
	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<a
				class="navbar-brand d-flex align-items-center gap-3 fw-bold text-white"
				href="<%=request.getContextPath()%>/index.jsp"> <!-- Logo --> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" class="me-1"> <%
 if (loginCustomer != null) {
 %> <!-- Logged-in user info -->
				<div class="d-flex align-items-center gap-2 px-3 py-1 rounded-pill"
					style="background: rgba(255, 255, 255, 0.15);">

					<!-- User Icon -->
					<i class="bi bi-person-circle fs-5"></i>

					<!-- User Name -->
					<span class="small fw-semibold"> <%=loginCustomer.getName()%>
					</span>

					<!-- Points -->
					<span id="pointBadge"
						class="badge bg-light text-danger fw-bold position-relative">
						<%=loginCustomer.getPoint()%> pt
					</span>


				</div> <%
 }
 %>


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
						href="<%=request.getContextPath()%>/MenuListServlet"> <i
							class="bi bi-menu-down me-1"></i>Menu
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

	<div class="container">
		<div
			class="row justify-content-center align-items-center done-wrapper text-center">
			<div class="col-12 col-md-8 col-lg-6">
				<div class="done-card">
					<!-- icon -->
					<div class="mb-3">
						<span class="check-icon">✓</span>
					</div>
					<p class="done-title mb-3">ご回答いただきありがとうございました！</p>
					<p class="done-text mb-4">
						10ポイントを付与しました。<br> 同一商品の重複レビューはできません。
					</p>
					<button class="btn btn-elegant"
						onclick="location.href='MenuListServlet'">メニューに戻る</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>

