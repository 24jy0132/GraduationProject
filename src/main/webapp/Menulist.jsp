<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"
   import="java.util.List, java.util.Map, model.Menu,model.Customer" %>
<%
List<Menu> menus = (List<Menu>) request.getAttribute("menus");
List<Menu> surveyMenus = (List<Menu>) request.getAttribute("surveyMenus");
List<Menu> newMenus = (List<Menu>) request.getAttribute("newMenus");
List<Menu> mainMenus = (List<Menu>) request.getAttribute("mainMenus");
List<Menu> alaCarteMenus = (List<Menu>) request.getAttribute("alaCarteMenus");
List<Menu> saladSoup = (List<Menu>) request.getAttribute("saladSoup");
List<Menu> drinks = (List<Menu>) request.getAttribute("drinks");
List<Menu> course = (List<Menu>) request.getAttribute("course");
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
 :root{
   --bg: #f6f2fb;          /* soft light purple */
   --card: #ffffff;
   --text: #212529;
   --muted: #6c757d;
   --line: #ece8f7;
   --accent1: #e64980;     /* pink */
   --accent2: #ae3ec9;     /* purple */
   --badge-bg: #f3e9ff;    /* soft purple badge */
   --badge-text: #6a2ca0;
 }
 body{ background: var(--bg); }
 .page-wrap{ padding: 24px 0 40px; }
 .section-head{ margin: 10px 0 14px; }
 .section-title{
   font-weight: 800;
   margin:0;
   color: #2b2b2b;
 }
 .section-sub{
   color: var(--muted);
   font-size:.92rem;
   margin:6px 0 0;
   line-height:1.4;
 }
 .divider{
   border:0;
   height:1px;
   background: rgba(174,62,201,.16);
   margin:18px 0;
 }
 .menu-card{
   border-radius: 16px;
   background: var(--card);
   overflow:hidden;
   border: 1px solid var(--line);
   box-shadow: 0 10px 26px rgba(0,0,0,.06);
   transition: transform .12s ease, box-shadow .12s ease, border-color .12s ease;
 }
 .menu-card:hover{
   transform: translateY(-2px);
   box-shadow: 0 14px 32px rgba(0,0,0,.10);
   border-color: rgba(174,62,201,.22);
 }
 .menu-card img{
   width:100%;
   aspect-ratio:16/9;
   object-fit:cover;
 }
 .menu-desc{
   font-size:.78rem;
   color: var(--muted);
   line-height:1.35;
   min-height:34px;
 }
 .price{
   font-weight: 800;
   color: #2b2b2b;
 }
 .review-wrap{ margin:6px 0 4px; }
 .review-badge{
   display:inline-block;
   padding:2px 8px;
   font-size:.68rem;
   border-radius:999px;
   background: var(--badge-bg);
   color: var(--badge-text);
   border: 1px solid rgba(174,62,201,.18);
   margin-right:4px;
   margin-bottom:4px;
   white-space:nowrap;
 }
 .answer-link{
   font-weight: 800;
   text-decoration: none;
   /* gradient text like your theme */
   background: linear-gradient(135deg, var(--accent1), var(--accent2));
   -webkit-background-clip: text;
   background-clip: text;
   -webkit-text-fill-color: transparent;
 }
 .answer-link:hover{
   text-decoration: underline;
   filter: brightness(0.95);
 }
</style>
</head>
<body>
<%
 // ✅ get login user from session (change attribute name if yours is different)
 Customer customer = (Customer) session.getAttribute("customer");
