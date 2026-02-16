<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.time.*, java.util.List, model.Menu, dao.MenuDao, model.Staff, service.Constants"%>

<%
Staff admin = (Staff) session.getAttribute("admin");
LocalTime t = Constants.OPEN;

// Fetch courses dynamically from your MenuDao
MenuDao menuDao = new MenuDao();
List<Menu> courseList = null;
try {
	courseList = menuDao.findCourses();
} catch (Exception e) {
	e.printStackTrace();
} finally {
	menuDao.connectionClose();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者予約登録</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">

<style>
/* ===== BASE STYLE (Your Original MHP Style) ===== */
body {
	background: #f5f5f7;
	font-family: "Helvetica Neue", Arial, sans-serif;
	color: #333;
	padding-bottom: 50px;
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

.buttons button:hover {
	background: rgba(255, 255, 255, .9);
	transform: translateY(-1px);
}

.form-card {
	max-width: 700px;
	margin: 0 auto;
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
}

.form-label {
	font-weight: 600;
	font-size: 14px;
	color: #555;
	margin-bottom: 8px;
}

.form-control, .form-select {
	border-radius: 10px;
	padding: 10px 15px;
	border: 1px solid #e0e0e0;
	background-color: #fcfcfc;
}

.section-icon {
	color: #007bff;
	margin-right: 8px;
}

.btn-glass {
	background: rgba(255, 255, 255, 0.8);
	border: 1px solid #d1d5db;
	border-radius: 8px;
	padding: 8px 20px;
	font-weight: 500;
	color: #333;
	text-decoration: none;
	font-size: 14px;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.btn-action {
	color: white;
	border: none;
	padding: 10px 30px;
	border-radius: 8px;
	font-weight: 600;
	transition: 0.2s;
}

.btn-action:hover {
	opacity: 0.9;
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

		<div class="form-card">
			<h3 class="mb-4 fw-bold text-center">
				<i class="fa-solid fa-pen-to-square section-icon"></i>管理者予約登録
			</h3>
			<%
			String error = (String) request.getAttribute("error");
			if (error != null) {
			%>
			<div class="alert alert-danger rounded-3 shadow-sm mb-4">
				<i class="fa-solid fa-triangle-exclamation me-2"></i><%=error%>
			</div>
			<%
			}
			%>

			<form method="post"
				action="<%=request.getContextPath()%>/admin/reserve">

				<div class="row mb-4">
					<div class="col-md-6">
						<label class="form-label"><i
							class="fa-regular fa-calendar me-2"></i>予約日</label> <input type="date"
							name="date" class="form-control" required
							value="<%=LocalDate.now()%>">
					</div>
					<div class="col-md-6">
						<label class="form-label"><i
							class="fa-regular fa-clock me-2"></i>開始時間</label> <select
							name="startTime" class="form-select" required>
							<%
							while (!t.isAfter(Constants.LAST_START)) {
							%>
							<option value="<%=t%>"><%=t%> ～
								<%=t.plusMinutes(Constants.DURATION_MINUTES)%></option>
							<%
							t = t.plusMinutes(Constants.SLOT_MINUTES);
							}
							%>
						</select>
					</div>
				</div>

				<div class="row mb-4">
					<div class="col-md-6">
						<label class="form-label"><i
							class="fa-solid fa-signature me-2"></i>お客様名</label> <input type="text"
							name="name" class="form-control" placeholder="例：山田 太郎" required>
					</div>
					<div class="col-md-6">
						<label class="form-label"><i
							class="fa-solid fa-phone me-2"></i>電話番号</label> <input type="tel"
							name="phone" class="form-control" placeholder="0000000000"
							required>
					</div>
				</div>

				<div class="mb-4">
					<label class="form-label"><i
						class="fa-solid fa-utensils me-2"></i>コース選択</label> <select
						name="courseId" class="form-select">
						<option value="0">席のみ予約 (コースなし)</option>
						<%
						if (courseList != null) {
							for (Menu course : courseList) {
						%>
						<option value="<%=course.getMenuId()%>">
							<%=course.getMenuName()%> (+<%=course.getPrice()%>円)
						</option>
						<%
						}
						}
						%>
					</select>
				</div>

				<div class="mb-4">
					<label class="form-label"><i class="fa-solid fa-chair me-2"></i>テーブル選択（複数可）</label>
					<select name="tableIds" class="form-select" multiple size="6"
						required>
						<optgroup label="2名席">
							<option value="A1">A1</option>
							<option value="A2">A2</option>
						</optgroup>
						<optgroup label="4名席">
							<option value="T1">T1</option>
							<option value="T2">T2</option>
							<option value="T3">T3</option>
							<option value="T4">T4</option>
						</optgroup>
						<optgroup label="6名席">
							<option value="Z1">Z1</option>
							<option value="Z2">Z2</option>
							<option value="Z3">Z3</option>
							<option value="Z4">Z4</option>
						</optgroup>
					</select>
					<div class="form-text mt-2">
						<i class="fa-solid fa-circle-info"></i> Ctrl (Win) / Cmd (Mac)
						で複数選択
					</div>
				</div>

				<div class="row mb-4">
					<div class="col-6">
						<label class="form-label"><i class="fa-solid fa-user me-2"></i>大人</label>
						<input type="number" name="adult" class="form-control" min="1"
							value="1">
					</div>
					<div class="col-6">
						<label class="form-label"><i
							class="fa-solid fa-child me-2"></i>子ども</label> <input type="number"
							name="child" class="form-control" min="0" value="0">
					</div>
				</div>

				<div class="mb-5">
					<label class="form-label"><i
						class="fa-regular fa-envelope me-2"></i>メールアドレス</label> <input
						type="email" name="email" class="form-control"
						placeholder="example@email.com">
				</div>

				<div class="d-flex justify-content-between align-items-center">
					<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"
						class="btn-glass text-muted"> キャンセル </a>
					<button type="submit" class="btn-action bg-primary shadow-sm">
						<i class="fa-solid fa-check me-2"></i>予約を登録する
					</button>
				</div>

			</form>
		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>