<%@ include file="../header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,java.time.*"%>
<%@ page import="model.Staff,model.Reservation"%>

<%
Staff admin = (Staff) session.getAttribute("admin");

LocalDate selectedDate = (LocalDate) request.getAttribute("date");
YearMonth ym = (YearMonth) request.getAttribute("ym");
List<Reservation> list = (List<Reservation>) request.getAttribute("list");
Map<LocalDate, Integer> monthCount = (Map<LocalDate, Integer>) request.getAttribute("monthCount");

String[] tableOrder = {"A1", "A2", "T1", "T2", "T3", "T4", "Z1", "Z2", "Z3", "Z4"};

/* table → reservations */
Map<String, List<Reservation>> tableMap = new LinkedHashMap<>();
for (String t : tableOrder) {
	tableMap.put(t, new ArrayList<>());
}

/* render reservation on ALL selected tables */
for (Reservation r : list) {
	if (r.getTableIds() == null)
		continue;
	for (String tid : r.getTableIds()) {
		if (tableMap.containsKey(tid)) {
	tableMap.get(tid).add(r);
		}
	}
}

/* sort per table */
for (List<Reservation> rs : tableMap.values()) {
	rs.sort(Comparator.comparing(Reservation::getStartTime));
}

LocalTime OPEN = LocalTime.of(17, 0);
LocalTime CLOSE = LocalTime.of(22, 0);
int TOTAL_MIN = (int) Duration.between(OPEN, CLOSE).toMinutes();

LocalDate firstDay = ym.atDay(1);
int startDay = firstDay.getDayOfWeek().getValue();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<style>
/* ===== LAYOUT ===== */
.timeline {
	display: grid;
	grid-template-columns: 70px 1fr;
	row-gap: 14px;
	margin-bottom: 80px;
}

.track {
	position: relative;
	height: 50px;
	background: #e9ecef;
	border-radius: 6px;
}

/* ===== BLOCK ===== */
.block {
	position: absolute;
	height: 50px;
	padding: 6px 8px;
	border-radius: 6px;
	font-size: 12px;
	color: #fff;
	cursor: pointer;
	box-shadow: inset 0 0 0 1px rgba(0, 0, 0, .2);
}

.block.RESERVED {
	background: #0d6efd;
}

.block.ARRIVED {
	background: #ffc107;
	color: #000;
}

.block.BILL_REQUESTED {
	background: #fd7e14;
}

.block.FINISHED {
	background: rgba(25, 135, 84, .35);
}

.block:hover {
	z-index: 20
}

/* visual link for multi-table */
.block.linked {
	outline: 2px dashed rgba(255, 255, 255, .9);
	outline-offset: -2px;
}

/* ===== HOVER ===== */
.hover-card {
	position: absolute;
	top: 56px;
	left: 0;
	width: 220px;
	background: #fff;
	color: #000;
	border-radius: 8px;
	padding: 10px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, .25);
	opacity: 0;
	visibility: hidden;
	transition: .2s;
}

.block:hover .hover-card {
	opacity: 1;
	visibility: visible;
}

.hover-row {
	font-size: 12px;
	margin-bottom: 4px
}

/* ===== TIME HEADER ===== */
.time-header {
	display: grid;
	grid-template-columns: 70px 1fr;
	margin-bottom: 12px;
}

.time-scale {
	position: relative;
	height: 28px;
	background: #f8f9fa;
	border: 1px solid #ccc;
	border-radius: 6px;
	overflow: hidden;
}

.time-scale span {
	position: absolute;
	top: 4px;
	font-size: 12px;
	white-space: nowrap;
}

.time-scale .first {
	left: 0
}

.time-scale .mid {
	transform: translateX(-50%)
}

.time-scale .last {
	right: 0
}

/* ===== CALENDAR ===== */
.calendar {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	gap: 6px;
	max-width: 420px;
}

.calendar a {
	border: 1px solid #ccc;
	border-radius: 6px;
	padding: 6px;
	text-align: center;
	color: #000;
	text-decoration: none;
}

.calendar .selected {
	background: #0d6efd;
	color: #fff
}

#calendarBox {
	display: none
}

/* ===== USER CARD ===== */
.user-card {
	display: flex;
	gap: 10px;
	background: #fff;
	padding: 8px 12px;
	border-radius: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, .1);
}