%>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg bg-danger py-3">
 <div class="container">
   <!-- Brand -->
   <a class="navbar-brand fw-bold text-white"
      href="<%= (customer != null) ? "member_profile.jsp" : "index.jsp" %>">
     <img src="<%= request.getContextPath() %>/img/Gemini_Generated_Image_j4wab2j4wab2j4wa.png"
          height="40" width="40" alt="Logo" class="me-2">
     <% if (customer == null) { %>
       Welcome From Mesa
     <% } else { %>
       <span class="d-inline-flex align-items-center gap-2">
         <i class="fa-solid fa-user"></i>
         <span><%= customer.getName() %></span>
         <span class="badge bg-light text-danger"><%= customer.getPoint() %> point</span>
       </span>
     <% } %>
   </a>
  
   <!-- Toggler -->
   <button class="navbar-toggler" type="button"
           data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
           aria-controls="navbarSupportedContent" aria-expanded="false"
           aria-label="Toggle navigation">
     <span class="navbar-toggler-icon"></span>
   </button>
   <!-- Links -->
   <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
     <ul class="navbar-nav mb-2 mb-lg-0 d-flex gap-4">
       <li class="nav-item">
         <a class="nav-link active text-white" href="index.jsp">
           <i class="bi bi-house-fill me-1"></i>Home
         </a>
       </li>
       <li class="nav-item">
         <a class="nav-link text-white" href="MenuListServlet">
           <i class="bi bi-menu-down me-1"></i>Menu
         </a>
       </li>
       <li class="nav-item">
         <a class="nav-link text-white" href="">
           <i class="bi bi-calendar-check me-1"></i>Reservation
         </a>
       </li>
       <li class="nav-item">
         <a class="nav-link text-white" href="contact.jsp">
           <i class="bi bi-telephone-fill me-1"></i>Contact
         </a>
       </li>
       <li class="nav-item">
       <a class="nav-link text-white" href="map.jsp">
           <i class="bi bi-pin-map-fill me-1"></i>Map
         </a>
       </li>
     </ul>
     <!-- ✅ Login / Logout switch -->
     <% if (customer == null) { %>
       <a class="nav-link active text-white fw-bold ms-lg-3 mt-2 mt-lg-0" href="login.jsp">
         <i class="bi bi-box-arrow-in-right me-1"></i>Login
       </a>
     <% } else { %>
       <a class="nav-link active text-white fw-bold ms-lg-3 mt-2 mt-lg-0" href="<%=request.getContextPath()%>/Customer_LogOut">
         <i class="bi bi-box-arrow-right me-1"></i>LogOut
       </a>
     <% } %>
      </div>
 </div>
</nav>
    
