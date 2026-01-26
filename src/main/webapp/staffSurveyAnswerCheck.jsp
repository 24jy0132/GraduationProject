<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="java.util.List, model.Menu"%>
<%
List<Menu> smenu = (List<Menu>) request.getAttribute("smenu");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>回答閲覧</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
 body { font-size: 14px; }
 .section-title {
   font-weight: 700;
   margin-bottom: 8px;
 }
 .form-area {
   max-width: 600px;
   margin-top: 30px;
 }
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
 <div class="fw-bold fs-5 mt-2">回答閲覧</div>
</div>
<div class="container form-area">
 <form action="AdminSurveyAnswersServlet" method="post">
   <div class="mb-4">
     <div class="section-title">回答を確認したい商品
</div>
     <select name="menuId" id="menuId" class="form-select">
       <option value="">商品を選択してください
</option>
       <%
       if (smenu != null) {
         for (Menu m : smenu) {
       %>
         <option value="<%= m.getMenuId() %>"><%= m.getMenuName() %></option>
       <%
         }
       }
       %>
     </select>
   </div>
   <div class="d-flex justify-content-end gap-2">
     <button type="button" class="btn btn-outline-secondary"
             onclick="history.back()">戻る</button>
     <button type="submit" class="btn btn-primary">次へ</button>
   </div>
 </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

