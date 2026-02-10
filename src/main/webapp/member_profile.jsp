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
<title>会員情報</title>
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

.profile-card {
	max-width: 720px;
	width: 100%;
}

.profile-row {
	padding: 12px 0;
	border-bottom: 1px solid #eee;
}

.profile-row:last-child {
	border-bottom: none;
}

.label {
	color: #6c757d;
	font-size: .9rem;
}

.value {
	font-weight: 600;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-danger py-3 sticky-top">
		<div class="container">
			<a
				class="navbar-brand d-flex align-items-center gap-3 fw-bold text-white"
				href="<%=request.getContextPath()%>/index.jsp"> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" class="me-1" alt="Logo"> Welcome From
				Mesa<%
 if (loginCustomer != null) {
 %>
				<div class="d-flex align-items-center gap-2 px-3 py-1 rounded-pill"
					style="background: rgba(255, 255, 255, 0.15);">
					<i class="bi bi-person-circle fs-5"></i> <span
						class="small fw-semibold"><%=loginCustomer.getName()%></span> <span
						class="badge bg-light text-danger fw-bold position-relative"><%=loginCustomer.getPoint()%>
						pt</span>
				</div> <%
 }
 %>
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
						href="<%=request.getContextPath()%>/index.jsp"><i
							class="bi bi-house-fill me-1"></i>Home</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/member_index.jsp"><i
							class="bi bi-house-fill me-1"></i>Home</a></li>
					<%
					}
					%>

					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/MenuListServlet"><i
							class="bi bi-menu-down me-1"></i>Menu</a></li>

					<%
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/reserve/form"><i
							class="bi bi-calendar-check me-1"></i>Reservation</a></li>
					<%
					}
					%>

					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/contact.jsp"><i
							class="bi bi-telephone-fill me-1"></i>Contact</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/map.jsp"><i
							class="bi bi-pin-map-fill me-1"></i>Map</a></li>

					<%
					if (loginCustomer != null) {
					%>
					<li class="nav-item"><a class="nav-link text-white ms-lg-3"
						href="<%=request.getContextPath()%>/Customer_LogOut"><i
							class="bi bi-box-arrow-right me-1"></i>LogOut</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a
						class="nav-link active text-white fw-bold ms-lg-3"
						href="<%=request.getContextPath()%>/login.jsp"><i
							class="bi bi-box-arrow-in-right me-1"></i>Login</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>


	<main>
		<div class="container">
			<div class="card shadow profile-card p-4 mx-auto">
				<h3 class="fw-bold text-center mb-4">会員情報</h3>
				<div class="profile-row row">
					<div class="col-4 label">お名前</div>
					<div class="col-8 value"><%=loginCustomer.getName()%></div>
				</div>
				<div class="profile-row row">
					<div class="col-4 label">メールアドレス</div>
					<div class="col-8 value"><%=loginCustomer.getEmail()%></div>
				</div>
				<div class="profile-row row">
					<div class="col-4 label">電話番号</div>
					<div class="col-8 value"><%=loginCustomer.getPhone()%></div>
				</div>
				<div class="profile-row row">
					<div class="col-4 label">パスワード</div>
					<div class="col-8 value"><%=loginCustomer.getPassword()%></div>
				</div>
				<div class="profile-row row mt-3">
					<div class="col-4 label">現在のポイント</div>
					<div class="col-8 value text-primary"><%=loginCustomer.getPoint()%>
						pt
					</div>
				</div>
				<div class="d-flex justify-content-end mt-4">
					<a href="<%=request.getContextPath()%>/member/edit"
						class="btn btn-primary px-4">情報を変更する</a>
				</div>
			</div>
		</div>
	</main>
	<%@ include file="footer.jsp"%>
</body>
</html>