<div class="page-wrap">
 <div class="container">
   <!-- ===== Survey Target ===== -->
   <div class="section-head">
     <h4 class="section-title">アンケート対象商品</h4>
     <p class="section-sub">下記の商品に回答するとポイントがたまります（1商品につき1回）</p>
   </div>
   <div class="row g-3 mb-4">
     <%
     if (surveyMenus != null) {
       for (Menu sm : surveyMenus) {
     %>
     <div class="col-6 col-sm-4 col-md-3 col-lg-2">
       <div class="card h-100 border-0 menu-card">
         <img src="<%= request.getContextPath() + "/" + sm.getImagePath() %>" class="card-img-top" alt="">
         <div class="card-body p-2">
           <div class="fw-bold small"><%= sm.getMenuName() %></div>
           <div class="review-wrap">
             <%
               Map<String,Integer> tasteMap = null;
               if (tasteSummary != null) tasteMap = tasteSummary.get(sm.getMenuId());
               if (tasteMap != null && !tasteMap.isEmpty()) {
                 for (Map.Entry<String,Integer> e : tasteMap.entrySet()) {
             %>
               <span class="review-badge"><%= e.getKey() %> × <%= e.getValue() %></span>
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
           <div class="price mt-1">¥<%= sm.getPrice() %></div>
           <a class="answer-link d-inline-block mt-1"
              href="SurveyServlet?menuId=<%= sm.getMenuId() %>">
             アンケートに回答する →
           </a>
         </div>
       </div>
     </div>
     <%
       }
     }
     %>
   </div>
   <hr class="divider">
   <!-- ===== New ===== -->
   <div class="section-head">
     <h4 class="section-title">新商品</h4>
     <p class="section-sub">期間限定・おすすめ</p>
   </div>
   <div class="row g-3 mb-4">
     <%
     if (newMenus != null) {
       for (Menu nm : newMenus) {
     %>
     <div class="col-6 col-sm-4 col-md-3 col-lg-2">
       <div class="card h-100 border-0 menu-card">
         <img src="<%= request.getContextPath() + "/" + nm.getImagePath() %>" class="card-img-top" alt="">
         <div class="card-body p-2">
           <div class="fw-bold small"><%= nm.getMenuName() %></div>
           <div class="menu-desc"><%= nm.getDescription() %></div>
           <div class="price mt-1">¥<%= nm.getPrice() %></div>
         </div>
       </div>
     </div>
     <%
       }
     }
     %>
   </div>
   <hr class="divider">
   <!-- ===== Course ===== -->
   <div class="section-head">
     <h4 class="section-title">コース</h4>
     <p class="section-sub">みんなで楽しめるセット</p>
   </div>
   <div class="row g-3 mb-4">
     <%
     if (course != null) {
       for (Menu c : course) {
     %>
     <div class="col-6 col-sm-4 col-md-3 col-lg-2">
       <div class="card h-100 border-0 menu-card">
         <img src="<%= request.getContextPath() + "/" + c.getImagePath() %>" class="card-img-top" alt="">
         <div class="card-body p-2">
           <div class="fw-bold small"><%= c.getMenuName() %></div>
           <div class="menu-desc"><%= c.getDescription() %></div>
           <div class="price mt-1">¥<%= c.getPrice() %></div>
         </div>
       </div>
     </div>
     <%
       }
     }
     %>
   </div>
   <hr class="divider">
   <!-- ===== Main ===== -->
   <div class="section-head">
     <h4 class="section-title">メイン商品</h4>
     <p class="section-sub">人気メニュー</p>
   </div>
   <div class="row g-3 mb-4">
     <%
     if (mainMenus != null) {
       for (Menu mm : mainMenus) {
     %>
     <div class="col-6 col-sm-4 col-md-3 col-lg-2">
       <div class="card h-100 border-0 menu-card">
         <img src="<%= request.getContextPath() + "/" + mm.getImagePath() %>" class="card-img-top" alt="">
         <div class="card-body p-2">
           <div class="fw-bold small"><%= mm.getMenuName() %></div>
           <div class="menu-desc"><%= mm.getDescription() %></div>
           <div class="price mt-1">¥<%= mm.getPrice() %></div>
         </div>
       </div>
     </div>
     <%
       }
     }
     %>
   </div>
   <hr class="divider">
   <!-- ===== Ala Carte ===== -->
   <div class="section-head">
     <h4 class="section-title">アラカルト</h4>
     <p class="section-sub">追加でちょい食べ</p>
   </div>
   <div class="row g-3 mb-4">
     <%
     if (alaCarteMenus != null) {
       for (Menu acm : alaCarteMenus) {
     %>
     <div class="col-6 col-sm-4 col-md-3 col-lg-2">
       <div class="card h-100 border-0 menu-card">
         <img src="<%= request.getContextPath() + "/" + acm.getImagePath() %>" class="card-img-top" alt="">
         <div class="card-body p-2">
           <div class="fw-bold small"><%= acm.getMenuName() %></div>
           <div class="menu-desc"><%= acm.getDescription() %></div>
           <div class="price mt-1">¥<%= acm.getPrice() %></div>
         </div>
       </div>
     </div>
     <%
       }
     }
     %>
   </div>
   <hr class="divider">
   <!-- ===== Salad / Soup ===== -->
   <div class="section-head">
     <h4 class="section-title">サラダ・スープ・その他</h4>
     <p class="section-sub">さっぱり系</p>
   </div>
   <div class="row g-3 mb-4">
     <%
     if (saladSoup != null) {
       for (Menu ssm : saladSoup) {
     %>
     <div class="col-6 col-sm-4 col-md-3 col-lg-2">
       <div class="card h-100 border-0 menu-card">
         <img src="<%= request.getContextPath() + "/" + ssm.getImagePath() %>" class="card-img-top" alt="">
         <div class="card-body p-2">
           <div class="fw-bold small"><%= ssm.getMenuName() %></div>
           <div class="menu-desc"><%= ssm.getDescription() %></div>
           <div class="price mt-1">¥<%= ssm.getPrice() %></div>
         </div>
       </div>
     </div>
     <%
       }
     }
     %>
   </div>
   <hr class="divider">
   <!-- ===== Drinks ===== -->
   <div class="section-head">
     <h4 class="section-title">ドリンク商品</h4>
     <p class="section-sub">食事と一緒に</p>
   </div>
   <div class="row g-3">
     <%
     if (drinks != null) {
       for (Menu dm : drinks) {
     %>
     <div class="col-6 col-sm-4 col-md-3 col-lg-2">
       <div class="card h-100 border-0 menu-card">
         <img src="<%= request.getContextPath() + "/" + dm.getImagePath() %>" class="card-img-top" alt="">
         <div class="card-body p-2">
           <div class="fw-bold small"><%= dm.getMenuName() %></div>
           <div class="menu-desc"><%= dm.getDescription() %></div>
           <div class="price mt-1">¥<%= dm.getPrice() %></div>
         </div>
       </div>
     </div>
     <%
       }
     }
     %>
   </div>
 </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

