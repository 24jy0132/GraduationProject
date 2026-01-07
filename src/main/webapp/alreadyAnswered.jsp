<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>回答済み</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    /* 背景（白でOKなら消してもOK） */
    body{
      background: #fff;
    }

    /* 中央カードの見た目 */
    .msg-card{
      max-width: 520px;
      width: 92%;
      border: 1px solid #b9b9b9;
      border-radius: 12px;
      background: #f7f6ff; /* うっすい紫 */
      box-shadow: 0 2px 0 rgba(0,0,0,0.15);
      padding: 28px 26px;
      text-align: center;
    }

    .msg-title{
      font-weight: 1000;
      color: #1e1b7a; /* 濃い青紫 */
      margin-bottom: 14px;
      font-size: 1.5rem;
    }

    .msg-text{
      color: #1e1b7a;
      font-weight: 700;
      font-size: 1.2rem;
      line-height: 1.8;
      margin: 0;
    }
  </style>
</head>

<body>
  <!-- 画面中央寄せ -->
  <div class="min-vh-100 d-flex align-items-center justify-content-center">
    <div class="msg-card">
      <div class="msg-title">このアンケートは回答済みです</div>
      <p class="msg-text">
        すでに当該商品のアンケートに回答済みのため、<br>
        再度回答することはできません。
      </p>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
