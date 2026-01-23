<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List, model.Reservation, model.Customer"%>
<%@ include file="header.jsp"%>

<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
%>

<style>
.history-container {
	background-color: #f8f9fa;
	min-height: 100vh;
	padding: 50px 0;
}

.reservation-card {
	border-radius: 15px;
	border: none;
	transition: transform .2s ease;
}

.reservation-card:hover {
	transform: translateY(-6px);
}

.status-badge {
	font-size: 0.85rem;
	padding: 6px 14px;
	border-radius: 50px;
	font-weight: bold;
}

.status-RESERVED {
	background-color: #0d6efd;
	color: white;
}

.status-FINISHED {
	background-color: #198754;
	color: white;
}

.status-CANCELLED {
	background-color: #dc3545;
	color: white;
}

.table-badge {
	background-color: #e9ecef;
	color: #000;
	padding: 5px 10px;
	border-radius: 50px;
	font-size: 0.75rem;
	margin-right: 5px;
}
</style>

<nav class="navbar navbar-expand-lg bg-danger py-3">
	<div class="container">
		<a class="navbar-brand fw-bold text-white"
			href="<%=request.getContextPath()%>/index.jsp"> <img
			src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
			height="40" width="40" class="me-2"> Welcome From Mesa
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent">
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
<div class="history-container">
	<div class="container">

		<div class="text-center mb-5">
			<h1 class="fw-bold">予約履歴</h1>
		</div>

		<div class="row g-4">

			<%
			if (reservations != null && !reservations.isEmpty()) {
				for (Reservation r : reservations) {
			%>

			<div class="col-12 col-md-6 col-lg-4">
				<div class="card reservation-card shadow-sm h-100">
					<div class="card-body d-flex flex-column">

						<div class="d-flex justify-content-between mb-2">
							<strong> <i class="bi bi-calendar-event me-1"></i> <%=r.getReservationDate()%>
							</strong> <span class="status-badge status-<%=r.getStatus()%>"> <%=r.getStatus()%>
							</span>
						</div>

						<p class="mb-2 text-muted">
							<i class="bi bi-clock me-1"></i>
							<%=r.getStartTime()%>
							-
							<%=r.getEndTime()%>
						</p>

						<p class="mb-2">
							👥 Adults: <strong><%=r.getAdultCount()%></strong> / Children: <strong><%=r.getChildCount()%></strong>
						</p>

						<div class="mb-3">
							<%
							if (r.getTableIds() != null) {
								for (String t : r.getTableIds()) {
							%>
							<span class="table-badge"><%=t%></span>
							<%
							}
							}
							%>
						</div>

						<div class="mt-auto">
							<%
							if ("RESERVED".equals(r.getStatus())) {
							%>
							<a
								href="<%=request.getContextPath()%>/member/reservation/cancel?id=<%=r.getReservationId()%>"
								class="btn btn-outline-danger btn-sm w-100"> Cancel
								Reservation </a>
							<%
							}
							%>
						</div>

					</div>
				</div>
			</div>

			<%
			}
			} else {
			%>

			<div class="col-12 text-center py-5">
				<i class="bi bi-calendar-x text-muted" style="font-size: 4rem;"></i>
				<h3 class="mt-3">No reservations found</h3>
				<p class="text-muted">You haven’t made any reservations yet.</p>
				<a href="<%=request.getContextPath()%>/reserve/form"
					class="btn btn-danger rounded-pill mt-3"> Make a Reservation </a>
			</div>

			<%
			}
			%>

		</div>
	</div>
</div>

<%@ include file="footer.jsp"%>
