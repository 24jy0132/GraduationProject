<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>アンケート投稿完了</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
 body { font-size: 14px; }
 .complete-area {
   margin-top: 80px;
   text-align: center;
 }
</style>
</head>
<body>
<!-- ===== Header ===== -->
<div class="container-fluid py-3 border-bottom">
 <div class="d-flex align-items-center justify-content-between">
   <div class="fw-bold fs-4">
     MHP株式会社　営業サポートシステム
   </div>
   <div class="d-flex gap-2">
     <a href="#" class="btn btn-outline-secondary btn-sm">管理TOP</a>
     <a href="#" class="btn btn-outline-secondary btn-sm">ログアウト</a>
   </div>
 </div>
 <div class="fw-bold fs-5 mt-2">アンケート作成</div>
</div>
<!-- ===== Complete Message ===== -->
<div class="container complete-area">
 <p class="fw-bold fs-5 mb-3">
   アンケートの投稿が完了しました。
 </p>
 <p class="mb-4">
   回答の閲覧は管理TOPの「回答閲覧」から行ってください。
 </p>
 <a href="AdminTopServlet" class="btn btn-primary px-4">
   管理TOPへ戻る
 </a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>