.user-avatar {
	width: 45px;
	height: 45px;
	border-radius: 50%;
	background: linear-gradient(135deg, #007bff, #00c6ff);
	display: flex;
	align-items: center;
	justify-content: center;
	color: #fff;
}
</style>
</head>

<body class="bg-light">
	<h1 class="text-center">MHP株式会社 営業サポートシステム</h1>
	<div class="container">



		<!-- HEADER -->
		<div class="d-flex justify-content-between align-items-start mb-4">
			<h2 class="fw-bold">📋 予約確認</h2>

			<div class="d-flex flex-column align-items-center">
				<%
				if (admin != null) {
				%>
				<div class="user-card mb-2">
					<div class="user-avatar">
						<i class="fa-solid fa-user"></i>
					</div>
					<div>
						<div>
							<b><%=admin.getStaffName()%></b>
						</div>
						<div><%=admin.getStaffType()%></div>
					</div>
				</div>
				<%
				}
				%>

				<div class="d-flex gap-2">
					<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"
						class="btn btn-primary px-4">管理TOP</a> <a
						href="<%=request.getContextPath()%>/Adminlogoutservlet"
						class="btn btn-primary px-4">ログアウト</a>
				</div>
			</div>
		</div>


		<form method="get" action="<%=request.getContextPath()%>/admin"
			class="row g-3 mb-3 justify-content-center align-items-center">
			<div class="col-auto">
				<input type="date" name="date" value="<%=selectedDate%>"
					class="form-control">
			</div>
			<div class="col-auto">
				<button class="btn btn-primary">Filter</button>
			</div>
			<div class="col-auto">
				<button type="button" class="btn btn-outline-secondary"
					onclick="toggleCalendar()">📅 Calendar</button>
			</div>
			<div class="col-auto">
				<a href="<%=request.getContextPath()%>/admin/list"
					class="btn btn-secondary">予約履歴</a>
			</div>
		</form>

		<div id="calendarBox" class="card p-3 mb-3">
			<div class="calendar mx-auto">
				<%
				for (int i = 1; i < startDay; i++) {
				%><div></div>
				<%
				}
				%>
				<%
				for (int d = 1; d <= ym.lengthOfMonth(); d++) {
					LocalDate day = ym.atDay(d);
				%>
				<a href="<%=request.getContextPath()%>/admin?date=<%=day%>"
					class="<%=day.equals(selectedDate) ? "selected" : ""%>"> <%=d%><br>
					<small>(<%=monthCount.getOrDefault(day, 0)%>)
				</small>
				</a>
				<%
				}
				%>
			</div>
		</div>

		<div class="time-header">
			<div></div>
			<div class="time-scale">
				<%
				for (int m = 0; m <= TOTAL_MIN; m += 30) {
					LocalTime t = OPEN.plusMinutes(m);
					double left = m * 100.0 / TOTAL_MIN;
					String cls = m == 0 ? "first" : (m == TOTAL_MIN ? "last" : "mid");
				%>
				<span class="<%=cls%>"
					style="<%=cls.equals("mid") ? "left:" + left + "%;" : ""%>">
					<%=t%>
				</span>
				<%
				}
				%>
			</div>
		</div>

		<div class="timeline">
			<%
			for (String t : tableOrder) {
			%>
			<div>
				<b><%=t%></b>
			</div>
			<div class="track">
				<%
				for (Reservation r : tableMap.get(t)) {
					LocalTime st = r.getStartTime().isBefore(OPEN) ? OPEN : r.getStartTime();
					LocalTime en = r.getEndTime().isAfter(CLOSE) ? CLOSE : r.getEndTime();
					int s = (int) Duration.between(OPEN, st).toMinutes();
					int w = (int) Duration.between(st, en).toMinutes();
				%>
				<div class="block <%=r.getStatus()%>"
					data-res="<%=r.getReservationId()%>"
					style="left:<%=s * 100.0 / TOTAL_MIN%>%;width:<%=w * 100.0 / TOTAL_MIN%>%;">
					<%=r.getCustomerName()%>
					<%=r.getAdultCount() + r.getChildCount()%>様
					<div class="hover-card">
						<div class="hover-row">
							🪑
							<%=String.join(" + ", r.getTableIds())%></div>
						<div class="hover-row">
							⏰
							<%=r.getStartTime()%>
							-
							<%=r.getEndTime()%></div>
						<select class="form-select form-select-sm"
							onchange="updateStatus(<%=r.getReservationId()%>,this.value)">
							<option value="RESERVED"
								<%=r.getStatus().equals("RESERVED") ? "selected" : ""%>>RESERVED</option>
							<option value="ARRIVED"
								<%=r.getStatus().equals("ARRIVED") ? "selected" : ""%>>ARRIVED</option>
							<option value="BILL_REQUESTED"
								<%=r.getStatus().equals("BILL_REQUESTED") ? "selected" : ""%>>BILL</option>
							<option value="FINISHED"
								<%=r.getStatus().equals("FINISHED") ? "selected" : ""%>>FINISHED</option>
						</select>
						<div class="actions">
							<a
								href="<%=request.getContextPath()%>/admin/edit?id=<%=r.getReservationId()%>">✏</a>
							<a
								href="<%=request.getContextPath()%>/admin/delete?id=<%=r.getReservationId()%>"
								onclick="return confirm('Delete?')">🗑</a>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
			<%
			}
			%>
		</div>

	</div>

	<script>
function toggleCalendar(){
 const b=document.getElementById("calendarBox");
 b.style.display=b.style.display==="none"?"block":"none";
}
function updateStatus(id,status){
 fetch("<%=request.getContextPath()%>/admin/status",{
  method:"POST",
  headers:{"Content-Type":"application/x-www-form-urlencoded"},
  body:"id="+id+"&status="+status
 }).then(()=>{
  document.querySelectorAll('[data-res="'+id+'"]').forEach(el=>{
    el.className="block "+status;
  });
 });
}
/* visual link */
document.addEventListener("mouseover",e=>{
 const b=e.target.closest(".block");
 if(!b) return;
 document.querySelectorAll('[data-res="'+b.dataset.res+'"]')
   .forEach(x=>x.classList.add("linked"));
});
document.addEventListener("mouseout",e=>{
 const b=e.target.closest(".block");
 if(!b) return;
 document.querySelectorAll('[data-res="'+b.dataset.res+'"]')
   .forEach(x=>x.classList.remove("linked"));
});
</script>

</body>
</html>
