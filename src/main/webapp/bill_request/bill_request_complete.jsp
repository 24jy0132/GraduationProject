<%@ include file="/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>会計依頼完了 | Mesa</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
/* Base Styles */
body {
	background-color: #f8f9fa;
}

.hero-image {
	width: 100%;
	height: 200px;
	object-fit: cover;
	border-radius: 10px 10px 0 0;
	filter: brightness(0.9);
}

.bill-card {
	max-width: 600px;
	margin: -50px auto 0;
	margin-top: 30px;
	margin-bottom: 50px;
	border: none;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	border-radius: 15px;
	overflow: hidden;
}

.success-icon {
	font-size: 4rem;
	color: #198754; /* Bootstrap Success Green */
	margin-bottom: 15px;
}

.table-badge {
	background-color: #6c757d;
	color: white;
	padding: 5px 15px;
	border-radius: 20px;
	font-size: 0.9rem;
	font-weight: bold;
	text-transform: uppercase;
}

.survey-box {
	background-color: #fff3cd; /* Soft yellow for attention */
	border: 1px solid #ffe69c;
	border-radius: 12px;
	padding: 20px;
	text-align: left;
}
</style>
</head>
<body>

	<div class="container-fluid p-0">

		<nav class="navbar navbar-expand-lg bg-danger py-3">
			<div class="container">
				<!-- Brand -->
				<a class="navbar-brand fw-bold text-white" href="index.jsp"> <img
					src="../img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png" height="40"
					width="40" alt="Logo" class="me-2"> Welcome From Mesa
				</a>

				<!-- Toggler button -->
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<!-- Navbar links and login -->
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

					<div class="mb-2">
						<i class="bi bi-check-circle-fill success-icon"></i>
					</div>

					<h2 class="fw-bold mb-3">会計依頼を承りました</h2>

					<div class="mb-4">
						<span class="table-badge">Table ${table_id}</span>
					</div>

					<p class="text-muted mb-4">
						従業員が伝票を作成し、テーブルまでお持ちします。<br> 恐れ入りますが、そのままお席でお待ちください。
					</p>

					<hr class="my-4 text-secondary">

					<div class="survey-box mb-4">
						<h5 class="fw-bold text-dark mb-2">
							<i class="bi bi-star-fill text-warning me-2"></i>アンケートでポイントGET！
						</h5>
						<p class="small text-secondary mb-3">
							対象商品をご注文いただいた方は、アンケートへ回答いただくとお得なポイントがたまります。</p>


						<a href="<%=request.getContextPath()%>/login.jsp"
							class="btn btn-outline-dark btn-sm w-100"> <i
							class="bi bi-person-plus me-1"></i>会員登録 / ログインへ
						</a>
						<div class="mt-2 text-center">
							<small class="text-muted">※ログイン後、メニューページより回答可能です</small>
						</div>


						<a href="<%=request.getContextPath()%>/MenuListServlet"
							class="btn btn-warning w-100 text-dark fw-bold"> <i
							class="bi bi-arrow-right-circle me-1"></i>メニューページへ戻る
						</a>

					</div>

					<a href="<%=request.getContextPath()%>/index.jsp"
						class="btn btn-link text-decoration-none text-secondary">
						トップページへ戻る </a>

				</div>
			</div>
		</div>

		<%@ include file="/footer.jsp"%>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>