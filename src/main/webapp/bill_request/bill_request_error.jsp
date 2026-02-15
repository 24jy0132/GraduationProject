<%@ include file="/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>会計依頼失敗 | Mesa</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
/* Custom styles to refine the look */
body {
	background-color: #f8f9fa; /* Light grey background */
}

.hero-image {
	width: 100%;
	height: 200px;
	object-fit: cover; /* Prevents image stretching */
	border-radius: 10px 10px 0 0;
}

.bill-card {
	max-width: 600px;
	margin: -50px auto 0;
	/* Pull card up over the background/navbar slightly if desired, or just center it */
	margin-top: 30px;
	margin-bottom: 50px;
	border: none;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	border-radius: 15px;
	overflow: hidden;
}

.table-badge {
	background-color: #dc3545;
	color: white;
	padding: 5px 15px;
	border-radius: 20px;
	font-size: 0.9rem;
	font-weight: bold;
	text-transform: uppercase;
	letter-spacing: 1px;
}
</style>
</head>
<body>

	<div class="container-fluid p-0">

		<nav class="navbar navbar-expand-lg bg-danger py-3">
			<div class="container">
				<a class="navbar-brand fw-bold text-white" href="index.jsp"> <img
					src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
					height="40" width="40" alt="Logo" class="me-2"> Welcome From
					Mesa
				</a>

				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
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
							href="<%=request.getContextPath()%>/reserve/form"> <i
								class="bi bi-calendar-check me-1"></i>Reservation
						</a></li>
						<li class="nav-item"><a class="nav-link text-white"
							href="<%=request.getContextPath()%>/contact.jsp"><i
								class="bi bi-telephone-fill me-1"></i>Contact</a></li>
						<li class="nav-item"><a class="nav-link text-white"
							href="<%=request.getContextPath()%>/map.jsp"><i
								class="bi bi-pin-map-fill me-1"></i>Map</a></li>
					</ul>
					<a class="nav-link active text-white fw-bold ms-lg-3 mt-2 mt-lg-0"
						href="<%=request.getContextPath()%>/login.jsp"> <i
						class="bi bi-box-arrow-in-right me-1"></i>Login
					</a>
				</div>
			</div>
		</nav>

		<div class="container pb-5">
			<div class="card bill-card bg-white">

				<img src="<%=request.getContextPath()%>/img/mesa_cash_register.jpg"
					alt="Cash Register" class="hero-image">

				<div class="card-body p-4 text-center">


					<h2 class="fw-bold mb-3">会計依頼 失敗</h2>

					<p class="text-muted mb-4">大変お手数ですが、店員にお声がけのうえ、お会計の旨をお伝えください。</p>

				</div>
			</div>
		</div>

		<%@ include file="/footer.jsp"%>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>