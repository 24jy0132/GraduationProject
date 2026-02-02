<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List, model.Menu, model.Staff"%>

<%
Staff admin = (Staff) session.getAttribute("admin");

List<Menu> surveyMenus = (List<Menu>) request.getAttribute("surveyMenus");
List<Menu> newMenus = (List<Menu>) request.getAttribute("newMenus");
List<Menu> mainMenus = (List<Menu>) request.getAttribute("mainMenus");
List<Menu> alaCarteMenus = (List<Menu>) request.getAttribute("alaCarteMenus");
List<Menu> saladSoup = (List<Menu>) request.getAttribute("saladSoup");
List<Menu> drinks = (List<Menu>) request.getAttribute("drinks");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー管理</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">

<style>
/* ===== BASE STYLE ===== */
body {
	background: #f5f5f7;
	font-family: "Helvetica Neue", Arial, sans-serif;
	color: #333;
	padding-bottom: 50px;
}

/* ===== HEADER ===== */
.page-title {
	text-align: center;
	font-weight: 700;
	margin: 30px 0 10px 0;
	color: #1d1d1f;
}

/* Row 1: User Card */
.topcontainer {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 10px; /* Gap between User and Buttons */
}

/* Row 2: Buttons (EXACT CLASS KEPT) */
.nav-buttons {
	display: flex;
	justify-content: flex-end; /* Aligned right */
	gap: 10px;
	margin-bottom: 30px;
}

/* ===== USER CARD ===== */
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

/* ===== BUTTON STYLES ===== */
.btn-glass {
	background: rgba(255, 255, 255, 0.8);
	border: 1px solid #d1d5db;
	border-radius: 8px;
	padding: 8px 20px;
	font-weight: 500;
	color: #333;
	text-decoration: none;
	font-size: 14px;
	transition: 0.2s;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	backdrop-filter: blur(4px);
}

