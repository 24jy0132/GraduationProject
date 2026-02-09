<%@ include file="header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="model.Customer"%>
<%@ page import="service.Constants"%>

<%
// 1. Setup Logic
Customer loginCustomer = (Customer) session.getAttribute("customer");
LocalTime t = Constants.OPEN;

// 2. Pre-fill Data
String nameVal = "";
String emailVal = "";
String phoneVal = ""; // ✅ New Variable
boolean readOnly = false;

if (loginCustomer != null) {
	nameVal = loginCustomer.getName();
	emailVal = loginCustomer.getEmail();
	// Assuming your Customer model has getPhone(). If it's named getTel(), change this.
	// phoneVal = loginCustomer.getPhone(); 
	readOnly = true;
}

// 3. Date Constraints
String todayStr = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
%>

<!DOCTYPE html>
<html>
<head>
<title>予約入力 | Mesa</title>

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

.line {
	width: 40px;
	height: 2px;
	background: #dee2e6;
	margin: 0 5px 20px 5px;
}

/* =====================
   FORM CARD
===================== */
.form-container {
	max-width: 800px;
	margin: 0 auto;
}

.form-card {
	background: white;
	border: 1px solid #dee2e6;
	border-radius: 12px;
	padding: 40px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.section-label {
	font-size: 0.9rem;
	font-weight: 700;
	color: #6c757d;
	margin-bottom: 8px;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.input-group-text {
	background-color: #f8f9fa;
	border-right: none;
}

.form-control, .form-select {
	border-left: none;
	padding-left: 0;
}

.form-control:focus, .form-select:focus {
	box-shadow: none;
	border-color: #dee2e6;
}

.input-group:focus-within {
	box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
	border-radius: 0.375rem;
}

.input-group:focus-within .input-group-text, .input-group:focus-within .form-control,
	.input-group:focus-within .form-select {
	border-color: #dc3545;
}

.readonly-field {
	background-color: #f8f9fa !important;
	color: #6c757d;
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
				height="40" width="40" class="me-1" alt="Logo"> <%
 if (loginCustomer != null) {
 %>
				<div class="d-flex align-items-center gap-2 px-3 py-1 rounded-pill"
					style="background: rgba(255, 255, 255, 0.15);">
					<i class="bi bi-person-circle fs-5"></i> <span
						class="small fw-semibold"><%=loginCustomer.getName()%></span> <span
						class="badge bg-light text-danger fw-bold position-relative"><%=loginCustomer.getPoint()%>
						pt</span>
				</div> <%
 } else {
 %> <span>Welcome From Mesa</span> <%
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
						href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/member_index.jsp">Home</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>

	<main>
		<div class="container">

			<%
			String error = (String) request.getAttribute("error");
			if (error != null) {
			%>
			<div
				class="alert alert-danger d-flex align-items-center shadow-sm mx-auto mb-4"
				style="max-width: 800px;">
				<i class="bi bi-exclamation-triangle-fill fs-4 me-3"></i>
				<div><%=error%></div>
			</div>
			<%
			}
			%>

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

			<div class="form-container">
				<div class="form-card">
					<h3 class="fw-bold mb-4 text-center">ご予約情報の入力</h3>
					<p class="text-muted text-center mb-5 small">ご希望の日時と人数を入力してください。</p>

					<form method="post"
						action="<%=request.getContextPath()%>/reserve/input">

						<div class="row g-4 mb-4">
							<div class="col-md-6">
								<label class="section-label">予約日</label>
								<div class="input-group input-group-lg">
									<span class="input-group-text"><i
										class="bi bi-calendar-event text-danger"></i></span> <input
										type="date" name="date" class="form-control" required
										min="<%=todayStr%>">
								</div>
							</div>
							<div class="col-md-6">
								<label class="section-label">開始時間</label>
								<div class="input-group input-group-lg">
									<span class="input-group-text"><i
										class="bi bi-clock text-danger"></i></span> <select name="startTime"
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
							</div>
						</div>

						<div class="row g-4 mb-4">
							<div class="col-6">
								<label class="section-label">大人</label>
								<div class="input-group input-group-lg">
									<span class="input-group-text"><i
										class="bi bi-person-fill"></i></span> <input type="number"
										name="adult" min="1" value="1" class="form-control"> <span
										class="input-group-text bg-white border-start-0">名</span>
								</div>
							</div>
							<div class="col-6">
								<label class="section-label">子ども</label>
								<div class="input-group input-group-lg">
									<span class="input-group-text"><i
										class="bi bi-emoji-smile"></i></span> <input type="number"
										name="child" min="0" value="0" class="form-control"> <span
										class="input-group-text bg-white border-start-0">名</span>
								</div>
							</div>
						</div>

						<hr class="my-5 text-muted opacity-25">

						<div class="row g-4">

							<div class="col-md-6">
								<label class="section-label d-flex justify-content-between">
									お名前 <%
								if (readOnly) {
								%> <span
									class="badge bg-light text-muted border"><i
										class="bi bi-lock-fill"></i> 会員情報</span> <%
 }
 %>
								</label>
								<div class="input-group input-group-lg">
									<span class="input-group-text <%=readOnly ? "bg-light" : ""%>"><i
										class="bi bi-person-badge"></i></span> <input type="text" name="name"
										class="form-control <%=readOnly ? "readonly-field" : ""%>"
										value="<%=nameVal%>" <%=readOnly ? "readonly" : ""%> required>
								</div>
							</div>

							<div class="col-md-6">
								<label class="section-label d-flex justify-content-between">
									電話番号 <%
								if (readOnly && !phoneVal.isEmpty()) {
								%> <span
									class="badge bg-light text-muted border"><i
										class="bi bi-lock-fill"></i> 会員情報</span> <%
 }
 %>
								</label>
								<div class="input-group input-group-lg">
									<span
										class="input-group-text <%=(readOnly && !phoneVal.isEmpty()) ? "bg-light" : ""%>"><i
										class="bi bi-telephone"></i></span> <input type="tel" name="phone"
										class="form-control <%=(readOnly && !phoneVal.isEmpty()) ? "readonly-field" : ""%>"
										value="<%=phoneVal%>"
										<%=(readOnly && !phoneVal.isEmpty()) ? "readonly" : ""%>
										required placeholder="09012345678">
								</div>
							</div>

							<div class="col-12">
								<label class="section-label d-flex justify-content-between">
									メールアドレス <%
								if (readOnly) {
								%> <span
									class="badge bg-light text-muted border"><i
										class="bi bi-lock-fill"></i> 会員情報</span> <%
 }
 %>
								</label>
								<div class="input-group input-group-lg">
									<span class="input-group-text <%=readOnly ? "bg-light" : ""%>"><i
										class="bi bi-envelope"></i></span> <input type="email" name="email"
										class="form-control <%=readOnly ? "readonly-field" : ""%>"
										value="<%=emailVal%>" <%=readOnly ? "readonly" : ""%> required>
								</div>
							</div>
						</div>

						<div class="text-end mt-5">
							<button
								class="btn btn-primary px-5 py-3 fw-bold rounded-pill shadow">
								次へ（席選択） <i class="bi bi-arrow-right ms-2"></i>
							</button>
						</div>

					</form>
				</div>
			</div>
		</div>
	</main>

	<%@ include file="footer.jsp"%>

</body>
</html>