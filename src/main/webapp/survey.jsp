<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.Menu" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Menu menu = (Menu)request.getAttribute("menu");

%>
	<h3>商品レビューアンケート</h3>
	<p>商品に関するご感想をお聞かせください。
		アンケートに回答すると、1商品につき1度だけポイントが加算されます<p>
		<img src="<%=menu.getImagePath() %>" width="80">
		<p><%=menu.getMenuName()%></p>
		<small><%=menu.getDescription()%></small>
		<p>\<%=menu.getPrice()%></p>
		
		<p>味・量・値段について印象を選択し、任意コメント（非公開）を入力できます。</p>
		<p>味の印象</p>
		<form action="SurveyDoneServlet" method="post">
			<input type="hidden" name="menuId" value="<%=menu.getMenuId() %>">
		
			<input type="radio" id="" name="taste" value="やや辛い"required>
			<label for="">やや辛い</label>
			<input type="radio" id="" name="taste" value="とても辛い">
			<label for="">とても辛い</label>
			<input type="radio" id="" name="taste" value="甘め">
			<label for="">甘め</label>
			<input type="radio" id="" name="taste" value="かなり辛い">
			<label for="">かなり辛い</label>
			<input type="radio" id="" name="taste" value="あっさり">
			<label for="">あっさり</label>
			<input type="radio" id="" name="taste" value="濃いめ">
			<label for="">濃いめ</label>
			<input type="radio" id="" name="taste" value="香ばしい">
			<label for="">香ばしい</label>
			<input type="radio" id="" name="taste" value="ジューシー">
			<label for="">ジューシー</label><br>
			
			<p>量の印象</p>
			<input type="radio" id="" name="volume" value="少ない"required>
			<label for="">少ない</label>
			<input type="radio" id="" name="volume" value="ちょうどいい">
			<label for="">ちょうどいい</label>
			<input type="radio" id="" name="volume" value="多い">
			<label for="">多い</label>
			
			<p>値段の印象</p>
			<input type="radio" id="" name="price" value="やすい"required>
			<label for="">やすい</label>
			<input type="radio" id="" name="price" value="妥当">
			<label for="">妥当</label>
			<input type="radio" id="" name="price" value="高い">
			<label for="">高い</label>
			
			<p>任意コメント(管理者のみ閲覧)</p>
			<textarea id="" name="comment" rows="5" cols="70" placeholder="サービス改善のためのメモ等"></textarea>
 			<br>
			<button type="button" onclick="history.back()">戻る</button>
			<button type="submit">投稿する</button>
		</form>
		
</body>
</html>