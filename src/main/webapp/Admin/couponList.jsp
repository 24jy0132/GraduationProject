<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.List, model.Coupon, model.Staff"%>

<%
// 1. Retrieve Data
Staff admin = (Staff) session.getAttribute("admin");
List<Coupon> couponList = (List<Coupon>) request.getAttribute("coupons");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>割引クーポン管理</title>

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

/* ===== MAIN CARD ===== */
.content-card {
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .05);
	padding: 30px;
	margin-bottom: 50px;
}

/* Table Styles */
.table thead th {
	background: #343a40;
	color: #fff;
	border: none;
	white-space: nowrap;
}

.table tbody td {
	vertical-align: middle;
}

.img-preview {
	width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 6px;
	border: 1px solid #ddd;
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
					<i class="fa-solid fa-tags me-2"></i> クーポン一覧
				</h4>

				<a href="<%=request.getContextPath()%>/Admin/couponForm.jsp"
					class="btn btn-primary px-4 rounded-pill shadow-sm"> <i
					class="fa-solid fa-plus me-1"></i> 新規登録
				</a>
			</div>

			<div class="table-responsive">
				<table class="table table-hover align-middle text-center">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>画像</th>
							<th class="text-start">タイトル</th>
							<th>割引額</th>
							<th>予約条件</th>
							<th>必要P</th>
							<th>有効期間</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (couponList != null && !couponList.isEmpty()) {
							for (Coupon c : couponList) {
						%>
						<tr>
							<td class="fw-bold text-secondary"><%=c.getCouponId()%></td>

							<td>
								<%
								if (c.getImagePath() != null && !c.getImagePath().isEmpty()) {
								%> <img
								src="<%=request.getContextPath()%>/<%=c.getImagePath()%>"
								class="img-preview"> <%
 } else {
 %> <span class="text-muted small"><i class="fa-regular fa-image"></i></span>
								<%
								}
								%>
							</td>

							<td class="text-start fw-bold"><%=c.getTitle()%></td>

							<td class="text-danger fw-bold">¥<%=String.format("%,d", c.getDiscountAmount())%></td>

							<td><span class="badge bg-light text-dark border"><%=c.getReservationType()%></span></td>

							<td><span class="badge bg-warning text-dark"><%=c.getMinPoint()%>
									pt</span></td>

							<td class="small text-muted"><%=c.getStartDate()%> <i
								class="fa-solid fa-arrow-right mx-1"></i> <%=c.getEndDate()%></td>

							<td style="min-width: 140px;"><a
								href="<%=request.getContextPath()%>/admin/coupon/edit?id=<%=c.getCouponId()%>"
								class="btn btn-sm btn-outline-primary me-1"> <i
									class="fa-solid fa-pen"></i> 編集
							</a> <a
								href="<%=request.getContextPath()%>/admin/coupon/delete?id=<%=c.getCouponId()%>"
								class="btn btn-sm btn-outline-danger"
								onclick="return confirm('本当にこのクーポンを削除しますか？');"> <i
									class="fa-solid fa-trash"></i>
							</a></td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="8" class="text-center py-5 text-muted"><i
								class="fa-solid fa-ticket-simple-slash fs-1 mb-3 d-block"></i>
								クーポンが登録されていません</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>