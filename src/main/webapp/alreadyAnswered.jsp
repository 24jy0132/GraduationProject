<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Customer"%>
<%@ include file="header.jsp"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>回答済み</title>

<style>
body {
	background: #ffffff;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

/* central card */
.msg-card {
	max-width: 520px;
	width: 92%;
	border-radius: 18px;
	background: #ffffff;
	box-shadow: 0 14px 34px rgba(0, 0, 0, .08);
	padding: 42px 32px;
	text-align: center;
}

/* check icon */
.check-icon {
	font-size: 3.2rem;
	color: #e64980;
	margin-bottom: 14px;
}

/* title */
.msg-title {
	font-weight: 800;
	font-size: 1.4rem;
	color: #212529;
	margin-bottom: 10px;
}

/* text */
.msg-text {
	color: #666;
	font-size: 0.95rem;
	line-height: 1.8;
	margin-bottom: 18px;
}

/* earned points box */
.point-box {
	background: #fff3f8;
	border: 1px dashed #f3b7cc;
	border-radius: 14px;
	padding: 14px;
	margin-bottom: 26px;
}

.point-value {
	font-size: 1.6rem;
	font-weight: 800;
	color: #e64980;
}

/* button */
.btn-soft {
	background: black;
	color: #fff;
	border: none;
	border-radius: 999px;
	padding: 0.65rem 2.2rem;
	font-weight: 600;
	box-shadow: 0 8px 18px rgba(174, 62, 201, .35);
	transition: all .2s ease;
}

.btn-soft:hover {
	transform: translateY(-2px);
	box-shadow: 0 12px 26px rgba(174, 62, 201, .45);
	color: #fff;
}
</style>
</head>

<body>

	<%
	Customer loginCustomer = (Customer) session.getAttribute("customer");


	%>

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
 } else {
 %> <!-- Not logged in --> <span class="small fw-semibold">
					Welcome From Mesa </span> <%
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



	<!-- ===== Center Content ===== -->
	<div
		class="flex-grow-1 d-flex align-items-center justify-content-center">

		<div class="msg-card">

			<div class="check-icon">✓</div>

			<div class="msg-title">このアンケートは回答済みです</div>

			<p class="msg-text">
				すでに当該商品のアンケートに回答済みのため、<br> 再度回答することはできません。
			</p>

			<!-- ★ Earned Points -->
			<div class="point-box">
				<div class="fw-bold mb-1">今回獲得したポイント</div>
				<div class="point-value">
					+10
					pt
				</div>
			</div>

			<button class="btn btn-soft"
				onclick="location.href='MenuListServlet'">メニューに戻る</button>

		</div>
	</div>

	<%@ include file="footer.jsp"%>


</body>
</html>
