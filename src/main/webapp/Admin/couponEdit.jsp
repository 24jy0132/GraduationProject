<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Staff, model.Coupon"%>

<%
// Retrieve Data
Staff admin = (Staff) session.getAttribute("admin");
Coupon c = (Coupon) request.getAttribute("coupon");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>クーポン編集</title>

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

/* ===== FORM CARD ===== */
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
	font-size: 18px;
	margin-bottom: 25px;
	border-left: 5px solid #007bff;
	padding-left: 15px;
	color: #333;
}

.form-label {
	font-weight: 600;
	font-size: 13px;
	color: #555;
	margin-bottom: 5px;
}

.input-group-text {
	font-size: 13px;
	background: #f8f9fa;
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
			<div class="section-title">クーポン情報編集</div>

			<%
			if (c == null) {
			%>
			<div class="alert alert-danger">クーポン情報が見つかりませんでした。</div>
			<div class="text-center">
				<button onclick="history.back()" class="btn btn-secondary">戻る</button>
			</div>
			<%
			} else {
			%>

			<form action="<%=request.getContextPath()%>/admin/coupon/update"
				method="post">

				<input type="hidden" name="couponId" value="<%=c.getCouponId()%>">

				<div class="row g-4">

					<div class="col-12">
						<label class="form-label">クーポンタイトル <span
							class="badge bg-danger ms-1">必須</span></label> <input type="text"
							name="title" value="<%=c.getTitle()%>" class="form-control"
							required>
					</div>

					<div class="col-12">
						<label class="form-label">説明文</label>
						<textarea name="description" class="form-control" rows="3"><%=c.getDescription()%></textarea>
					</div>

					<div class="col-md-6">
						<label class="form-label">割引額</label>
						<div class="input-group">
							<span class="input-group-text">¥</span> <input type="number"
								name="discountAmount" value="<%=c.getDiscountAmount()%>"
								class="form-control">
						</div>
					</div>

					<div class="col-md-6">
						<label class="form-label">必要ポイント</label>
						<div class="input-group">
							<input type="number" name="minPoint" value="<%=c.getMinPoint()%>"
								class="form-control"> <span class="input-group-text">pt</span>
						</div>
					</div>

					<div class="col-md-6">
						<label class="form-label">開始日</label> <input type="date"
							name="startDate" value="<%=c.getStartDate()%>"
							class="form-control">
					</div>

					<div class="col-md-6">
						<label class="form-label">終了日</label> <input type="date"
							name="endDate" value="<%=c.getEndDate()%>" class="form-control">
					</div>

					<div class="col-md-6">
						<label class="form-label">予約条件</label>
						<%
						String type = c.getReservationType();
						if (type == null)
							type = "";
						%>
						<select name="reservationType" class="form-select">
							<option value="ANY" <%=type.equals("ANY") ? "selected" : ""%>>指定なし
								(ANY)</option>
							<option value="LUNCH" <%=type.equals("LUNCH") ? "selected" : ""%>>ランチ限定
								(LUNCH)</option>
							<option value="DINNER"
								<%=type.equals("DINNER") ? "selected" : ""%>>ディナー限定
								(DINNER)</option>
						</select>
					</div>

					<div class="col-md-6">
						<label class="form-label">画像パス</label> <input type="text"
							name="imagePath" value="<%=c.getImagePath()%>"
							class="form-control">
					</div>

					<div
						class="col-12 text-center mt-5 d-flex justify-content-center gap-3">
						<button type="button" class="btn btn-outline-secondary px-4"
							onclick="history.back()">
							<i class="fa-solid fa-arrow-left"></i> キャンセル
						</button>
						<button type="submit" class="btn btn-primary px-5">
							<i class="fa-solid fa-arrows-rotate"></i> 更新する
						</button>
					</div>

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