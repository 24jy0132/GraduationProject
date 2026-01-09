<%@ include file="../header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Staff"%>

<%
Staff admin = (Staff) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理設定</title>

<style>
/* ===== Page Title ===== */
.page-title {
	text-align: center;
	font-weight: 700;
	margin: 40px 0 30px;
	color: #333;
}

/* ===== Top Bar ===== */
.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

/* ===== User Card ===== */
.user-card {
	display: inline-flex;
	align-items: center;
	gap: 10px;
	background: white;
	padding: 8px 14px;
	border-radius: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, .12);
}

.user-avatar {
	width: 44px;
	height: 44px;
	border-radius: 50%;
	background: linear-gradient(135deg, #0d6efd, #00c6ff);
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-size: 18px;
}

/* ===== Action Buttons ===== */
.action-buttons {
	text-align: right;
	margin-bottom: 30px;
}

/* ===== Main Card ===== */
.setting-card {
	max-width: 720px;
	margin: 0 auto 80px;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .15);
	padding: 50px 30px;
}

/* ===== Button Group ===== */
.setting-actions {
	display: flex;
	justify-content: center;
	gap: 20px;
	flex-wrap: wrap;
}
</style>
</head>

<body class="bg-light">

<div class="container-fluid">

	<div class="container">

		<!-- PAGE TITLE -->
		<h1 class="page-title">MHP株式会社 営業サポートシステム</h1>

		<!-- TOP BAR -->
		<div class="top-bar">
			<h2 class="fw-bold mb-0">⚙ 管理画面</h2>

			<% if (admin != null) { %>
			<div class="user-card">
				<div class="user-avatar">👤</div>
				<div>
					<div class="fw-bold"><%=admin.getStaffName()%></div>
					<div class="text-muted small"><%=admin.getStaffType()%></div>
				</div>
			</div>
			<% } %>
		</div>

		<!-- ACTION BUTTONS -->
		<div class="action-buttons">
			<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"
			   class="btn btn-primary me-2">
			   管理TOP
			</a>
			<a href="<%=request.getContextPath()%>/Adminlogoutservlet"
			   class="btn btn-danger">
			   ログアウト
			</a>
		</div>

		<!-- MAIN CARD -->
		<div class="card setting-card text-center">

			<div class="setting-actions">
				<a href="<%=request.getContextPath()%>/admin"
				   class="btn btn-success btn-lg">
				   予約状況を確認
				</a>

				<a href="<%=request.getContextPath()%>/reservation/adminReserveForm.jsp"
				   class="btn btn-secondary btn-lg">
				   新規予約登録
				</a>
			</div>

		</div>

	</div>
</div>

</body>
</html>