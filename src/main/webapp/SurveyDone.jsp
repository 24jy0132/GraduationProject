<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>アンケート完了</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
  .done-wrapper {
    min-height: 70vh;
  }
  .done-title {
    font-weight: 700;
    font-size: 1.2rem;
  }
  .done-text {
    color: #666;
    font-size: 0.9rem;
  }
  .btn-purple {
    background-color: #8e84d8;
    color: #fff;
    border-radius: 999px;
    padding: 0.5rem 1.8rem;
  }
  .btn-purple:hover {
    background-color: #7a6fd1;
    color: #fff;
  }
</style>
</head>

<body class="bg-white">

<div class="container">
  <div class="row justify-content-center align-items-center done-wrapper text-center">
    <div class="col-12 col-md-8 col-lg-6">

      <p class="done-title mb-3">
        ご回答いただきありがとうございました！
      </p>

      <p class="done-text mb-4">
        10ポイントを付与しました。重複レビューはできません
      </p>

      <button class="btn btn-purple"
              onclick="location.href='MenuListServlet'">
        メニューに戻る
      </button>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
