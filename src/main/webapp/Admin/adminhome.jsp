<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Staff"%>
<%
Staff admin = (Staff) session.getAttribute("admin");
%>
<title>Adminhome</title>

<style>
body {
	background: #f5f5f5;
	margin: 0;
	padding: 0;
}

h1 {
	text-align: center;
	margin-top: 30px;
	margin-bottom: 40px;
	font-weight: 700;
	color: #333;
}

/* Top buttons (管理TOP / ログアウト) */
.buttons {
	text-align: right;
	margin-bottom: 20px;
}

.buttons a button {
	background: #007bff;
	color: white;
	padding: 8px 25px;
	font-size: 16px;
	border: none;
	border-radius: 6px;
	margin-left: 10px;
	cursor: pointer;
	transition: 0.3s;
}

.buttons a button:hover {
	background: #0056b3;
}

/* Navigation pills styling */
.nav-pills .nav-link {
	font-size: 18px;
	padding: 10px 18px;
	color: #333;
	border-radius: 6px;
	transition: 0.3s;
}

.nav-pills .nav-link:hover {
	background: #e0e0e0;
}

.nav-pills .nav-link.active {
	background: #007bff;
	color: white;
}

/* Dropdown menu styling */
.dropdown-menu {
	font-size: 16px;
}

.dropdown-menu a {
	padding: 10px 15px;
}

.dropdown-menu a:hover {
	background: #f0f0f0;
}

.topcontainer{
	display:flex;
	justify-content: flex-end;
}

.top-bar {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

/* User Card – tighter width */
.user-card {
	display: inline-flex;
	align-items: flex-end;
	background: white;
	padding: 6px 10px;
	border-radius: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	gap: 8px;
	width: 200px;
}

/* Avatar smaller */
.user-avatar {
	width: 50px; /* reduced */
	height: 50px;
	background: linear-gradient(135deg, #007bff, #00c6ff);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-size: 18px;
}

/* Text */
.user-name {
	font-weight: 600;
	font-size: 18px;
}

.user-role {
	font-size: 16px;
	color: #777;
}
</style>

</head>
<body>
	<div class="container-fluid">
		<h1>MHP株式会社 営業サポートシステム</h1>

		<div class="container">
			<div class="topcontainer">
				<!-- Top right buttons -->
				<div class="top-bar">
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
			</div>
			<div class="buttons">
				<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"><button>管理TOP</button></a>
				<a href="<%=request.getContextPath()%>/Adminlogoutservlet"><button>ログアウト</button></a>
			</div>

			<!-- Navigation -->
			<div class="point">
				<ul class="nav nav-pills">

					<li class="nav-item"><a class="nav-link" href="#">予約確認</a></li>

					<li class="nav-item"><a class="nav-link" href="#">メニュー管理</a></li>

					<li class="nav-item"><a class="nav-link" href="#">割引管理</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
						href="#"> アンケート管理 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">アンケート作成</a></li>
							<li><a class="dropdown-item" href="#">回答一覧表</a></li>
							<li><a class="dropdown-item" href="#">その他</a></li>
						</ul></li>

					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/Adminmanagementservlet">従業員管理</a>
					</li>

				</ul>
			</div>

		</div>
	</div>
</body>
</html>