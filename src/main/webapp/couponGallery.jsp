<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List, model.Coupon,model.Customer"%>
<%@ include file="header.jsp"%>
<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>
<style>
.coupon-container {
	background-color: #f8f9fa;
	min-height: 100vh;
	padding: 50px 0;
}

.coupon-card {
	border: none;
	border-radius: 15px;
	overflow: hidden;
	transition: transform 0.3s ease;
	background: white;
}

.coupon-card:hover {
	transform: translateY(-10px);
}

.coupon-img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}
/* Perforated edge effect */
.coupon-details {
	position: relative;
	border-top: 2px dashed #dee2e6;
	padding: 20px;
}

.coupon-details::before, .coupon-details::after {
	content: "";
	position: absolute;
	top: -11px;
	width: 22px;
	height: 22px;
	background-color: #f8f9fa; /* Matches page background */
	border-radius: 50%;
}

.coupon-details::before {
	left: -11px;
}

.coupon-details::after {
	right: -11px;
}

.discount-badge {
	font-size: 1.25rem;
	font-weight: bold;
	color: #dc3545;
}

.points-badge {
	background-color: #ffc107;
	color: #000;
	padding: 5px 12px;
	border-radius: 50px;
	font-size: 0.85rem;
	font-weight: bold;
}
</style>
<nav class="navbar navbar-expand-lg bg-danger py-3">
	<div class="container">
		<a class="navbar-brand fw-bold text-white"
			href="<%=request.getContextPath()%>/index.jsp"> <img
			src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
			height="40" width="40" class="me-2"> Welcome From Mesa
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent">
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
					href="MenuListServlet"> <i class="bi bi-menu-down me-1"></i>Menu
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
<div class="coupon-container">


	<div class="container">
		<div class="text-center mb-5">
			<h1 class="fw-bold">クーポン一覧表</h1>
		</div>

		<div class="row g-4">
			<%
			List<Coupon> allCoupons = (List<Coupon>) request.getAttribute("allCoupons");
			if (allCoupons != null && !allCoupons.isEmpty()) {
				for (Coupon c : allCoupons) {
			%>
			<div class="col-12 col-md-6 col-lg-4">
				<div class="card coupon-card shadow-sm h-100">
					<img src="<%=request.getContextPath()%>/<%=c.getImagePath()%>"
						class="coupon-img" alt="coupon image">

					<div class="coupon-details d-flex flex-column flex-grow-1">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<span class="points-badge"><%=c.getMinPoint()%> Points</span> <span
								class="discount-badge">¥<%=c.getDiscountAmount()%> OFF
							</span>
						</div>

						<h5 class="fw-bold"><%=c.getTitle()%></h5>
						<p class="text-muted small flex-grow-1">
							<%=c.getDescription()%>
						</p>

						<div class="mt-3 pt-3 border-top">
							<div class="text-muted x-small mb-2" style="font-size: 0.75rem;">
								<i class="bi bi-calendar-event me-1"></i> Valid:
								<%=c.getStartDate()%>
								~
								<%=c.getEndDate()%>
							</div>
							<a href="<%=request.getContextPath()%>/reserve/form"
								class="btn btn-danger w-100 rounded-pill"> Make a
								Reservation </a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<div class="col-12 text-center py-5">
				<i class="bi bi-ticket-perforated text-muted"
					style="font-size: 4rem;"></i>
				<h3 class="mt-3">No coupons available right now</h3>
				<p>Please check back later!</p>
			</div>
			<%
			}
			%>
		</div>
	</div>
</div>

<%@ include file="footer.jsp"%>