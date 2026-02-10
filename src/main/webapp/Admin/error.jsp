<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Staff"%>
<%
// --- DATA PREP ---
Staff admin = (Staff) session.getAttribute("admin");
String message = (String) request.getAttribute("errorMessage");
Boolean forceAllowed = (Boolean) request.getAttribute("forceAllowed");
if (forceAllowed == null)
	forceAllowed = false;
if (message == null)
	message = "不明なエラーが発生しました。";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>確認・エラー | MHP</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">

<style>
/* ===== UI SYSTEM ALIGNMENT ===== */
body {
	background: #f5f5f7;
	font-family: "Helvetica Neue", Arial, sans-serif;
	color: #333;
}

.page-title {
	text-align: center;
	font-weight: 700;
	margin: 30px 0 10px 0;
	color: #1d1d1f;
}

.topcontainer {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

.user-card {
	display: inline-flex;
	align-items: center;
	background: white;
	padding: 6px 15px 6px 8px;
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

.buttons {
	text-align: right;
	margin-bottom: 25px;
}

.buttons button {
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

.form-card {
	max-width: 650px;
	margin: 0 auto;
	background: white;
	padding: 50px 40px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
	text-align: center;
}

/* Specific Alerts */
.status-icon {
	font-size: 55px;
	margin-bottom: 20px;
}

.icon-warning {
	color: #f5a623;
}

.icon-error {
	color: #dc3545;
}

.btn-glass {
	background: rgba(255, 255, 255, 0.8);
	border: 1px solid #d1d5db;
	border-radius: 10px;
	padding: 10px 25px;
	font-weight: 500;
	color: #333;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: 0.2s;
}

.btn-action {
	color: white;
	border: none;
	padding: 10px 30px;
	border-radius: 10px;
	font-weight: 600;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: 0.2s;
}

.btn-force {
	background: #dc3545;
	box-shadow: 0 4px 14px rgba(220, 53, 69, 0.3);
}

.btn-force:hover {
	background: #c82333;
	transform: translateY(-1px);
	color: white;
}
</style>
</head>

<body>

	<div class="container mt-4">

		<h1 class="page-title">MHP株式会社 営業サポートシステム</h1>

		<div class="topcontainer">
			<%
			if (admin != null) {
			%>
			<div class="user-card">
				<div class="user-avatar">
					<i class="fa-solid fa-user-gear"></i>
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

		<div class="form-card">
			<%
			if (forceAllowed) {
			%>
			<i class="fa-solid fa-circle-exclamation status-icon icon-warning"></i>
			<h3 class="fw-bold mb-4">予約の重複・警告</h3>
			<%
			} else {
			%>
			<i class="fa-solid fa-circle-xmark status-icon icon-error"></i>
			<h3 class="fw-bold mb-4">エラーが発生しました</h3>
			<%
			}
			%>

			<div class="alert alert-light border-0 py-4 px-3 mb-4"
				style="background: #f8f9fa; border-radius: 12px;">
				<p class="fs-5 mb-0 text-secondary">
					<%=message%>
				</p>
			</div>

			<%
			if (forceAllowed) {
			%>
			<div class="mb-5">
				<p class="text-danger fw-bold">
					<i class="fa-solid fa-triangle-exclamation me-1"></i>
					この内容で強制的に予約を確定させますか？
				</p>
			</div>

			<div class="d-flex justify-content-center gap-3">
				<a href="javascript:history.back()" class="btn-glass"> <i
					class="fa-solid fa-chevron-left"></i> 戻って修正
				</a>
				<form method="post"
					action="<%=request.getContextPath()
		+ (session.getAttribute("pendingEditReservation") != null
				? "/admin/edit/force"
				: "/admin/reserve/force")%>">


					<button type="submit" class="btn-action btn-force">
						<i class="fa-solid fa-bolt me-1"></i> 強制予約を続行
					</button>
				</form>
			</div>
			<%
			} else {
			%>
			<div class="d-flex justify-content-center">
				<a href="javascript:history.back()" class="btn-glass"> <i
					class="fa-solid fa-chevron-left"></i> 前の画面に戻る
				</a>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>