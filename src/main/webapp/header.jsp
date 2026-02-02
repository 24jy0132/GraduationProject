<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
<link rel="stylesheet"
  href="${pageContext.request.contextPath}/css/bootstrap.min.css">

<style>
/* required for floating animation */
#pointBadge {
  position: relative;
}

/* ✅ FIXED keyframes */
@keyframes pointFloat {
  0% {
    opacity: 0;
    transform: translateY(10px);
  }
  20% {
    opacity: 1;
  }
  100% {
    opacity: 0;
    transform: translateY(-20px);
  }
}
</style>

<%
Integer earnedPoint = (Integer) session.getAttribute("earnedPoint");
if (earnedPoint != null) {
%>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const badge = document.getElementById("pointBadge");
  if (!badge) return;

  // current total (after DB update)
  const total = parseInt(badge.innerText);

  // earned points
  const earned = <%= earnedPoint %>;

  // previous value
  const previous = total - earned;

  // start from previous
  badge.innerText = previous + " pt";

  // count-up animation
  let current = previous;
  const interval = setInterval(() => {
    current++;
    badge.innerText = current + " pt";
    if (current >= total) clearInterval(interval);
  }, 40);

  // floating +X bubble
  const bubble = document.createElement("span");
  bubble.textContent = "+" + earned;
  bubble.style.position = "absolute";
  bubble.style.top = "-18px";
  bubble.style.right = "0";
  bubble.style.fontSize = "0.8rem";
  bubble.style.fontWeight = "700";
  bubble.style.color = "#ffd43b";
  bubble.style.pointerEvents = "none";
  bubble.style.animation = "pointFloat 1.5s ease forwards";

  badge.appendChild(bubble);
  setTimeout(() => bubble.remove(), 1500);
});
</script>

<%
session.removeAttribute("earnedPoint");
}
%>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</head>
</html>
