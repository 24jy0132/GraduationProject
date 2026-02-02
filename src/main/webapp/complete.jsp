<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp"%>
<%@ page import="model.Customer"%>
<%
Customer loginCustomer = (Customer) session.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
<title>予約完了 | Mesa</title>

<style>
/* =====================
   GLOBAL LAYOUT
===================== */
html, body {
	height: 100%;
}

body {
	background-color: #f8f9fa;
	display: flex;
	flex-direction: column;
}

main {
	flex: 1;
	padding: 30px 15px;
	display: flex;
	align-items: center; /* Center vertical */
	justify-content: center;
}

/* =====================
   STEPPER
===================== */
.stepper {
	display: flex;
	justify-content: center;
	margin-bottom: 40px;
	position: relative;
	width: 100%;
}

.step {
	text-align: center;
	font-size: 0.8rem;
	color: #adb5bd;
	position: relative;
	z-index: 1;
	min-width: 60px;
}

.step .circle {
	width: 32px;
	height: 32px;
	background: #e9ecef;
	border-radius: 50%;
	margin: 0 auto 5px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: bold;
	color: #6c757d;
}

.step.active {
	color: #dc3545;
	font-weight: bold;
}

.step.active .circle {
	background: #dc3545;
	color: white;
	box-shadow: 0 0 0 4px rgba(220, 53, 69, 0.2);
}

/* All previous steps are "Done" (Green) */
.step.done .circle {
	background: #198754;
	color: white;
}

.step.done {
	color: #198754;
}

.line {
	width: 40px;
	height: 2px;
	background: #dee2e6;
	margin: 0 5px 20px 5px;
}

/* =====================
   SUCCESS CARD
===================== */
.complete-container {
	max-width: 600px;
	width: 100%;
}

.success-card {
	background: white;
	border: 1px solid #dee2e6;
	border-radius: 12px;
	padding: 50px 30px;
	text-align: center;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.success-icon {
	font-size: 5rem;
	color: #198754;
	margin-bottom: 20px;
	animation: popIn 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

@
keyframes popIn { 0% {
	transform: scale(0);
	opacity: 0;
}

100
%
{
transform
:
scale(
1
);
opacity
:
1;
}
}
.complete-title {
	font-size: 1.8rem;
	font-weight: 800;
	color: #212529;
	margin-bottom: 15px;
}

.complete-message {
	color: #6c757d;
	line-height: 1.8;
	margin-bottom: 30px;
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
				height="40" width="40" class="me-1" alt="Logo"> Welcome From Mesa <%
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
					if (loginCustomer == null) {
					%>
					<li class="nav-item"><a
						class="nav-link active text-white fw-bold ms-lg-3"
						href="<%=request.getContextPath()%>/login.jsp"><i
							class="bi bi-box-arrow-in-right me-1"></i>Login</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link text-white ms-lg-3"
						href="<%=request.getContextPath()%>/Customer_LogOut"><i
							class="bi bi-box-arrow-right me-1"></i>LogOut</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>

	<main>
		<div class="complete-container">

			<div class="stepper">
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					入力
				</div>
				<div class="line"></div>
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					席選択
				</div>
				<div class="line"></div>
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					コース
				</div>
				<div class="line"></div>

				<%
				if (loginCustomer != null) {
				%>
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					クーポン
				</div>
				<div class="line"></div>
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					確認
				</div>
				<div class="line"></div>
				<div class="step active">
					<div class="circle">6</div>
					完了
				</div>
				<%
				} else {
				%>
				<div class="step done">
					<div class="circle">
						<i class="bi bi-check"></i>
					</div>
					確認
				</div>
				<div class="line"></div>
				<div class="step active">
					<div class="circle">5</div>
					完了
				</div>
				<%
				}
				%>
			</div>

			<div class="success-card">
				<i class="bi bi-check-circle-fill success-icon"></i>

				<div class="complete-title">ご予約ありがとうございます</div>

				<div class="complete-message">
					予約が完了いたしました。<br> ご登録のメールアドレスへ確認メールを送信しました。<br>
					当日のご来店を心よりお待ちしております。
				</div>

				<%
				Boolean mailFailed = (Boolean) session.getAttribute("mailFailed");
				session.removeAttribute("mailFailed");

				if (mailFailed != null && mailFailed) {
				%>
				<div
					class="alert alert-warning d-flex align-items-center text-start mx-auto"
					style="max-width: 450px;" role="alert">
					<i class="bi bi-exclamation-triangle-fill fs-4 me-3"></i>
					<div>
						<strong>メール送信エラー</strong><br>
						メール送信には失敗しましたが、予約はシステム上で正常に完了しています。
					</div>
				</div>
				<%
				}
				%>

				<div class="mt-4 pt-2">
					<%
					if (loginCustomer != null) {
					%>
					<a href="<%=request.getContextPath()%>/member_index.jsp"
						class="btn btn-primary px-5 py-3 fw-bold rounded-pill shadow">
						ホームへ戻る </a>
					<%
					} else {
					%>
					<a href="<%=request.getContextPath()%>/index.jsp"
						class="btn btn-primary px-5 py-3 fw-bold rounded-pill shadow">
						トップページへ戻る </a>
					<%
					}
					%>
				</div>

			</div>
		</div>
	</main>

	<%@ include file="footer.jsp"%>

</body>
</html>