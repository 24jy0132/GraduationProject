<%@ include file="header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.time.*"%>
<%@ page import="model.Customer"%>
<%@ page import="service.Constants"%>

<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
LocalTime t = Constants.OPEN;

String nameVal = loginCustomer != null ? loginCustomer.getName() : "";
String emailVal = loginCustomer != null ? loginCustomer.getEmail() : "";
boolean readOnly = loginCustomer != null;
%>

<!DOCTYPE html>
<html>
<head>
<title>予約入力</title>

<style>
/* =====================
   PAGE LAYOUT
===================== */
html, body {
	height: 100%;
}

body {
	margin: 0;
	display: flex;
	flex-direction: column;
}

/* =====================
   NAV / MAIN / FOOTER
===================== */
main {
	flex: 1; /* fills remaining space */
	display: flex;
	align-items: center; /* vertical center */
	justify-content: center; /* horizontal center */
	padding: 40px 15px;
}

/* =====================
   STEPPER
===================== */
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

/* =====================
   CARD
===================== */
.form-card {
	max-width: 720px;
	width: 100%;
}

.cta-btn {
	font-size: 1.1rem;
	padding: 12px 40px;
}
</style>
</head>

<body>

	<!-- =====================
     NAVBAR (TOP)
===================== -->
	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<a class="navbar-brand fw-bold text-white"
				href="<%=request.getContextPath()%>/index.jsp"> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" alt="Logo" class="me-2"> Welcome From
				Mesa
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

	<!-- =====================
     MAIN (CENTERED FORM)
===================== -->
	<main>

		<div class="container">

			<!-- STEP -->
			<div class="stepper">
				<div class="step active">
					<div class="circle">1</div>
					入力
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">2</div>
					席選択
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">3</div>
					コース
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
			<div class="card shadow form-card p-4 mx-auto">
				<h3 class="fw-bold mb-4">予約入力</h3>

				<form method="post"
					action="<%=request.getContextPath()%>/reserve/input">

					<div class="row g-3">
						<div class="col-md-4">
							<label class="form-label">予約日</label> <input type="date"
								name="date" class="form-control" required>
						</div>

						<div class="col-md-4">
							<label class="form-label">開始時間</label> <select name="startTime"
								class="form-select">
								<%
								while (!t.isAfter(Constants.LAST_START)) {
								%>
								<option value="<%=t%>"><%=t%></option>
								<%
								t = t.plusMinutes(Constants.SLOT_MINUTES);
								}
								%>
							</select>
						</div>

						<div class="col-md-2">
							<label>大人</label> <input type="number" name="adult" min="1"
								value="1" class="form-control">
						</div>

						<div class="col-md-2">
							<label>子ども</label> <input type="number" name="child" min="0"
								value="0" class="form-control">
						</div>
					</div>

					<hr class="my-4">

					<div class="row g-3">
						<div class="col-md-6">
							<label>お客様名</label> <input type="text" name="name"
								class="form-control" value="<%=nameVal%>"
								<%=readOnly ? "readonly" : ""%> required>
						</div>

						<div class="col-md-6">
							<label>メール</label> <input type="email" name="email"
								class="form-control" value="<%=emailVal%>"
								<%=readOnly ? "readonly" : ""%>>
						</div>
					</div>

					<div class="text-end mt-4">
						<button class="btn btn-primary cta-btn">次へ（席選択）</button>
					</div>

				</form>
			</div>
		</div>

	</main>

	<!-- =====================
     FOOTER (BOTTOM)
===================== -->
	<%@ include file="footer.jsp"%>

</body>
</html>
