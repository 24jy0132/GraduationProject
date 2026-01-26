<%@ include file="../header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Coupon"%>
<%@ page import="model.Staff"%>

<%
Staff admin = (Staff) session.getAttribute("admin");
List<Coupon> couponList = (List<Coupon>) request.getAttribute("coupons");
%>

<title>割引管理</title>

<style>
body {
	background: #f5f5f5;
}

.user-card {
	display: flex;
	align-items: center;
	gap: 12px;
}

.buttons {
	text-align: right;
	margin-bottom: 20px;
}

.buttons a button {
	background: #007bff;
	color: white;
	padding: 8px 25px;
	font-size: 16px;
	border: none;
	border-radius: 6px;
	margin-left: 10px;
	cursor: pointer;
	transition: 0.3s;
}

.buttons a button:hover {
	background: #0056b3;
}

.topcontainer {
	display: flex;
	justify-content: flex-end;
}

.top-bar {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

/* User Card – tighter width */
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

/* ===== TABLE CARD ===== */
.card {
	border-radius: 16px;
	box-shadow: 0 6px 18px rgba(0, 0, 0, .08);
}

.table th {
	background: #f8f9fa;
}

.action-btn {
	font-size: .85rem;
}
</style>

<body>

	<div class="container mt-4">
		<h1 class="text-center">MHP株式会社 営業サポートシステム</h1>

		<div class="topcontainer">
			<!-- Top right buttons -->
			<div class="top-bar">
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
		</div>
		<div class="buttons">
			<a href="<%=request.getContextPath()%>/Admin/adminhome.jsp"><button>管理TOP</button></a>
			<a href="<%=request.getContextPath()%>/Adminlogoutservlet"><button>ログアウト</button></a>
		</div>
		<!-- ===== TABLE ===== -->
		<div class="card p-4">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h5 class="fw-bold mb-0">クーポン一覧</h5>
				<a class="btn btn-dark btn-sm"
					href="<%=request.getContextPath()%>/Admin/couponForm.jsp"> ➕
					新規登録 </a>
			</div>

			<table
				class="table table-bordered table-hover align-middle text-center">
				<thead>
					<tr>
						<th>ID</th>
						<th>タイトル</th>
						<th>割引額</th>
						<th>予約条件</th>
						<th>必要ポイント</th>
						<th>期間</th>
						<th>画像</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (couponList != null && !couponList.isEmpty()) {
						for (Coupon c : couponList) {
					%>
					<tr>
						<td><%=c.getCouponId()%></td>
						<td><%=c.getTitle()%></td>
						<td>¥<%=c.getDiscountAmount()%></td>
						<td><%=c.getReservationType()%></td>
						<td><%=c.getMinPoint()%> pt</td>
						<td><%=c.getStartDate()%><br>〜<br><%=c.getEndDate()%>
						</td>
						<td>
							<%
							if (c.getImagePath() != null && !c.getImagePath().isEmpty()) {
							%> <img src="<%=request.getContextPath()%>/<%=c.getImagePath()%>"
							height="40"> <%
 } else {
 %> なし <%
 }
 %>
						</td>
						<td><a class="btn btn-outline-secondary btn-sm action-btn"
							href="<%=request.getContextPath()%>/admin/coupon/edit?id=<%=c.getCouponId()%>">
								編集 </a> <a class="btn btn-outline-danger btn-sm action-btn"
							href="<%=request.getContextPath()%>/admin/coupon/delete?id=<%=c.getCouponId()%>"
							onclick="return confirm('削除しますか？');"> 削除 </a></td>
					</tr>
					<%
					}
					} else {
					%>
					<tr>
						<td colspan="8">クーポンが登録されていません</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

	</div>

</body>
</html>
