<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Staff"%>

<%
Staff admin = (Staff) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理画面ホーム</title>

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
	margin: 40px 0;
	color: #1d1d1f;
	letter-spacing: 0.5px;
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
	grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
	gap: 25px;
	margin-bottom: 50px;
	padding: 0 10px;
}

.dash-card {
	background: #fff;
	border-radius: 20px;
	padding: 30px 20px;
	text-align: center;
	transition: all 0.3s ease;
	text-decoration: none;
	color: #333;
	border: 1px solid transparent;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 100%;
}

.dash-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
}

/* Icon Styles */
.dash-icon-box {
	width: 70px;
	height: 70px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 28px;
	margin-bottom: 20px;
	color: white;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

/* Gradients for Icons */
.bg-blue {
	background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

.bg-orange {
	background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.bg-purple {
	background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%);
}

.bg-green {
	background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
}

.bg-teal {
	background: linear-gradient(135deg, #20E2D7 0%, #F9FEA5 100%);
}

.bg-red {
	background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 99%, #fecfef 100%);
}

.dash-title {
	font-weight: 700;
	font-size: 18px;
	margin-bottom: 8px;
}

.dash-desc {
	font-size: 13px;
	color: #888;
	line-height: 1.4;
}
</style>
</head>

<body>

	<div class="container">

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

			<a href="<%=request.getContextPath()%>/reservation/success.jsp"
				class="dash-card">
				<div class="dash-icon-box bg-blue">
					<i class="fa-solid fa-calendar-check"></i>
				</div>
				<div class="dash-title">予約管理</div>
				<div class="dash-desc">予約状況の確認と管理を行います</div>
			</a> <a href="<%=request.getContextPath()%>/StaffMenuListServlet"
				class="dash-card">
				<div class="dash-icon-box bg-orange">
					<i class="fa-solid fa-utensils"></i>
				</div>
				<div class="dash-title">メニュー管理</div>
				<div class="dash-desc">商品メニューの追加・編集・削除</div>
			</a> <a href="<%=request.getContextPath()%>/admin/coupon/list"
				class="dash-card">
				<div class="dash-icon-box bg-red">
					<i class="fa-solid fa-tags"></i>
				</div>
				<div class="dash-title">割引管理</div>
				<div class="dash-desc">クーポンの発行と管理設定</div>
			</a> <a href="${pageContext.request.contextPath}/Adminmanagementservlet"
				class="dash-card">
				<div class="dash-icon-box bg-purple">
					<i class="fa-solid fa-users-gear"></i>
				</div>
				<div class="dash-title">従業員管理</div>
				<div class="dash-desc">スタッフ情報の登録・編集</div>
			</a> <a
				href="${pageContext.request.contextPath}/AdminSurveyCreateServlet"
				class="dash-card">
				<div class="dash-icon-box bg-green">
					<i class="fa-solid fa-pen-to-square"></i>
				</div>
				<div class="dash-title">アンケート作成</div>
				<div class="dash-desc">新しいアンケートフォームを作成</div>
			</a> <a
				href="${pageContext.request.contextPath}/AdminSurveyAnswerCheckServlet"
				class="dash-card">
				<div class="dash-icon-box bg-teal">
					<i class="fa-solid fa-chart-pie"></i>
				</div>
				<div class="dash-title">回答一覧</div>
				<div class="dash-desc">お客様からのアンケート結果を確認</div>
			</a>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>