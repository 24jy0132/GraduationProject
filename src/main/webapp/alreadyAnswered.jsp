<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="model.Customer"%>
   <%@ include file="header.jsp"%>
  
<!DOCTYPE html>
<html lang="ja">
<head>
 <meta charset="UTF-8" />
 <meta name="viewport" content="width=device-width, initial-scale=1" />
 <title>回答済み</title>
 <!-- Bootstrap -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <style>
   body{
     background: #ffffff;
   }
   /* central card */
   .msg-card{
     max-width: 520px;
     width: 92%;
     border-radius: 18px;
     background: #ffffff;
     box-shadow: 0 14px 34px rgba(0,0,0,.08);
     padding: 42px 32px;
     text-align: center;
   }
   /* check icon */
   .check-icon{
     font-size: 3.2rem;
     color: #e64980;   /* pink like screenshot */
     margin-bottom: 14px;
   }
   .msg-title{
     font-weight: 800;
     font-size: 1.4rem;
     color: #212529;
     margin-bottom: 14px;
   }
   .msg-text{
     color: #666;
     font-size: 0.95rem;
     line-height: 1.8;
     margin-bottom: 26px;
   }
   /* elegant pink-purple button */
   .btn-soft {
     background: linear-gradient(135deg, #e64980, #ae3ec9);
     color: #fff;
     border: none;
     border-radius: 999px;
     padding: 0.65rem 2.2rem;
     font-weight: 600;
     box-shadow: 0 8px 18px rgba(174,62,201,.35);
     transition: all .2s ease;
   }
   .btn-soft:hover{
     transform: translateY(-2px);
     box-shadow: 0 12px 26px rgba(174,62,201,.45);
     color: #fff;
   }
 </style>
</head>
<body>
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
 <!-- center -->
 <div class="min-vh-100 d-flex align-items-center justify-content-center">
   <div class="msg-card">
     <!-- icon -->
     <div class="check-icon">✓</div>
     <div class="msg-title">
       このアンケートは回答済みです
     </div>
     <p class="msg-text">
       すでに当該商品のアンケートに回答済みのため、<br>
       再度回答することはできません。
     </p>
     <button class="btn btn-soft"
             onclick="location.href='MenuListServlet'">
       メニューに戻る
     </button>
   </div>
 </div>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

