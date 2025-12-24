<%@ include file="../header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Staff"%>
<%@ page import="java.util.*,java.time.*"%>
<%@ page import="model.Reservation"%>

<%
Staff admin = (Staff) session.getAttribute("admin");

LocalDate selectedDate = (LocalDate) request.getAttribute("date");
YearMonth ym = (YearMonth) request.getAttribute("ym");
List<Reservation> list = (List<Reservation>) request.getAttribute("list");
Map<LocalDate, Integer> monthCount =
    (Map<LocalDate, Integer>) request.getAttribute("monthCount");

/* tables */
String[] tableOrder = {
	"A1","A2",
	"T1","T2","T3","T4",
	"Z1","Z2","Z3","Z4"
};

Map<String, List<Reservation>> tableMap = new LinkedHashMap<>();
for (String t : tableOrder) tableMap.put(t, new ArrayList<>());
for (Reservation r : list) tableMap.get(r.getTableId()).add(r);
for (List<Reservation> rs : tableMap.values())
	rs.sort(Comparator.comparing(Reservation::getStartTime));

/* timeline */
LocalTime OPEN = LocalTime.of(17,0);
LocalTime CLOSE = LocalTime.of(22,0);
int TOTAL_MIN = (int) Duration.between(OPEN, CLOSE).toMinutes();

/* calendar */
LocalDate firstDay = ym.atDay(1);
int startDay = firstDay.getDayOfWeek().getValue();
%>


<title>Admin Dashboard</title>


<style>
/* ====== YOUR ORIGINAL CSS (kept) ====== */
.calendar {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	gap: 6px;
	max-width: 420px;
}
.calendar a {
	padding: 6px;
	border: 1px solid #ccc;
	border-radius: 6px;
	text-align: center;
	text-decoration: none;
	color: black;
}
.calendar .selected {
	background: #0d6efd;
	color: white;
}
.timeline {
	display: grid;
	grid-template-columns: 70px 1fr;
	row-gap: 10px;
	margin-top: 20px;
	margin-bottom: 80px;
}
.track {
	position: relative;
	height: 40px;
	background: #eee;
	border-radius: 6px;
}
.block {
	position: absolute;
	height: 100%;
	background: #0d6efd;
	color: white;
	font-size: 12px;
	padding: 4px;
	border-radius: 6px;
}

.user-card {
	display: inline-flex;
	align-items: flex-end;
	background: white;
	padding: 6px 10px;
	border-radius: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	gap: 8px;
	width: 200px;
}

/* Avatar smaller */
.user-avatar {
	width: 50px; /* reduced */
	height: 50px;
	background: linear-gradient(135deg, #007bff, #00c6ff);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-size: 18px;
}

/* Text */
.user-name {
	font-weight: 600;
	font-size: 18px;
}

.user-role {
	font-size: 16px;
	color: #777;
}
</style>
</head>

<body class="bg-light">

<div class="container-fluid">

	<h1 class="text-center my-4 fw-bold">
		MHP株式会社 営業サポートシステム
	</h1>

	<div class="container">

		<!-- TOP BAR -->
		<div class="d-flex justify-content-between align-items-center mb-4">

			<h2 class="fw-bold">📋 予約確認</h2>

			<% if (admin != null) { %>
			<div class="user-card">
						<div class="user-avatar">
							<i class="fa-solid fa-user"></i>
						</div>


						<div class="user-details">
							<div class="user-name"><%=admin.getStaffName()%></div>
							<div class="user-role"><%=admin.getStaffType()%></div>
						</div>




					</div>
			<% } %>

		</div>

		<!-- ACTION BUTTONS -->
		<div class="mb-4 text-end">
			<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"
			   class="btn btn-primary me-2">管理TOP</a>
			<a href="<%=request.getContextPath()%>/Adminlogoutservlet"
			   class="btn btn-primary me-2">ログアウト</a>
		</div>

		<!-- MONTH SELECT -->
		<form method="get"
		      action="<%=request.getContextPath()%>/admin"
		      class="row g-2 align-items-end mb-3">

			<div class="col-auto">
				<label class="form-label">Year</label>
				<select name="year" class="form-select">
				<% for (int y = ym.getYear()-1; y <= ym.getYear()+1; y++) { %>
					<option value="<%=y%>" <%=y==ym.getYear()?"selected":""%>>
						<%=y%>
					</option>
				<% } %>
				</select>
			</div>

			<div class="col-auto">
				<label class="form-label">Month</label>
				<select name="month" class="form-select">
				<% for (int m=1; m<=12; m++) { %>
					<option value="<%=m%>" <%=m==ym.getMonthValue()?"selected":""%>>
						<%=m%>
					</option>
				<% } %>
				</select>
			</div>

			<div class="col-auto">
				<button class="btn btn-success">Move</button>
			</div>
		</form>

		<!-- CALENDAR -->
		<div class="card p-3 mb-4">
			<div class="calendar mx-auto">

			<% for (int i=1; i<startDay; i++) { %>
				<div></div>
			<% } %>

			<% for (int d=1; d<=ym.lengthOfMonth(); d++) {
				LocalDate day = ym.atDay(d);
			%>
				<a href="<%=request.getContextPath()%>/admin?date=<%=day%>"
				   class="<%=day.equals(selectedDate)?"selected":""%>">
					<%=d%><br>
					<small>(<%=monthCount.getOrDefault(day,0)%>)</small>
				</a>
			<% } %>

			</div>
		</div>

		<!-- NAV BUTTONS -->
		<div class="mb-4 text-end">
			<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"
			   class="btn btn-warning me-2">予約編集</a>
			<a href="<%=request.getContextPath()%>/admin/list"
			   class="btn btn-secondary">予約履歴</a>
		</div>

		<h4 class="fw-bold mb-3">Date: <%=selectedDate%></h4>

		<!-- TIMELINE -->
		<div class="timeline">
		<% for (String t : tableOrder) { %>

			<div class="fw-bold"><%=t%></div>
			<div class="track">

			<% for (Reservation r : tableMap.get(t)) {
				int s = (int)Duration.between(OPEN,r.getStartTime()).toMinutes();
				int w = (int)Duration.between(r.getStartTime(),r.getEndTime()).toMinutes();
			%>
				<div class="block"
				     style="left:<%=s*100.0/TOTAL_MIN%>%;
				            width:<%=w*100.0/TOTAL_MIN%>%;">
					<%=r.getCustomerName()%><br>
					<%=r.getStartTime()%> - <%=r.getEndTime()%>
				</div>
			<% } %>

			</div>
		<% } %>
		</div>

	</div>
</div>

</body>
</html>