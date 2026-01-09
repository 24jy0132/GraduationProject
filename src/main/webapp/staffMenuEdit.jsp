<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.List, model.Menu"%> 
    <%
    List<Menu> allMenus = (List<Menu>) request.getAttribute("allMenus"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- ===== Header (管理TOP / ログアウト) ===== -->
<div class="container-fluid py-3 border-bottom">
  <div class="d-flex align-items-center justify-content-between">
    <div class="fw-bold fs-4">
      MHP株式会社　営業サポートシステム
    </div>

    <div class="d-flex gap-2">
      <a href="" class="btn btn-outline-secondary btn-sm">管理TOP</a>
      <a href="" class="btn btn-outline-secondary btn-sm">ログアウト</a>
    </div>
  </div>

  <div class="fw-bold fs-5 mt-2">メニュー管理</div>
</div>

<h4>新規登録</h4>

<form action="AdminMenuEditServlet" method="post">
<label>メニュー名</label>
<input type="text" name="menuName"> <br>
<label>メニュージャンル</label>
<input type="text" name="category"> <br>
<label>値段</label>
<input type="number" name="price"> <br>
<label>メニュー説明</label>
<input type="text" name="description"> <br>
<label>メニュー画像</label>
<input type="text" name="imagePath"> <br>
<label>アンケート対象</label><br>
<input type="radio" name="isSurveyTarget" value="1">
<label>する</label>
<input type="radio" name ="isSurveyTarget" value="0">
<label>しない</label>
<button type="submit">登録</button>
</form>


<h4>メニュー一覧</h4>
<table>
<tr>
<td>メニュー名</td>
<td>メニュージャンル</td>
<td>メニュー値段</td>
<td>メニュー説明</td>
</tr>
 <%for(Menu m:allMenus){%>

<tr>
<td> <%=m.getMenuName()%></td>
<td> <%=m.getCategory()%></td>
<td> <%=m.getPrice()%></td>
<td> <%=m.getDescription()%></td>
</tr>
<%}%>
</table>

</body>
</html>