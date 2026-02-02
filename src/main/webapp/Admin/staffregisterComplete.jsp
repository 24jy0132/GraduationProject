<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Staff"%>

<%
// 1. Retrieve Data
Staff admin = (Staff) session.getAttribute("admin");
String message = (String) session.getAttribute("message");

// Clear the message after retrieving it so it doesn't show again on refresh
if (message != null) {
	session.removeAttribute("message");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>従業員登録完了</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">

<style>
/* ===== BASE STYLE ===== */
body {
	background: #f5f5f7;
	font-size: 14px;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		"Helvetica Neue", Arial, sans-serif;
	color: #333;
}

.page-title {
	text-align: center;
	font-weight: 700;
	margin: 30px 0;
	color: #1d1d1f;
}

/* ===== USER CARD (Synced) ===== */
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

/* ===== SUCCESS CARD ===== */
.complete-card {
	background: #fff;
	border-radius: 20px;
	box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
	padding: 60px 40px;
	max-width: 600px;
	margin: 50px auto;
	text-align: center;
}

.icon-box {
	width: 80px;
	height: 80px;
	background: #d1e7dd;
	color: #198754;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 40px;
	margin: 0 auto 30px auto;
}

.msg-title {
	font-weight: 700;
	font-size: 24px;
	margin-bottom: 15px;
	color: #1d1d1f;
}

.msg-body {
	color: #6c757d;
	margin-bottom: 40px;
	font-size: 15px;
	line-height: 1.6;
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


		<div class="complete-card">

			<%
			if (message != null) {
			%>
			<div class="icon-box">
				<i class="fa-solid fa-check"></i>
			</div>

			<h2 class="msg-title"><%=message%></h2>

			<p class="msg-body">
				データベースへの登録が完了しました。<br> 従業員一覧画面にて新しいアカウントを確認できます。
			</p>

			<div class="d-flex justify-content-center gap-3">
				<a href="<%=request.getContextPath()%>/Admin/Admin_emp_manage.jsp"
					class="btn btn-primary px-5 py-2 rounded-pill shadow-sm"> <i
					class="fa-solid fa-users me-2"></i> 従業員一覧へ
				</a> <a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"
					class="btn btn-outline-secondary px-4 py-2 rounded-pill"> 管理TOP
				</a>
			</div>

			<%
			} else {
			%>
			<div class="icon-box" style="background: #f8d7da; color: #dc3545;">
				<i class="fa-solid fa-triangle-exclamation"></i>
			</div>

			<h2 class="msg-title">セッション切れ、または不正なアクセス</h2>

			<p class="msg-body">
				登録情報が見つかりませんでした。<br> もう一度最初から操作を行ってください。
			</p>

			<a href="staffRegister.jsp"
				class="btn btn-secondary px-5 py-2 rounded-pill"> 戻る </a>
			<%
			}
			%>
		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>