<form action="<%=request.getContextPath()%>/reserve" method="post">

Date:
<input type="date" name="date" required><br>

Time:
<select name="time">
<%
java.time.LocalTime t = service.Constants.OPEN;
while (!t.isAfter(service.Constants.LAST_START)) {
%>
<option value="<%=t%>"><%=t%></option>
<%
t = t.plusMinutes(service.Constants.SLOT_MINUTES);
}
%>
</select><br>

Adults:
<input type="number" name="adult" min="1" required><br>

Children:
<input type="number" name="child" min="0" required><br>

Name:
<input type="text" name="name" required><br>

Email:
<input type="email" name="email"><br>

<button type="submit">Reserve</button>

</form>
