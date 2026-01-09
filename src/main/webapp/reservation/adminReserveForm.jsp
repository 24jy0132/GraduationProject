<%@ include file="../header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.time.*"%>
<%@ page import="model.Staff"%>
<%@ page import="service.Constants"%>

<%
Staff admin = (Staff) session.getAttribute("admin");
LocalTime t = Constants.OPEN;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者予約登録</title>

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
</style>
</head>

<body class="bg-light">

	<div class="container">
		<h1 class="text-center my-4 fw-bold">MHP株式会社 営業サポートシステム</h1>

		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2>📝 管理者予約登録</h2>

			<%
			if (admin != null) {
			%>
			<div
				class="d-flex align-items-center gap-3 bg-white px-3 py-2 rounded-pill shadow-sm">
				<div
					class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center"
					style="width: 40px; height: 40px;">👤</div>
				<div>
					<b><%=admin.getStaffName()%></b><br> <small><%=admin.getStaffType()%></small>
				</div>
			</div>
			<%
			}
			%>
		</div>

		<div class="form-card">

			<form method="post"
				action="<%=request.getContextPath()%>/admin/reserve">

				<!-- DATE -->
				<div class="mb-3">
					<label class="form-label">予約日</label> <input type="date"
						name="date" class="form-control" required>
				</div>

				<!-- START TIME -->
				<div class="mb-3">
					<label class="form-label">開始時間（15分単位）</label> <select
						name="startTime" class="form-select" required>
						<%
						while (!t.isAfter(Constants.LAST_START)) {
						%>
						<option value="<%=t%>">
							<%=t%> ～
							<%=t.plusMinutes(Constants.DURATION_MINUTES)%>
						</option>
						<%
						t = t.plusMinutes(Constants.SLOT_MINUTES);
						}
						%>
					</select>
				</div>

				<!-- MULTI TABLE SELECT -->
				<div class="mb-3">
					<label class="form-label">テーブル選択（複数可）</label> <select
						name="tableIds" class="form-select" multiple required>
						<optgroup label="2名席">
							<option value="A1">A1</option>
							<option value="A2">A2</option>
						</optgroup>
						<optgroup label="4名席">
							<option value="T1">T1</option>
							<option value="T2">T2</option>
							<option value="T3">T3</option>
							<option value="T4">T4</option>
						</optgroup>
						<optgroup label="6名席">
							<option value="Z1">Z1</option>
							<option value="Z2">Z2</option>
							<option value="Z3">Z3</option>
							<option value="Z4">Z4</option>
						</optgroup>
					</select> <small class="text-muted">Ctrl / Cmd を押しながら複数選択</small>
				</div>

				<!-- PEOPLE -->
				<div class="row mb-3">
					<div class="col">
						<label>大人</label> <input type="number" name="adult"
							class="form-control" min="1" value="1">
					</div>
					<div class="col">
						<label>子ども</label> <input type="number" name="child"
							class="form-control" min="0" value="0">
					</div>
				</div>

				<!-- CUSTOMER -->
				<div class="mb-3">
					<label>お客様名</label> <input type="text" name="name"
						class="form-control" required>
				</div>

				<div class="mb-4">
					<label>メール</label> <input type="email" name="email"
						class="form-control">
				</div>

				<div class="d-flex justify-content-between">
					<a href="<%=request.getContextPath()%>/admin"
						class="btn btn-secondary">戻る</a>
					<button class="btn btn-primary px-4">登録</button>
				</div>

			</form>
		</div>
	</div>
</body>
</html>
