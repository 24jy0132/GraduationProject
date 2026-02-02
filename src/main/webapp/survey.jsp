<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Menu,model.Customer"%>

<%
Menu menu = (Menu) request.getAttribute("menu");
Customer loginCustomer = (Customer) session.getAttribute("customer");
if (menu == null) {
	response.sendRedirect("MenuListServlet");
	return;
}
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>商品レビューアンケート</title>



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

/* main card */
.page-box {
	background: var(--card);
	border-radius: 20px;
	padding: 32px;
	border: 1px solid var(--line);
	box-shadow: 0 18px 40px rgba(0, 0, 0, .10);
}

/* section title */
.section-title {
	font-weight: 800;
	font-size: 0.9rem;
	margin-bottom: .5rem;
	color: #2b2b2b;
}

/* option layout */
.option-row {
	gap: 1.5rem;
	row-gap: .75rem;
}

/* product box */
.product-box {
	background: #faf7ff;
	border: 1px solid #e7d9ff;
	border-radius: 14px;
	padding: 16px;
}

/* textarea */
.comment-box {
	background: #fbf7ff;
	border-radius: 12px;
	border: 1px solid #e7d9ff;
}

.comment-box:focus {
	box-shadow: 0 0 0 .2rem rgba(174, 62, 201, .15);
	border-color: rgba(174, 62, 201, .45);
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
	border-color: #d7d7e2;
	font-weight: 600;
}
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
					<span id="pointBadge"
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

	<!-- ===== Main ===== -->
	<div class="container py-5 flex-grow-1">
		<div class="row justify-content-center">
			<div class="col-12 col-md-9 col-lg-7">

				<div class="page-box">

					<h4 class="fw-bold mb-2">商品レビューアンケート</h4>
					<p class="text-muted mb-4">
						ご意見は今後のサービス改善に活用します。<br> 回答は <strong>1商品につき1回のみ</strong>、ポイントが加算されます。
					</p>

					<!-- Product -->
					<div class="product-box mb-4">
						<div class="d-flex gap-3 align-items-center">
							<img src="<%=menu.getImagePath()%>"
								style="width: 96px; height: 72px; object-fit: cover; border-radius: 8px;">
							<div>
								<div class="fw-bold"><%=menu.getMenuName()%></div>
								<div class="small text-muted"><%=menu.getDescription()%></div>
								<div class="fw-bold mt-1">
									¥<%=menu.getPrice()%></div>
							</div>
						</div>
					</div>

					<form action="SurveyDoneServlet" method="post">
						<input type="hidden" name="menuId" value="<%=menu.getMenuId()%>">

						<!-- Taste -->
						<div class="mb-4">
							<div class="section-title">味の印象</div>
							<div class="d-flex flex-wrap option-row">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="taste"
										value="とてもおいしかった" required> <label
										class="form-check-label">とてもおいしかった</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="taste"
										value="おいしかった"> <label class="form-check-label">おいしかった</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="taste"
										value="普通だった"> <label class="form-check-label">普通だった</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="taste"
										value="あまり口に合わなかった"> <label class="form-check-label">あまり口に合わなかった</label>
								</div>
							</div>
						</div>

						<!-- Volume -->
						<div class="mb-4">
							<div class="section-title">量の印象</div>
							<div class="d-flex flex-wrap option-row">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="volume"
										value="少ない" required> <label class="form-check-label">少ない</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="volume"
										value="ちょうどいい"> <label class="form-check-label">ちょうどいい</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="volume"
										value="多い"> <label class="form-check-label">多い</label>
								</div>
							</div>
						</div>

						<!-- Price -->
						<div class="mb-4">
							<div class="section-title">値段の印象</div>
							<div class="d-flex flex-wrap option-row">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="price"
										value="やすい" required> <label class="form-check-label">やすい</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="price"
										value="妥当"> <label class="form-check-label">妥当</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="price"
										value="高い"> <label class="form-check-label">高い</label>
								</div>
							</div>
						</div>

						<!-- Comment -->
						<div class="mb-4">
							<div class="section-title">任意コメント（管理者のみ閲覧）</div>
							<textarea class="form-control comment-box" name="comment"
								rows="4" placeholder="改善点やご意見があればご記入ください"></textarea>
						</div>

						<!-- Buttons -->
						<div class="d-flex justify-content-center gap-3">
							<button type="button" class="btn btn-outline-secondary px-4"
								onclick="history.back()">戻る</button>
							<button type="submit" class="btn btn-primary px-4">投稿する</button>
						</div>
					</form>

				</div>

			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>

</body>
</html>
