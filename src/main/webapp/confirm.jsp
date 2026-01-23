<%@ include file="header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Reservation"%>
<%@ page import="model.Menu"%>
<%@ page import="model.Customer"%>
<%@ page import="model.Coupon"%>


<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
Reservation r = (Reservation) session.getAttribute("pendingReservation");
if (r == null || r.getTableIds() == null || r.getTableIds().isEmpty()) {
	response.sendRedirect(request.getContextPath() + "/reserve/form");
	return;
}
%>

<%
Menu course = (Menu) request.getAttribute("course");
%>

<!DOCTYPE html>
<html>
<head>
<title>入力内容確認</title>

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

/* ===== CARD ===== */
.confirm-card {
	max-width: 720px;
	width: 100%;
}

.confirm-row {
	padding: 10px 0;
	border-bottom: 1px solid #eee;
}

.confirm-row:last-child {
	border-bottom: none;
}

.label {
	color: #6c757d;
	font-size: .9rem;
}

.value {
	font-weight: 600;
}
</style>
</head>

<body>

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
					<div class="circle">4</div>
					確認
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">5</div>
					完了
				</div>
			</div>

			<!-- CONFIRM CARD -->
			<div class="card shadow confirm-card p-4 mx-auto">
				<h3 class="fw-bold mb-4 text-center">入力内容確認</h3>

				<div class="confirm-row row">
					<div class="col-4 label">予約日</div>
					<div class="col-8 value"><%=r.getReservationDate()%></div>
				</div>

				<div class="confirm-row row">
					<div class="col-4 label">時間</div>
					<div class="col-8 value">
						<%=r.getStartTime()%>
						-
						<%=r.getEndTime()%>
					</div>
				</div>

				<div class="confirm-row row">
					<div class="col-4 label">人数</div>
					<div class="col-8 value">
						<%=r.getAdultCount() + r.getChildCount()%>
						名
					</div>
				</div>

				<div class="confirm-row row">
					<div class="col-4 label">席</div>
					<div class="col-8 value">
						<%=String.join(" + ", r.getTableIds())%>
					</div>
				</div>

				<!-- ✅ FIXED RESERVATION TYPE -->
				<div class="confirm-row row">
					<div class="col-4 label">予約タイプ</div>
					<div class="col-8 value">
						<%="COURSE".equals(r.getReservationType()) ? "コース予約" : "席のみ"%>
					</div>
				</div>

				<%
				if (course != null) {
				%>
				<div class="confirm-row row">
					<div class="col-4 label">コース</div>
					<div class="col-8 value">
						<%=course.getMenuName()%>（¥<%=course.getPrice()%>）
					</div>
				</div>
				<%
				}
				%>

				<%
				Coupon coupon = (Coupon) session.getAttribute("selectedCoupon");
				if (coupon != null) {
				%>
				<div class="confirm-row row">
					<div class="col-4 label">クーポン</div>
					<div class="col-8 value">
						<%=coupon.getTitle()%>
						（<%=coupon.getDiscountAmount()%>円OFF）
					</div>
				</div>
				<%
}
%>




				<div class="confirm-row row">
					<div class="col-4 label">お名前</div>
					<div class="col-8 value"><%=r.getCustomerName()%></div>
				</div>

				<div class="confirm-row row">
					<div class="col-4 label">メール</div>
					<div class="col-8 value"><%=r.getCustomerEmail()%></div>
				</div>

				<!-- ACTIONS -->
				<div class="d-flex justify-content-between mt-4">
					<a class="btn btn-outline-secondary"
						href="<%=request.getContextPath()%>/reserve/course">戻る</a>

					<form method="post"
						action="<%=request.getContextPath()%>/reserve/complete"
						class="m-0">
						<button class="btn btn-primary px-4">この内容で予約する</button>
					</form>
				</div>

			</div>
		</div>
	</main>

	<%@ include file="footer.jsp"%>
</body>
</html>
c
