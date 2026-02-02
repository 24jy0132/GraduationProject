<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,java.time.*,model.Staff,model.Reservation"%>

<%
// 1. DATA RETRIEVAL
Staff admin = (Staff) session.getAttribute("admin");

// --- DATE LOGIC ---
String dateParam = request.getParameter("date");
LocalDate selectedDate = null;
if (dateParam != null && !dateParam.isEmpty()) {
	try {
		selectedDate = LocalDate.parse(dateParam);
	} catch (Exception e) {
	}
}
if (selectedDate == null) {
	selectedDate = (LocalDate) request.getAttribute("date");
}
if (selectedDate == null) {
	selectedDate = LocalDate.now();
}

// Current View Month
YearMonth currentYm = YearMonth.from(selectedDate);

// Arrow Navigation Dates (1st of prev/next month)
LocalDate prevMonthDate = selectedDate.minusMonths(1).withDayOfMonth(1);
LocalDate nextMonthDate = selectedDate.plusMonths(1).withDayOfMonth(1);

// Reservation Data
List<Reservation> list = (List<Reservation>) request.getAttribute("list");
Map<LocalDate, Integer> monthCount = (Map<LocalDate, Integer>) request.getAttribute("monthCount");
if (monthCount == null)
	monthCount = new HashMap<>();

// 2. SETUP TABLES
String[] tableOrder = {"A1", "A2", "T1", "T2", "T3", "T4", "Z1", "Z2", "Z3", "Z4"};
Map<String, List<Reservation>> tableMap = new LinkedHashMap<>();
for (String t : tableOrder) {
	tableMap.put(t, new ArrayList<>());
}

// 3. MAP RESERVATIONS
if (list != null) {
	for (Reservation r : list) {
		if (r.getTableIds() == null)
	continue;
		for (String tid : r.getTableIds()) {
	if (tableMap.containsKey(tid)) {
		tableMap.get(tid).add(r);
	}
		}
	}
}

// 4. TIME CONSTANTS
LocalTime OPEN = LocalTime.of(17, 0);
LocalTime CLOSE = LocalTime.of(22, 0);
long TOTAL_MIN = Duration.between(OPEN, CLOSE).toMinutes();

// Calendar Helper
LocalDate firstDayOfGrid = currentYm.atDay(1);
int startDayOfWeek = firstDayOfGrid.getDayOfWeek().getValue();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>予約管理システム</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">

<style>
/* ===== BASE ===== */
body {
	background: #eef2f6;
	font-family: "Roboto", sans-serif;
	color: #333;
}

