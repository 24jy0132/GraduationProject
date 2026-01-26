<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="model.Coupon"%>
<%@ page import="model.Reservation"%>
<%@ page import="model.Customer"%>

<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
Reservation r = (Reservation) session.getAttribute("pendingReservation");
List<Coupon> couponList = (List<Coupon>) request.getAttribute("couponList");

if (loginCustomer == null || r == null) {
	response.sendRedirect(request.getContextPath() + "/reserve/form");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Coupon Selection</title>

<style>
html, body {
	height: 100%;
}

body {
	margin: 0;
	display: flex;
	flex-direction: column;
}

main {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 40px 15px;
}

/* ===== STEPPER ===== */
.stepper {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 30px;
}

.step {
	text-align: center;
	color: #adb5bd;
}

.step .circle {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	background: #dee2e6;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: auto;
	font-weight: bold;
}

.step.done .circle {
	background: #198754;
	color: #fff;
}

.step.active {
	color: #0d6efd;
}

.step.active .circle {
	background: #0d6efd;
	color: #fff;
	box-shadow: 0 0 0 6px rgba(13, 110, 253, .15);
}

.line {
	width: 60px;
	height: 4px;
	background: #dee2e6;
	margin: 0 12px;
}

/* ===== COUPON CARD ===== */
.coupon-card {
	border: 2px solid #dee2e6;
	border-radius: 14px;
	padding: 20px;
	cursor: pointer;
	transition: .2s;
}

.coupon-card:hover {
	transform: translateY(-3px);
}

.coupon-card.active {
	border-color: #0d6efd;
	background: #f8f9ff;
}

.coupon-title {
	font-weight: 700;
}

.coupon-price {
	color: #dc3545;
	font-size: 1.2rem;
	font-weight: bold;
}
</style>
</head>

<body>

	<!-- ===== NAVBAR ===== -->
	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<a class="navbar-brand fw-bold text-white"
				href="<%=request.getContextPath()%>/index.jsp"> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" class="me-2"> Welcome From Mesa
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

	<!-- ===== MAIN ===== -->
	<main>
		<div class="container">

			<!-- STEPPER -->
			<div class="stepper">
				<div class="step done">
					<div class="circle">1</div>
					入力
				</div>
				<div class="line"></div>
				<div class="step done">
					<div class="circle">2</div>
					席選択
				</div>
				<div class="line"></div>
				<div class="step done">
					<div class="circle">3</div>
					コース
				</div>
				<div class="line"></div>
				<div class="step active">
					<div class="circle">3</div>
					クーポン
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">4</div>
					確認
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">5</div>
					完了
				</div>
			</div>

			<!-- CARD -->
			<div class="card shadow p-4 mx-auto" style="max-width: 760px;">
				<h3 class="fw-bold text-center mb-4">クーポンを選択してください</h3>

				<form method="post"
					action="<%=request.getContextPath()%>/reserve/coupon">

					<!-- NO COUPON -->
					<div class="coupon-card active mb-3"
						onclick="selectCoupon(this,'')">
						<div class="coupon-title">クーポンを使用しない</div>
						<p class="text-muted mb-0">通常料金で予約します</p>
					</div>

					<!-- COUPON LIST -->
					<%
					if (couponList != null && !couponList.isEmpty()) {
						for (Coupon c : couponList) {
					%>
					<div class="coupon-card mb-3"
						onclick="selectCoupon(this,'<%=c.getCouponId()%>')">
						<div class="coupon-title"><%=c.getTitle()%></div>
						<div class="coupon-price">
							¥<%=c.getDiscountAmount()%>
							OFF
						</div>
						<small class="text-muted"> 必要ポイント: <%=c.getMinPoint()%> pt
						</small>
					</div>
					<%
					}
					}
					%>

					<input type="hidden" name="couponId" id="couponId" value="">

					<div class="text-end mt-4">
						<button class="btn btn-primary px-4">次へ（確認）</button>
					</div>

				</form>
			</div>

		</div>
	</main>

	<%@ include file="footer.jsp"%>

	<script>
function selectCoupon(card, id) {
    document.querySelectorAll('.coupon-card')
        .forEach(c => c.classList.remove('active'));
    card.classList.add('active');
    document.getElementById('couponId').value = id;
}
</script>

</body>
</html>
