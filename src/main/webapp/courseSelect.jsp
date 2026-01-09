<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp"%>

<%@ page import="java.util.*"%>
<%@ page import="model.Menu"%>
<%@ page import="model.Reservation"%>

<%
Reservation r = (Reservation) session.getAttribute("pendingReservation");
List<Menu> courses = (List<Menu>) request.getAttribute("courses");

if (r == null || r.getTableIds() == null || r.getTableIds().isEmpty()) {
	response.sendRedirect(request.getContextPath() + "/reserve/form");
	return;
}
%>


<head>
<title>コース選択</title>

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

/* ===== STEPPER ===== */
.stepper {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 30px;
}

.step {
	text-align: center;
	color: #adb5bd;
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

.step.done .circle {
	background: #198754;
	color: #fff;
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

/* ===== CARD ===== */
.form-card {
	max-width: 720px;
	width: 100%;
}

.option-card {
	border: 2px solid #dee2e6;
	border-radius: 12px;
	padding: 20px;
	cursor: pointer;
	transition: .2s;
}

.option-card.active {
	border-color: #0d6efd;
	background: #f8f9ff;
}
</style>
</head>

<body>

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
					<li class="nav-item"><a class="nav-link active text-white"
						href="<%=request.getContextPath()%>/index.jsp"><i
							class="bi bi-house-fill me-1"></i>Home</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="MenuListServlet"><i class="bi bi-menu-down me-1"></i>Menu</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/reserve/form"> <i
							class="bi bi-calendar-check me-1"></i>Reservation
					</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/contact.jsp"><i
							class="bi bi-telephone-fill me-1"></i>Contact</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="<%=request.getContextPath()%>/map.jsp"><i
							class="bi bi-pin-map-fill me-1"></i>Map</a></li>
				</ul>
				<a class="nav-link active text-white fw-bold ms-lg-3 mt-2 mt-lg-0"
					href="<%=request.getContextPath()%>/login.jsp"> <i
					class="bi bi-box-arrow-in-right me-1"></i>Login
				</a>
			</div>
		</div>
	</nav>

	<!-- ===== MAIN ===== -->
	<main>
		<div class="container">

			<!-- STEPPER -->
			<div class="stepper">
				<div class="step done">
					<div class="circle">1</div>
					入力
				</div>
				<div class="line"></div>
				<div class="step done">
					<div class="circle">2</div>
					席選択
				</div>
				<div class="line"></div>
				<div class="step active">
					<div class="circle">3</div>
					コース
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">4</div>
					確認
				</div>
				<div class="line"></div>
				<div class="step">
					<div class="circle">5</div>
					完了
				</div>
			</div>

			<!-- CARD -->
			<div class="card shadow form-card p-4 mx-auto">
				<h3 class="fw-bold text-center mb-4">予約方法を選択</h3>

				<form method="post"
					action="<%=request.getContextPath()%>/reserve/course">

					<input type="hidden" name="reservationType" id="type"
						value="SEAT_ONLY">

					<!-- SEAT ONLY -->
					<div id="seat" class="option-card active mb-3">
						<h5 class="fw-bold">席のみ予約</h5>
						<p class="text-muted mb-0">お席のみ確保します</p>
					</div>

					<!-- COURSE -->
					<div id="course" class="option-card mb-3">
						<h5 class="fw-bold">コース予約</h5>
						<select name="courseId" class="form-select mt-2">
							<%
							for (Menu m : courses) {
							%>
							<option value="<%=m.getMenuId()%>">
								<%=m.getMenuName()%>（¥<%=m.getPrice()%>）
							</option>
							<%
							}
							%>
						</select>

					</div>
					<h5 class="fw-bold">
						<a class="nav-link text-black"
							href="<%=request.getContextPath()%>/MenuListServlet"><i
							class="bi bi-menu-down me-1"></i>メニューの詳しくはこちまで!</a>
					</h5>
					<div class="text-end mt-4">
						<button class="btn btn-primary px-4">次へ（確認）</button>
					</div>
				</form>
			</div>

		</div>
	</main>

	<%@ include file="footer.jsp"%>

	<script>
const seat = document.getElementById("seat");
const course = document.getElementById("course");
const type = document.getElementById("type");

seat.onclick = () => {
    seat.classList.add("active");
    course.classList.remove("active");
    type.value = "SEAT_ONLY";
};

course.onclick = () => {
    course.classList.add("active");
    seat.classList.remove("active");
    type.value = "COURSE";
};
</script>

</body>
</html>