/* ===== USER CARD & NAV ===== */
.topcontainer {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

.user-card {
	display: inline-flex;
	align-items: center; /* Changed to center for better alignment */
	background: white;
	padding: 6px 15px 6px 8px; /* Adjusted padding */
	border-radius: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	gap: 12px;
	min-width: 200px;
}

.user-avatar {
	width: 50px;
	height: 50px;
	background: linear-gradient(135deg, #007bff, #00c6ff);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-size: 20px;
	flex-shrink: 0;
}

.user-details {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.user-name {
	font-weight: 700;
	font-size: 16px;
	line-height: 1.2;
	color: #333;
}

.user-role {
	font-size: 13px;
	color: #777;
}

/* ===== BUTTONS (FROSTED) ===== */
.buttons {
	text-align: right;
	margin-bottom: 25px;
}

.buttons button, .btn-frost {
	background: rgba(255, 255, 255, .7);
	backdrop-filter: blur(8px);
	border-radius: 12px;
	border: 1px solid rgba(0, 0, 0, .08);
	padding: 9px 22px;
	font-size: 14px;
	font-weight: 500;
	color: #1c1c1e;
	margin-left: 10px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, .12);
	transition: .25s;
}

.buttons button:hover, .btn-frost:hover {
	background: rgba(255, 255, 255, .9);
	transform: translateY(-1px);
}

/* ===== SCHEDULER BOARD ===== */
.scheduler-wrapper {
	background: #fff;
	border: 1px solid #dcdfe3;
	border-radius: 8px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
	margin-bottom: 150px;
	overflow: hidden;
}

.scheduler-header {
	padding: 15px 20px;
	background: #f8f9fa;
	border-bottom: 1px solid #dcdfe3;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

/* Grid Scroll */
.grid-container {
	position: relative;
	overflow-x: auto;
	overflow-y: visible;
	padding-bottom: 10px;
	min-height: 500px;
}

.grid-row {
	display: flex;
	height: 70px;
	border-bottom: 1px solid #eee;
	position: relative;
}

.row-header {
	position: sticky;
	left: 0;
	width: 90px;
	min-width: 90px;
	background: #fff;
	border-right: 3px solid #dee2e6;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 800;
	color: #495057;
	z-index: 20;
	box-shadow: 4px 0 10px rgba(0, 0, 0, 0.05);
}

/* Time Header */
.time-header-row {
	display: flex;
	height: 35px;
	background: #343a40;
	color: #fff;
	position: sticky;
	top: 0;
	z-index: 30;
}

.time-header-label {
	position: sticky;
	left: 0;
	width: 90px;
	min-width: 90px;
	background: #212529;
	border-right: 1px solid #495057;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 12px;
	font-weight: bold;
}

.time-track {
	flex-grow: 1;
	position: relative;
	min-width: 800px;
}

/* Grid Lines & Markers */
.grid-guide {
	position: absolute;
	top: 0;
	bottom: 0;
	width: 1px;
	background: #e9ecef;
	z-index: 1;
}

.grid-guide.hour {
	background: #dee2e6;
	width: 1px;
}

.time-marker {
	position: absolute;
	top: 8px;
	font-size: 11px;
	font-weight: bold;
	color: #adb5bd;
}

.time-marker.start {
	transform: translateX(0);
}

.time-marker.mid {
	transform: translateX(-50%);
}

.time-marker.end {
	transform: translateX(-100%);
}

/* ===== BLOCKS ===== */
.res-block {
	position: absolute;
	top: 10px;
	bottom: 10px;
	border-radius: 6px;
	background: #fff;
	border: 1px solid #ccc;
	font-size: 12px;
	color: #333;
	padding: 0 10px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	overflow: visible;
	white-space: nowrap;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	transition: 0.1s;
	z-index: 10;
	border-left: 5px solid #999;
	cursor: pointer;
}

.res-block:hover {
	z-index: 100;
	transform: scale(1.02);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

.res-block.RESERVED {
	border-left-color: #0d6efd;
	background: #f0f7ff;
}

.res-block.ARRIVED {
	border-left-color: #ffc107;
	background: #fff9e6;
}

.res-block.BILL_REQUESTED {
	border-left-color: #fd7e14;
	background: #fff4e6;
}

.res-block.FINISHED {
	border-left-color: #198754;
	background: #f0fdf4;
	opacity: 0.7;
}

/* ===== POPUP ===== */
.detail-popup {
	display: none;
	position: absolute;
	top: 100%;
	left: 0;
	width: 260px;
	background: #fff;
	border: 1px solid #ccc;
	border-radius: 8px;
	padding: 15px;
	box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
	z-index: 200;
	text-align: left;
	color: #333;
	margin-top: 10px;
}

.res-block:hover .detail-popup {
	display: block;
}

/* ===== CALENDAR MODAL ===== */
.modal-calendar {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 9999;
	display: none;
	justify-content: center;
	align-items: center;
}

.cal-content {
	background: white;
	padding: 20px;
	border-radius: 12px;
	width: 340px;
	box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
}

.cal-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
}

.cal-grid {
	display: grid;
	grid-template-columns: repeat(7, 1fr);
	gap: 5px;
}

.cal-cell {
	padding: 8px 4px;
	text-align: center;
	border-radius: 4px;
	text-decoration: none;
	color: #333;
	background: #f8f9fa;
	font-size: 14px;
	position: relative;
	height: 50px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.cal-cell:hover {
	background: #e9ecef;
}

.cal-cell.active {
	background: #0d6efd;
	color: white;
}

.cal-count {
	font-size: 10px;
	margin-top: 2px;
	font-weight: bold;
	color: #dc3545;
}

.cal-cell.active .cal-count {
	color: white;
}
</style>
</head>

<body>

	<div class="container-fluid px-4 mt-4">

		<h2 class="text-center fw-bold text-dark mb-4">MHP株式会社 営業サポートシステム</h2>

		<div class="topcontainer">
			<%
			if (admin != null) {
			%>
			<div class="user-card">
				<div class="user-avatar">
					<i class="fa-solid fa-user"></i>
				</div>
				<div class="user-details">
					<div class="user-name"><%=admin.getStaffName()%></div>
					<div class="user-role"><%=admin.getStaffType()%></div>
				</div>
			</div>
			<%
			}
			%>
		</div>

		<div class="buttons">
			<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"><button>管理TOP</button></a>
			<a href="<%=request.getContextPath()%>/Adminlogoutservlet"><button>ログアウト</button></a>
		</div>

		<div class="scheduler-wrapper">

			<div class="scheduler-header">
				<div class="d-flex align-items-center gap-3">
					<h4 class="m-0 fw-bold text-dark"><%=selectedDate%></h4>

					<button class="btn btn-sm btn-dark d-flex align-items-center gap-2"
						onclick="openCalendar()">
						<i class="fa-regular fa-calendar"></i> カレンダー
					</button>

					<a href="<%=request.getContextPath()%>/admin/list"
						class="btn btn-sm btn-outline-secondary d-flex align-items-center gap-2">
						<i class="fa-solid fa-list-check"></i> 予約履歴
					</a>
				</div>
				<div class="d-flex gap-2">
					<span
						class="badge bg-primary bg-opacity-10 text-primary border border-primary">予約中</span>
					<span
						class="badge bg-warning bg-opacity-10 text-dark border border-warning">来店済</span>
					<span
						class="badge bg-danger bg-opacity-10 text-dark border border-danger">会計待</span>
					<span
						class="badge bg-success bg-opacity-10 text-success border border-success">完了</span>
				</div>
			</div>

			<div class="grid-container">

				<div class="time-header-row">
					<div class="time-header-label">TABLE</div>
					<div class="time-track">
						<%
						for (int m = 0; m <= TOTAL_MIN; m += 60) {
							LocalTime t = OPEN.plusMinutes(m);
							double left = m * 100.0 / TOTAL_MIN;
							String align = (m == 0) ? "start" : (m == TOTAL_MIN ? "end" : "mid");
						%>
						<div class="grid-guide hour"
							style="left: <%=left%>%; height: 2000px; background: rgba(255,255,255,0.1);"></div>
						<span class="time-marker <%=align%>" style="left: <%=left%>%;"><%=t%></span>
						<%
						}
						%>
					</div>
				</div>

				<%
				for (String t : tableOrder) {
				%>
				<div class="grid-row">
					<div class="row-header"><%=t%></div>
					<div class="time-track h-100">

						<%
						for (int m = 60; m < TOTAL_MIN; m += 60) {
							double left = m * 100.0 / TOTAL_MIN;
						%>
						<div class="grid-guide hour" style="left: <%=left%>%;"></div>
						<%
						}
						%>

						<%
						for (Reservation r : tableMap.get(t)) {
							LocalTime st = r.getStartTime().isBefore(OPEN) ? OPEN : r.getStartTime();
							LocalTime en = r.getEndTime().isAfter(CLOSE) ? CLOSE : r.getEndTime();
							long startMin = Duration.between(OPEN, st).toMinutes();
							long durationMin = Duration.between(st, en).toMinutes();
							double leftPct = startMin * 100.0 / TOTAL_MIN;
							double widthPct = durationMin * 100.0 / TOTAL_MIN;
						%>

						<div class="res-block <%=r.getStatus()%>"
							data-res="<%=r.getReservationId()%>"
							style="left:<%=leftPct%>%; width:<%=widthPct%>%;">

							<div class="fw-bold text-truncate"><%=r.getCustomerName()%></div>
							<div class="small text-muted"><%=r.getAdultCount() + r.getChildCount()%>名
							</div>

							<div class="detail-popup">
								<h6 class="fw-bold mb-3 border-bottom pb-2">
									詳細 (ID:<%=r.getReservationId()%>)
								</h6>
								<div class="mb-2">
									<i class="fa-regular fa-clock w-25"></i> <span><%=r.getStartTime()%>
										- <%=r.getEndTime()%></span>
								</div>
								<div class="mb-3">
									<i class="fa-solid fa-users w-25"></i> <span><%=r.getAdultCount()%>名
										/ 子<%=r.getChildCount()%></span>
								</div>

								<label class="small text-muted fw-bold">ステータス変更</label> <select
									class="form-select form-select-sm mb-3"
									onchange="updateStatus(<%=r.getReservationId()%>, this.value)">
									<option value="RESERVED"
										<%=r.getStatus().equals("RESERVED") ? "selected" : ""%>>🔵
										予約中</option>
									<option value="ARRIVED"
										<%=r.getStatus().equals("ARRIVED") ? "selected" : ""%>>🟡
										来店済</option>
									<option value="BILL_REQUESTED"
										<%=r.getStatus().equals("BILL_REQUESTED") ? "selected" : ""%>>🟠
										会計待</option>
									<option value="FINISHED"
										<%=r.getStatus().equals("FINISHED") ? "selected" : ""%>>🟢
										完了</option>
								</select>

								<div class="d-flex justify-content-end gap-2">
									<a
										href="<%=request.getContextPath()%>/admin/edit?id=<%=r.getReservationId()%>"
										class="btn btn-sm btn-outline-primary w-50">編集</a> <a
										href="<%=request.getContextPath()%>/admin/delete?id=<%=r.getReservationId()%>"
										class="btn btn-sm btn-outline-danger w-50"
										onclick="return confirm('削除？')">削除</a>
								</div>
							</div>
						</div>
						<%
						}
						%>
					</div>
				</div>
				<%
				}
				%>

			</div>
		</div>
	</div>

	<div id="calModal" class="modal-calendar"
		onclick="if(event.target===this)this.style.display='none'">
		<div class="cal-content">
			<div class="cal-header">
				<a href="?date=<%=prevMonthDate%>&calOpen=true"
					class="btn btn-sm btn-outline-secondary"> <i
					class="fa-solid fa-chevron-left"></i>
				</a>

				<h5 class="m-0 fw-bold"><%=currentYm%></h5>

				<a href="?date=<%=nextMonthDate%>&calOpen=true"
					class="btn btn-sm btn-outline-secondary"> <i
					class="fa-solid fa-chevron-right"></i>
				</a>
			</div>

			<div class="cal-grid">
				<%
				for (int i = 1; i < startDayOfWeek; i++) {
				%><span></span>
				<%
				}
				%>

				<%
				for (int d = 1; d <= currentYm.lengthOfMonth(); d++) {
					LocalDate day = currentYm.atDay(d);
					int count = monthCount.getOrDefault(day, 0);
					String active = day.equals(selectedDate) ? "active" : "";
				%>
				<a href="?date=<%=day%>" class="cal-cell <%=active%>"> <%=d%> <%
 if (count > 0) {
 %>
					<span class="cal-count"><%=count%>件</span> <%
 }
 %>
				</a>
				<%
				}
				%>
			</div>

			<button class="btn btn-secondary w-100 mt-3"
				onclick="document.getElementById('calModal').style.display='none'">閉じる</button>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script>
	// 1. Check if calendar should be open on load
	window.onload = function() {
		const params = new URLSearchParams(window.location.search);
		if(params.get('calOpen') === 'true') {
			document.getElementById('calModal').style.display = 'flex';
		}
	};

	function openCalendar() {
		document.getElementById('calModal').style.display = 'flex';
	}

	// 2. Status Update AJAX
	function updateStatus(id, status){
		fetch("<%=request.getContextPath()%>/admin/status", {
			method: "POST",
			headers: {"Content-Type":"application/x-www-form-urlencoded"},
			body: "id=" + id + "&status=" + status
		}).then(() => {
			document.querySelectorAll('[data-res="'+id+'"]').forEach(el => {
				el.classList.remove("RESERVED", "ARRIVED", "BILL_REQUESTED", "FINISHED");
				el.classList.add(status);
				const sel = el.querySelector("select");
				if(sel) sel.value = status;
			});
		}).catch(err => console.error(err));
	}
	</script>

</body>
</html>