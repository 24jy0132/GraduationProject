<%@ include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"
   import="java.util.List, java.util.Map, model.Menu,model.Customer" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン・会員登録のお願い</title>
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
 :root{
   --bg: #f6f2fb;          /* soft light purple background */
   --card: #ffffff;
   --text: #212529;
   --muted: #666;
   --accent1: #e64980;     /* pink */
   --accent2: #ae3ec9;     /* purple */
   --line: #ece8f7;
 }
 body{
   background: var(--bg);
 }
 /* page spacing */
 .page-wrap{
   min-height: 70vh;
   display:flex;
   align-items:center;
   justify-content:center;
   padding: 48px 12px;
 }
 /* ===== Card ===== */
 .notice-card{
   max-width: 720px;
   width: 100%;
   border-radius: 18px;
   background: var(--card);
   border: 1px solid var(--line);
   padding: 42px 28px;
   box-shadow: 0 14px 34px rgba(0,0,0,.08);
 }
 /* ===== Title ===== */
 .notice-title{
   color: var(--text);
   font-weight: 800;
   letter-spacing: .2px;
 }
 /* ===== Text ===== */
 .notice-text{
   color: var(--muted);
   font-weight: 600;
   line-height: 1.9;
 }
 /* ===== Main Action Button (Register) ===== */
 .btn-wine{
   border: none;
   background: linear-gradient(135deg, var(--accent1), var(--accent2));
   color:#fff;
   font-weight: 700;
   box-shadow: 0 8px 18px rgba(174,62,201,.28);
   transition: all .2s ease;
 }
 .btn-wine:hover{
   transform: translateY(-2px);
   box-shadow: 0 12px 26px rgba(174,62,201,.38);
   color:#fff;
 }
 /* ===== Secondary Button (Login) ===== */
 .btn-outline-wine{
   background:#fff;
   color:#555;
   border:1.5px solid #d7d7e2;
   font-weight: 700;
   transition: all .2s ease;
 }
 .btn-outline-wine:hover{
   background: #f3f0ff;
   border-color: rgba(174,62,201,.30);
   color:#333;
 }
</style>
</head>
<body class="bg-white">
<!-- if you have header/footer, keep them -->
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
 <div class="notice-card text-center shadow-sm">
   <h2 class="notice-title mb-4">アンケートに回答するにはログインが必要です</h2>
   <div class="notice-text mb-4">
     <div>商品アンケートは会員向けのサービスです。</div>
     <div>ログインしてから再度お試しください。</div>
     <div>会員登録がまだの方は、新規会員登録をお願いいたします。</div>
   </div>
  <div class="d-flex flex-column flex-sm-row gap-3 justify-content-center">
 <button type="button"
         class="btn btn-outline-wine rounded-pill px-4"
         onclick="location.href='login.jsp'">
   ログイン画面へ
 </button>
 <button type="button"
         class="btn btn-wine rounded-pill px-4"
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

