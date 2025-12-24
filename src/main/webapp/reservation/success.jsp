<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservation Completed</title>

<style>
body {
    font-family: Arial, sans-serif;
    text-align: center;
    margin-top: 60px;
}
.box {
    display: inline-block;
    padding: 30px;
    border: 1px solid #ccc;
    border-radius: 8px;
}
a {
    display: inline-block;
    margin-top: 20px;
    text-decoration: none;
    color: white;
    background: #3498db;
    padding: 10px 20px;
    border-radius: 6px;
}
</style>
</head>

<body>

<div class="box">
    <h2>✅ Reservation Completed</h2>
    <p>Your reservation has been successfully saved.</p>

    <a href="<%=request.getContextPath()%>/reservation/userReservationForm.jsp">
        Make Another Reservation
    </a>
    <br><br>
    <a href="<%=request.getContextPath()%>/admin">
        Go to Admin Dashboard
    </a>
</div>

</body>
</html>