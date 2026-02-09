	<%@ include file="../header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Customer"%>

<%
// Retain customer login logic for the Navbar
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>

<!DOCTYPE html>
<html>
<head>
<title>予約エラー</title>

<style>
html, body {
	height: 100%;
}

body {
	margin: 0;
	display: flex;
	flex-direction: column;
	background-color: #f8f9fa;
	/* Light background for better contrast with the white card */
}

main {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 40px 15px;
}

/* ===== ERROR CARD STYLE (From your request) ===== */
.error-card {
	max-width: 500px;
	width: 100%;
	background: #fff;
	padding: 40px;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .1);
	text-align: center;
}

.error-title {
	color: #e03131;
	font-weight: bold;
	margin-bottom: 20px;
}
</style>
</head>

<body>

	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<a
				class="navbar-brand d-flex align-items-center gap-3 fw-bold text-white"
				href="<%=request.getContextPath()%>/index.jsp"> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" class="me-1"> <%
 if (loginCustomer != null) {
 %>
				<div class="d-flex align-items-center gap-2 px-3 py-1 rounded-pill"
					style="background: rgba(255, 255, 255, 0.15);">
					<i class="bi bi-person-circle fs-5"></i> <span
						class="small fw-semibold"> <%=loginCustomer.getName()%>
					</span> <span id="pointBadge"
						class="badge bg-light text-danger fw-bold position-relative">
						<%=loginCustomer.getPoint()%> pt
					</span>
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
						href="<%=request.getContextPath()%>/MenuListServlet"> <i
							class="bi bi-menu-down me-1"></i>Menu
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

	<main>
		<div class="container d-flex justify-content-center">

			<div class="error-card">

				<h3 class="error-title">予約できません</h3>

				<p style="margin: 20px 0; font-size: 1.1rem; color: #555;">
					<%=request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "予期せぬエラーが発生しました。"%>
				</p>

				<button class="btn btn-dark px-4 py-2 mt-2"
					onclick="location.href='<%=request.getContextPath()%>/reserve/form'">
					予約をやり直す</button>

			</div>
		</div>
	</main>

	<%@ include file="../footer.jsp"%>
</body>
</html>