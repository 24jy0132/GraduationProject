<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Staff, java.util.List"%>

<%
// 1. Retrieve Data
Staff admin = (Staff) session.getAttribute("admin"); // For User Card
Staff temp = (Staff) session.getAttribute("tempStaff"); // For pre-fill
List<String> errors = (List<String>) request.getAttribute("errors");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>従業員登録</title>



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
			<div class="section-title">従業員新規登録</div>

			<%
			if (errors != null && !errors.isEmpty()) {
			%>
			<div class="alert alert-danger alert-dismissible fade show mb-4"
				role="alert">
				<i class="fa-solid fa-circle-exclamation me-2"></i> <strong>入力エラーがあります</strong>
				<ul class="mb-0 mt-2 ps-3 small">
					<%
					for (String e : errors) {
					%>
					<li><%=e%></li>
					<%
					}
					%>
				</ul>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>
			<%
			}
			%>

			<form action="<%=request.getContextPath()%>/Staffconfirmationservlet"
				method="post">
				<div class="row g-4">

					<div class="col-md-6">
						<label for="staffname" class="form-label">従業員名</label> <input
							type="text" class="form-control" id="staffname" name="staffname"
							value="<%=request.getAttribute("staffname") != null ? request.getAttribute("staffname")
		: (temp != null ? temp.getStaffName() : "")%>"
							required>
					</div>

					<div class="col-md-6">
						<label for="staffnamefurigana" class="form-label">フリガナ</label> <input
							type="text" class="form-control" id="staffnamefurigana"
							name="staffnamefurigana"
							value="<%=request.getAttribute("staffnamefurigana") != null ? request.getAttribute("staffnamefurigana")
		: (temp != null ? temp.getStaffNameFurigana() : "")%>"
							required>
					</div>

					<div class="col-md-6">
						<label for="stafftype" class="form-label">従業員種類</label> <select
							class="form-select" name="stafftype" id="stafftype">
							<option value="staff"
								<%="staff".equals(request.getAttribute("stafftype")) || (temp != null && "staff".equals(temp.getStaffType()))
		? "selected"
		: ""%>>
								正社員 (Staff)</option>
							<option value="parttime"
								<%="parttime".equals(request.getAttribute("stafftype")) || (temp != null && "parttime".equals(temp.getStaffType()))
				? "selected"
				: ""%>>
								アルバイト (Part-time)</option>
						</select>
					</div>

					<div class="col-md-6">
						<label for="staffphone" class="form-label">電話番号</label> <input
							type="tel" class="form-control" id="staffphone" name="staffphone"
							value="<%=request.getAttribute("staffphone") != null ? request.getAttribute("staffphone")
		: (temp != null ? temp.getStaffPhone() : "")%>"
							required>
					</div>

					<div class="col-12">
						<label for="staffemail" class="form-label">メールアドレス</label> <input
							type="email" class="form-control" id="staffemail"
							name="staffemail"
							value="<%=request.getAttribute("staffemail") != null ? request.getAttribute("staffemail")
		: (temp != null ? temp.getStaffEmail() : "")%>"
							required>
					</div>

					<div class="col-12">
						<label for="staffaddress" class="form-label">住所</label> <input
							type="text" class="form-control" id="staffaddress"
							name="staffaddress"
							value="<%=request.getAttribute("staffaddress") != null ? request.getAttribute("staffaddress")
		: (temp != null ? temp.getStaffAddress() : "")%>">
					</div>

					<div class="col-md-6">
						<label for="staffpassword" class="form-label">パスワード
							「8文字以上、数字一つ以上」</label> <input type="password" class="form-control"
							id="staffpassword" name="staffpassword" required>
					</div>

					<div class="col-md-6">
						<label for="staffrepassword" class="form-label">パスワード確認</label> <input
							type="password" class="form-control" id="staffrepassword"
							name="staffrepassword" required>
					</div>

					<div
						class="col-12 text-center mt-5 d-flex justify-content-center gap-3">
						<a href="Admin_emp_manage.jsp"
							class="btn btn-outline-secondary px-4 d-flex align-items-center">
							<i class="fa-solid fa-arrow-left me-2"></i> 戻る
						</a>
						<button type="submit" class="btn btn-primary px-5">
							確認画面へ <i class="fa-solid fa-arrow-right ms-2"></i>
						</button>
					</div>

				</div>
			</form>
		</div>

	</div>


</body>
</html>