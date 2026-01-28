<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="model.Menu"%>
<%
Menu menu = (Menu) request.getAttribute("menu");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>アンケートプレビュー</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
 body { font-size: 14px; }
 .section-title {
   font-weight: 700;
   margin-bottom: 6px;
 }
 .option-row {
   gap: 24px;
   row-gap: 8px;
 }
 .menu-area {
   display: flex;
   gap: 16px;
   align-items: flex-start;
   margin-bottom: 20px;
 }
 .menu-img {
   width: 120px;
   border: 1px solid #ccc;
 }
 .menu-name {
   font-weight: 700;
   font-size: 18px;
 }
 .menu-desc {
   color: #555;
   margin-top: 4px;
 }
 .menu-price {
   margin-top: 6px;
 }
 .comment-box {
   background: #f9f9f9;
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
 <div class="fw-bold fs-5 mt-2">アンケート作成</div>
</div>
<div class="container mt-4">
<h4 class="mb-3">プレビュー</h4>
<% if (menu == null) { %>
 <div class="alert alert-warning">メニュー情報を取得できませんでした。</div>
<% } else { %>
 <!-- ===== Menu Info ===== -->
 <div class="menu-area">
   <img src="<%= request.getContextPath() %>/<%= menu.getImagePath() %>"
        class="menu-img" alt="メニュー画像">
   <div>
     <div class="menu-name"><%= menu.getMenuName() %></div>
     <div class="menu-desc"><%= menu.getDescription() %></div>
     <div class="menu-price">¥<%= menu.getPrice() %></div>
   </div>
 </div>
 <form action="AdminSurveyPreviewDoneServlet" method="post">
   <input type="hidden" name="menuId" value="<%= menu.getMenuId() %>">
   <!-- Taste -->
   <div class="mb-4">
     <div class="section-title">味の印象</div>
     <div class="d-flex flex-wrap option-row">
       <label class="form-check">
         <input class="form-check-input" type="radio" name="taste" value="とてもおいしかった">
         とてもおいしかった
       </label>
       <label class="form-check">
         <input class="form-check-input" type="radio" name="taste" value="おいしかった">
         おいしかった
       </label>
       <label class="form-check">
         <input class="form-check-input" type="radio" name="taste" value="普通だった">
         普通だった
       </label>
       <label class="form-check">
         <input class="form-check-input" type="radio" name="taste" value="あまり口に合わなかった">
         あまり口に合わなかった
       </label>
     </div>
   </div>
   <!-- Volume -->
   <div class="mb-4">
     <div class="section-title">量の印象</div>
     <div class="d-flex flex-wrap option-row">
       <label class="form-check">
         <input class="form-check-input" type="radio" name="volume" value="少ない">
         少ない
       </label>
       <label class="form-check">
         <input class="form-check-input" type="radio" name="volume" value="ちょうどいい">
         ちょうどいい
       </label>
       <label class="form-check">
         <input class="form-check-input" type="radio" name="volume" value="多い">
         多い
       </label>
     </div>
   </div>
   <!-- Price -->
   <div class="mb-4">
     <div class="section-title">値段の印象</div>
     <div class="d-flex flex-wrap option-row">
       <label class="form-check">
         <input class="form-check-input" type="radio" name="price" value="やすい">
         やすい
       </label>
       <label class="form-check">
         <input class="form-check-input" type="radio" name="price" value="妥当">
         妥当
       </label>
       <label class="form-check">
         <input class="form-check-input" type="radio" name="price" value="高い">
         高い
       </label>
     </div>
   </div>
   <!-- Comment -->
   <div class="mb-4">
     <div class="section-title">任意コメント（管理者のみ閲覧）</div>
     <textarea class="form-control comment-box w-75"
       name="comment" rows="3"
       placeholder="サービス改善のためのメモ等"></textarea>
   </div>
   <!-- Buttons -->
   <div class="d-flex justify-content-center gap-3 mt-4">
     <button type="button" class="btn btn-outline-secondary px-4"
             onclick="history.back()">戻る</button>
     <button type="submit" class="btn btn-primary px-4">投稿する</button>
   </div>
 </form>
<% } %>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>