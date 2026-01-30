<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Customer"%>

<%@ include file="header.jsp"%>

<%
Customer temp = (Customer) session.getAttribute("tempUser");
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>登録内容確認</title>

<!-- Bootstrap -->


<style>
:root {
	--bg: #f6f2fb;
	--card: #ffffff;
	--text: #212529;
	--muted: #6c757d;
	--accent1: #e64980;
	--accent2: #ae3ec9;
	--line: #ece8f7;
}

body {
	background: var(--bg);
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

/* main wrapper */
.page-wrap {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 48px 12px;
}

/* card */
.confirm-card {
	max-width: 640px;
	width: 100%;
	background: var(--card);
	border-radius: 20px;
	padding: 36px 32px;
	border: 1px solid var(--line);
	box-shadow: 0 18px 40px rgba(0, 0, 0, .10);
}

/* title */
.confirm-title {
	font-weight: 800;
	margin-bottom: 24px;
	text-align: center;
}

/* row */
.confirm-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 0;
	border-bottom: 1px dashed #e3def2;
}

.confirm-label {
	color: var(--muted);
	font-weight: 600;
}

.confirm-value {
	font-weight: 700;
	color: var(--text);
	text-align: right;
}

/* buttons */
.btn-primary {
	border: none;
	background: black;
	font-weight: 700;
	box-shadow: 0 8px 18px rgba(174, 62, 201, .28);
}

.btn-primary:hover {
	transform: translateY(-1px);
	box-shadow: 0 12px 26px rgba(174, 62, 201, .38);
}

.btn-outline-secondary {
	font-weight: 600;
}
</style>
</head>

<body>
	<%
	Customer loginCustomer = (Customer) session.getAttribute("customer");
	%>

	<!-- ===== Navbar (unchanged) ===== -->
	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<a class="navbar-brand fw-bold text-white"
				href="<%=request.getContextPath()%>/index.jsp"> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" class="me-2"> Welcome From Mesa
			</a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse justify-content-end"
				id="navbarSupportedContent">
				<ul class="navbar-nav gap-4">
					<%
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/index.jsp"> <i
							class="bi bi-house-fill me-1"></i>Home
					</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/member_index.jsp"> <i
							class="bi bi-house-fill me-1"></i>Home
					</a></li>
					<%
					}
					%>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/MenuListServlet"> <i class="bi bi-menu-down me-1"></i>Menu
					</a></li>


					<%
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/reserve/form"> <i
							class="bi bi-calendar-check me-1"></i>Reservation
					</a></li>
					<%
					}
					%>

					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/contact.jsp"> <i
							class="bi bi-telephone-fill me-1"></i>Contact
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/map.jsp"> <i
							class="bi bi-pin-map-fill me-1"></i>Map
					</a></li>

					<%
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a
						class="nav-link active text-white fw-bold ms-lg-3"
						href="<%=request.getContextPath()%>/login.jsp"> <i
							class="bi bi-box-arrow-in-right me-1"></i>Login
					</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link text-white ms-lg-3"
						href="<%=request.getContextPath()%>/Customer_LogOut"> <i
							class="bi bi-box-arrow-right me-1"></i>LogOut
					</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>


	<div class="page-wrap">

		<%
		if (temp == null) {
		%>
		<!-- ===== No session data ===== -->
		<div class="alert alert-warning text-center">
			登録情報が見つかりません。<br> <a href="registerForm.jsp" class="alert-link">登録画面へ戻る</a>
		</div>
		<%
		} else {
		%>

		<!-- ===== Confirm Card ===== -->
		<div class="confirm-card">

			<h4 class="confirm-title">登録内容の確認</h4>

			<div class="confirm-row">
				<div class="confirm-label">名前</div>
				<div class="confirm-value"><%=temp.getName()%></div>
			</div>

			<div class="confirm-row">
				<div class="confirm-label">フリガナ</div>
				<div class="confirm-value"><%=temp.getNameKana()%></div>
			</div>

			<div class="confirm-row">
				<div class="confirm-label">メールアドレス</div>
				<div class="confirm-value"><%=temp.getEmail()%></div>
			</div>

			<div class="confirm-row">
				<div class="confirm-label">電話番号</div>
				<div class="confirm-value"><%=temp.getPhone()%></div>
			</div>

			<div class="confirm-row">
				<div class="confirm-label">パスワード</div>
				<div class="confirm-value">
					<%=temp.getPassword().replaceAll(".", "●")%>
				</div>
			</div>

			<!-- buttons -->
			<div class="d-flex justify-content-center gap-3 mt-4">
				<form action="registerForm.jsp" method="get">
					<button type="submit" class="btn btn-outline-secondary px-4">
						修正する</button>
				</form>

				<form action="Registerinsertionservlet" method="post">
					<button type="submit" class="btn btn-primary px-4">
						この内容で登録</button>
				</form>
			</div>

		</div>

		<%
		}
		%>

	</div>

	<%@ include file="footer.jsp"%>


</body>
</html>
