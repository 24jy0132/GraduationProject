<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.List, model.Menu"%>

<%
List<Menu> allMenus = (List<Menu>) request.getAttribute("allMenus");
Integer editId = (Integer) request.getAttribute("editId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー管理</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
  body { font-size: 14px; }

  /* dark purple */
  .btn-purple{
    color:#5b3a82;
    border:1px solid #5b3a82;
    background:#fff;
  }
  .btn-purple:hover{
    background:#5b3a82;
    color:#fff;
  }

  .page-area { max-width: 980px; }
  .section-title { font-weight: 700; margin: 18px 0 10px; }
  .form-label { font-weight: 600; }
</style>
</head>

<body>

<!-- ===== Header ===== -->
<div class="container-fluid py-3 border-bottom">
  <div class="d-flex align-items-center justify-content-between">
    <div class="fw-bold fs-4">MHP株式会社　営業サポートシステム</div>
    <div class="d-flex gap-2">
      <a href="#" class="btn btn-outline-secondary btn-sm">管理TOP</a>
      <a href="#" class="btn btn-outline-secondary btn-sm">ログアウト</a>
    </div>
  </div>
  <div class="fw-bold fs-5 mt-2">メニュー管理</div>
</div>

<div class="container page-area py-4">

  <!-- ===== 新規登録 ===== -->
  <div class="section-title">新規登録</div>

  <form action="AdminMenuEditServlet" method="post" enctype="multipart/form-data" class="border rounded p-3 bg-white">
    <div class="row g-3">

      <div class="col-md-6">
        <label class="form-label">メニュー名</label>
        <input type="text" name="menuName" class="form-control" required>
      </div>

      <div class="col-md-6">
        <label class="form-label">メニュージャンル</label>
        <input type="text" name="category" class="form-control" required>
      </div>

      <div class="col-md-3">
        <label class="form-label">値段</label>
        <input type="number" name="price" class="form-control" required>
      </div>

      <div class="col-md-9">
        <label class="form-label">メニュー画像</label>
        <input type="file" name="imagePath" class="form-control" accept="image/*" required>
      </div>

      <div class="col-12">
        <label class="form-label">メニュー説明</label>
        <input type="text" name="description" class="form-control" required>
      </div>

      <div class="col-12">
        <label class="form-label d-block">アンケート対象</label>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="isSurveyTarget" value="1" checked>
          <label class="form-check-label">する</label>
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="radio" name="isSurveyTarget" value="0">
          <label class="form-check-label">しない</label>
        </div>
      </div>

      <div class="col-12 d-flex justify-content-end">
        <button type="submit" class="btn btn-purple px-4">登録</button>
      </div>

    </div>
  </form>

  <!-- ===== 一覧 ===== -->
  <div class="section-title">メニュー一覧</div>

  <div class="table-responsive bg-white border rounded">
  
    <table class="table table-sm table-hover align-middle mb-0">
      <thead class="table-light">
        <tr>
          <th>メニュー名</th>
          <th>ジャンル</th>
          <th style="width:120px;">値段</th>
          <th>説明</th>
          <th style="width:90px;">編集</th>
          <th style="width:90px;">削除</th>
        </tr>
      </thead>

      <tbody>
      <%
      if (allMenus != null) {
        for (Menu m : allMenus) {
        	//main to make editable only one line
          boolean editing = (editId != null && m.getMenuId() == editId.intValue());
      %>

        <tr>
        <% if (!editing) { %>

          <td><%= m.getMenuName() %></td>
          <td><%= m.getCategory() %></td>
          <td>¥<%= m.getPrice() %></td>
          <td><%= m.getDescription() %></td>

          <td>
            <a class="btn btn-sm btn-purple"
               href="AdminMenuEditServlet?editId=<%= m.getMenuId() %>">編集</a>
          </td>

          <td>
            <form action="AdminMenuDeleteServlet" method="post" class="m-0">
              <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
              <button type="submit" class="btn btn-sm btn-outline-secondary"
                      onclick="return confirm('削除しますか？')">削除</button>
            </form>
          </td>

        <% } else { %>

          <!-- 編集モード：この行だけフォーム表示（HTML valid) -->
          <td colspan="6">
            <form action="AdminMenuUpdateServlet" method="post" class="row g-2 align-items-center">
              <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">

              <div class="col-md-3">
                <input class="form-control form-control-sm" name="menuName"
                       value="<%= m.getMenuName() %>" required>
              </div>

              <div class="col-md-2">
                <input class="form-control form-control-sm" name="category"
                       value="<%= m.getCategory() %>" required>
              </div>

              <div class="col-md-2">
                <input class="form-control form-control-sm" type="number" name="price"
                       value="<%= m.getPrice() %>" required>
              </div>

              <div class="col-md-3">
                <input class="form-control form-control-sm" name="description"
                       value="<%= m.getDescription() %>" required>
              </div>

              <div class="col-md-2 d-flex gap-2">
                <button type="submit" class="btn btn-sm btn-purple">保存</button>
                <a class="btn btn-sm btn-outline-secondary" href="AdminMenuEditServlet">キャンセル</a>
              </div>
            </form>
          </td>

        <% } %>
        </tr>

      <%
        }
      }
      %>
      </tbody>
    </table>
  </div>

</div>

<%
String message = (String) request.getAttribute("message");
if (message != null) {
%>
<script>
  alert("<%= message %>");
</script>
<%
}
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
