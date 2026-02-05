<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="model.Reservation"%>
<%@ page import="model.Menu"%>
<%@ page import="model.Customer"%>
<%@ page import="model.Coupon"%>

<%
// 1. Session Access & Security
Customer loginCustomer = (Customer) session.getAttribute("customer");
Reservation r = (Reservation) session.getAttribute("pendingReservation");

// Redirect if session expired or flow broken
if (r == null || r.getTableIds() == null || r.getTableIds().isEmpty()) {
	response.sendRedirect(request.getContextPath() + "/reserve/form");
	return;
}

// 2. Retrieve Data (Course and Coupon should be in session or request by now)
// Assuming Course is stored in session for the flow, or retrieved via ID
Menu course = (Menu) session.getAttribute("selectedCourse");
// Fallback if course is passed via request in previous servlet
if (course == null)
	course = (Menu) request.getAttribute("course");

Coupon coupon = (Coupon) session.getAttribute("selectedCoupon");

// 3. Calculations
int totalPeople = r.getAdultCount() + r.getChildCount();

// Financials
int unitPrice = (course != null) ? course.getPrice() : 0;
int subTotal = unitPrice * totalPeople;

int couponDiscount = (coupon != null) ? coupon.getDiscountAmount() : 0;
int usedPoints = (r.getUsedPoint() != null) ? r.getUsedPoint() : 0;

// Calculate final payment (ensure it doesn't go below 0)
int totalPayment = subTotal - couponDiscount - usedPoints;
if (totalPayment < 0)
	totalPayment = 0;

// Point Balance Logic
int currentPoints = (loginCustomer != null) ? loginCustomer.getPoint() : 0;
int remainingPoints = currentPoints - usedPoints;
%>

<!DOCTYPE html>
<html>
<head>
<title>予約内容確認 | Mesa</title>

<style>
/* =====================
   GLOBAL LAYOUT (Matched)
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
	padding: 30px 15px;
}

/* =====================
   STEPPER (Matched)
===================== */
.stepper {
	display: flex;
	justify-content: center;
	margin-bottom: 40px;
	position: relative;
}

.step {
	text-align: center;
	font-size: 0.8rem;
	color: #adb5bd;
	position: relative;
	z-index: 1;
	width: 60px;
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

.stepper::before {
	content: '';
	position: absolute;
	top: 16px;
	left: 50%;
	transform: translateX(-50%);
	width: 300px;
	height: 2px;
	background: #e9ecef;
	z-index: 0;
}

/* =====================
   CONFIRMATION CARD
===================== */
.confirm-container {
	max-width: 800px;
	margin: 0 auto;
}

.summary-card {
	background: white;
	border: 1px solid #dee2e6;
	border-radius: 12px;
	padding: 0; /* Header/Body split */
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.card-header-custom {
	background-color: #fff;
	padding: 25px 25px 15px;
	border-bottom: 1px solid #f0f0f0;
	text-align: center;
}

.card-body-custom {
	padding: 25px;
}

/* Rows */
.summary-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 0;
	border-bottom: 1px solid #f8f9fa;
}

.summary-row:last-child {
	border-bottom: none;
}

.label {
	color: #6c757d;
	font-size: 0.95rem;
	font-weight: 500;
	display: flex;
	align-items: center;
	gap: 8px;
}

.value {
	font-weight: 600;
	color: #212529;
	text-align: right;
}

/* Sections */
.section-title {
	font-size: 0.85rem;
	text-transform: uppercase;
	letter-spacing: 1px;
	color: #adb5bd;
	font-weight: 700;
	margin-bottom: 15px;
	margin-top: 10px;
}

/* Price Highlights */
.price-breakdown {
	background-color: #f8f9fa;
	border-radius: 8px;
	padding: 20px;
	margin-top: 20px;
}

.discount-text {
	color: #198754;
}

.points-text {
	color: #dc3545;
}

.total-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 15px;
	padding-top: 15px;
	border-top: 2px solid #dee2e6;
}

.total-label {
	font-size: 1.2rem;
	font-weight: 700;
}

.total-price {
	font-size: 1.8rem;
	font-weight: 800;
	color: #dc3545;
}

