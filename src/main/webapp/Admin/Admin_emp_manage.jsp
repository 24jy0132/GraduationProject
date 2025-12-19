<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Staff"%>

<title>従業員管理</title>

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

.buttons .edit button {
	background: black;
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

			<!-- Navigation -->





			<div class="mt-4">
				<h3 class="mb-3">従業員一覧</h3>

				<table class="table table-bordered table-striped table-hover">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>名前</th>
							<th>フリガナ</th>
							<th>職種</th>
							<th>電話番号</th>
							<th>メール</th>
							<th>住所</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Staff> list = (List<Staff>) session.getAttribute("staffList");
						if (list != null && !list.isEmpty()) {
							for (Staff s : list) {
						%>
						<tr>
							<td><%=s.getStaffId()%></td>
							<td><%=s.getStaffName()%></td>
							<td><%=s.getStaffNameFurigana()%></td>
							<td><%=s.getStaffType()%></td>
							<td><%=s.getStaffPhone()%></td>
							<td><%=s.getStaffEmail()%></td>
							<td><%=s.getStaffAddress()%></td>
							<td>
								<div class="buttons">
									<a href="<%= request.getContextPath() %>/Staffeditingservlet?staffId=<%= s.getStaffId() %>" class="edit"><button>編集</button></a> <a
										href="<%= request.getContextPath() %>/Staffdeletingservlet?staffId=<%= s.getStaffId() %>"  class="edit"><button>削除</button></a>
								</div>
							</td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="7" class="text-center">従業員情報がありません。</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
			<div class="buttons">
				<a href="${pageContext.request.contextPath}/Admin/adminhome.jsp"><button>戻る</button></a>
				<a href="${pageContext.request.contextPath}/Admin/staffregisteration.jsp"><button>従業員追加</button></a>
			</div>
		</div>
	</div>
</body>
</html>