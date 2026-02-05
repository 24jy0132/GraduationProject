<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List, model.Menu, model.Staff"%>

<%
// 1. Retrieve Data
List<Menu> notSurveyMenu = (List<Menu>) request.getAttribute("notSurveyMenu");
Staff admin = (Staff) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>アンケート作成</title>

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

/* ===== USER CARD (Synced with staffMenuEdit.jsp) ===== */
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

/* ===== NAVIGATION BUTTONS ===== */
.nav-buttons {
	text-align: right;
	margin-bottom: 25px;
}

.btn-glass {
	background: rgba(255, 255, 255, 0.8);
	backdrop-filter: blur(10px);
	border: 1px solid rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	padding: 8px 20px;
	font-weight: 500;
	transition: all 0.2s;
	color: #333;
	text-decoration: none;
	display: inline-block;
	margin-left: 10px;
}

.btn-glass:hover {
	background: white;
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	color: #007bff;
}

/* ===== FORM CARD ===== */
.card-soft {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .05);
	padding: 30px;
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

/* ===== RADIO BUTTONS ===== */
.option-row {
	background: #f8f9fa;
	padding: 15px;
	border-radius: 8px;
	border: 1px solid #e9ecef;
}

.form-check-input:checked {
	background-color: #007bff;
	border-color: #007bff;
}

.form-check-label {
	cursor: pointer;
	margin-right: 15px;
}

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
			<h4 class="mb-4 text-center fw-bold">
				<i class="fa-solid fa-pen-to-square text-primary"></i> アンケート作成
			</h4>

			<form action="AdminSurveyPreviewServlet" method="post">

				<div class="mb-5">
					<div class="section-title">対象メニュー選択</div>
					<select name="menuId" id="menuId"
						class="form-select form-select-lg" required>
						<option value="" disabled selected>メニューを選択してください</option>
						<%
						if (notSurveyMenu != null) {
							for (Menu m : notSurveyMenu) {
						%>
						<option value="<%=m.getMenuId()%>"><%=m.getMenuName()%></option>
						<%
						}
						}
						%>
					</select>
				</div>

				<div class="mb-4">
					<div class="section-title">Q1. 味の印象 (選択肢プレビュー)</div>
					<div class="d-flex flex-wrap gap-2 text-secondary">
						<span class="badge bg-light text-dark border p-2 fw-normal">とてもおいしかった</span>
						<span class="badge bg-light text-dark border p-2 fw-normal">おいしかった</span>
						<span class="badge bg-light text-dark border p-2 fw-normal">普通だった</span>
						<span class="badge bg-light text-dark border p-2 fw-normal">あまり口に合わなかった</span>
					</div>
					<input type="hidden" name="taste" value="skipped">
				</div>

				<div class="mb-4">
					<div class="section-title">Q2. 量の印象 (選択肢プレビュー)</div>
					<div class="d-flex flex-wrap gap-2 text-secondary">
						<span class="badge bg-light text-dark border p-2 fw-normal">少ない</span>
						<span class="badge bg-light text-dark border p-2 fw-normal">ちょうどいい</span>
						<span class="badge bg-light text-dark border p-2 fw-normal">多い</span>
					</div>
					<input type="hidden" name="volume" value="skipped">
				</div>

				<div class="mb-4">
					<div class="section-title">Q3. 値段の印象 (選択肢プレビュー)</div>
					<div class="d-flex flex-wrap gap-2 text-secondary">
						<span class="badge bg-light text-dark border p-2 fw-normal">やすい</span>
						<span class="badge bg-light text-dark border p-2 fw-normal">妥当</span>
						<span class="badge bg-light text-dark border p-2 fw-normal">高い</span>
					</div>
					<input type="hidden" name="price" value="skipped">
				</div>
				<div class="mb-5">
					<div class="section-title">
						任意コメント <span class="badge bg-secondary ms-2"
							style="font-size: 0.7em">管理者用メモ</span>
					</div>
					<textarea class="form-control" name="comment" rows="4"
						placeholder="サービス改善のためのメモや、メニューに関する特記事項があれば入力してください。"></textarea>
				</div>

				<div class="d-flex justify-content-center gap-3 border-top pt-4">
					<button type="button" class="btn btn-outline-secondary px-4"
						onclick="history.back()">
						<i class="fa-solid fa-arrow-left"></i> 戻る
					</button>
					<button type="submit" class="btn btn-primary px-5">
						プレビューへ <i class="fa-solid fa-arrow-right"></i>
					</button>
				</div>
			</form>
		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>