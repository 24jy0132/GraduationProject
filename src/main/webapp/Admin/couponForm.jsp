<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Staff"%>

<%
// Retrieve Admin User (For Header)
Staff admin = (Staff) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>クーポン登録</title>

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
			<div class="section-title">クーポン新規登録</div>

			<form action="<%=request.getContextPath()%>/admin/coupon/save"
				method="post" enctype="multipart/form-data">

				<div class="row g-4">

					<div class="col-12">
						<label class="form-label">クーポンタイトル <span
							class="badge bg-danger ms-1">必須</span></label> <input type="text"
							name="title" class="form-control" placeholder="例：期間限定デザート無料"
							required>
					</div>

					<div class="col-12">
						<label class="form-label">説明文 <span
							class="badge bg-danger ms-1">必須</span></label>
						<textarea name="description" class="form-control" rows="3"
							placeholder="利用条件や詳細を入力" required></textarea>
					</div>

					<div class="col-md-6">
						<label class="form-label">割引額 <span
							class="badge bg-danger ms-1">必須</span></label>
						<div class="input-group">
							<span class="input-group-text">¥</span> <input type="number"
								name="discountAmount" class="form-control" placeholder="0"
								required>
						</div>
					</div>

					<div class="col-md-6">
						<label class="form-label">必要ポイント <span
							class="badge bg-danger ms-1">必須</span></label>
						<div class="input-group">
							<input type="number" name="minPoint" class="form-control"
								placeholder="100" required> <span
								class="input-group-text">pt</span>
						</div>
					</div>

					<div class="col-md-6">
						<label class="form-label">開始日 <span
							class="badge bg-danger ms-1">必須</span></label> <input type="date"
							name="startDate" class="form-control" required>
					</div>

					<div class="col-md-6">
						<label class="form-label">終了日 <span
							class="badge bg-danger ms-1">必須</span></label> <input type="date"
							name="endDate" class="form-control" required>
					</div>

					<div class="col-md-6">
						<label class="form-label">予約タイプ</label> <select
							name="reservationType" class="form-select">
							<option value="ANY">指定なし (ANY)</option>
							<option value="LUNCH">ランチ限定 (LUNCH)</option>
							<option value="DINNER">ディナー限定 (DINNER)</option>
						</select>
					</div>

					<div class="col-md-6">
						<label class="form-label">クーポン画像</label> <input type="file"
							name="image" class="form-control" accept="image/*">
						<div class="form-text small">※ jpg, png, gif
							形式の画像をアップロードしてください</div>
					</div>

					<div
						class="col-12 text-center mt-5 d-flex justify-content-center gap-3">
						<a href="<%=request.getContextPath()%>/admin/coupon/list"
							class="btn btn-outline-secondary px-4 d-flex align-items-center">
							<i class="fa-solid fa-arrow-left me-2"></i> 戻る
						</a>
						<button type="submit" class="btn btn-primary px-5">
							<i class="fa-solid fa-plus me-2"></i> 登録する
						</button>
					</div>

				</div>
			</form>
		</div>

	</div>


</body>
</html>