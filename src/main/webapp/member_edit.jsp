<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp"%>
<%@ page import="model.Customer"%>
<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
if (loginCustomer == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>会員情報変更</title>
<style>
html, body {
	height: 100%;
}

body {
	margin: 0;
	display: flex;
	flex-direction: column;
}

main {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 40px 15px;
}

.edit-card {
	max-width: 720px;
	width: 100%;
}

.label {
	font-size: .9rem;
	color: #6c757d;
}

.toast-container {
	position: fixed;
	top: 90px;
	right: 20px;
	z-index: 1055;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<a class="navbar-brand fw-bold text-white"
				href="<%=request.getContextPath()%>/member/profile"> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" class="me-2"> Welcome From Mesa
			</a>
			<div class="collapse navbar-collapse justify-content-end">
				<ul class="navbar-nav gap-4">
					<li class="nav-item"><a class="nav-link text-white"
						href="member_index.jsp"><i class="bi bi-house-fill me-1"></i>Home</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="MenuListServlet"><i class="bi bi-menu-down me-1"></i>Menu</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="contact.jsp"><i class="bi bi-telephone-fill me-1"></i>Contact</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="map.jsp"><i class="bi bi-pin-map-fill me-1"></i>Map</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="Customer_LogOut"><i class="bi bi-box-arrow-right me-1"></i>LogOut</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="toast-container">
		<%
		String err = (String) request.getAttribute("errorMessage");
		if (err != null) {
		%>
		<div class="alert alert-danger alert-dismissible fade show"><%=err%><button
				type="button" class="btn-close" data-bs-dismiss="alert"></button>
		</div>
		<%
		}
		%>
		<%
		String succ = (String) request.getAttribute("successMessage");
		if (succ != null) {
		%>
		<div class="alert alert-success alert-dismissible fade show"><%=succ%><button
				type="button" class="btn-close" data-bs-dismiss="alert"></button>
		</div>
		<%
		}
		%>
	</div>

	<main>
		<div class="container">
			<div class="card shadow edit-card p-4 mx-auto">
				<h3 class="fw-bold text-center mb-4">会員情報変更</h3>
				<form method="post"
					action="<%=request.getContextPath()%>/member/edit">
					<div class="mb-3">
						<label class="form-label label">お名前</label> <input type="text"
							name="name" class="form-control"
							value="<%=loginCustomer.getName()%>" required>
					</div>
					<div class="mb-3">
						<label class="form-label label">メールアドレス</label> <input
							type="email" name="email" class="form-control"
							value="<%=loginCustomer.getEmail()%>" required>
					</div>
					<div class="mb-4">
						<label class="form-label label">電話番号</label> <input type="text"
							name="phone" class="form-control"
							value="<%=loginCustomer.getPhone()%>" required>
					</div>

					<hr class="my-4">
					<h5 class="fw-bold mb-3">パスワード変更</h5>
					<div class="mb-3">
						<label class="form-label label">新しいパスワード</label> <input
							type="password" name="newPassword" class="form-control"
							placeholder="8文字以上（数字を含む）">
					</div>
					<div class="mb-4">
						<label class="form-label label">新しいパスワード（確認）</label> <input
							type="password" name="rePassword" class="form-control"
							placeholder="もう一度入力してください">
					</div>

					<div class="d-flex justify-content-between align-items-center mt-4">
						<a href="<%=request.getContextPath()%>/member/profile"
							class="btn btn-outline-secondary">戻る</a>
						<button type="submit" class="btn btn-dark px-5">保存する</button>
					</div>
				</form>

				<hr class="my-5">
				<div class="text-end">
					<button class="btn btn-outline-danger btn-sm"
						data-bs-toggle="modal" data-bs-target="#deleteModal">退会する</button>
				</div>
			</div>
		</div>
	</main>

	<div class="modal fade" id="deleteModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title text-danger">退会確認</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<p>本当に退会しますか？</p>
					<p class="text-danger small">※ この操作は取り消せません。</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">キャンセル</button>
					<form method="post"
						action="<%=request.getContextPath()%>/member/delete">
						<button class="btn btn-danger">退会する</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>