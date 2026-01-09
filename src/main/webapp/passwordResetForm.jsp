<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>パスワード再設定画面</title>
</head>
<h2>パスワード再設定</h2>

<form action="passwordReset" method="post">
    <!-- tokenを引き継ぐ -->
    <input type="hidden" name="token" value="${token}">

    <div>
        <label>新しいパスワード</label><br>
        <input type="password" name="password" required minlength="8">
    </div>

    <div>
        <label>新しいパスワード（確認）</label><br>
        <input type="password" name="passwordConfirm" required minlength="8">
    </div>

    <div style="margin-top: 10px;">
        <button type="submit">パスワードを変更する</button>
    </div>
</form>

</body>

</html>