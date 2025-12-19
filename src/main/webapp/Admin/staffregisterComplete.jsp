<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<title>StaffRegisterComplete</title>

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

.confirm-box {
	background: #fff;
	padding: 25px;
	border-radius: 10px;
	max-width: 600px;
	margin: auto;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
</style>

</head>
<body>
	<div class="container-fluid">
		<h1>MHP株式会社 営業サポートシステム</h1>

		<div class="container">
		
			<!-- Top right buttons -->
			 <div class="buttons">
                <a href="<%= request.getContextPath() %>/Admin/adminhome.jsp"><button>管理TOP</button></a>
                <a href="<%= request.getContextPath() %>/Adminlogoutservlet"><button>ログアウト</button></a>
            </div>

			<div class="confirm-box">
				<%
				String message = (String) session.getAttribute("message");
				%>

				<%
				if (message != null) {
				%>
				<h2 style="color: green;"><%=message%></h2>
				<%
				session.removeAttribute("message");
				%>
				<%
				} else {
				%>
				<h2>No registration information found.</h2>
				<%
				}
				%>
			</div>

		</div>
	</div>
</body>
</html>