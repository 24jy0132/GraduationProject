<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Staff"%>

<%
// 1. Retrieve Data
Staff admin = (Staff) session.getAttribute("admin");
Staff temp = (Staff) session.getAttribute("tempStaff");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>従業員登録確認</title>

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

/* ===== CONFIRM CARD ===== */
.card-soft {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .05);
	padding: 40px;
	max-width: 600px;
	margin: 0 auto 50px auto;
}

.section-title {
	font-weight: 700;
	font-size: 18px;
	margin-bottom: 25px;
	border-left: 5px solid #007bff;
	padding-left: 15px;
	color: #333;
}

/* ===== DATA GRID ROWS ===== */
.data-row {
	display: flex;
	align-items: center;
	padding: 12px 0;
	border-bottom: 1px dashed #e0e0e0;
}

.data-row:last-child {
	border-bottom: none;
}

.data-label {
	width: 40%;
	font-weight: 600;
	color: #6c757d;
}

.data-value {
	width: 60%;
	font-weight: 500;
	color: #1d1d1f;
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


		<div class="card-soft">

			<%
			if (temp == null) {
			%>
			<div class="alert alert-warning text-center">
				<i class="fa-solid fa-triangle-exclamation"></i> 登録データが見つかりません。
			</div>
			<div class="text-center">
				<a href="staffRegister.jsp" class="btn btn-secondary">フォームへ戻る</a>
			</div>
			<%
			} else {
			%>

			<div class="text-center mb-4">
				<h4 class="fw-bold">登録内容の確認</h4>
				<p class="text-muted small">以下の内容で登録します。よろしいですか？</p>
			</div>

			<div class="mb-4">
				<div class="data-row">
					<div class="data-label">
						<i class="fa-solid fa-user me-2"></i> 従業員名
					</div>
					<div class="data-value"><%=temp.getStaffName()%></div>
				</div>

				<div class="data-row">
					<div class="data-label">
						<i class="fa-regular fa-id-card me-2"></i> フリガナ
					</div>
					<div class="data-value"><%=temp.getStaffNameFurigana()%></div>
				</div>

				<div class="data-row">
					<div class="data-label">
						<i class="fa-solid fa-briefcase me-2"></i> 従業員種別
					</div>
					<div class="data-value">
						<%
						if ("staff".equals(temp.getStaffType())) {
						%>
						<span class="badge bg-primary">正社員</span>
						<%
						} else {
						%>
						<span class="badge bg-success">アルバイト</span>
						<%
						}
						%>
					</div>
				</div>

				<div class="data-row">
					<div class="data-label">
						<i class="fa-solid fa-phone me-2"></i> 電話番号
					</div>
					<div class="data-value"><%=temp.getStaffPhone()%></div>
				</div>

				<div class="data-row">
					<div class="data-label">
						<i class="fa-solid fa-envelope me-2"></i> メール
					</div>
					<div class="data-value"><%=temp.getStaffEmail()%></div>
				</div>

				<div class="data-row">
					<div class="data-label">
						<i class="fa-solid fa-location-dot me-2"></i> 住所
					</div>
					<div class="data-value"><%=temp.getStaffAddress()%></div>
				</div>

				<div class="data-row">
					<div class="data-label">
						<i class="fa-solid fa-lock me-2"></i> パスワード
					</div>
					<div class="data-value font-monospace">●●●●●●●●</div>
				</div>
			</div>

			<div class="d-flex justify-content-center gap-3 mt-5">
				<a href="<%=request.getContextPath()%>/Admin/staffregisteration.jsp"
					class="btn btn-outline-secondary px-4 d-flex align-items-center">
					<i class="fa-solid fa-arrow-left me-2"></i> 修正する
				</a>

				<form action="<%=request.getContextPath()%>/Staffinsertionservlet"
					method="post">
					<button type="submit" class="btn btn-primary px-5">
						<i class="fa-solid fa-check me-2"></i> 登録する
					</button>
				</form>
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