/* User Info Box */
.user-info-box {
	border: 1px dashed #dee2e6;
	background: #fff;
	border-radius: 8px;
	padding: 15px;
	margin-top: 20px;
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
						href="<%=request.getContextPath()%>/member_index.jsp"><i
							class="bi bi-house-fill me-1"></i>Home</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/MenuListServlet"><i
							class="bi bi-menu-down me-1"></i>Menu</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/contact.jsp"><i
							class="bi bi-telephone-fill me-1"></i>Contact</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/map.jsp"><i
							class="bi bi-pin-map-fill me-1"></i>Map</a></li>
					<li class="nav-item"><a class="nav-link text-white ms-lg-3"
						href="<%=request.getContextPath()%>/Customer_LogOut"><i
							class="bi bi-box-arrow-right me-1"></i>LogOut</a></li>
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
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					席選択
				</div>
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					コース
				</div>
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					クーポン
				</div>
				<div class="step active">
					<div class="circle">5</div>
					確認
				</div>
				<div class="step">
					<div class="circle">6</div>
					完了
				</div>
			</div>

			<div class="confirm-container">

				<form method="post"
					action="<%=request.getContextPath()%>/reserve/complete">

					<div class="summary-card">
						<div class="card-header-custom">
							<h3 class="fw-bold m-0">ご予約内容の最終確認</h3>
							<p class="text-muted small m-0 mt-2">
								以下の内容で間違いがなければ「予約を確定する」を押してください。</p>
						</div>

						<div class="card-body-custom">

							<div class="section-title">日時・人数</div>
							<div class="summary-row">
								<div class="label">
									<i class="bi bi-calendar-event"></i> ご予約日
								</div>
								<div class="value"><%=r.getReservationDate()%></div>
							</div>
							<div class="summary-row">
								<div class="label">
									<i class="bi bi-clock"></i> 時間
								</div>
								<div class="value"><%=r.getStartTime()%>
									-
									<%=r.getEndTime()%></div>
							</div>
							<div class="summary-row">
								<div class="label">
									<i class="bi bi-people"></i> 人数
								</div>
								<div class="value"><%=totalPeople%>
									名様
								</div>
							</div>
							<div class="summary-row">
								<div class="label">
									<i class="bi bi-shop"></i> お席
								</div>
								<div class="value"><%=String.join(", ", r.getTableIds())%></div>
							</div>

							<div class="section-title mt-4">選択メニュー</div>
							<%
							if (course != null) {
							%>
							<div class="summary-row">
								<div class="label">
									<i class="bi bi-journal-bookmark"></i> コース
								</div>
								<div class="value">
									<%=course.getMenuName()%><br> <span
										class="small text-muted">¥<%=String.format("%,d", course.getPrice())%>
										/ 1名
									</span>
								</div>
							</div>
							<%
							} else {
							%>
							<div class="summary-row">
								<div class="label">予約タイプ</div>
								<div class="value">席のみ予約</div>
							</div>
							<%
							}
							%>

							<%
							if (coupon != null) {
							%>
							<div class="summary-row">
								<div class="label text-success">
									<i class="bi bi-ticket-perforated-fill"></i> クーポン適用
								</div>
								<div class="value text-success fw-bold"><%=coupon.getTitle()%></div>
							</div>
							<%
							}
							%>

							<div class="price-breakdown">
								<div class="summary-row">
									<div class="label">小計</div>
									<div class="value">
										¥<%=String.format("%,d", subTotal)%></div>
								</div>

								<%
								if (couponDiscount > 0) {
								%>
								<div class="summary-row">
									<div class="label">クーポン割引</div>
									<div class="value discount-text">
										- ¥<%=String.format("%,d", couponDiscount)%></div>
								</div>
								<%
								}
								%>

								<%
								if (usedPoints > 0) {
								%>
								<div class="summary-row">
									<div class="label">ポイント利用</div>
									<div class="value points-text">
										-
										<%=String.format("%,d", usedPoints)%>
										pt
									</div>
								</div>
								<%
								}
								%>

								<div class="total-row">
									<div class="total-label">お支払い予定額</div>
									<div class="total-price">
										¥<%=String.format("%,d", totalPayment)%>
									</div>
								</div>
								<div class="text-end mt-1">
									<span class="badge bg-light text-secondary border">現地決済</span>
								</div>
							</div>

							<%
							if (loginCustomer != null) {
							%>
							<div
								class="user-info-box d-flex justify-content-between align-items-center">
								<div class="small text-muted">
									<i class="bi bi-wallet2"></i> ポイント残高推移
								</div>
								<div class="small fw-bold">
									<%=currentPoints%>
									pt <i class="bi bi-arrow-right mx-1 text-muted"></i>
									<%=remainingPoints%>
									pt
								</div>
							</div>
							<%
							}
							%>

							<div class="section-title mt-4">ご予約者様情報</div>
							<div class="summary-row">
								<div class="label">お名前</div>
								<div class="value"><%=r.getCustomerName()%>
									様
								</div>
							</div>
							<div class="summary-row">
								<div class="label">メールアドレス</div>
								<div class="value"><%=r.getCustomerEmail()%></div>
							</div>

						</div>
					</div>

					<div class="d-flex justify-content-between mt-5 pt-3 border-top">
						<a class="btn btn-outline-secondary px-4 rounded-pill"
							href="javascript:history.back()"> <i class="bi bi-arrow-left"></i>
							戻る
						</a>
						<button type="submit"
							class="btn btn-primary px-5 py-3 fw-bold rounded-pill shadow fs-5">
							この内容で予約する <i class="bi bi-check-lg"></i>
						</button>
					</div>

				</form>
			</div>

		</div>
	</main>

	<%@ include file="footer.jsp"%>

</body>
</html>