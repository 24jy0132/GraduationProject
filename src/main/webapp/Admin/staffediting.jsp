<%@ include file="../header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Staff"%>

<%
Staff staff = (Staff) session.getAttribute("staff");
%>

<title>従業員編集</title>

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
}

.edit {
	background: black;
	color: white;
	padding: 8px 25px;
	font-size: 16px;
	border: none;
	border-radius: 6px;
	margin-left: 10px;
	cursor: pointer;
}

.buttons .back button {
	background: black;
}

.form-container {
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
</style>

</head>
<body>

	<div class="container-fluid">
		<h1>MHP株式会社 営業サポートシステム</h1>

		<div class="container">
			
			<!-- Top right buttons -->
			<div class="buttons">
				<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp">
					<button>管理TOP</button>
				</a> <a href="<%=request.getContextPath()%>/logout">
					<button>ログアウト</button>
				</a>
			</div>

			<!-- Edit Form -->
			<div class="form-container">
				<h3 class="mb-4">従業員編集</h3>

				<form action="<%=request.getContextPath()%>/Adminstaffupdateservlet"
					method="post">

					<input type="hidden" name="staffId" value="<%=staff.getStaffId()%>">

					<div class="mb-3">
						<label>名前</label> <input type="text" name="staffName"
							class="form-control" value="<%=staff.getStaffName()%>" required>
					</div>

					<div class="mb-3">
						<label>フリガナ</label> <input type="text" name="staffNameFurigana"
							class="form-control" value="<%=staff.getStaffNameFurigana()%>">
					</div>

					<div class="mb-3">
						<label class="form-label d-block">職種</label>

						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="staffType"
								value="Staff"
								<%="Staff".equals(staff.getStaffType()) ? "checked" : ""%>>
							<label class="form-check-label">Staff</label>
						</div>

						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="staffType"
								value="Part-time"
								<%="Part-time".equals(staff.getStaffType()) ? "checked" : ""%>>
							<label class="form-check-label">Part-time</label>
						</div>
					</div>

					<div class="mb-3">
						<label>電話番号</label> <input type="text" name="staffPhone"
							class="form-control" value="<%=staff.getStaffPhone()%>">
					</div>

					<div class="mb-3">
						<label>メール</label> <input type="email" name="staffEmail"
							class="form-control" value="<%=staff.getStaffEmail()%>">
					</div>

					<div class="mb-3">
						<label>住所</label> <input type="text" name="staffAddress"
							class="form-control" value="<%=staff.getStaffAddress()%>">
					</div>

					<div class="buttons">
						<a class="back"
							href="<%=request.getContextPath()%>/Adminmanagementservlet">
							<button type="button">戻る</button>
						</a>
						<button class="edit" type="submit">更新</button>
					</div>

				</form>
			</div>
		</div>
	</div>

</body>
</html>