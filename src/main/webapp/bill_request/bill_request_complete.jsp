<%@ include file="/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>会計依頼完了</title>
</head>
<body>

	<div class="container-fluid">
		<!-- Navbar -->
		<nav class="navbar navbar-expand-lg bg-danger py-3">
			<div class="container">
				<!-- Brand -->
				<a class="navbar-brand fw-bold text-white" href="index.jsp"> <img
					src="${pageContext.request.contextPath}/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
					height="40" width="40" alt="Logo" class="me-2"> Welcome From
					Mesa
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

					<!-- Login link -->
					<a class="nav-link active text-white fw-bold ms-lg-3 mt-2 mt-lg-0"
						href="login.jsp"> <i class="bi bi-box-arrow-in-right me-1"></i>Login
					</a>
				</div>
			</div>
		</nav>

		<div>
			<img
				src="${pageContext.request.contextPath}/img/mesa_cash_register.jpg"
				alt="map" title="map" width="100%" height="200">

		</div>

		<div>
			<h3>会計依頼が完了しました！</h3>
			<p>
				テーブル番号 <strong>${table_id}</strong> の会計依頼を受け付けました。
			</p>
			<p>従業員が伝票を作成し、テーブルまでお持ちします。受領後は速やかな会計にご協力ください。</p>
			<p>また対象商品をご注文いただいた方は、お得なポイントがたまるアンケートへ回答いただけますと幸いです。</p>
			<p><a href="<%=request.getContextPath()%>/login.jsp">会員登録/ログイン</a>>後、メニューページ内からお願いいたします。</p>

		</div>

		<%@ include file="/footer.jsp"%>
	</div>

</body>

</html>