.btn-glass:hover {
	background: white;
	transform: translateY(-1px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
}

/* Dark Action Button Style (For Edit) */
.btn-action {
	background: #333;
	color: white;
	border: 1px solid #333;
}

.btn-action:hover {
	background: #000;
	color: white;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.text-danger:hover {
	color: #dc3545 !important;
	background: #fff0f0;
	border-color: #ffcccc;
}

/* ===== SECTION STYLING ===== */
.section-header {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
	padding-bottom: 5px;
	border-bottom: 2px solid #e5e5e5;
}

.section-title {
	font-size: 1.25rem;
	font-weight: 700;
	margin: 0;
	color: #1d1d1f;
}

.section-icon {
	margin-right: 10px;
	color: #007bff;
}

/* ===== MENU CARD DESIGN ===== */
.menu-card {
	background: white;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
	transition: transform 0.2s ease, box-shadow 0.2s ease;
	height: 100%;
	display: flex;
	flex-direction: column;
	position: relative;
}

.menu-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.card-img-wrap {
	width: 100%;
	aspect-ratio: 4/3;
	overflow: hidden;
	background: #eee;
}

.card-img-wrap img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: 0.3s;
}

.menu-card:hover .card-img-wrap img {
	transform: scale(1.05);
}

.menu-content {
	padding: 15px;
	flex-grow: 1;
	display: flex;
	flex-direction: column;
}

.menu-title {
	font-weight: 700;
	font-size: 15px;
	margin-bottom: 5px;
	line-height: 1.3;
}

.menu-desc {
	font-size: 12px;
	color: #666;
	margin-bottom: 10px;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

.menu-footer {
	margin-top: auto;
	padding-top: 10px;
	border-top: 1px solid #f0f0f0;
	text-align: right;
}

.menu-price {
	font-weight: 800;
	font-size: 16px;
	color: #333;
}

/* Badges */
.badge-overlay {
	position: absolute;
	top: 10px;
	left: 10px;
	padding: 4px 10px;
	border-radius: 20px;
	font-size: 11px;
	font-weight: 700;
	color: white;
	z-index: 2;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

.bg-gradient-pink {
	background: linear-gradient(135deg, #ff416c, #ff4b2b);
}

.bg-gradient-orange {
	background: linear-gradient(135deg, #fce38a, #f38181);
	color: #333;
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

		<div class="nav-buttons">

			<a href="<%=request.getContextPath()%>/AdminMenuEditServlet"
				class="btn-glass btn-action"> <i
				class="fa-solid fa-pen-to-square"></i> メニューを編集
			</a> <a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"
				class="btn-glass">  管理TOP
			</a> <a href="<%=request.getContextPath()%>/Adminlogoutservlet"
				class="btn-glass">  ログアウト
			</a>

		</div>


		<%
		if (surveyMenus != null && !surveyMenus.isEmpty()) {
		%>
		<div class="mb-5">
			<div class="section-header">
				<i class="fa-solid fa-chart-pie section-icon"></i>
				<h4 class="section-title">アンケート対象商品</h4>
			</div>
			<div class="row g-4">
				<%
				for (Menu m : surveyMenus) {
				%>
				<div class="col-6 col-md-3 col-lg-2">
					<div class="menu-card">
						<div class="card-img-wrap">
							<span class="badge-overlay bg-gradient-pink">SURVEY</span> <img
								src="<%=m.getImagePath()%>" alt="menu">
						</div>
						<div class="menu-content">
							<div class="menu-title"><%=m.getMenuName()%></div>
							<div class="menu-desc"><%=m.getDescription()%></div>
							<div class="menu-footer">
								<span class="menu-price">¥<%=m.getPrice()%></span>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
		<%
		}
		%>

		<%
		if (newMenus != null && !newMenus.isEmpty()) {
		%>
		<div class="mb-5">
			<div class="section-header">
				<i class="fa-solid fa-star section-icon text-warning"></i>
				<h4 class="section-title">新商品</h4>
			</div>
			<div class="row g-4">
				<%
				for (Menu m : newMenus) {
				%>
				<div class="col-6 col-md-3 col-lg-2">
					<div class="menu-card">
						<div class="card-img-wrap">
							<span class="badge-overlay bg-gradient-orange">NEW</span> <img
								src="<%=m.getImagePath()%>" alt="menu">
						</div>
						<div class="menu-content">
							<div class="menu-title"><%=m.getMenuName()%></div>
							<div class="menu-desc"><%=m.getDescription()%></div>
							<div class="menu-footer">
								<span class="menu-price">¥<%=m.getPrice()%></span>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
		<%
		}
		%>

		<%
		List<Menu>[] groups = new List[] { mainMenus, alaCarteMenus, saladSoup, drinks };
		String[] titles = { "メイン商品", "アラカルト", "サラダ・スープ・その他", "ドリンク商品" };
		String[] icons = { "fa-utensils", "fa-burger", "fa-bowl-food", "fa-mug-hot" };

		for (int i = 0; i < groups.length; i++) {
			if (groups[i] != null && !groups[i].isEmpty()) {
		%>
		<div class="mb-5">
			<div class="section-header">
				<i class="fa-solid <%=icons[i]%> section-icon"></i>
				<h4 class="section-title"><%=titles[i]%></h4>
			</div>
			<div class="row g-4">
				<%
				for (Menu m : groups[i]) {
				%>
				<div class="col-6 col-md-3 col-lg-2">
					<div class="menu-card">
						<div class="card-img-wrap">
							<img src="<%=m.getImagePath()%>"
								onerror="this.src='https://via.placeholder.com/150'" alt="menu">
						</div>
						<div class="menu-content">
							<div class="menu-title"><%=m.getMenuName()%></div>
							<div class="menu-desc"><%=m.getDescription()%></div>
							<div class="menu-footer">
								<span class="menu-price">¥<%=m.getPrice()%></span>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
		<%
		}
		}
		%>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>