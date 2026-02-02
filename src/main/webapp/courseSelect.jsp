<%@ include file="header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="model.Menu"%>
<%@ page import="model.Reservation"%>
<%@ page import="model.Customer"%>

<%
// 1. Session & Access Control
Customer loginCustomer = (Customer) session.getAttribute("customer");
Reservation r = (Reservation) session.getAttribute("pendingReservation");
List<Menu> courses = (List<Menu>) request.getAttribute("courses");

// Redirect if flow is broken
if (r == null || r.getTableIds() == null || r.getTableIds().isEmpty()) {
	response.sendRedirect(request.getContextPath() + "/reserve/form");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>コース選択 | Mesa</title>

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
	position: relative;
	width: 100%;
}

.step {
	text-align: center;
	font-size: 0.8rem;
	color: #adb5bd;
	position: relative;
	z-index: 1;
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
	margin: 0 5px 20px 5px;
}

/* =====================
   SELECTION CARDS
===================== */
.selection-container {
	max-width: 800px;
	margin: 0 auto;
}

.option-card {
	background: white;
	border: 2px solid #dee2e6;
	border-radius: 12px;
	padding: 30px 20px;
	cursor: pointer;
	transition: all 0.2s ease;
	height: 100%;
	text-align: center;
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.option-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
	border-color: #ced4da;
}

.option-card.active {
	border-color: #dc3545;
	background-color: #fff5f5;
	color: #a71d2a;
}

.option-card i.icon-main {
	font-size: 3.5rem;
	margin-bottom: 15px;
	color: #adb5bd;
	transition: color 0.3s;
}

.option-card.active i.icon-main {
	color: #dc3545;
}

.check-mark {
	position: absolute;
	top: 15px;
	right: 15px;
	font-size: 1.5rem;
	color: #dee2e6;
	transition: color 0.3s;
}

.option-card.active .check-mark {
	color: #dc3545;
}

/* Course Dropdown Section */
#courseDetails {
	display: none; /* Hidden by default */
	background: white;
	border-radius: 12px;
	padding: 30px;
	margin-top: 20px;
	border: 1px solid #dee2e6;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	animation: slideDown 0.3s ease-out;
}

@
keyframes slideDown {from { opacity:0;
	transform: translateY(-10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
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
					if (loginCustomer != null) {
					%>
					<li class="nav-item"><a class="nav-link text-white ms-lg-3"
						href="<%=request.getContextPath()%>/Customer_LogOut"><i
							class="bi bi-box-arrow-right me-1"></i>LogOut</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a
						class="nav-link active text-white fw-bold ms-lg-3"
						href="<%=request.getContextPath()%>/login.jsp"><i
							class="bi bi-box-arrow-in-right me-1"></i>Login</a></li>
					<%
					}
					%>
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
				<div class="step active">
					<div class="circle">3</div>
					コース
				</div>
				<div class="line"></div>

				<%
				if (loginCustomer != null) {
				%>
				<div class="step">
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
				<%
				} else {
				%>
				<div class="step">
					<div class="circle">4</div>
					確認
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">5</div>
					完了
				</div>
				<%
				}
				%>
			</div>

			<form method="post"
				action="<%=request.getContextPath()%>/reserve/course">
				<input type="hidden" name="reservationType" id="type"
					value="SEAT_ONLY">

				<div class="selection-container">
					<h3 class="fw-bold text-center mb-4">予約タイプを選択してください</h3>

					<div class="row g-4">
						<div class="col-md-6">
							<div id="cardSeat" class="option-card active"
								onclick="selectType('SEAT_ONLY')">
								<i class="bi bi-check-circle-fill check-mark"></i> <i
									class="bi bi-shop icon-main"></i>
								<h4 class="fw-bold">席のみ予約</h4>
								<p class="text-muted mb-0 small">お料理は来店時にご注文ください</p>
							</div>
						</div>

						<div class="col-md-6">
							<div id="cardCourse" class="option-card"
								onclick="selectType('COURSE')">
								<i class="bi bi-check-circle-fill check-mark"></i> <i
									class="bi bi-journal-richtext icon-main"></i>
								<h4 class="fw-bold">コースを予約</h4>
								<p class="text-muted mb-0 small">事前にコース料理を指定します</p>
							</div>
						</div>
					</div>

					<div id="courseDetails">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<h5 class="fw-bold m-0 text-danger">
								<i class="bi bi-ui-checks me-2"></i>コースを選択
							</h5>
							<a href="<%=request.getContextPath()%>/MenuListServlet"
								target="_blank"
								class="btn btn-sm btn-outline-secondary rounded-pill"> <i
								class="bi bi-journal-text me-1"></i>メニュー詳細
							</a>
						</div>

						<select name="courseId" class="form-select form-select-lg">
							<%
							if (courses != null) {
								for (Menu m : courses) {
							%>
							<option value="<%=m.getMenuId()%>">
								<%=m.getMenuName()%>（¥<%=String.format("%,d", m.getPrice())%>）
							</option>
							<%
							}
							}
							%>
						</select>
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

				</div>
			</form>

		</div>
	</main>

	<%@ include file="footer.jsp"%>

	<script>
		function selectType(selectedType) {
			// Update Hidden Input
			document.getElementById("type").value = selectedType;

			// UI References
			const cardSeat = document.getElementById("cardSeat");
			const cardCourse = document.getElementById("cardCourse");
			const courseDetails = document.getElementById("courseDetails");

			// Toggle Classes
			if (selectedType === 'SEAT_ONLY') {
				cardSeat.classList.add("active");
				cardCourse.classList.remove("active");
				courseDetails.style.display = "none";
			} else {
				cardCourse.classList.add("active");
				cardSeat.classList.remove("active");
				courseDetails.style.display = "block";
			}
		}
	</script>

</body>
</html>