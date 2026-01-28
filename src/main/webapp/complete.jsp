<%@ include file="header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Customer"%>
<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
<title>予約完了</title>

<style>
/* =====================
   PAGE LAYOUT
===================== */
html, body {
	height: 100%;
}

body {
	margin: 0;
	display: flex;
	flex-direction: column;
}

/* =====================
   MAIN CENTER AREA
===================== */
main {
	flex: 1;
	display: flex;
	align-items: center; /* vertical center */
	justify-content: center; /* horizontal center */
	padding: 20px;
}

/* wrapper for stepper + message */
.complete-wrapper {
	text-align: center;
}

/* =====================
   STEPPER
===================== */
.stepper {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 40px;
}

.step {
	text-align: center;
	color: #adb5bd;
	font-size: 0.9rem;
}

.step .circle {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	background: #dee2e6;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: auto;
	font-weight: bold;
}

.step.active {
	color: #0d6efd;
}

.step.active .circle {
	background: #0d6efd;
	color: #fff;
	box-shadow: 0 0 0 6px rgba(13, 110, 253, .15);
}

.line {
	width: 60px;
	height: 4px;
	background: #dee2e6;
	margin: 0 12px;
}

/* =====================
   COMPLETE MESSAGE
===================== */
.complete-title {
	font-size: 1.6rem;
	font-weight: 600;
	margin-bottom: 20px;
}

.complete-message {
	font-size: 1rem;
	line-height: 1.8;
	color: #333;
}
</style>
</head>

<body>

	<!-- =====================
     NAVBAR (TOP)
===================== -->
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

						href="<%=request.getContextPath()%>/Userloginservlet"> <i
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
						href="MenuListServlet"> <i class="bi bi-menu-down me-1"></i>Menu
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

	<!-- =====================
     MAIN (CENTER)
===================== -->
	<main>
		<div class="complete-wrapper">

			<!-- STEPPER -->
			<div class="stepper">
				<div class="step">
					<div class="circle">1</div>
					入力
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">2</div>
					席選択
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">3</div>
					コース
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">4</div>
					確認
				</div>
				<div class="line"></div>
				<div class="step active">
					<div class="circle">5</div>
					完了
				</div>
			</div>

			<!-- MESSAGE -->
			<div class="complete-title">ご予約ありがとうございます。</div>

			<div class="complete-message">
				予約が完了しました。確認メールを送信しました。<br> 当日のご来店を心よりお待ちしております。
			</div>

			<%
			Boolean mailFailed = (Boolean) session.getAttribute("mailFailed");
			session.removeAttribute("mailFailed");
			%>

			<%
			if (mailFailed != null && mailFailed) {
			%>
			<p style="color: red;">メール送信には失敗しましたが、予約は正常に完了しています。</p>
			<%
			}
			%>


		</div>
	</main>

	<!-- =====================
     FOOTER (BOTTOM)
===================== -->
	<%@ include file="footer.jsp"%>

</body>
</html>
