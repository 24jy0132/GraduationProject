<%@ include file="header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="model.Reservation"%>
<%@ page import="model.Customer"%>
<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>
<%
Reservation r = (Reservation) session.getAttribute("pendingReservation");
if (r == null) {
	response.sendRedirect(request.getContextPath() + "/reserve/form");
	return;
}

Set<String> available = (Set<String>) request.getAttribute("availableTables");
String[] candidate = (String[]) request.getAttribute("candidateTables");
String error = (String) request.getAttribute("error");

Map<String, Integer> capacity = new HashMap<>();
capacity.put("A1", 2);
capacity.put("A2", 2);
capacity.put("T1", 4);
capacity.put("T2", 4);
capacity.put("T3", 4);
capacity.put("T4", 4);
capacity.put("Z1", 6);
capacity.put("Z2", 6);
capacity.put("Z3", 6);
capacity.put("Z4", 6);

Set<String> candidateSet = new HashSet<>(Arrays.asList(candidate));
%>

<!DOCTYPE html>
<html>
<head>
<title>席選択</title>

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
   MAIN CENTER
===================== */
main {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
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

/* =====================
   TABLE UI (UNCHANGED)
===================== */
.table-seat {
	width: 110px;
	height: 75px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 700;
	cursor: pointer;
	user-select: none;
	border: 2px solid transparent;
}

.seat-free {
	background: #e9ecef;
	color: #111;
}

.seat-full {
	background: #dc3545;
	color: #fff;
	cursor: not-allowed;
	opacity: .85;
}

.seat-disabled {
	background: #adb5bd;
	color: #fff;
	cursor: not-allowed;
	opacity: .7;
}

.seat-selected {
	background: #0d6efd;
	color: #fff;
	border-color: #0b5ed7;
}

.legend-dot {
	width: 12px;
	height: 12px;
	border-radius: 50%;
	display: inline-block;
	margin-right: 6px;
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

	<!-- =====================
     MAIN (CENTERED)
===================== -->
	<main>

		<div class="container">

			<!-- STEP INDICATOR -->
			<div class="stepper">
				<div class="step done">
					<div class="circle">1</div>
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

			<!-- INFO -->
			<div class="text-center mb-3 text-muted">
				日付: <b><%=r.getReservationDate()%></b> 時間: <b><%=r.getStartTime()%>
					- <%=r.getEndTime()%></b> 人数: <b><%=r.getAdultCount() + r.getChildCount()%></b>
			</div>

			<!-- LEGEND -->
			<div class="d-flex justify-content-center gap-4 mb-3">
				<div>
					<span class="legend-dot" style="background: #e9ecef;"></span>予約可
				</div>
				<div>
					<span class="legend-dot" style="background: #dc3545;"></span>満席
				</div>
				<div>
					<span class="legend-dot" style="background: #adb5bd;"></span>対象外
				</div>
				<div>
					<span class="legend-dot" style="background: #0d6efd;"></span>選択中
				</div>
			</div>

			<%
			if (error != null) {
			%>
			<div class="alert alert-danger text-center"><%=error%></div>
			<%
			}
			%>

			<!-- TABLE CARD -->
			<form method="post"
				action="<%=request.getContextPath()%>/reserve/table" id="tableForm">
				<input type="hidden" name="tableId" id="tableId">

				<div class="card p-4 shadow-sm mx-auto" style="max-width: 900px;">

					<div class="row g-4 justify-content-center">

						<!-- 2 seats -->
						<div class="col-12">
							<h5 class="fw-bold">2名席</h5>
							<div class="d-flex gap-3 flex-wrap justify-content-center">
								<%
								for (String tid : new String[]{"A1", "A2"}) {
									boolean isCandidate = candidateSet.contains(tid);
									boolean isFree = available.contains(tid);
									String cls = !isCandidate ? "seat-disabled" : (isFree ? "seat-free" : "seat-full");
								%>
								<div class="table-seat <%=cls%>" data-id="<%=tid%>"
									data-can="<%=isCandidate%>" data-free="<%=isFree%>">
									<div class="text-center">
										<div><%=tid%></div>
										<small>~<%=capacity.get(tid)%>名
										</small>
									</div>
								</div>
								<%
								}
								%>
							</div>
						</div>

						<!-- 4 seats -->
						<div class="col-12">
							<h5 class="fw-bold">4名席</h5>
							<div class="d-flex gap-3 flex-wrap justify-content-center">
								<%
								for (String tid : new String[]{"T1", "T2", "T3", "T4"}) {
									boolean isCandidate = candidateSet.contains(tid);
									boolean isFree = available.contains(tid);
									String cls = !isCandidate ? "seat-disabled" : (isFree ? "seat-free" : "seat-full");
								%>
								<div class="table-seat <%=cls%>" data-id="<%=tid%>"
									data-can="<%=isCandidate%>" data-free="<%=isFree%>">
									<div class="text-center">
										<div><%=tid%></div>
										<small>~<%=capacity.get(tid)%>名
										</small>
									</div>
								</div>
								<%
								}
								%>
							</div>
						</div>

						<!-- 6 seats -->
						<div class="col-12">
							<h5 class="fw-bold">6名席</h5>
							<div class="d-flex gap-3 flex-wrap justify-content-center">
								<%
								for (String tid : new String[]{"Z1", "Z2", "Z3", "Z4"}) {
									boolean isCandidate = candidateSet.contains(tid);
									boolean isFree = available.contains(tid);
									String cls = !isCandidate ? "seat-disabled" : (isFree ? "seat-free" : "seat-full");
								%>
								<div class="table-seat <%=cls%>" data-id="<%=tid%>"
									data-can="<%=isCandidate%>" data-free="<%=isFree%>">
									<div class="text-center">
										<div><%=tid%></div>
										<small>~<%=capacity.get(tid)%>名
										</small>
									</div>
								</div>
								<%
								}
								%>
							</div>
						</div>

					</div>

					<div class="d-flex justify-content-between mt-4">
						<a class="btn btn-outline-secondary"
							href="<%=request.getContextPath()%>/reserve/form">戻る</a>
						<button type="submit" class="btn btn-primary px-4" id="nextBtn"
							disabled>この席で次へ</button>
					</div>

				</div>
			</form>

		</div>
	</main>

	<!-- =====================
     FOOTER (BOTTOM)
===================== -->
	<%@ include file="footer.jsp"%>

	<script>
let selected = null;

document.querySelectorAll(".table-seat").forEach(el=>{
  el.addEventListener("click", ()=>{
    const can = el.dataset.can === "true";
    const free = el.dataset.free === "true";
    if(!can || !free) return;

    document.querySelectorAll(".table-seat")
      .forEach(x=>x.classList.remove("seat-selected"));

    el.classList.add("seat-selected");
    selected = el.dataset.id;
    document.getElementById("tableId").value = selected;
    document.getElementById("nextBtn").disabled = false;
  });
});
</script>

</body>
</html>
