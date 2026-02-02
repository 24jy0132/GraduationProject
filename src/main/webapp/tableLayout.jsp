<%@ include file="header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="model.Reservation"%>
<%@ page import="model.Customer"%>

<%
// 1. Session & Access Control
Customer loginCustomer = (Customer) session.getAttribute("customer");
Reservation r = (Reservation) session.getAttribute("pendingReservation");

// Redirect if flow is broken
if (r == null) {
	response.sendRedirect(request.getContextPath() + "/reserve/form");
	return;
}

// 2. Data for Map
Set<String> available = (Set<String>) request.getAttribute("availableTables");
String[] candidate = (String[]) request.getAttribute("candidateTables");
String error = (String) request.getAttribute("error");

// Convert candidate array to set for easier lookup
Set<String> candidateSet = new HashSet<>();
if (candidate != null) {
	candidateSet.addAll(Arrays.asList(candidate));
} else {
	// Fallback to prevent null pointer if attribute missing
	candidateSet = new HashSet<>();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>席選択 | Mesa</title>

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
   CARD CONTAINER
===================== */
.map-card {
	max-width: 900px; /* Wider for the map */
	width: 100%;
	background: white;
	border: 1px solid #dee2e6;
	border-radius: 12px;
	padding: 30px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	margin: 0 auto;
}

/* =====================
   RESTAURANT MAP CSS
===================== */
.floor-container {
	overflow-x: auto; /* Scroll if screen is too small */
	display: flex;
	justify-content: center;
	padding: 20px 0;
	border: 1px solid #f0f0f0;
	border-radius: 8px;
	background: #fafafa;
}

.restaurant-map {
	position: relative;
	width: 800px;
	min-width: 800px;
	height: 550px;
	background-color: #eaddcf;
	background-image: repeating-linear-gradient(90deg, transparent 0, transparent 1px, rgba(160
		, 82, 45, 0.1) 1px, rgba(160, 82, 45, 0.1) 20px);
	border: 8px solid #4e342e;
	border-radius: 8px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

/* Infrastructure */
.kitchen {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 90px;
	background: #cfd8dc;
	border-bottom: 4px solid #4e342e;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #546e7a;
	font-weight: bold;
	letter-spacing: 5px;
	font-size: 18px;
}

.kitchen-pass {
	position: absolute;
	bottom: -8px;
	left: 20%;
	width: 60%;
	height: 8px;
	background: #8d6e63;
	border-radius: 0 0 4px 4px;
}

.entrance {
	position: absolute;
	bottom: -8px;
	left: 40%;
	width: 20%;
	height: 8px;
	background: #eaddcf;
	border-left: 4px solid #4e342e;
	border-right: 4px solid #4e342e;
}

.entrance::after {
	content: "ENTRANCE";
	display: block;
	margin-top: 10px;
	text-align: center;
	font-size: 10px;
	font-weight: bold;
	color: #4e342e;
}

.cashier {
	position: absolute;
	bottom: 30px;
	left: 300px;
	width: 60px;
	height: 30px;
	background: #5d4037;
	border-radius: 3px;
	color: white;
	font-size: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.cashier::before {
	content: "Cashier";
}

.restroom {
	position: absolute;
	top: 0;
	right: 0;
	width: 80px;
	height: 90px;
	background: #eceff1;
	border-left: 4px solid #4e342e;
	border-bottom: 4px solid #4e342e;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #78909c;
	font-size: 20px;
	z-index: 5;
}

/* Labels */
.floor-label {
	position: absolute;
	font-size: 11px;
	text-transform: uppercase;
	color: #8d6e63;
	font-weight: bold;
	border-bottom: 1px dashed #8d6e63;
	padding-bottom: 2px;
}

/* Tables */
.table-unit {
	position: absolute;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: 0.2s;
	z-index: 10;
}

.table-unit:hover {
	transform: scale(1.05);
	z-index: 20;
}

.table-surface {
	background: #fff8e1;
	border: 2px solid #8d6e63;
	border-radius: 4px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: bold;
	color: #5d4037;
	font-size: 13px;
	box-shadow: 0 3px 6px rgba(0, 0, 0, 0.15);
}

.size-2 {
	width: 50px;
	height: 50px;
	border-radius: 50%;
}

.size-4 {
	width: 80px;
	height: 60px;
}

.size-6 {
	width: 100px;
	height: 70px;
}

.chair {
	width: 20px;
	height: 10px;
	background: #3e2723;
	border-radius: 3px;
}

.chair-row {
	display: flex;
	gap: 8px;
}

.top-row .chair {
	margin-bottom: -3px;
}

.btm-row .chair {
	margin-top: -3px;
}

.left-chair {
	position: absolute;
	left: -8px;
	width: 10px;
	height: 20px;
	margin: auto;
	top: 0;
	bottom: 0;
}

.right-chair {
	position: absolute;
	right: -8px;
	width: 10px;
	height: 20px;
	margin: auto;
	top: 0;
	bottom: 0;
}

/* Status Classes */
.seat-free .table-surface {
	background: #fff8e1;
}

.seat-full {
	opacity: 0.5;
	cursor: not-allowed;
}

.seat-full .table-surface {
	background: #ffcdd2;
	border-color: #c62828;
	color: #c62828;
}

.seat-full .chair {
	background: #ef9a9a;
}

.seat-disabled {
	opacity: 0.2;
	pointer-events: none;
	filter: grayscale(100%);
}

.seat-selected .table-surface {
	background: #0d6efd;
	border-color: #004085;
	color: white;
	box-shadow: 0 0 15px rgba(13, 110, 253, 0.6);
}

.seat-selected .chair {
	background: #004085;
}

/* Coordinates */
.pos-A1 {
	top: 150px;
	left: 60px;
}

.pos-A2 {
	top: 300px;
	left: 60px;
}

.pos-T1 {
	top: 150px;
	left: 280px;
}

.pos-T2 {
	top: 150px;
	left: 450px;
}

.pos-T3 {
	top: 300px;
	left: 280px;
}

.pos-T4 {
	top: 300px;
	left: 450px;
}

.pos-Z1 {
	top: 120px;
	right: 50px;
}

.pos-Z2 {
	top: 220px;
	right: 50px;
}

.pos-Z3 {
	top: 320px;
	right: 50px;
}

.pos-Z4 {
	top: 420px;
	right: 50px;
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
				height="40" width="40" class="me-1" alt="Logo"> Welcome From Mesa<%
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
				<div class="step active">
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


			<div class="map-card shadow">

				<div
					class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4 pb-3 border-bottom">
					<div class="mb-3 mb-md-0">
						<h4 class="fw-bold m-0">座席を選択してください</h4>
						<p class="text-muted small m-0 mt-1">
							<i class="bi bi-calendar"></i>
							<%=r.getReservationDate()%>
							<%=r.getStartTime()%>
							<span class="mx-2">|</span> <i class="bi bi-people"></i>
							<%=r.getAdultCount() + r.getChildCount()%>名様
						</p>
					</div>

					<div class="d-flex gap-3">
						<div class="d-flex align-items-center gap-2 small">
							<div
								style="width: 15px; height: 15px; border: 1px solid #6c757d; background: #fff8e1; border-radius: 3px;"></div>
							予約可
						</div>
						<div class="d-flex align-items-center gap-2 small">
							<div
								style="width: 15px; height: 15px; background: #0d6efd; border-radius: 3px;"></div>
							選択
						</div>
						<div class="d-flex align-items-center gap-2 small">
							<div
								style="width: 15px; height: 15px; background: #ffcdd2; border: 1px solid #c62828; border-radius: 3px;"></div>
							満席
						</div>
						<div class="d-flex align-items-center gap-2 small">
							<div
								style="width: 15px; height: 15px; background: #eee; border: 1px solid #ccc; border-radius: 3px;"></div>
							不可(人数)
						</div>
					</div>
				</div>

				<%
				String globalError = (String) request.getAttribute("globalError");
				if (globalError != null) {
				%>
				<div class="alert alert-warning text-center fw-bold mb-3">
					<i class="bi bi-exclamation-triangle"></i>
					<%=globalError%>
				</div>
				<%
				}
				%>

				<form method="post"
					action="<%=request.getContextPath()%>/reserve/table" id="tableForm">
					<input type="hidden" name="tableId" id="tableId">

					<div class="floor-container">
						<div class="restaurant-map">

							<div class="kitchen">
								KITCHEN
								<div class="kitchen-pass"></div>
							</div>
							<div class="restroom">
								<i class="bi bi-gender-ambiguous"></i>
							</div>
							<div class="entrance"></div>
							<div class="cashier"></div>

							<div class="floor-label" style="top: 110px; left: 50px;">窓側
								(2名)</div>
							<div class="floor-label" style="top: 110px; left: 350px;">テーブル
								(4名)</div>
							<div class="floor-label" style="top: 100px; right: 50px;">ボックス
								(6名)</div>

							<%-- A Tables (2 Person) --%>
							<%
							for (String tid : new String[]{"A1", "A2"}) {
								boolean can = candidateSet.contains(tid);
								boolean free = available != null && available.contains(tid);
								String cls = !can ? "seat-disabled" : (free ? "seat-free" : "seat-full");
							%>
							<div class="table-unit pos-<%=tid%> <%=cls%>" data-id="<%=tid%>"
								data-can="<%=can%>" data-free="<%=free%>">
								<div class="chair" style="margin-bottom: 2px"></div>
								<div class="table-surface size-2"><%=tid%></div>
								<div class="chair" style="margin-top: 2px"></div>
							</div>
							<%
							}
							%>

							<%-- T Tables (4 Person) --%>
							<%
							for (String tid : new String[]{"T1", "T2", "T3", "T4"}) {
								boolean can = candidateSet.contains(tid);
								boolean free = available != null && available.contains(tid);
								String cls = !can ? "seat-disabled" : (free ? "seat-free" : "seat-full");
							%>
							<div class="table-unit pos-<%=tid%> <%=cls%>" data-id="<%=tid%>"
								data-can="<%=can%>" data-free="<%=free%>">
								<div class="chair-row top-row">
									<div class="chair"></div>
									<div class="chair"></div>
								</div>
								<div class="table-surface size-4"><%=tid%></div>
								<div class="chair-row btm-row">
									<div class="chair"></div>
									<div class="chair"></div>
								</div>
							</div>
							<%
							}
							%>

							<%-- Z Tables (6 Person) --%>
							<%
							for (String tid : new String[]{"Z1", "Z2", "Z3", "Z4"}) {
								boolean can = candidateSet.contains(tid);
								boolean free = available != null && available.contains(tid);
								String cls = !can ? "seat-disabled" : (free ? "seat-free" : "seat-full");
							%>
							<div class="table-unit pos-<%=tid%> <%=cls%>" data-id="<%=tid%>"
								data-can="<%=can%>" data-free="<%=free%>">
								<div class="chair left-chair" style="height: 40px"></div>
								<div class="table-surface size-6"><%=tid%></div>
								<div class="chair right-chair" style="height: 40px"></div>
							</div>
							<%
							}
							%>

						</div>
					</div>

					<div class="d-flex justify-content-between mt-4 pt-2">
						<a class="btn btn-outline-secondary px-4 rounded-pill"
							href="<%=request.getContextPath()%>/reserveForm.jsp"> <i
							class="bi bi-arrow-left"></i> 戻る
						</a>
						<button type="submit"
							class="btn btn-primary px-5 fw-bold rounded-pill shadow"
							id="nextBtn" disabled>
							この席にする <i class="bi bi-check-lg"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<%@ include file="footer.jsp"%>

	<script>
    // Simple logic to handle table selection highlighting
    document.querySelectorAll(".table-unit").forEach(el => {
      el.addEventListener("click", () => {
        const can = el.dataset.can === "true";
        const free = el.dataset.free === "true";
        
        // Ignore clicks if table is full or not suitable for party size
        if(!can || !free) return;

        // Deselect others
        document.querySelectorAll(".table-unit").forEach(x => x.classList.remove("seat-selected"));
        
        // Select clicked
        el.classList.add("seat-selected");
        
        // Update hidden input and enable button
        document.getElementById("tableId").value = el.dataset.id;
        document.getElementById("nextBtn").disabled = false;
      });
    });
    </script>
</body>
</html>