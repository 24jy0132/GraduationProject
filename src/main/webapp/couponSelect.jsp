<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="model.Coupon"%>
<%@ page import="model.Reservation"%>
<%@ page import="model.Customer"%>

<%
// 1. DATA & ACCESS CONTROL
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
<title>クーポン選択 | Mesa</title>

<style>
/* =====================
   GLOBAL LAYOUT
===================== */
html, body {
	height: 100%;
}

body {
	margin: 0;
	display: flex;
	flex-direction: column;
	background-color: #f8f9fa;
}

main {
	flex: 1;
	padding: 40px 15px;
}

/* =====================
   STEPPER
===================== */
.stepper {
	display: flex;
	justify-content: center;
	margin-bottom: 40px;
}

.step {
	text-align: center;
	font-size: 0.8rem;
	color: #adb5bd;
	min-width: 60px;
}

.step .circle {
	width: 32px;
	height: 32px;
	background: #e9ecef;
	border-radius: 50%;
	margin: 0 auto 5px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: bold;
	color: #6c757d;
}

.step.active {
	color: #dc3545;
	font-weight: bold;
}

.step.active .circle {
	background: #dc3545;
	color: white;
	box-shadow: 0 0 0 4px rgba(220, 53, 69, 0.2);
}

.step.done .circle {
	background: #198754;
	color: white;
}

.line {
	width: 40px;
	height: 2px;
	background: #dee2e6;
	margin: 15px 5px;
}

/* =====================
   COUPON VISUAL GRID
===================== */
.selection-container {
	max-width: 900px;
	margin: 0 auto;
}

.coupon-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 20px;
	margin-top: 20px;
}

.coupon-item-card {
	border: 2px solid #eee;
	border-radius: 15px;
	overflow: hidden;
	cursor: pointer;
	transition: 0.3s;
	background: white;
	position: relative;
	display: flex;
	flex-direction: column;
}

.coupon-item-card:hover {
	border-color: #dc3545;
	transform: translateY(-3px);
}

.coupon-item-card.selected {
	border-color: #dc3545;
	background-color: #fff5f5;
	box-shadow: 0 5px 15px rgba(220, 53, 69, 0.1);
}

.coupon-img-wrapper {
	height: 160px;
	width: 100%;
	overflow: hidden;
	background: #f0f0f0;
	position: relative;
}

.coupon-img-wrapper img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.no-coupon-icon {
	font-size: 4rem;
	color: #dee2e6;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100%;
}

.coupon-info {
	padding: 15px;
	flex-grow: 1;
}

.coupon-name {
	font-weight: bold;
	font-size: 1.1rem;
	margin-bottom: 5px;
}

.coupon-discount {
	color: #dc3545;
	font-weight: 700;
	font-size: 1.2rem;
}

.selected-badge {
	position: absolute;
	top: 10px;
	right: 10px;
	background: #dc3545;
	color: white;
	padding: 5px 12px;
	border-radius: 20px;
	font-size: 0.8rem;
	display: none;
	z-index: 2;
}

.coupon-item-card.selected .selected-badge {
	display: block;
}

.point-badge {
	position: absolute;
	bottom: 10px;
	left: 10px;
	background: rgba(0, 0, 0, 0.6);
	color: white;
	padding: 2px 8px;
	border-radius: 4px;
	font-size: 0.75rem;
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
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/member_index.jsp"> <i
							class="bi bi-house-fill me-1"></i>Home
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/MenuListServlet"> <i
							class="bi bi-menu-down me-1"></i>Menu
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/contact.jsp"> <i
							class="bi bi-telephone-fill me-1"></i>Contact
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/map.jsp"> <i
							class="bi bi-pin-map-fill me-1"></i>Map
					</a></li>
					<li class="nav-item"><a class="nav-link text-white ms-lg-3"
						href="<%=request.getContextPath()%>/Customer_LogOut"> <i
							class="bi bi-box-arrow-right me-1"></i>LogOut
					</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<main>
		<div class="container">
			<div class="stepper">
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					入力
				</div>
				<div class="line"></div>
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					席選択
				</div>
				<div class="line"></div>
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					コース
				</div>
				<div class="line"></div>
				<div class="step active">
					<div class="circle">4</div>
					クーポン
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">5</div>
					確認
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">6</div>
					完了
				</div>
			</div>

			<div class="selection-container">
				<h3 class="fw-bold text-center mb-4">クーポンを選択してください</h3>

				<form id="couponForm" method="post"
					action="<%=request.getContextPath()%>/reserve/coupon">
					<input type="hidden" name="couponId" id="selectedCouponId" value="">

					<div class="coupon-grid">
						<div class="coupon-item-card selected"
							onclick="pickCoupon('', this)">
							<span class="selected-badge"><i class="bi bi-check-lg"></i>
								選択中</span>
							<div class="coupon-img-wrapper">
								<div class="no-coupon-icon">
									<i class="bi bi-slash-circle"></i>
								</div>
							</div>
							<div class="coupon-info text-center">
								<div class="coupon-name">クーポンを使用しない</div>
								<p class="text-muted small mb-0">通常料金で予約を確定します</p>
							</div>
						</div>

						<%
						if (couponList != null) {
							for (Coupon c : couponList) {
								// Path rearrange: Folder "coupon" is directly under "webapp"
								String imgPath = (c.getImagePath() != null && !c.getImagePath().isEmpty())
								? c.getImagePath()
								: "img/default_food.jpg";
						%>
						<div class="coupon-item-card"
							onclick="pickCoupon('<%=c.getCouponId()%>', this)">
							<span class="selected-badge"><i class="bi bi-check-lg"></i>
								選択中</span>
							<div class="coupon-img-wrapper">
								<img src="<%=request.getContextPath()%>/<%=imgPath%>"
									alt="Coupon"
									onerror="this.src='<%=request.getContextPath()%>/img/default_food.jpg';">
								<span class="point-badge"><%=c.getMinPoint()%> pt 必要</span>
							</div>
							<div class="coupon-info">
								<div class="coupon-name text-truncate"><%=c.getTitle()%></div>
								<div class="coupon-discount">
									¥<%=String.format("%,d", c.getDiscountAmount())%>
									OFF
								</div>
								<p class="small text-muted mt-2 mb-0">保有ポイントから自動引き落とし</p>
							</div>
						</div>
						<%
						}
						}
						%>
					</div>

					<div class="d-flex justify-content-between mt-5 pt-3 border-top">
						<a class="btn btn-outline-secondary px-4 rounded-pill"
							href="javascript:history.back()"> <i class="bi bi-arrow-left"></i>
							戻る
						</a>
						<button type="submit"
							class="btn btn-primary px-5 fw-bold rounded-pill shadow">
							次へ（確認） <i class="bi bi-arrow-right"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<%@ include file="footer.jsp"%>

	<script>
		function pickCoupon(id, element) {
			document.querySelectorAll('.coupon-item-card').forEach(card => card.classList.remove('selected'));
			element.classList.add('selected');
			document.getElementById("selectedCouponId").value = id;
		}
	</script>
</body>
</html>