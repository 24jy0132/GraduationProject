<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Staff"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Staff Registration Confirmation</title>

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

.confirm-box {
	background: #fff;
	padding: 25px;
	border-radius: 10px;
	max-width: 600px;
	margin: auto;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

p {
	font-size: 16px;
	margin: 8px 0;
	border-bottom: 1px solid #ddd;
	padding-bottom: 5px;
}

.label {
	font-weight: bold;
	color: #555;
}

.buttons {
	text-align: center;
	margin-top: 30px;
}

button {
	padding: 10px 25px;
	font-size: 15px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	margin: 0 10px;
}

.btn-primary {
	background-color: #007bff;
	color: white;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.btn-secondary {
	background-color: #6c757d;
	color: white;
}

.btn-secondary:hover {
	background-color: #5a6268;
}
</style>

</head>
<body>

	<h1>MHP株式会社 営業サポートシステム</h1>
	<h2>従業員登録確認</h2>

	<div class="confirm-box">

		<%
		Staff temp = (Staff) session.getAttribute("tempStaff");

		if (temp == null) {
		%>
		<p>
			登録データが見つかりません。<a href="Staffregisterservlet.jsp">フォームへ戻る</a>
		</p>

		<%
		} else {
		%>

		<p>
			<span class="label">従業員名：</span>
			<%=temp.getStaffName()%></p>
		<p>
			<span class="label">従業員名フリガナ：</span>
			<%=temp.getStaffNameFurigana()%></p>
		<p>
			<span class="label">従業員種別：</span>
			<%=temp.getStaffType()%></p>
		<p>
			<span class="label">電話番号：</span>
			<%=temp.getStaffPhone()%></p>
		<p>
			<span class="label">メール：</span>
			<%=temp.getStaffEmail()%></p>
		<p>
			<span class="label">住所：</span>
			<%=temp.getStaffAddress()%></p>

		<!-- Mask password -->
		<p>
			<span class="label">パスワード：</span>
			<%=temp.getStaffPassword().replaceAll(".", "*")%></p>

		<div class="buttons">
			<form action="StaffInsertServlet" method="post"
				style="display: inline;">
				<button type="submit" class="btn-primary">登録する</button>
			</form>

			<a href="Admin/staffregisteration.jsp"><button type="submit"
					class="btn-secondary">戻って修正</button></a>


		</div>

		<%
		}
		%>

	</div>

</body>
</html>