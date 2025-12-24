<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン・会員登録のお願い</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
  /* page spacing (so it looks like your screenshot) */
  .page-wrap{
    min-height: 70vh;
    display:flex;
    align-items:center;
    justify-content:center;
    padding: 48px 12px;
  }

  /* the purple card */
  .notice-card{
    max-width: 720px;
    width: 100%;
    border-radius: 18px;
    background: #f4f1ff;          /* light purple */
    border: 1px solid #d8d1ff;    /* soft border */
    padding: 40px 28px;
  }

  .notice-title{
    color:#2f2a7a; /* deep purple */
    font-weight: 800;
    letter-spacing: .2px;
  }

  .notice-text{
    color:#2f2a7a;
    font-weight: 600;
    line-height: 1.9;
  }

  /* buttons */
  .btn-purple{
    background:#8e86d8;
    border-color:#8e86d8;
    color:#fff;
  }
  .btn-purple:hover{
    background:#7e76cf;
    border-color:#7e76cf;
    color:#fff;
  }
  .btn-outline-purple{
    border-color:#8e86d8;
    color:#2f2a7a;
    background:#fff;
  }
  .btn-outline-purple:hover{
    background:#f0eeff;
  }
</style>
</head>

<body class="bg-white">

<!-- if you have header/footer, keep them -->
<%-- <%@ include file="header.jsp"%> --%>

<div class="page-wrap">
  <div class="notice-card text-center shadow-sm">
    <h2 class="notice-title mb-4">アンケートに回答するにはログインが必要です</h2>

    <div class="notice-text mb-4">
      <div>商品アンケートは会員向けのサービスです。</div>
      <div>ログインしてから再度お試しください。</div>
      <div>会員登録がまだの方は、新規会員登録をお願いいたします。</div>
    </div>

    <div class="d-flex flex-column flex-sm-row gap-3 justify-content-center">
      <button type="button" class="btn btn-outline-purple rounded-pill px-4"
              onclick="location.href='login.jsp'">
        ログイン画面へ
      </button>
      <button type="button" class="btn btn-purple rounded-pill px-4"
              onclick="location.href='registerForm.jsp'">
        新規会員登録
      </button>
    </div>
  </div>
</div>

<%-- <%@ include file="footer.jsp"%> --%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
