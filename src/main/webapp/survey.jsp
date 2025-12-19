<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.Menu" %>

<%
Menu menu = (Menu)request.getAttribute("menu");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品レビューアンケート</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
  .desc-text { font-size: 0.85rem; color: #666; line-height: 1.4; }
  .section-title { font-weight: 700; font-size: 0.95rem; margin-bottom: 0.5rem; }
  .option-row { gap: 1.5rem; row-gap: 0.75rem; }
  .comment-box { background: #f3f8ff; border-radius: 12px; border: 1px solid #cfe0ff; }
</style>
</head>

<body class="bg-white">

<div class="container py-5">
  <div class="row justify-content-center">
    <!-- width like screenshot -->
    <div class="col-12 col-md-9 col-lg-7">

      <!-- Title -->
      <h4 class="fw-bold mb-3">商品レビューアンケート</h4>
      <p class="text-muted mb-4">
        商品に関するご感想をお聞かせください。<br>
        アンケートに回答すると、1商品につき1度だけポイントが加算されます
      </p>

      <!-- Product Card -->
      <div class="card border-0 mb-4">
        <div class="card-body px-0">
          <div class="d-flex align-items-start gap-3">
            <img src="<%= menu.getImagePath() %>" alt=""
                 style="width:96px;height:72px;object-fit:cover;border-radius:6px;background:#eee;">
            <div class="flex-grow-1">
              <div class="fw-bold"><%= menu.getMenuName() %></div>
              <div class="desc-text"><%= menu.getDescription() %></div>
              <div class="fw-bold mt-1">¥<%= menu.getPrice() %></div>
            </div>
          </div>
        </div>
      </div>

      <p class="fw-semibold mb-4">
        味・量・値段について印象を選択し、任意コメント（非公開）を入力できます。
      </p>

      <form action="SurveyDoneServlet" method="post">
        <input type="hidden" name="menuId" value="<%= menu.getMenuId() %>">

        <!-- Taste -->
        <div class="mb-4">
          <div class="section-title">味の印象</div>
          <div class="d-flex flex-wrap option-row">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="taste" value="とてもおいしかった" required>
              <label class="form-check-label">とてもおいしかった</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="taste" value="おいしかった">
              <label class="form-check-label">おいしかった</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="taste" value="普通だった">
              <label class="form-check-label">普通だった</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="taste" value="あまり口に合わなかった">
              <label class="form-check-label">あまり口に合わなかった</label>
            </div>
          </div>
        </div>

        <!-- Volume -->
        <div class="mb-4">
          <div class="section-title">量の印象</div>
          <div class="d-flex flex-wrap option-row">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="volume" value="少ない" required>
              <label class="form-check-label">少ない</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="volume" value="ちょうどいい">
              <label class="form-check-label">ちょうどいい</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="volume" value="多い">
              <label class="form-check-label">多い</label>
            </div>
          </div>
        </div>

        <!-- Price -->
        <div class="mb-4">
          <div class="section-title">値段の印象</div>
          <div class="d-flex flex-wrap option-row">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="price" value="やすい" required>
              <label class="form-check-label">やすい</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="price" value="妥当">
              <label class="form-check-label">妥当</label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="price" value="高い">
              <label class="form-check-label">高い</label>
            </div>
          </div>
        </div>

        <!-- Comment -->
        <div class="mb-4">
          <div class="section-title">任意コメント（管理者のみ閲覧）</div>
          <textarea class="form-control comment-box"
                    name="comment" rows="4"
                    placeholder="サービス改善のためのメモ等"></textarea>
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-center gap-3 mt-4">
          <button type="button" class="btn btn-outline-secondary px-4"
                  onclick="history.back()">戻る</button>
          <button type="submit" class="btn btn-primary px-4">投稿する</button>
        </div>

      </form>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
