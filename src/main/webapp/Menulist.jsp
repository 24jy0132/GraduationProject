<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.List, java.util.Map, model.Menu" %>

<%
List<Menu> menus = (List<Menu>) request.getAttribute("menus");
List<Menu> surveyMenus = (List<Menu>) request.getAttribute("surveyMenus");
List<Menu> newMenus = (List<Menu>) request.getAttribute("newMenus");
List<Menu> mainMenus = (List<Menu>) request.getAttribute("mainMenus");
List<Menu> alaCarteMenus = (List<Menu>) request.getAttribute("alaCarteMenus");
List<Menu> saladSoup = (List<Menu>) request.getAttribute("saladSoup");
List<Menu> drinks = (List<Menu>) request.getAttribute("drinks");

Map<Integer, Map<String,Integer>> tasteSummary =
    (Map<Integer, Map<String,Integer>>) request.getAttribute("tasteSummary");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー一覧</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.menu-desc {
  font-size: 0.7rem;
  color: #777;
  line-height: 1.3;
}
.menu-card img{
  width: 100%;
  aspect-ratio: 16 / 9;
  object-fit: cover;
  border-radius: 10px;
}


.review-wrap {
  margin: 4px 0;
}
.review-badge {
  display: inline-block;
  padding: 2px 8px;
  font-size: 0.65rem;
  border-radius: 999px;
  background-color: #eef3ff;
  color: #3b5bdb;
  margin-right: 4px;
  margin-bottom: 2px;
  white-space: nowrap;
}
</style>
</head>

<body>
<div class="container py-4">

<!-- ================= Survey Target ================= -->
<h4 class="fw-bold mb-1">アンケート対象商品</h4>
<p class="text-muted small mb-3">
  下記の商品についてアンケートに回答すると、ポイントがたまります。<br>
  1商品につき1度だけ回答できます
</p>

<div class="row g-3 mb-5">
<%
if (surveyMenus != null) {
  for (Menu sm : surveyMenus) {
%>
  <div class="col-6 col-sm-4 col-md-3 col-lg-2">
    <div class="card h-100 border-0 menu-card">
      <img src="<%= sm.getImagePath() %>" class="card-img-top">
      <div class="card-body p-2">

        <div class="fw-bold small"><%= sm.getMenuName() %></div>

        <!-- ===== Taste Review Badges ===== -->
        <div class="review-wrap">
        <%
          Map<String,Integer> tasteMap = null;
          if (tasteSummary != null) {
              tasteMap = tasteSummary.get(sm.getMenuId());
          }

          if (tasteMap != null && !tasteMap.isEmpty()) {
              for (Map.Entry<String,Integer> entry : tasteMap.entrySet()) {
        %>
            <span class="review-badge">
              <%= entry.getKey() %> × <%= entry.getValue() %>
            </span>
        <%
              }
          } else {
        %>
            <span class="review-badge">まだレビューありません</span>
        <%
          }
        %>
        </div>

        <div class="menu-desc"><%= sm.getDescription() %></div>
        <div class="fw-bold mt-1">¥<%= sm.getPrice() %></div>

        <a class="small link-primary"
           href="SurveyServlet?menuId=<%= sm.getMenuId() %>">
          アンケートに回答する
        </a>
      </div>
    </div>
  </div>
<%
  }
}
%>
</div>
<hr>
<!-- ================= New ================= -->
<h4 class="fw-bold mb-3">新商品 <span class="badge bg-primary">NEW</span></h4>
<div class="row g-3 mb-5">
<%
if (newMenus != null) {
  for (Menu nm : newMenus) {
%>
  <div class="col-6 col-sm-4 col-md-3 col-lg-2">
    <div class="card h-100 border-0 menu-card">
      <img src="<%= nm.getImagePath() %>" class="card-img-top">
      <div class="card-body p-2">
        <div class="fw-bold small"><%= nm.getMenuName() %></div>
        <div class="menu-desc"><%= nm.getDescription() %></div>
        <div class="fw-bold mt-1">¥<%= nm.getPrice() %></div>
      </div>
    </div>
  </div>
<%
  }
}
%>
</div>
<hr>
<!-- ================= Main ================= -->
<h4 class="fw-bold mb-3">メイン商品</h4>
<div class="row g-3 mb-5">
<%
if (mainMenus != null) {
  for (Menu mm : mainMenus) {
%>
  <div class="col-6 col-sm-4 col-md-3 col-lg-2">
    <div class="card h-100 border-0 menu-card">
      <img src="<%= mm.getImagePath() %>" class="card-img-top">
      <div class="card-body p-2">
        <div class="fw-bold small"><%= mm.getMenuName() %></div>
        <div class="menu-desc"><%= mm.getDescription() %></div>
        <div class="fw-bold mt-1">¥<%= mm.getPrice() %></div>
      </div>
    </div>
  </div>
<%
  }
}
%>
</div>
<hr>
<!-- ================= Ala Carte ================= -->
<h4 class="fw-bold mb-3">アラカルト</h4>
<div class="row g-3 mb-5">
<%
if (alaCarteMenus != null) {
  for (Menu acm : alaCarteMenus) {
%>
  <div class="col-6 col-sm-4 col-md-3 col-lg-2">
    <div class="card h-100 border-0 menu-card">
      <img src="<%= acm.getImagePath() %>" class="card-img-top">
      <div class="card-body p-2">
        <div class="fw-bold small"><%= acm.getMenuName() %></div>
        <div class="menu-desc"><%= acm.getDescription() %></div>
        <div class="fw-bold mt-1">¥<%= acm.getPrice() %></div>
      </div>
    </div>
  </div>
<%
  }
}
%>
</div>
<hr>
<!-- ================= Salad / Soup ================= -->
<h4 class="fw-bold mb-3">サラダ・スープ・その他</h4>
<div class="row g-3 mb-5">
<%
if (saladSoup != null) {
  for (Menu ssm : saladSoup) {
%>

  <div class="col-6 col-sm-4 col-md-3 col-lg-2">
    <div class="card h-100 border-0 menu-card">
      <img src="<%= ssm.getImagePath() %>" class="card-img-top">
      <div class="card-body p-2">
        <div class="fw-bold small"><%= ssm.getMenuName() %></div>
        <div class="menu-desc"><%= ssm.getDescription() %></div>
        <div class="fw-bold mt-1">¥<%= ssm.getPrice() %></div>
      </div>
    </div>
  </div>
<%
  }
}
%>
</div>
<hr>
<!-- ================= Drinks ================= -->
<h4 class="fw-bold mb-3">ドリンク商品</h4>
<div class="row g-3 mb-5">
<%
if (drinks != null) {
  for (Menu dm : drinks) {
%>
  <div class="col-6 col-sm-4 col-md-3 col-lg-2">
    <div class="card h-100 border-0 menu-card">
      <img src="<%= dm.getImagePath() %>" class="card-img-top">
      <div class="card-body p-2">
        <div class="fw-bold small"><%= dm.getMenuName() %></div>
        <div class="menu-desc"><%= dm.getDescription() %></div>
        <div class="fw-bold mt-1">¥<%= dm.getPrice() %></div>
      </div>
    </div>
  </div>
<%
  }
}
%>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
