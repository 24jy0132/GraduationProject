<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.List, java.util.Map, model.Menu, model.Customer"%>

<%
List<Menu> surveyMenus = (List<Menu>) request.getAttribute("surveyMenus");
List<Menu> newMenus = (List<Menu>) request.getAttribute("newMenus");
List<Menu> mainMenus = (List<Menu>) request.getAttribute("mainMenus");
List<Menu> alaCarteMenus = (List<Menu>) request.getAttribute("alaCarteMenus");
List<Menu> saladSoup = (List<Menu>) request.getAttribute("saladSoup");
List<Menu> drinks = (List<Menu>) request.getAttribute("drinks");
List<Menu> course = (List<Menu>) request.getAttribute("course");

Map<Integer, Map<String, Integer>> tasteSummary = (Map<Integer, Map<String, Integer>>) request
		.getAttribute("tasteSummary");

Customer loginCustomer = (Customer) session.getAttribute("customer");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー一覧</title>

<style>
body {
	background-color: #f8f9fa;
}

.card-img-top {
	height: 150px;
	object-fit: cover;
}

<
style>body {
	background-color: #f8f9fa;
}

.card-img-top {
	height: 150px;
	object-fit: cover;
}

/* ===== Survey Special Design ===== */
.survey-area {
	background: #fff3f8;
	border-radius: 12px;
	padding: 20px;
	border: 1px dashed #f5c2d7;
}

.survey-card {
	border: 2px solid #f06292;
}

.survey-badge {
	position: absolute;
	top: 10px;
	left: 10px;
	background: #f06292;
	color: #fff;
	font-size: 0.75rem;
	padding: 4px 8px;
	border-radius: 6px;
	font-weight: bold;
}
</style>

</style>
</head>

<body>

	<!-- ===== Navbar ===== -->
	<nav class="navbar navbar-expand-lg bg-danger py-3">
		<div class="container">
			<a
				class="navbar-brand d-flex align-items-center gap-3 fw-bold text-white"
				href="<%=request.getContextPath()%>/index.jsp"> <!-- Logo --> <img
				src="<%=request.getContextPath()%>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
				height="40" width="40" class="me-1"> <%
 if (loginCustomer != null) {
 %> <!-- Logged-in user info -->
				<div class="d-flex align-items-center gap-2 px-3 py-1 rounded-pill"
					style="background: rgba(255, 255, 255, 0.15);">

					<!-- User Icon -->
					<i class="bi bi-person-circle fs-5"></i>

					<!-- User Name -->
					<span class="small fw-semibold"> <%=loginCustomer.getName()%>
					</span>

					<!-- Points -->
					<span class="badge bg-light text-danger fw-bold"> <%=loginCustomer.getPoint()%>
						pt
					</span>
				</div> <%
 } else { %>
 <!-- Not logged in -->
 <span class="small fw-semibold">
   Welcome From Mesa
 </span>
<% } %>
 


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

	<!-- ===== Page Content ===== -->
	<div class="container my-5">

		<!-- ================= Survey (SPECIAL DESIGN) ================= -->
		<div class="survey-area mb-5">

			<div class="d-flex align-items-center mb-3">
				<h4 class="fw-bold mb-0">アンケート対象商品</h4>
				<span class="badge bg-danger ms-2">ポイント獲得</span>
			</div>

			<p class="text-muted small mb-4">
				回答すると <strong>1商品につき1ポイント</strong> がもらえます
			</p>

			<div class="row g-3">
				<%
				if (surveyMenus != null) {
					for (Menu m : surveyMenus) {
				%>
				<div class="col-6 col-md-4 col-lg-3">
					<div class="card h-100 shadow-sm survey-card position-relative">

						<!-- Ribbon -->
						<div class="survey-badge">POINT</div>

						<img src="<%=request.getContextPath() + "/" + m.getImagePath()%>"
							class="card-img-top">

						<div class="card-body d-flex flex-column">
							<h6 class="fw-bold"><%=m.getMenuName()%></h6>

							<p class="small text-muted">
								<%=m.getDescription()%>
							</p>

							<!-- Review summary -->
							<div class="mb-2">
								<%
								Map<String, Integer> map = tasteSummary != null ? tasteSummary.get(m.getMenuId()) : null;

								if (map != null && !map.isEmpty()) {
									for (Map.Entry<String, Integer> e : map.entrySet()) {
								%>
								<span class="badge bg-light text-dark border me-1"> <%=e.getKey()%>
									× <%=e.getValue()%>
								</span>
								<%
								}
								} else {
								%>
								<span class="badge bg-secondary">レビューなし</span>
								<%
								}
								%>
							</div>

							<div class="mt-auto">
								<div class="fw-bold text-end mb-2">
									¥<%=m.getPrice()%>
								</div>

								<a href="SurveyServlet?menuId=<%=m.getMenuId()%>"
									class="btn btn-danger btn-sm w-100"> アンケートに回答 </a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				}
				%>
			</div>
		</div>


		<!-- ================= Reusable Section Template ================= -->
		<%
		String[][] sections = {
				{ "新商品", "期間限定・おすすめ" },
				{ "コース", "セットメニュー" },
				{ "メイン商品", "人気メニュー" },
				{ "アラカルト", "追加で注文" },
				{ "サラダ・スープ", "さっぱり系" },
				{ "ドリンク", "食事と一緒に" }
		};

		List<Menu>[] menuLists = new List[] {
				newMenus, course, mainMenus, alaCarteMenus, saladSoup, drinks
		};

		for (int i = 0; i < sections.length; i++) {
		%>

		<h4 class="fw-bold mb-3"><%=sections[i][0]%></h4>
		<div class="row g-3 mb-5">
			<%
			if (menuLists[i] != null) {
				for (Menu m : menuLists[i]) {
			%>
			<div class="col-6 col-md-4 col-lg-3">
				<div class="card h-100 shadow-sm">
					<img src="<%=request.getContextPath() + "/" + m.getImagePath()%>"
						class="card-img-top">
					<div class="card-body">
						<h6 class="fw-bold"><%=m.getMenuName()%></h6>
						<p class="small text-muted"><%=m.getDescription()%></p>
						<div class="fw-bold text-end">
							¥<%=m.getPrice()%></div>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>

		<%
		}
		%>

	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
