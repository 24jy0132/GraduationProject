<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>Contact - Mesa</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
/* Style the top banner image */
.contact-banner {
	width: 100%;
	height: 350px; /* Fixed height for consistency */
	object-fit: cover; /* Ensures image covers area without stretching */
	object-position: center;
	margin-bottom: 2rem;
}

/* Hover effect for the phone number */
.phone-link {
	text-decoration: none;
	color: #dc3545; /* Bootstrap danger color */
	transition: color 0.3s ease;
}

.phone-link:hover {
	color: #bb2d3b;
	text-decoration: underline;
}
</style>
</head>
<body>

	<div class="container-fluid p-0">
		<nav class="navbar navbar-expand-lg bg-danger py-3 sticky-top">
			<div class="container">
				<a class="navbar-brand fw-bold text-white" href="index.jsp"> <img
					src="img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png" height="40"
					width="40" alt="Logo" class="me-2"> Welcome From Mesa
				</a>

				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse justify-content-end"
					id="navbarSupportedContent">
					<ul class="navbar-nav mb-2 mb-lg-0 d-flex gap-4">
						<li class="nav-item"><a class="nav-link active text-white"
							href="#"><i class="bi bi-house-fill me-1"></i>Home</a></li>
						<li class="nav-item"><a class="nav-link text-white"
							href="Menucontrollers"><i class="bi bi-menu-down me-1"></i>Menu</a></li>
						<li class="nav-item"><a class="nav-link text-white" href="#"><i
								class="bi bi-calendar-check me-1"></i>Reservation</a></li>
						<li class="nav-item"><a class="nav-link text-white"
							href="contact.jsp"><i class="bi bi-telephone-fill me-1"></i>Contact</a></li>
						<li class="nav-item"><a class="nav-link text-white"
							href="map.jsp"><i class="bi bi-pin-map-fill me-1"></i>Map</a></li>
					</ul>

					<a class="nav-link active text-white fw-bold ms-lg-3 mt-2 mt-lg-0"
						href="login.jsp"> <i class="bi bi-box-arrow-in-right me-1"></i>Login
					</a>
				</div>
			</div>
		</nav>
		<div>
			<img src="img/mesa_exterior.jpg" alt="Mesa Restaurant Exterior"
				class="contact-banner shadow-sm">
		</div>

		<div class="container mb-5">
			<div class="row justify-content-center">
				<div class="col-lg-8 text-center">

					<h2 class="fw-bold mb-4 text-uppercase text-secondary">Contact
						Us</h2>

					<div class="card shadow border-0 py-5 px-3">
						<div class="card-body">
							<i
								class="bi bi-telephone-inbound-fill text-danger display-4 mb-3"></i>

							<h5 class="card-title fw-bold mb-4">問い合わせ・予約</h5>

							<p class="fs-5 text-muted mb-2">For reservations or
								questions, please contact us directly by phone.</p>

							<p class="mb-4">お手数ですが、以下の番号までお電話をお願い致します。</p>

							<a href="tel:0333637761" class="phone-link"> <span
								class="display-4 fw-bold">03-3363-7761</span>
							</a>

							<div class="mt-4 pt-4 border-top">
								<p class="small text-muted mb-0">We look forward to serving
									you.</p>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>

		<%@ include file="footer.jsp"%>
	</div>

</body>
</html>