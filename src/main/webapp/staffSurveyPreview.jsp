<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Menu, model.Staff"%>

<%
// 1. Retrieve Data
Menu menu = (Menu) request.getAttribute("menu");
Staff admin = (Staff) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>アンケートプレビュー</title>

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

/* ===== CARD & FORM ===== */
.card-soft {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .05);
	padding: 40px;
	max-width: 800px;
	margin: 0 auto 50px auto;
}

.section-title {
	font-weight: 700;
	font-size: 16px;
	margin-bottom: 15px;
	border-left: 4px solid #007bff;
	padding-left: 10px;
	color: #333;
}

/* ===== MENU PREVIEW HEADER ===== */
.menu-header {
	display: flex;
	align-items: flex-start;
	gap: 20px;
	background: #f8f9fa;
	padding: 20px;
	border-radius: 12px;
	margin-bottom: 30px;
	border: 1px solid #eee;
}

.menu-img {
	width: 120px;
	height: 120px;
	object-fit: cover;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.menu-info h3 {
	font-weight: 700;
	font-size: 22px;
	margin-bottom: 5px;
}

.menu-desc {
	color: #666;
	font-size: 13px;
	margin-bottom: 10px;
}

.menu-price {
	font-weight: 700;
	font-size: 18px;
	color: #007bff;
}

/* ===== RADIO BUTTONS ===== */
.option-row {
	background: #fff;
	padding: 15px;
	border: 1px solid #e9ecef;
	border-radius: 8px;
}

.form-check-label {
	cursor: pointer;
	margin-right: 15px;
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

			<h4 class="text-center fw-bold mb-4">
				<i class="fa-regular fa-eye text-primary"></i> アンケートプレビュー
			</h4>

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
				<img src="<%=request.getContextPath()%>/<%=menu.getImagePath()%>"
					class="menu-img" alt="Menu Image">
				<%
				} else {
				%>
				<div
					class="menu-img d-flex align-items-center justify-content-center bg-white border text-secondary display-6">
					<i class="fa-solid fa-utensils"></i>
				</div>
				<%
				}
				%>

				<div class="menu-info">
					<h3><%=menu.getMenuName()%></h3>
					<div class="menu-desc"><%=menu.getDescription()%></div>
					<div class="menu-price">
						¥<%=String.format("%,d", menu.getPrice())%></div>
				</div>
			</div>

			<form action="AdminSurveyPreviewDoneServlet" method="post">
				<input type="hidden" name="menuId" value="<%=menu.getMenuId()%>">

				<div class="mb-4">
					<div class="section-title">味の印象</div>
					<div class="option-row d-flex flex-wrap gap-3">
						<label class="form-check"> <input class="form-check-input"
							type="radio" name="taste" value="とてもおいしかった"> とてもおいしかった
						</label> <label class="form-check"> <input
							class="form-check-input" type="radio" name="taste" value="おいしかった">
							おいしかった
						</label> <label class="form-check"> <input
							class="form-check-input" type="radio" name="taste" value="普通だった">
							普通だった
						</label> <label class="form-check"> <input
							class="form-check-input" type="radio" name="taste"
							value="あまり口に合わなかった"> あまり口に合わなかった
						</label>
					</div>
				</div>

				<div class="mb-4">
					<div class="section-title">量の印象</div>
					<div class="option-row d-flex flex-wrap gap-3">
						<label class="form-check"> <input class="form-check-input"
							type="radio" name="volume" value="少ない"> 少ない
						</label> <label class="form-check"> <input
							class="form-check-input" type="radio" name="volume"
							value="ちょうどいい"> ちょうどいい
						</label> <label class="form-check"> <input
							class="form-check-input" type="radio" name="volume" value="多い">
							多い
						</label>
					</div>
				</div>

				<div class="mb-4">
					<div class="section-title">値段の印象</div>
					<div class="option-row d-flex flex-wrap gap-3">
						<label class="form-check"> <input class="form-check-input"
							type="radio" name="price" value="やすい"> やすい
						</label> <label class="form-check"> <input
							class="form-check-input" type="radio" name="price" value="妥当">
							妥当
						</label> <label class="form-check"> <input
							class="form-check-input" type="radio" name="price" value="高い">
							高い
						</label>
					</div>
				</div>

				<div class="mb-5">
					<div class="section-title">
						任意コメント <span class="badge bg-secondary ms-2"
							style="font-size: 0.7em">管理者用</span>
					</div>
					<textarea class="form-control" name="comment" rows="4"
						placeholder="サービス改善のためのメモ等"></textarea>
				</div>

				<div class="d-flex justify-content-center gap-3 pt-3 border-top">
					<button type="button" class="btn btn-outline-secondary px-4"
						onclick="history.back()">
						<i class="fa-solid fa-arrow-left"></i> 戻る
					</button>
					<button type="submit" class="btn btn-primary px-5">
						<i class="fa-solid fa-paper-plane"></i> 投稿する
					</button>
				</div>
			</form>

			<%
			}
			%>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>