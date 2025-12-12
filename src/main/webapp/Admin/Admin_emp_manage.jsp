<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>従業員一覧画面</title>
</head>
<body>
	<header
		style="display: flex; justify-content: space-between; /* 左右に配置する */ align-items: center; /* 縦位置を揃える */ padding: 10px;">
		<h1>MHP株式会社 営業サポートシステム</h1>
		<div>
			<button onclick="location.href='Admin_top.jsp'">管理TOP</button>
			<button onclick="location.href='Admin_top.jsp'">ログアウト</button>
		</div>
		<!--ログアウトボタンを編集-->
	</header>

	<main>
		<p>〇従業員管理</p>
		<p>サーバに接続し、登録されている従業員の一覧を出力</p>

<div><button onclick="location.href='Admin_add_emp.jsp'">従業員追加</button></div>
		<button onclick="history.back()">戻る</button>

	</main>
</body>
</html>