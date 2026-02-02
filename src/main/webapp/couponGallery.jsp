<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List, model.Coupon, model.Customer"%>
<%@ include file="header.jsp"%>
<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>

<!DOCTYPE html>
<html>
<head>
<title>Coupons | Mesa</title>

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
	padding: 50px 0;
}

/* =====================
   COUPON CARD
===================== */
.coupon-card {
	border: none;
	border-radius: 12px;
	overflow: hidden;
	transition: all 0.3s ease;
	background: white;
	height: 100%;
	display: flex;
	flex-direction: column;
}

.coupon-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.coupon-img {
	width: 100%;
	height: 180px;
	object-fit: cover;
}

/* Perforated edge effect */
.coupon-details {
	position: relative;
	border-top: 2px dashed #dee2e6;
	padding: 25px;
	flex: 1;
	display: flex;
	flex-direction: column;
	background: #fff;
}

.coupon-details::before, .coupon-details::after {
	content: "";
	position: absolute;
	top: -10px;
	width: 20px;
	height: 20px;
	background-color: #f8f9fa; /* Matches page background */
	border-radius: 50%;
}

.coupon-details::before {
	left: -10px;
}

.coupon-details::after {
	right: -10px;
}

/* Badges & Text */
.discount-badge {
	font-size: 1.4rem;
	font-weight: 800;
	color: #dc3545;
}

.points-pill {
	background-color: #fff3cd;
	color: #856404;
	padding: 5px 15px;
	border-radius: 50px;
	font-size: 0.8rem;
	font-weight: 700;
	display: inline-block;
}

.coupon-title {
	font-weight: 700;
	font-size: 1.15rem;
	margin-top: 10px;
	margin-bottom: 8px;
	color: #212529;
}

.validity-text {
	font-size: 0.75rem;
	color: #adb5bd;
	margin-bottom: 15px;
	display: block;
}

/* Action Area */
.action-area {
	margin-top: auto;
	padding-top: 15px;
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
				height="40" width="40" class="me-1" alt="Logo"> Welcome From Mesa <%
 if (loginCustomer != null) {
 %>
				<div class="d-flex align-items-center gap-2 px-3 py-1 rounded-pill"
					style="background: rgba(255, 255, 255, 0.15);">
					<i class="bi bi-person-circle fs-5"></i> <span
						class="small fw-semibold"><%=loginCustomer.getName()%></span> <span
						class="badge bg-light text-danger fw-bold position-relative"><%=loginCustomer.getPoint()%>
						pt</span>
				</div> <%
 } else {
 %> <span>Welcome From Mesa</span> <%
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
						href="<%=request.getContextPath()%>/index.jsp"><i
							class="bi bi-house-fill me-1"></i>Home</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/member_index.jsp"><i
							class="bi bi-house-fill me-1"></i>Home</a></li>
					<%
					}
					%>

					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/MenuListServlet"><i
							class="bi bi-menu-down me-1"></i>Menu</a></li>

					<%
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/reserve/form"><i
							class="bi bi-calendar-check me-1"></i>Reservation</a></li>
					<%
					}
					%>

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
		<div class="container">

			<div class="text-center mb-5">
				<h2 class="fw-bold mb-2">お得なクーポン</h2>
				<p class="text-muted">会員様限定の特別オファーをご利用ください</p>
			</div>

			<div class="row g-4">
				<%
				List<Coupon> allCoupons = (List<Coupon>) request.getAttribute("allCoupons");

				if (allCoupons != null && !allCoupons.isEmpty()) {
					for (Coupon c : allCoupons) {
				%>
				<div class="col-12 col-md-6 col-lg-4">
					<div class="coupon-card shadow-sm">

						<div style="position: relative;">
							<img src="<%=request.getContextPath()%>/<%=c.getImagePath()%>"
								class="coupon-img" alt="<%=c.getTitle()%>">
							<%
							if (c.getTitle().contains("新規")) {
							%>
							<span
								class="badge bg-warning text-dark position-absolute top-0 start-0 m-3 shadow-sm">NEW</span>
							<%
							}
							%>
						</div>

						<div class="coupon-details">
							<div class="d-flex justify-content-between align-items-start">
								<span class="points-pill"> <i class="bi bi-stars"></i> <%=c.getMinPoint()%>
									pt
								</span> <span class="discount-badge"> ¥<%=String.format("%,d", c.getDiscountAmount())%>
									OFF
								</span>
							</div>

							<h5 class="coupon-title"><%=c.getTitle()%></h5>

							<p class="text-muted small flex-grow-1" style="line-height: 1.6;">
								<%=c.getDescription()%>
							</p>

							<div class="action-area">
								<span class="validity-text"> <i
									class="bi bi-calendar3 me-1"></i> 有効期限: <%=c.getEndDate()%> まで
								</span> <a href="<%=request.getContextPath()%>/reserve/form"
									class="btn btn-dark w-100 rounded-pill fw-bold py-2 shadow-sm">
									このクーポンを使って予約 </a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				} else {
				%>
				<div class="col-12 text-center py-5">
					<div class="mb-3">
						<i class="bi bi-ticket-perforated text-muted opacity-25"
							style="font-size: 5rem;"></i>
					</div>
					<h4 class="text-muted fw-bold">現在利用可能なクーポンはありません</h4>
					<p class="text-muted">新しいクーポンが追加されるのをお待ちください。</p>
					<a href="<%=request.getContextPath()%>/index.jsp"
						class="btn btn-outline-secondary rounded-pill mt-3 px-4">トップへ戻る</a>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</main>

	<%@ include file="footer.jsp"%>

</body>
</html>