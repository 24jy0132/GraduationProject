<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,java.time.*,model.Reservation,model.Staff"%>

<%
// 1. DATA RETRIEVAL
Staff admin = (Staff) session.getAttribute("admin");

// Date & List Logic
LocalDate selectedDate = (LocalDate) request.getAttribute("date");
if (selectedDate == null)
	selectedDate = LocalDate.now();

List<Reservation> list = (List<Reservation>) request.getAttribute("list");

boolean isAll = "true".equals(request.getParameter("all"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>予約一覧</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
/* ===== BASE STYLE ===== */
body {
	background: #f5f5f7;
	font-family: "Roboto", sans-serif;
	color: #333;
}

/* ===== USER CARD & NAV ===== */
.topcontainer {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

.user-card {
	display: inline-flex;
	align-items: center; /* Changed to center for better alignment */
	background: white;
	padding: 6px 15px 6px 8px; /* Adjusted padding */
	border-radius: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	gap: 12px;
	min-width: 200px;
}

.user-avatar {
	width: 50px;
	height: 50px;
	background: linear-gradient(135deg, #007bff, #00c6ff);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-size: 20px;
	flex-shrink: 0;
}

.user-details {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.user-name {
	font-weight: 700;
	font-size: 16px;
	line-height: 1.2;
	color: #333;
}

.user-role {
	font-size: 13px;
	color: #777;
}

/* ===== BUTTONS (FROSTED) ===== */
.buttons {
	text-align: right;
	margin-bottom: 25px;
}

.buttons button, .btn-frost {
	background: rgba(255, 255, 255, .7);
	backdrop-filter: blur(8px);
	border-radius: 12px;
	border: 1px solid rgba(0, 0, 0, .08);
	padding: 9px 22px;
	font-size: 14px;
	font-weight: 500;
	color: #1c1c1e;
	margin-left: 10px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, .12);
	transition: .25s;
}

.buttons button:hover, .btn-frost:hover {
	background: rgba(255, 255, 255, .9);
	transform: translateY(-1px);
}

/* ===== TABLE CONTAINER ===== */
.content-card {
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
	padding: 30px;
	margin-bottom: 50px;
}

.table thead th {
	background: #343a40;
	color: #fff;
	border: none;
}
</style>
</head>

<body>

	<div class="container mt-4">

		<h2 class="text-center fw-bold text-dark mb-4">MHP株式会社 営業サポートシステム</h2>

		<div class="topcontainer">
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

		<div class="buttons">
			<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"><button>管理TOP</button></a>
			<a href="<%=request.getContextPath()%>/Adminlogoutservlet"><button>ログアウト</button></a>
		</div>


		<div class="content-card">

			<div
				class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
				<h4 class="m-0 fw-bold">
					<i class="bi bi-list-check me-2"></i>予約一覧表
				</h4>
			</div>

			<form method="get"
				action="<%=request.getContextPath()%>/adminreservation/list"
				class="row g-2 align-items-end mb-4 bg-light p-3 rounded">

				<div class="col-auto">
					<label class="form-label fw-bold small text-muted">表示日付</label> <input
						type="date" name="date" value="<%=selectedDate%>"
						class="form-control">
				</div>

				<div class="col-auto">
					<button class="btn btn-dark px-4">
						<i class="bi bi-search"></i> 検索
					</button>
				</div>

				<!-- ✅ NEW BUTTON: GO TO DASHBOARD WITH SAME DATE -->
				<div class="col-auto">
					<a class="btn btn-outline-dark px-4"
						href="<%=request.getContextPath()%>/admin?date=<%=selectedDate%>">
						<i class="bi bi-calendar-week"></i> ダッシュボード
					</a>
				</div>

				<div class="col-auto">
					<a class="btn btn-outline-dark px-4"
						href="<%=request.getContextPath()%>/reservation/adminReserveForm.jsp">
						<i class="bi bi-calendar-week"></i> 新規予約登録
					</a>
				</div>

				<div class="col-auto">
					<a class="btn btn-outline-dark px-4"
						href="<%=request.getContextPath()%>/adminreservation/list?all=true">
						<i class="bi bi-arrow-clockwise"></i> 全件表示
					</a>
				</div>


			</form>


			<div class="table-responsive">
				<table class="table table-hover align-middle text-center border">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>Date</th>
							<th>Time</th>
							<th>Table</th>
							<th>Customer</th>
							<th>Phno</th>
							<th>People</th>
							<th>Course</th>
							<th>Coupon</th>
							<th>Type</th>
							<th>Action</th>
						</tr>
					</thead>

					<tbody>
						<%
						if (list == null || list.isEmpty()) {
						%>
						<tr>
							<td colspan="10" class="text-center py-5 text-muted"><i
								class="bi bi-calendar-x fs-1 d-block mb-2"></i> 予約データが見つかりませんでした
							</td>
						</tr>
						<%
						} else {
						for (Reservation r : list) {
						%>
						<tr>
							<td class="fw-bold text-secondary"><%=r.getReservationId()%></td>

							<td><%=r.getReservationDate()%></td>

							<td class="fw-bold text-primary"><%=r.getStartTime()%> – <%=r.getEndTime()%></td>

							<td><span class="badge bg-light text-dark border"> <%=r.getTableIds() == null || r.getTableIds().isEmpty() ? "-" : String.join(", ", r.getTableIds())%>
							</span></td>

							<td class="text-start ps-4 fw-bold"><%=r.getCustomerName()%></td>

							<td class="text-start ps-4 fw-bold"><%=r.getCustomerPhone()%></td>

							<td><small class="d-block text-muted">大人: <%=r.getAdultCount()%></small>
								<small class="d-block text-muted">子供: <%=r.getChildCount()%></small>
							</td>

							<td><%=(r.getCourseName() == null || r.getCourseName().isEmpty()) ? "-" : r.getCourseName()%></td>

							<td><%=(r.getCouponTitle() == null || r.getCouponTitle().isEmpty())
		? "-"
		: "<span class='badge bg-warning text-dark'>" + r.getCouponTitle() + "</span>"%></td>

							<td>
								<%
								if (r.getCustomerId() != null) {
								%> <span
								class="badge bg-success bg-opacity-10 text-success border border-success">会員</span>
								<%
								} else {
								%> <span
								class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary">非会員</span>
								<%
								}
								%>
							</td>

							<td>
								<div class="btn-group">
									<a class="btn btn-sm btn-outline-primary"
										href="<%=request.getContextPath()%>/admin/edit?id=<%=r.getReservationId()%>">
										<i class="bi bi-pencil-square"></i>
									</a> <a class="btn btn-sm btn-outline-danger"
										href="<%=request.getContextPath()%>/admin/delete?id=<%=r.getReservationId()%><%=isAll ? "&all=true" : "&date=" + selectedDate%>"
										onclick="return confirm('本当に削除しますか？')"> <i
										class="bi bi-trash"></i>
									</a>


								</div>
							</td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
			</div>

		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>