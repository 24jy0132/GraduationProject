<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Menu"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Restaurant Menu</title>
<style>
table {
	width: 80%;
	border-collapse: collapse;
	margin-bottom: 30px;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

img {
	width: 100px; /* adjust as needed */
	height: 80px; /* adjust as needed */
	object-fit: cover;
}
</style>
</head>
<body>

	<%
	List<Menu> menuList = (List<Menu>) session.getAttribute("menu");

	if (menuList != null && !menuList.isEmpty()) {

		// Separate dishes and alcohol
		List<Menu> dishes = new ArrayList<>();
		List<Menu> alcohols = new ArrayList<>();
		for (Menu m : menuList) {
			if ("Dish".equalsIgnoreCase(m.getCategory())) {
		dishes.add(m);
			} else if ("Whiskey".equalsIgnoreCase(m.getCategory())) {
		alcohols.add(m);
			}
		}
	%>

	<h2>Dishes</h2>
	<%
	if (!dishes.isEmpty()) {
	%>
	<table>
		<tr>
			<th>Image</th>
			<th>Name</th>
			<th>Price</th>
			<th>Description</th>
		</tr>
		<%
		for (Menu m : dishes) {
		%>
		<tr>
			<td><img src="<%=m.getImagePath()%>" alt="Dish Image" /></td>
			<td><%=m.getMenuname()%></td>
			<td>$<%=m.getPrice()%></td>
			<td><%=m.getDescription()%></td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	} else {
	%>
	<p>No dishes available.</p>
	<%
	}
	%>

	<h2>Alcohol</h2>
	<%
	if (!alcohols.isEmpty()) {
	%>
	<table>
		<tr>
			<th>Image</th>
			<th>Name</th>
			<th>Price</th>
		</tr>
		<%
		for (Menu m : alcohols) {
		%>
		<tr>
			<td><img src="<%=m.getImagePath()%>" alt="Alcohol Image" /></td>
			<td><%=m.getMenuname()%></td>
			<td>$<%=m.getPrice()%></td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	} else {
	%>
	<p>No alcohol available.</p>
	<%
	}
	%>

	<%
	} else {
	%>
	<p>No menu available.</p>
	<%
	}
	%>

</body>
</html>