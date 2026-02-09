<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List, model.Menu, model.Staff"%>

<%
// 1. DATA RETRIEVAL
// Handle both "menuList" (standard) or "allMenus" (previous code) just in case
List<Menu> allMenus = (List<Menu>) request.getAttribute("menuList");
if (allMenus == null) {
	allMenus = (List<Menu>) request.getAttribute("allMenus");
}

// 2. EDIT ID HANDLING
Integer editId = null;
try {
	Object editIdObj = request.getAttribute("editId");
	if (editIdObj != null)
		editId = (Integer) editIdObj;
	else {
		String editIdParam = request.getParameter("editId");
		if (editIdParam != null)
	editId = Integer.parseInt(editIdParam);
	}
} catch (Exception e) {
}

// 3. ADMIN USER
Staff admin = (Staff) session.getAttribute("admin");
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
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">

<style>
/* ===== BASE ===== */
body {
	background: #f5f5f7;
	font-size: 14px;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		"Helvetica Neue", Arial, sans-serif;
}

.page-title {
	text-align: center;
	font-weight: 700;
	margin: 30px 0;
	color: #1d1d1f;
}

/* ===== USER CARD (RESTORED DESIGN) ===== */
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

/* ===== CARDS & FORMS ===== */
.card-soft {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .12);
	padding: 24px;
	margin-bottom: 30px;
}

.section-title {
	font-weight: 700;
	margin-bottom: 20px;
	border-left: 4px solid #007bff;
	padding-left: 12px;
	font-size: 18px;
}

/* ===== TABLE ===== */
.table thead th {
	background: #f8f9fa;
	text-align: center;
	white-space: nowrap;
	font-weight: 600;
	border-bottom: 2px solid #dee2e6;
}
</style>
</head>

