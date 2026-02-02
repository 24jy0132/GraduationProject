<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, java.util.Map, model.Menu, model.Staff"%>

<%
// 1. Retrieve Data
Menu menu = (Menu) request.getAttribute("menu");
Map<Integer, Map<String, Integer>> tasteSummary = (Map<Integer, Map<String, Integer>>) request
		.getAttribute("tasteSummary");
Map<Integer, Map<String, Integer>> volumeSummary = (Map<Integer, Map<String, Integer>>) request
		.getAttribute("volumeSummary");
Map<Integer, Map<String, Integer>> priceSummary = (Map<Integer, Map<String, Integer>>) request
		.getAttribute("priceSummary");
List<String> comments = (List<String>) request.getAttribute("comments");

// 2. Retrieve Admin User (For Header)
Staff admin = (Staff) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>回答閲覧</title>

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
/* ===== CARD STYLES ===== */
.card-soft {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .05);
	padding: 30px;
	margin-bottom: 40px;
}

.menu-header {
	display: flex;
	align-items: center;
	gap: 20px;
	margin-bottom: 30px;
	padding-bottom: 20px;
	border-bottom: 1px solid #eee;
}

.menu-img-thumb {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 12px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.menu-title {
	font-size: 24px;
	font-weight: 700;
	color: #1d1d1f;
	margin: 0;
}

.section-label {
	font-weight: 700;
	font-size: 16px;
	margin-bottom: 15px;
	border-left: 4px solid #007bff;
	padding-left: 10px;
	color: #333;
}

/* ===== RESULT BOXES ===== */
.result-box {
	background: #f8f9fa;
	border-radius: 12px;
	padding: 15px;
	height: 100%;
}

.result-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 8px 0;
	border-bottom: 1px dashed #e0e0e0;
}

.result-item:last-child {
	border-bottom: none;
}

.result-label {
	font-weight: 500;
}

.result-count {
	font-weight: 700;
	background: #e9ecef;
	padding: 2px 8px;
	border-radius: 6px;
	font-size: 12px;
}

/* ===== COMMENT BOX ===== */
.comment-container {
	background: #fdfdfd;
	border: 1px solid #e0e0e0;
	border-radius: 12px;
	max-height: 300px;
	overflow-y: auto;
}

.comment-item {
	padding: 12px 15px;
	border-bottom: 1px solid #eee;
}

.comment-item:last-child {
	border-bottom: none;
}

.comment-icon {
	color: #ccc;
	margin-right: 8px;
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
			if (menu == null) {
			%>
			<div class="alert alert-warning text-center">
				<i class="fa-solid fa-triangle-exclamation"></i> メニュー情報を取得できませんでした。
			</div>
			<div class="text-center">
				<button type="button" class="btn btn-outline-secondary"
					onclick="history.back()">戻る</button>
			</div>
			<%
			} else {
			%>

			<div class="menu-header">
				<%
				if (menu.getImagePath() != null && !menu.getImagePath().isEmpty()) {
				%>
				<img src="<%=menu.getImagePath()%>" class="menu-img-thumb"
					alt="menu">
				<%
				} else {
				%>
				<div
					class="menu-img-thumb d-flex align-items-center justify-content-center bg-light text-secondary fs-2">
					<i class="fa-solid fa-utensils"></i>
				</div>
				<%
				}
				%>

				<div>
					<div class="text-muted small mb-1">アンケート集計結果</div>
					<h2 class="menu-title"><%=menu.getMenuName()%></h2>
				</div>
			</div>

			<div class="section-label">回答集計</div>
			<div class="row g-4 mb-5">

				<div class="col-md-4">
					<div class="result-box">
						<h6 class="text-primary fw-bold mb-3">
							<i class="fa-solid fa-utensils"></i> 味の印象
						</h6>
						<%
						Map<String, Integer> tasteMap = (tasteSummary != null) ? tasteSummary.get(menu.getMenuId()) : null;
						if (tasteMap != null && !tasteMap.isEmpty()) {
							for (Map.Entry<String, Integer> e : tasteMap.entrySet()) {
						%>
						<div class="result-item">
							<span class="result-label"><%=e.getKey()%></span> <span
								class="result-count"><%=e.getValue()%>件</span>
						</div>
						<%
						}
						} else {
						%>
						<div class="text-muted small text-center py-3">データなし</div>
						<%
						}
						%>
					</div>
				</div>

				<div class="col-md-4">
					<div class="result-box">
						<h6 class="text-success fw-bold mb-3">
							<i class="fa-solid fa-chart-pie"></i> 量の印象
						</h6>
						<%
						Map<String, Integer> volumeMap = (volumeSummary != null) ? volumeSummary.get(menu.getMenuId()) : null;
						if (volumeMap != null && !volumeMap.isEmpty()) {
							for (Map.Entry<String, Integer> e : volumeMap.entrySet()) {
						%>
						<div class="result-item">
							<span class="result-label"><%=e.getKey()%></span> <span
								class="result-count"><%=e.getValue()%>件</span>
						</div>
						<%
						}
						} else {
						%>
						<div class="text-muted small text-center py-3">データなし</div>
						<%
						}
						%>
					</div>
				</div>

				<div class="col-md-4">
					<div class="result-box">
						<h6 class="text-warning fw-bold mb-3">
							<i class="fa-solid fa-yen-sign"></i> 値段の印象
						</h6>
						<%
						Map<String, Integer> priceMap = (priceSummary != null) ? priceSummary.get(menu.getMenuId()) : null;
						if (priceMap != null && !priceMap.isEmpty()) {
							for (Map.Entry<String, Integer> e : priceMap.entrySet()) {
						%>
						<div class="result-item">
							<span class="result-label"><%=e.getKey()%></span> <span
								class="result-count"><%=e.getValue()%>件</span>
						</div>
						<%
						}
						} else {
						%>
						<div class="text-muted small text-center py-3">データなし</div>
						<%
						}
						%>
					</div>
				</div>
			</div>

			<div class="section-label">
				任意コメント <span class="badge bg-secondary ms-2"
					style="font-size: 0.7em">管理者のみ閲覧</span>
			</div>
			<div class="comment-container mb-4">
				<%
				if (comments != null && !comments.isEmpty()) {
					for (String cm : comments) {
				%>
				<div class="comment-item">
					<i class="fa-regular fa-comment-dots comment-icon"></i>
					<%=cm%>
				</div>
				<%
				}
				} else {
				%>
				<div class="text-center text-muted py-4">コメントはまだありません</div>
				<%
				}
				%>
			</div>

			<div class="d-flex justify-content-center pt-3">
				<button type="button" class="btn btn-outline-secondary px-4"
					onclick="history.back()">
					<i class="fa-solid fa-arrow-left"></i> 戻る
				</button>
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