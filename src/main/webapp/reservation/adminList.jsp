<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.*"%>
<%@ page import="model.Reservation"%>
<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Staff"%>
<%
Staff admin = (Staff) session.getAttribute("admin");
%>


<style>
body {
	background: #f5f5f5;
	margin: 0;
	padding: 0;
}

h1 {
	text-align: center;
	margin-top: 30px;
	margin-bottom: 40px;
	font-weight: 700;
	color: #333;
}

/* Top buttons (管理TOP / ログアウト) */
.buttons {
	text-align: right;
	margin-bottom: 20px;
}

.buttons a button {
	background: #007bff;
	color: white;
	padding: 8px 25px;
	font-size: 16px;
	border: none;
	border-radius: 6px;
	margin-left: 10px;
	cursor: pointer;
	transition: 0.3s;
}

.buttons a button:hover {
	background: #0056b3;
}

/* Navigation pills styling */
.nav-pills .nav-link {
	font-size: 18px;
	padding: 10px 18px;
	color: #333;
	border-radius: 6px;
	transition: 0.3s;
}

.nav-pills .nav-link:hover {
	background: #e0e0e0;
}

.nav-pills .nav-link.active {
	background: #007bff;
	color: white;
}

/* Dropdown menu styling */
.dropdown-menu {
	font-size: 16px;
}

.dropdown-menu a {
	padding: 10px 15px;
}

.dropdown-menu a:hover {
	background: #f0f0f0;
}

.topcontainer {
	display: flex;
	justify-content: flex-end;
}

.top-bar {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

/* User Card – tighter width */
.user-card {
	display: inline-flex;
	align-items: flex-end;
	background: white;
	padding: 6px 10px;
	border-radius: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	gap: 8px;
	width: 200px;
}

/* Avatar smaller */
.user-avatar {
	width: 50px; /* reduced */
	height: 50px;
	background: linear-gradient(135deg, #007bff, #00c6ff);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-size: 18px;
}

/* Text */
.user-name {
	font-weight: 600;
	font-size: 18px;
}

.user-role {
	font-size: 16px;
	color: #777;
}
</style>


<%
LocalDate selectedDate = (LocalDate) request.getAttribute("date");
List<Reservation> list = (List<Reservation>) request.getAttribute("list");
%>



<body class="container mt-4">
	<h1>MHP株式会社 営業サポートシステム</h1>

	<div class="container">
		<div class="topcontainer">
			<!-- Top right buttons -->
			<div class="top-bar">
				<%
				if (admin != null) {
				%>
				<div class="user-card">
					<div class="user-avatar">
						<i class="fa-solid fa-user"></i>
					</div>


					<div class="user-details">
						<div class="user-name"><%=admin.getStaffName()%></div>
						<div class="user-role"><%=admin.getStaffType()%></div>
					</div>




				</div>
				<%
				}
				%>
			</div>
		</div>
		<div class="buttons">
			<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"><button>管理TOP</button></a>
			<a href="<%=request.getContextPath()%>/Adminlogoutservlet"><button>ログアウト</button></a>
		</div>

		<h2 class="mb-4">📋 Reservation List</h2>

		<!-- DATE FILTER -->
		<form method="get"
			action="<%=request.getContextPath()%>/adminreservation/list"
			class="row g-3 align-items-end mb-4">

			<div class="col-auto">
				<label class="form-label">Date</label> <input type="date"
					name="date" value="<%=selectedDate%>" class="form-control">
			</div>

			<div class="col-auto">
				<button class="btn btn-primary">
					<i class="bi bi-funnel"></i> Filter
				</button>
			</div>
		</form>

		<!-- RESERVATION TABLE -->
		<table
			class="table table-bordered table-hover align-middle text-center">

			<thead class="table-dark">
				<tr>
					<th>ID</th>
					<th>Date</th>
					<th>Time</th>
					<th>Table</th>
					<th>Customer</th>
					<th>People</th>
					<th>Action</th>
				</tr>
			</thead>

			<tbody>
				<%
				if (list == null || list.isEmpty()) {
				%>
				<tr>
					<td colspan="7" class="text-muted">No reservations found for
						this date</td>
				</tr>
				<%
				} else {
				%>

				<%
				for (Reservation r : list) {
				%>
				<tr>
					<td><%=r.getReservationId()%></td>

					<td><%=r.getReservationDate()%></td>

					<td><%=r.getStartTime()%> – <%=r.getEndTime()%></td>

					<td><span class="badge bg-secondary"> <%=r.getTableId()%>
					</span></td>

					<td><%=r.getCustomerName()%></td>

					<td>A:<%=r.getAdultCount()%> / C:<%=r.getChildCount()%>
					</td>

					<td><a class="btn btn-sm btn-warning"
						href="<%=request.getContextPath()%>/admin/edit?id=<%=r.getReservationId()%>">
							<i class="bi bi-pencil-square"></i>
					</a> <a class="btn btn-sm btn-danger"
						href="<%=request.getContextPath()%>/admin/delete?id=<%=r.getReservationId()%>"
						onclick="return confirm('Cancel this reservation?')"> <i
							class="bi bi-trash"></i>
					</a></td>
				</tr>
				<%
				}
				%>

				<%
				}
				%>
			</tbody>
		</table>
</body>
</html>