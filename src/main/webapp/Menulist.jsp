<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.List, model.Menu" %>

<%
List<Menu> menus = (List<Menu>) request.getAttribute("menus");
List<Menu> surveyMenus = (List<Menu>) request.getAttribute("surveyMenus");
List<Menu> newMenus = (List<Menu>) request.getAttribute("newMenus");
List<Menu> mainMenus = (List<Menu>) request.getAttribute("mainMenus");
List<Menu> alaCarteMenus = (List<Menu>) request.getAttribute("alaCarteMenus");
List<Menu> saladSoup = (List<Menu>) request.getAttribute("saladSoup");
List<Menu> drinks = (List<Menu>) request.getAttribute("drinks");
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
    height: 80px;
    object-fit: cover;
  }
</style>

</head>
<body>

<div class="container py-4">

  <!-- ============ Survey Target ============ -->
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
          <img src="<%= sm.getImagePath() %>" class="card-img-top" alt="">
          <div class="card-body p-2">
            <div class="fw-bold small"><%= sm.getMenuName() %></div>
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

  <!-- ============ New ============ -->
  <h4 class="fw-bold mb-3">新商品 <span class="badge bg-primary">NEW</span></h4>

  <div class="row g-3 mb-5">
    <%
      if (newMenus != null) {
        for (Menu nm : newMenus) {
    %>
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="card h-100 border-0 menu-card">
          <img src="<%= nm.getImagePath() %>" class="card-img-top" alt="">
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

  <!-- ============ Main ============ -->
  <h4 class="fw-bold mb-3">メイン商品</h4>

  <div class="row g-3 mb-5">
    <%
      if (mainMenus != null) {
        for (Menu mm : mainMenus) {
    %>
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="card h-100 border-0 menu-card">
          <img src="<%= mm.getImagePath() %>" class="card-img-top" alt="">
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

  <!-- ============ Ala Carte ============ -->
  <h4 class="fw-bold mb-3">アラカルト</h4>

  <div class="row g-3 mb-5">
    <%
      if (alaCarteMenus != null) {
        for (Menu acm : alaCarteMenus) {
    %>
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="card h-100 border-0 menu-card">
          <img src="<%= acm.getImagePath() %>" class="card-img-top" alt="">
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

  <!-- ============ Salad / Soup / Other ============ -->
  <h4 class="fw-bold mb-3">サラダ・スープ・その他</h4>

  <div class="row g-3 mb-5">
    <%
      if (saladSoup != null) {
        for (Menu ssm : saladSoup) {
    %>
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="card h-100 border-0 menu-card">
          <img src="<%= ssm.getImagePath() %>" class="card-img-top" alt="">
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

  <!-- ============ Drinks ============ -->
  <h4 class="fw-bold mb-3">ドリンク商品</h4>

  <div class="row g-3 mb-5">
    <%
      if (drinks != null) {
        for (Menu dm : drinks) {
    %>
      <div class="col-6 col-sm-4 col-md-3 col-lg-2">
        <div class="card h-100 border-0 menu-card">
          <img src="<%= dm.getImagePath() %>" class="card-img-top" alt="">
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
