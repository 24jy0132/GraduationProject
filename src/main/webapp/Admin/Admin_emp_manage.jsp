<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, model.Staff"%>

<%
// 1. Retrieve Data
Staff admin = (Staff) session.getAttribute("admin");
List<Staff> list = (List<Staff>) session.getAttribute("staffList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>従業員管理</title>

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
/* ===== MAIN CARD ===== */
.content-card {
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
	padding: 30px;
	margin-bottom: 50px;
}

/* Table Style */
.table thead th {
	background: #343a40;
	color: #fff;
	border: none;
	white-space: nowrap;
}

.table tbody td {
	vertical-align: middle;
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

		<div class="content-card">

			<div
				class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
				<h4 class="m-0 fw-bold">
					<i class="fa-solid fa-users-gear me-2"></i> 従業員一覧
				</h4>

				<a href="<%=request.getContextPath()%>/Admin/staffregisteration.jsp"
					class="btn btn-primary px-4 rounded-pill shadow-sm"> <i
					class="fa-solid fa-plus me-1"></i> 新規登録
				</a>
			</div>

			<div class="table-responsive">
				<table class="table table-hover align-middle">
					<thead class="table-dark text-center">
						<tr>
							<th>ID</th>
							<th>名前</th>
							<th>フリガナ</th>
							<th>職種</th>
							<th>電話番号</th>
							<th>メール</th>
							<th>住所</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (list != null && !list.isEmpty()) {
							for (Staff s : list) {
						%>
						<tr>
							<td class="text-center fw-bold text-secondary"><%=s.getStaffId()%></td>

							<td class="fw-bold"><%=s.getStaffName()%></td>

							<td class="small text-muted"><%=s.getStaffNameFurigana()%></td>

							<td class="text-center">
								<%
								if ("admin".equals(s.getStaffType()) || "staff".equals(s.getStaffType())) {
								%> <span
								class="badge bg-primary bg-opacity-10 text-primary border border-primary">正社員</span>
								<%
								} else {
								%> <span
								class="badge bg-success bg-opacity-10 text-success border border-success">アルバイト</span>
								<%
								}
								%>
							</td>

							<td><%=s.getStaffPhone()%></td>

							<td><%=s.getStaffEmail()%></td>

							<td class="small text-muted text-truncate"
								style="max-width: 200px;" title="<%=s.getStaffAddress()%>">
								<%=s.getStaffAddress()%>
							</td>

							<td class="text-center" style="min-width: 140px;"><a
								href="<%=request.getContextPath()%>/Staffeditingservlet?staffId=<%=s.getStaffId()%>"
								class="btn btn-sm btn-outline-primary me-1"> <i
									class="fa-solid fa-pen"></i> 編集
							</a> <a
								href="<%=request.getContextPath()%>/Staffdeletingservlet?staffId=<%=s.getStaffId()%>"
								class="btn btn-sm btn-outline-danger"
								onclick="return confirm('本当に削除しますか？\n<%=s.getStaffName()%>')">
									<i class="fa-solid fa-trash"></i>
							</a></td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="8" class="text-center py-5 text-muted"><i
								class="fa-solid fa-user-slash fs-1 mb-3 d-block"></i>
								従業員データが見つかりません</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>

			<div class="text-center mt-4">
				<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"
					class="btn btn-outline-secondary px-4 rounded-pill"> <i
					class="fa-solid fa-arrow-left me-2"></i> 戻る
				</a>
			</div>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>