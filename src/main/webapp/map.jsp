<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Customer"%>
<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>
<title>Location - Mesa</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
/* 1. Custom Map Styling */
.full-width-map iframe {
	width: 100%;
	height: 500px; /* Taller map for a "cinematic" feel */
	border: none;
	filter: grayscale(20%);
	/* Optional: Slightly desaturates map for a modern look */
}

/* 2. Info Box Styling */
.info-box {
	background: white;
	transition: transform 0.3s ease;
	border-bottom: 4px solid transparent;
}

.info-box:hover {
	transform: translateY(-5px); /* Gentle lift on hover */
	border-bottom: 4px solid #dc3545; /* Red underline appears */
}

/* 3. Icon Circle */
.icon-circle {
	width: 60px;
	height: 60px;
	background-color: #f8f9fa;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 1rem auto;
	color: #dc3545;
}
</style>
</head>
<body>

	<div class="container-fluid p-0">

		<nav class="navbar navbar-expand-lg bg-danger py-3 sticky-top">
			<div class="container">
				<a
					class="navbar-brand d-flex align-items-center gap-3 fw-bold text-white"
					href="<%=request.getContextPath()%>/index.jsp"> <img
					src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
					height="40" width="40" class="me-1" alt="Logo"> Welcome From
					Mesa <%
 if (loginCustomer != null) {
 %>
					<div class="d-flex align-items-center gap-2 px-3 py-1 rounded-pill"
						style="background: rgba(255, 255, 255, 0.15);">
						<i class="bi bi-person-circle fs-5"></i> <span
							class="small fw-semibold"><%=loginCustomer.getName()%></span> <span
							class="badge bg-light text-danger fw-bold position-relative"><%=loginCustomer.getPoint()%>
							pt</span>
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
		<div class="bg-dark text-white text-center py-5">
			<h1 class="display-4 fw-bold">Find Us</h1>
			<p class="lead text-white-50">Heart of Itabashi, Tokyo</p>
		</div>

		<div class="full-width-map">
			<iframe
				src="https://maps.google.com/maps?q=Itabashi 2-66-1, Tokyo&t=&z=15&ie=UTF8&iwloc=&output=embed"
				allowfullscreen="" loading="lazy"
				referrerpolicy="no-referrer-when-downgrade"> </iframe>
		</div>

		<div class="container my-5">
			<div class="row g-4 justify-content-center">

				<div class="col-md-4">
					<div class="card p-4 h-100 shadow-sm border-0 text-center info-box">
						<div class="icon-circle">
							<i class="bi bi-geo-alt-fill fs-3"></i>
						</div>
						<h5 class="fw-bold">Address</h5>
						<p class="text-muted mb-1">Itabashi 2-66-1, Tokyo</p>
						<p class="text-secondary small">東京都板橋区2-66-1</p>
						<a href="https://maps.google.com/maps?q=Itabashi 2-66-1, Tokyo"
							target="_blank" class="btn btn-sm btn-outline-dark mt-2">Get
							Directions</a>
					</div>
				</div>

				<div class="col-md-4">
					<div class="card p-4 h-100 shadow-sm border-0 text-center info-box">
						<div class="icon-circle">
							<i class="bi bi-train-front-fill fs-3"></i>
						</div>
						<h5 class="fw-bold">Access</h5>
						<p class="text-muted mb-1">Toei Mita Line</p>
						<p class="text-secondary small">Right outside the ticket gate</p>
						<span class="badge bg-success mt-2">Immediate Access</span>
					</div>
				</div>

				<div class="col-md-4">
					<div class="card p-4 h-100 shadow-sm border-0 text-center info-box">
						<div class="icon-circle">
							<i class="bi bi-telephone-fill fs-3"></i>
						</div>
						<h5 class="fw-bold">Contact</h5>
						<p class="text-muted mb-0">Reservations & Inquiry</p>
						<a href="tel:0333637761"
							class="text-decoration-none text-danger fs-5 fw-bold mt-2 d-block">03-3363-7761</a>
					</div>
				</div>

			</div>
		</div>

		<%@ include file="footer.jsp"%>
	</div>

</body>
</html>