<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Staff"%>
<%@ page import="java.util.List"%>
<title>Staff Registeration</title>

<style>
body {
	background: #f5f5f5;
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

h1, h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

/* Top buttons */
.buttons {
	text-align: right;
	margin-bottom: 15px;
}

.buttons a button {
	background: #007bff;
	color: #fff;
	padding: 8px 20px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: 0.3s;
	margin-left: 10px;
}

.buttons a button:hover {
	background: #0056b3;
}

/* Form container */
.staffhero {
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	max-width: 500px;
	margin: auto;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* Form fields */
.form-label {
	font-weight: 500;
}

.form-control, .form-select {
	margin-bottom: 15px;
}

/* Submit button */
button.btn-primary {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border-radius: 6px;
	border: none;
	background-color: #007bff;
	color: #fff;
	cursor: pointer;
}

button.btn-primary:hover {
	background-color: #0056b3;
}

</style>

</head>
<body>
	<div class="container-fluid">
		<h1>MHP株式会社 営業サポートシステム</h1>
		<h2>従業員管理</h2>

		<div class="container">
			<div class="topcontainer">
				
				<!-- Top right buttons -->
				<div class="buttons">
					<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"><button>管理TOP</button></a>
					<a href="<%=request.getContextPath()%>/Adminlogoutservlet"><button>ログアウト</button></a>
				</div>

				<!-- Display errors if any -->
				<%
				List<String> errors = (List<String>) request.getAttribute("errors");
				if (errors != null && !errors.isEmpty()) {
				%>
				<div style="color: red; margin-bottom: 15px;">
					<ul>
						<%
						for (String e : errors) {
						%>
						<li><%=e%></li>
						<%
						}
						%>
					</ul>
				</div>
				<%
				}
				// Pre-fill from session if exists
				Staff temp = (Staff) session.getAttribute("tempStaff");
				%>

				<!-- Form -->
				<div class="staffhero">
					<form
						action="<%=request.getContextPath()%>/Staffconfirmationservlet"
						method="post">

						<div class="mb-3">
							<label for="staffname" class="form-label">従業員名</label> <input
								type="text" class="form-control" id="staffname" name="staffname"
								value="<%=request.getAttribute("staffname") != null ? request.getAttribute("staffname")
		: (temp != null ? temp.getStaffName() : "")%>">
						</div>

						<div class="mb-3">
							<label for="staffnamefurigana" class="form-label">従業員名フリガナ</label>
							<input type="text" class="form-control" id="staffnamefurigana"
								name="staffnamefurigana"
								value="<%=request.getAttribute("staffnamefurigana") != null ? request.getAttribute("staffnamefurigana")
		: (temp != null ? temp.getStaffNameFurigana() : "")%>">
						</div>
						<label for="stafftype" class="form-label">従業員種類</label> <select
							class="form-select" name="stafftype"
							aria-label="Default select example" 　id="stafftype">
							<option value="staff"
								<%="staff".equals(request.getAttribute("stafftype")) || (temp != null && "admin".equals(temp.getStaffType()))
		? "selected"
		: ""%>>正社員</option>
							<option value="parttime"
								<%="parttime".equals(request.getAttribute("stafftype")) || (temp != null && "parttime".equals(temp.getStaffType()))
				? "selected"
				: ""%>>アルバイト</option>
						</select>

						<div class="mb-3">
							<label for="staffphone" class="form-label">電話番号</label> <input
								type="tel" class="form-control" id="staffphone"
								name="staffphone"
								value="<%=request.getAttribute("staffphone") != null ? request.getAttribute("staffphone")
		: (temp != null ? temp.getStaffPhone() : "")%>">
						</div>

						<div class="mb-3">
							<label for="staffemail" class="form-label">メール</label> <input
								type="email" class="form-control" id="staffemail"
								name="staffemail"
								value="<%=request.getAttribute("staffemail") != null ? request.getAttribute("staffemail")
		: (temp != null ? temp.getStaffEmail() : "")%>">
						</div>

						<div class="mb-3">
							<label for="staffaddress" class="form-label">住所</label> <input
								type="text" class="form-control" id="staffaddress"
								name="staffaddress"
								value="<%=request.getAttribute("staffaddress") != null ? request.getAttribute("staffaddress")
		: (temp != null ? temp.getStaffAddress() : "")%>">
						</div>

						<div class="mb-3">
							<label for="staffpassword" class="form-label">パスワード</label> <input
								type="password" class="form-control" id="staffpassword"
								name="staffpassword">
						</div>

						<div class="mb-3">
							<label for="staffrepassword" class="form-label">パスワード確認</label> <input
								type="password" class="form-control" id="staffrepassword"
								name="staffrepassword">
						</div>

						<button type="submit" class="btn btn-primary">Submit</button>
					</form>
				</div>
				<div class="buttons">
					<a href="Admin_emp_manage.jsp"><button>戻る</button></a>
				</div>
			</div>
		</div>
</body>
</html>