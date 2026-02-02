<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Staff"%>

<%
Staff admin = (Staff) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理設定</title>

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
	font-family: "Roboto", sans-serif;
	color: #333;
}

.page-title {
	text-align: center;
	font-weight: 700;
	margin: 30px 0;
	color: #1d1d1f;
}

/* ===== USER CARD ===== */
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

/* ===== DASHBOARD GRID ===== */
.dashboard-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 25px;
	margin-bottom: 40px;
}

.dash-card {
	background: #fff;
	border-radius: 16px;
	padding: 30px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
	text-align: center;
	transition: 0.3s;
	text-decoration: none;
	color: #333;
	border: 1px solid transparent;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 200px;
}

.dash-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
	border-color: #007bff;
	color: #007bff;
}

.dash-icon {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 30px;
	margin-bottom: 15px;
	color: white;
}

.dash-title {
	font-weight: 700;
	font-size: 18px;
}

.dash-desc {
	font-size: 13px;
	color: #777;
	margin-top: 5px;
}

/* Specific Colors */
.bg-blue {
	background: linear-gradient(135deg, #007bff, #00c6ff);
}

.bg-green {
	background: linear-gradient(135deg, #28a745, #85e085);
}

.bg-purple {
	background: linear-gradient(135deg, #6f42c1, #a685e0);
}

.bg-orange {
	background: linear-gradient(135deg, #fd7e14, #ffb375);
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

		<div class="dashboard-grid">

			<a href="<%=request.getContextPath()%>/admin" class="dash-card">
				<div class="dash-icon bg-blue">
					<i class="fa-solid fa-calendar-check"></i>
				</div>
				<div class="dash-title">予約状況確認</div>
				<div class="dash-desc">本日の予約、カレンダー表示</div>
			</a> <a
				href="<%=request.getContextPath()%>/reservation/adminReserveForm.jsp"
				class="dash-card">
				<div class="dash-icon bg-green">
					<i class="fa-solid fa-plus"></i>
				</div>
				<div class="dash-title">新規予約登録</div>
				<div class="dash-desc">電話・来店予約の入力</div>
			</a> <a href="<%=request.getContextPath()%>//admin/list"
				class="dash-card">
				<div class="dash-icon bg-orange">
					<i class="fa-solid fa-clock-rotate-left"></i>
				</div>
				<div class="dash-title">予約履歴</div>
				<div class="dash-desc">過去の予約一覧・検索</div>
			</a>

		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>