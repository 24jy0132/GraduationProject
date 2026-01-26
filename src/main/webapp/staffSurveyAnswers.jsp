<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"
   import="model.Menu, java.util.Map, java.util.List" %>
<%
Menu menu = (Menu) request.getAttribute("menu");
Map<Integer, Map<String, Integer>> tasteSummary =
       (Map<Integer, Map<String, Integer>>) request.getAttribute("tasteSummary");
Map<Integer, Map<String, Integer>> volumeSummary =
       (Map<Integer, Map<String, Integer>>) request.getAttribute("volumeSummary");
Map<Integer, Map<String, Integer>> priceSummary =
       (Map<Integer, Map<String, Integer>>) request.getAttribute("priceSummary");
List<String> comments = (List<String>) request.getAttribute("comments");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>回答閲覧</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
 /* simple staff look */
 body { font-size: 14px; }
 .page-title { font-weight: 700; font-size: 18px; margin: 16px 0 8px; }
 .menu-title { font-weight: 700; font-size: 20px; margin: 12px 0 12px; }
 .section-label { font-weight: 700; margin-top: 18px; margin-bottom: 8px; }
 .summary-table td, .summary-table th { vertical-align: middle; }
 .comment-box { background: #fff; }
</style>
</head>
<body>
<!-- ===== Header ===== -->
<div class="container-fluid py-3 border-bottom">
 <div class="d-flex align-items-center justify-content-between">
   <div class="fw-bold fs-5">MHP株式会社　営業サポートシステム</div>
   <div class="d-flex gap-2">
     <a href="#" class="btn btn-outline-secondary btn-sm">管理TOP</a>
     <a href="#" class="btn btn-outline-secondary btn-sm">ログアウト</a>
   </div>
 </div>
 <div class="fw-bold mt-2">回答閲覧</div>
</div>
<div class="container py-3">
<% if (menu == null) { %>
 <div class="alert alert-warning">メニュー情報を取得できませんでした。</div>
<% } else { %>
 <div class="menu-title"><%= menu.getMenuName() %></div>
 <!-- ===== Summary (simple table) ===== -->
 <div class="section-label">集計結果</div>
 <table class="table table-bordered summary-table">
   <thead class="table-light">
     <tr>
       <th style="width: 140px;">項目</th>
       <th>内容（件数）</th>
     </tr>
   </thead>
   <tbody>
     <!-- Taste row -->
     <tr>
       <td>味の印象</td>
       <td>
         <%
         Map<String, Integer> tasteMap = null;
         if (tasteSummary != null) tasteMap = tasteSummary.get(menu.getMenuId());
         if (tasteMap != null && !tasteMap.isEmpty()) {
             boolean first = true;
             for (Map.Entry<String, Integer> e : tasteMap.entrySet()) {
                 if (!first) out.print(" / ");
                 out.print(e.getKey() + "：" + e.getValue());
                 first = false;
             }
         } else {
             out.print("まだレビューありません");
         }
         %>
       </td>
     </tr>
     <!-- Volume row -->
     <tr>
       <td>量の印象</td>
       <td>
         <%
         Map<String, Integer> volumeMap = null;
         if (volumeSummary != null) volumeMap = volumeSummary.get(menu.getMenuId());
         if (volumeMap != null && !volumeMap.isEmpty()) {
             boolean first = true;
             for (Map.Entry<String, Integer> e : volumeMap.entrySet()) {
                 if (!first) out.print(" / ");
                 out.print(e.getKey() + "：" + e.getValue());
                 first = false;
             }
         } else {
             out.print("まだレビューありません");
         }
         %>
       </td>
     </tr>
     <!-- Price row -->
     <tr>
       <td>値段の印象</td>
       <td>
         <%
         Map<String, Integer> priceMap = null;
         if (priceSummary != null) priceMap = priceSummary.get(menu.getMenuId());
         if (priceMap != null && !priceMap.isEmpty()) {
             boolean first = true;
             for (Map.Entry<String, Integer> e : priceMap.entrySet()) {
                 if (!first) out.print(" / ");
                 out.print(e.getKey() + "：" + e.getValue());
                 first = false;
             }
         } else {
             out.print("まだレビューありません");
         }
         %>
       </td>
     </tr>
   </tbody>
 </table>
 <!-- ===== Comments (simple list) ===== -->
 <div class="section-label">任意コメント（管理者のみ閲覧）</div>
 <div class="border p-2 comment-box">
   <%
   if (comments != null && !comments.isEmpty()) {
       for (String cm : comments) {
   %>
         <div class="border-bottom py-2"><%= cm %></div>
   <%
       }
   } else {
   %>
       <div class="text-muted py-2">コメントはまだありません</div>
   <%
   }
   %>
 </div>
 <div class="d-flex justify-content-end mt-3">
   <button type="button" class="btn btn-outline-secondary" onclick="history.back()">戻る</button>
 </div>
<% } %>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