<body>

	<div class="container mt-4 mb-5">

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
			<div class="section-title">新規メニュー登録</div>

			<form action="AdminMenuEditServlet" method="post"
				enctype="multipart/form-data">
				<div class="row g-3">
					<div class="col-md-6">
						<label class="form-label fw-bold">メニュー名</label> <input type="text"
							name="menuName" class="form-control" required>
					</div>

					<div class="col-md-6">
						<label class="form-label fw-bold">ジャンル</label> <input type="text"
							name="category" class="form-control" required>
					</div>

					<div class="col-md-3">
						<label class="form-label fw-bold">価格</label> <input type="number"
							name="price" class="form-control" required>
					</div>

					<div class="col-md-9">
						<label class="form-label fw-bold">画像</label> <input type="file"
							name="imagePath" class="form-control" accept="image/*" required>
					</div>

					<div class="col-12">
						<label class="form-label fw-bold">説明</label> <input type="text"
							name="description" class="form-control" required>
					</div>

					<div class="col-12">
						<label class="form-label fw-bold d-block">アンケート対象</label>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="isSurveyTarget" value="1" checked> <label
								class="form-check-label">する</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="isSurveyTarget" value="0"> <label
								class="form-check-label">しない</label>
						</div>
					</div>

					<div class="col-12 text-end">
						<button type="submit" class="btn-frost">登録</button>
					</div>
				</div>
			</form>
		</div>

		<div class="card shadow-sm border-0">
			<div class="card-header bg-white fw-bold py-3">
				<i class="fa-solid fa-list text-primary me-2"></i>メニュー一覧
			</div>

			<div class="table-responsive">
				<table class="table table-striped table-hover align-middle mb-0">
					<thead class="table-secondary text-center">
						<tr>
							<th style="width:120px;">画像</th>
							
							<th>メニュー名</th>
							<th>ジャンル</th>
							<th style="width: 100px;">価格</th>
							<th>説明</th>
							<th style="width: 140px;">アンケート対象</th>
							<th style="width: 140px;">新商品</th>

							<th style="width: 100px;">編集</th>
							<th style="width: 80px;">削除</th>
						</tr>
					</thead>

					<tbody>
						<%
						if (allMenus != null) {
							for (Menu m : allMenus) {
								boolean editing = (editId != null && m.getMenuId() == editId);
						%>

						<tr id="row-<%=m.getMenuId()%>"
							class="<%=editing ? "table-warning" : ""%>">

							<%
							if (!editing) {
							%>
							<td class="text-center">
							  <img
							    src="<%=request.getContextPath()%>/<%=m.getImagePath()%>"
							    alt="menu"
							    style="width:100px; height:60px; object-fit:cover; border-radius:10px; border:1px solid #ddd;">
							</td>
							
							<td class="fw-bold"><%=m.getMenuName()%></td>
							<td class="text-center"><span
								class="badge bg-light text-dark border"><%=m.getCategory()%></span></td>
							<td class="text-end pe-4">¥<%=String.format("%,d", m.getPrice())%></td>
							<td class="small text-muted"><%=m.getDescription()%></td>
							<td class="text-center">
							  <% if (m.isSurveyTarget()) { %>
							    <span class="badge bg-success">対象</span>
							
							    <form action="AdminMenuSurveyRemoveServlet" method="post" class="d-inline">
							      <input type="hidden" name="menuId" value="<%=m.getMenuId()%>">
							      <button class="btn btn-sm btn-outline-secondary ms-2"
							              onclick="return confirm('アンケート対象から外しますか？')">
							        外す
							      </button>
							    </form>
							
							  <% } else { %>
							    <span class="badge bg-secondary">対象外</span>
							  <% } %>
							</td>
							
							<td class="text-center">
								<%
								if (m.getIsNew() == 1) {
								%> <span class="badge bg-warning text-dark">NEW</span>

								<form action="AdminMenuNewToggleServlet" method="post"
									class="d-inline">
									<input type="hidden" name="menuId" value="<%=m.getMenuId()%>">
									<input type="hidden" name="isNew" value="0">
									<button class="btn btn-sm btn-outline-dark ms-2"
										onclick="return confirm('新商品対象から外しますか？')">外す</button>
								</form> <%
 								} else {
 									%> <span class="badge bg-secondary">通常</span>

								<form action="AdminMenuNewToggleServlet" method="post"
									class="d-inline">
									<input type="hidden" name="menuId" value="<%=m.getMenuId()%>">
									<input type="hidden" name="isNew" value="1">
									<button class="btn btn-sm btn-outline-warning ms-2"
										onclick="return confirm('新商品にしますか？')">新商品にする</button>
								</form> <%
 											}
 										%>
							</td>


							<td class="text-center"><a
								class="btn btn-sm btn-outline-primary"
								href="AdminMenuEditServlet?editId=<%=m.getMenuId()%>#row-<%=m.getMenuId()%>">
									<i class="fa-solid fa-pen"></i> 編集
							</a></td>

							<td class="text-center">
								<form action="AdminMenuDeleteServlet" method="post"
									class="d-inline">
									<input type="hidden" name="menuId" value="<%=m.getMenuId()%>">
									<button type="submit" class="btn btn-sm btn-outline-danger"
										onclick="return confirm('本当に削除しますか？')">
										<i class="fa-solid fa-trash"></i>
									</button>
								</form>
							</td>

							<%
							} else {
							%>
							<td colspan="9" class="p-3">
								<form action="AdminMenuUpdateServlet" method="post"
									class="row g-2 align-items-center bg-white p-2 rounded shadow-sm border" enctype="multipart/form-data">

									<input type="hidden" name="menuId" value="<%=m.getMenuId()%>">

									<div class="col-md-3">
									  <label class="small text-muted">画像</label>
									  <input type="file"
									         name="imageFile"
									         class="form-control form-control-sm"
									         accept="image/*">
									  <input type="hidden" name="currentImage"
									         value="<%=request.getContextPath()%>/<%=m.getImagePath()%>">
									</div>
									
									<div class="col-md-3">
										<label class="small text-muted">メニュー名</label> <input
											class="form-control form-control-sm" name="menuName"
											value="<%=m.getMenuName()%>" required>
									</div>

									<div class="col-md-2">
										<label class="small text-muted">ジャンル</label> <input
											class="form-control form-control-sm" name="category"
											value="<%=m.getCategory()%>" required>
									</div>

									<div class="col-md-2">
										<label class="small text-muted">価格</label> <input
											class="form-control form-control-sm" type="number"
											name="price" value="<%=m.getPrice()%>" required>
									</div>

									<div class="col-md-3">
										<label class="small text-muted">説明</label> <input
											class="form-control form-control-sm" name="description"
											value="<%=m.getDescription()%>" required>
									</div>

									<div class="col-md-2 d-flex gap-2 align-items-end">
										<button type="submit" class="btn btn-sm btn-success w-100">保存</button>
										<a href="AdminMenuEditServlet#row-<%=m.getMenuId()%>"
											class="btn btn-sm btn-secondary">中止</a>
									</div>
								</form>
							</td>
							<%
							}
							%>
						</tr>

						<%
						}
						} else {
						%>
						<tr>
							<td colspan="6" class="text-center py-4">データがありません</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>

	</div>
	<%
	String message = (String) request.getAttribute("message");
	if (message != null) {
	%>
	<script>
		alert("<%=message%>
		");
	</script>
	<%
	}
	%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>