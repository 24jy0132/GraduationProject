<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="model.Menu,model.Customer" %>
<%
Menu menu = (Menu)request.getAttribute("menu");
Customer customer = (Customer) session.getAttribute("customer");
if(menu == null){
 response.sendRedirect("MenuListServlet");
 return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品レビューアンケート</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
 /* theme colors (pink-purple like your favorite screen) */
 :root{
   --bg: #f6f2fb;          /* very light purple background */
   --card: #ffffff;
   --text: #212529;
   --muted: #6c757d;
   --accent1: #e64980;     /* pink */
   --accent2: #ae3ec9;     /* purple */
   --line: #ece8f7;
 }
 body {
   background: var(--bg);
 }
 .page-box {
   background: var(--card);
   border-radius: 18px;
   padding: 28px;
   box-shadow: 0 14px 34px rgba(0,0,0,.08);
   border: 1px solid var(--line);
 }
 .desc-text {
   font-size: 0.85rem;
   color: var(--muted);
   line-height: 1.45;
 }
 .section-title {
   font-weight: 800;
   font-size: 0.95rem;
   margin-bottom: 0.5rem;
   color: #2b2b2b;
 }
 /* keep your layout EXACTLY the same */
 .option-row { gap: 1.5rem; row-gap: 0.75rem; }
 /* make textarea match theme */
 .comment-box {
   background: #fbf7ff;
   border-radius: 12px;
   border: 1px solid #e7d9ff;
 }
 .comment-box:focus{
   box-shadow: 0 0 0 .2rem rgba(174,62,201,.15);
   border-color: rgba(174,62,201,.45);
 }
 /* buttons theme (CSS-only, no HTML change) */
 .btn-primary{
   border: none;
   background: linear-gradient(135deg, var(--accent1), var(--accent2));
   box-shadow: 0 8px 18px rgba(174,62,201,.25);
   font-weight: 600;
 }
 .btn-primary:hover{
   background: linear-gradient(135deg, #f06595, #b44ad8);
   box-shadow: 0 12px 26px rgba(174,62,201,.35);
   transform: translateY(-1px);
 }
 .btn-outline-secondary{
   border-color: #d7d7e2;
   color: #555;
   font-weight: 600;
   background: #fff;
 }
 .btn-outline-secondary:hover{
   background: #f3f0ff;
   border-color: #cdb8ff;
   color: #3b3b3b;
 }
</style>
</head>
<body>
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
<div class="container py-5">
 <div class="row justify-content-center">
   <div class="col-12 col-md-9 col-lg-7">
     <div class="page-box">
       <h4 class="fw-bold mb-3">商品レビューアンケート</h4>
       <p class="text-muted mb-4">
         商品に関するご感想をお聞かせください。<br>
         アンケートに回答すると、1商品につき1度だけポイントが加算されます
       </p>
       <!-- Product -->
       <div class="mb-4">
         <div class="d-flex gap-3">
           <img src="<%= menu.getImagePath() %>"
                style="width:96px;height:72px;object-fit:cover;border-radius:6px;background:#eee;">
           <div>
             <div class="fw-bold"><%= menu.getMenuName() %></div>
             <div class="desc-text"><%= menu.getDescription() %></div>
             <div class="fw-bold mt-1">¥<%= menu.getPrice() %></div>
           </div>
         </div>
       </div>
       <form action="SurveyDoneServlet" method="post">
         <input type="hidden" name="menuId" value="<%= menu.getMenuId() %>">
         <!-- Taste (UNCHANGED) -->
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
         <!-- Volume (UNCHANGED) -->
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
         <!-- Price (UNCHANGED) -->
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
         <div class="d-flex justify-content-center gap-3">
           <button type="button" class="btn btn-outline-secondary px-4"
                   onclick="history.back()">戻る</button>
           <button type="submit" class="btn btn-primary px-4">投稿する</button>
         </div>
       </form>
     </div>
   </div>
 </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

