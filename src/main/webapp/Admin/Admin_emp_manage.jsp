<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Staff"%>
<%@ page import="java.util.List"%>
<title>従業員一覧画面</title>

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
		<header
			style="display: flex; justify-content: space-between; /* 左右に配置する */ align-items: center; /* 縦位置を揃える */ padding: 10px;">
			<h1>MHP株式会社 営業サポートシステム</h1>
			<!-- Top right buttons -->
			<div class="buttons">
				<a href="adminhome.jsp"><button>管理TOP</button></a> <a
					href="https://example.com"><button>ログアウト</button></a>
			</div>
			<!--ログアウトボタンを編集-->
		</header>

		<main>
			<p>〇従業員管理</p>
			<p>サーバに接続し、登録されている従業員の一覧を出力する</p>


			<div class="buttons">
				<a href="staffregisteration.jsp"><button>従業員追加</button></a>
			</div>
			<div class="buttons">
				<a href="adminhome.jsp"><button>戻る</button></a>
			</div>

		</main>
	</div>
</body>
</html>