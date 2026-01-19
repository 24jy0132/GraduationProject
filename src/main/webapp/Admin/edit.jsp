<%@ include file="../header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.time.*"%>
<%@ page import="java.util.*"%>
<%@ page import="model.Staff, model.Reservation"%>
<%@ page import="service.Constants"%>

<%
Staff admin = (Staff) session.getAttribute("admin");
Reservation r = (Reservation) request.getAttribute("reservation");

LocalTime t = Constants.OPEN;
List<String> selectedTables =
    (r.getTableIds() != null) ? r.getTableIds() : new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者予約編集</title>

<link
 href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
 rel="stylesheet">

<style>
.form-card {
	max-width: 720px;
	margin: auto;
	background: #fff;
	padding: 32px;
	border-radius: 18px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .15);
}
.user-card {
	display: flex;
	gap: 10px;
	background: #fff;
	padding: 8px 12px;
	border-radius: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, .1);
}
.user-avatar {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	background: linear-gradient(135deg, #007bff, #00c6ff);
	display: flex;
	align-items: center;
	justify-content: center;
	color: #fff;
}
</style>
</head>

<body class="bg-light">

<div class="container">
	<h1 class="text-center my-4 fw-bold">
		MHP株式会社 営業サポートシステム
	</h1>

	<div class="d-flex justify-content-between align-items-start mb-4">
		<h2 class="fw-bold">📝 予約編集</h2>

		<% if (admin != null) { %>
		<div class="user-card">
			<div class="user-avatar">👤</div>
			<div>
				<b><%=admin.getStaffName()%></b><br>
				<%=admin.getStaffType()%>
			</div>
		</div>
		<% } %>
	</div>

	<div class="form-card">
	<form method="post"
	      action="<%=request.getContextPath()%>/admin/edit">

		<!-- ✅ ID -->
		<input type="hidden" name="reservationId"
		       value="<%=r.getReservationId()%>">

		<!-- DATE -->
		<div class="mb-3">
			<label class="form-label">予約日</label>
			<input type="date" name="date"
			       class="form-control"
			       value="<%=r.getReservationDate()%>" required>
		</div>

		<!-- START TIME -->
		<div class="mb-3">
			<label class="form-label">開始時間</label>
			<select name="startTime" class="form-select" required>
			<%
			while (!t.isAfter(Constants.LAST_START)) {
				boolean selected = t.equals(r.getStartTime());
			%>
				<option value="<%=t%>" <%=selected?"selected":""%>>
					<%=t%> ～ <%=t.plusMinutes(Constants.DURATION_MINUTES)%>
				</option>
			<%
				t = t.plusMinutes(Constants.SLOT_MINUTES);
			}
			%>
			</select>
		</div>

		<!-- TABLES -->
		<div class="mb-3">
			<label class="form-label">テーブル（複数可）</label>
			<select name="tableIds" class="form-select" multiple required>
				<option value="A1" <%=selectedTables.contains("A1")?"selected":""%>>A1</option>
				<option value="A2" <%=selectedTables.contains("A2")?"selected":""%>>A2</option>
				<option value="T1" <%=selectedTables.contains("T1")?"selected":""%>>T1</option>
				<option value="T2" <%=selectedTables.contains("T2")?"selected":""%>>T2</option>
				<option value="T3" <%=selectedTables.contains("T3")?"selected":""%>>T3</option>
				<option value="T4" <%=selectedTables.contains("T4")?"selected":""%>>T4</option>
				<option value="Z1" <%=selectedTables.contains("Z1")?"selected":""%>>Z1</option>
				<option value="Z2" <%=selectedTables.contains("Z2")?"selected":""%>>Z2</option>
				<option value="Z3" <%=selectedTables.contains("Z3")?"selected":""%>>Z3</option>
				<option value="Z4" <%=selectedTables.contains("Z4")?"selected":""%>>Z4</option>
			</select>
		</div>

		<!-- PEOPLE -->
		<div class="row mb-3">
			<div class="col">
				<label>大人</label>
				<input type="number" name="adult"
				 class="form-control" value="<%=r.getAdultCount()%>">
			</div>
			<div class="col">
				<label>子ども</label>
				<input type="number" name="child"
				 class="form-control" value="<%=r.getChildCount()%>">
			</div>
		</div>

		<!-- CUSTOMER -->
		<div class="mb-3">
			<label>お客様名</label>
			<input type="text" name="customerName"
			       class="form-control"
			       value="<%=r.getCustomerName()%>" required>
		</div>

		<div class="mb-4">
			<label>メール</label>
			<input type="email" name="customerEmail"
			       class="form-control"
			       value="<%=r.getCustomerEmail()%>">
		</div>

		<div class="d-flex justify-content-between">
			<a href="<%=request.getContextPath()%>/admin"
			   class="btn btn-secondary">戻る</a>
			<button class="btn btn-primary px-4">更新</button>
		</div>

	</form>
	</div>
</div>
</body>
</html>
