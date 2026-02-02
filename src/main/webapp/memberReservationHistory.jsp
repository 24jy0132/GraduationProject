<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List, model.Reservation, model.Customer"%>
<%@ include file="header.jsp"%>

<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");

// Safety check: if accessed directly without login
if (loginCustomer == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Reservation History | Mesa</title>

<style>
/* =====================
   GLOBAL LAYOUT
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
	padding: 50px 0;
}

/* =====================
   HISTORY CARDS
===================== */
.history-card {
	border: none;
	border-radius: 12px;
	background: white;
	transition: all 0.2s ease;
	height: 100%;
	overflow: hidden;
	position: relative;
}

.history-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
}

.card-body {
	padding: 25px;
}

/* Status Badges */
.status-badge {
	font-size: 0.75rem;
	padding: 5px 12px;
	border-radius: 50px;
	font-weight: 700;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	display: inline-block;
}

.status-RESERVED {
	background-color: #e7f1ff;
	color: #0d6efd;
}

.status-FINISHED, .status-COMPLETED {
	background-color: #d1e7dd;
	color: #0f5132;
}

.status-CANCELLED {
	background-color: #f8d7da;
	color: #842029;
}

/* Typography */
.res-date {
	font-size: 1.25rem;
	font-weight: 700;
	color: #212529;
	margin-bottom: 5px;
}

.res-time {
	font-size: 1rem;
	color: #6c757d;
	font-weight: 500;
	margin-bottom: 15px;
}

.info-row {
	display: flex;
	align-items: center;
	margin-bottom: 8px;
	color: #495057;
	font-size: 0.95rem;
}

.info-row i {
	width: 24px;
	color: #adb5bd;
}

/* Table Pills */
.table-pill {
	background-color: #f8f9fa;
	border: 1px solid #dee2e6;
	color: #495057;
	padding: 2px 8px;
	border-radius: 4px;
	font-size: 0.8rem;
	font-weight: 600;
	margin-right: 4px;
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

			<div
				class="d-flex justify-content-between align-items-center mb-5 border-bottom pb-3">
				<div>
					<h2 class="fw-bold m-0">予約履歴</h2>
					<p class="text-muted m-0 small">過去および現在の予約状況を確認できます</p>
				</div>
				<a href="<%=request.getContextPath()%>/reserve/form"
					class="btn btn-primary rounded-pill px-4 shadow-sm"> <i
					class="bi bi-plus-lg"></i> 新規予約
				</a>
			</div>

			<div class="row g-4">
				<%
				if (reservations != null && !reservations.isEmpty()) {
					for (Reservation r : reservations) {
				%>
				<div class="col-12 col-md-6 col-lg-4">
					<div class="card history-card shadow-sm">
						<div class="card-body">

							<div
								class="d-flex justify-content-between align-items-start mb-3">
								<span class="text-muted small" style="font-family: monospace;">#<%=r.getReservationId()%></span>
								<span class="status-badge status-<%=r.getStatus()%>"> <%
 if ("RESERVED".equals(r.getStatus())) {
 %>
									<i class="bi bi-clock-history"></i> 予約中 <%
									} else if ("FINISHED".equals(r.getStatus())) {
									%>
									<i class="bi bi-check-circle"></i> 来店済 <%
									} else if ("CANCELLED".equals(r.getStatus())) {
									%>
									<i class="bi bi-x-circle"></i> 取消済 <%
									} else {
									%> <%=r.getStatus()%>
									<%
									}
									%>
								</span>
							</div>

							<div class="mb-3">
								<div class="res-date">
									<i class="bi bi-calendar-event text-danger me-2"></i><%=r.getReservationDate()%>
								</div>
								<div class="res-time ps-4">
									<%=r.getStartTime()%>
									-
									<%=r.getEndTime()%>
								</div>
							</div>

							<hr class="text-muted opacity-25">

							<div class="info-row">
								<i class="bi bi-people-fill"></i> <span>大人 <strong><%=r.getAdultCount()%></strong>名
									/ 子ども <strong><%=r.getChildCount()%></strong>名
								</span>
							</div>

							<div class="info-row align-items-start">
								<i class="bi bi-grid-3x3-gap-fill mt-1"></i>
								<div>
									<%
									if (r.getTableIds() != null && !r.getTableIds().isEmpty()) {
										for (String t : r.getTableIds()) {
									%>
									<span class="table-pill"><%=t%></span>
									<%
									}
									} else {
									%>
									<span class="text-muted small">指定なし</span>
									<%
									}
									%>
								</div>
							</div>

						</div>
					</div>
				</div>
				<%
				}
				} else {
				%>
				<div class="col-12 text-center py-5">
					<div class="mb-3">
						<i class="bi bi-calendar-x text-muted opacity-25"
							style="font-size: 5rem;"></i>
					</div>
					<h4 class="text-muted fw-bold">予約履歴がありません</h4>
					<p class="text-muted">新しい予約を作成して、素敵な時間をお過ごしください。</p>
					<a href="<%=request.getContextPath()%>/reserve/form"
						class="btn btn-outline-danger rounded-pill mt-2 px-5">予約する</a>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</main>

	<%@ include file="footer.jsp"%>

</body>
</html>