<%@ page contentType="text/html; charset=UTF-8"%>

<footer class="footer">
  <nav class="navbar navbar-expand-lg bg-dark py-3">
    <div class="container d-flex justify-content-between align-items-center">
      <!-- Left -->
      <div class="text-white fw-bold">mhp株式会社 @2025.inc</div>

      <!-- Right -->
      <div class="d-flex gap-3">
        <a href="#" class="text-white fs-4"><i class="bi bi-facebook"></i></a>
        <a href="#" class="text-white fs-4"><i class="bi bi-instagram"></i></a>
        <a href="#" class="text-white fs-4"><i class="bi bi-snapchat"></i></a>
      </div>
    </div>
  </nav>
</footer>

<!-- ================= POINT AUTO REFRESH ================= -->
<script>
function refreshPoint() {
  const badge = document.getElementById("pointBadge");
  if (!badge) return;

  fetch("<%=request.getContextPath()%>/PointServlet")
    .then(res => res.json())
    .then(data => {
      const current = parseInt(badge.innerText);
      const latest = data.point;

      if (!isNaN(current) && current !== latest) {
        animatePointChange(badge, current, latest);
      }
    })
    .catch(err => console.error(err));
}

function animatePointChange(badge, from, to) {
  let value = from;
  const step = from < to ? 1 : -1;

  const timer = setInterval(() => {
    value += step;
    badge.innerText = value + " pt";
    if (value === to) clearInterval(timer);
  }, 30);

  // floating +X bubble
  if (to > from) {
    const bubble = document.createElement("span");
    bubble.textContent = "+" + (to - from);
    bubble.style.position = "absolute";
    bubble.style.top = "-18px";
    bubble.style.right = "0";
    bubble.style.fontSize = "0.75rem";
    bubble.style.fontWeight = "700";
    bubble.style.color = "#ffd43b";
    bubble.style.pointerEvents = "none";
    bubble.style.animation = "pointFloat 1.5s ease forwards";

    badge.appendChild(bubble);
    setTimeout(() => bubble.remove(), 1500);
  }
}

// refresh once + every 5 seconds
document.addEventListener("DOMContentLoaded", refreshPoint);
setInterval(refreshPoint, 5000);
</script>

<style>
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
