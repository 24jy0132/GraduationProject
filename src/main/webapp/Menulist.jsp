<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.List, model.Menu" %>

<%
    // サーブレットから受け取ったメニュー一覧
    List<Menu> menus = (List<Menu>) request.getAttribute("menus");
	List<Menu> surveyMenus = (List<Menu>)request.getAttribute("surveyMenus");
	List<Menu> newMenus = (List<Menu>)request.getAttribute("newMenus");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー一覧</title>
</head>
<body>


    <h3>アンケート対象商品</h3>
    <%
        for (Menu sm : surveyMenus) {
            
        	
    %>
        <div>
            <img src="<%= sm.getImagePath()%>" width="80">
            <p>
                <%= sm.getMenuName() %><br>
                <%= sm.getDescription() %>
                <%= sm.getPrice() %>
            </p>
            <a href="SurveyServlet?menuId=<%= sm.getMenuId() %>">アンケートに回答する</a>
        </div>
    <%
            
        }
    %>
    
    

    <h3>新商品</h3>
    <%
        for (Menu nm : newMenus) {
    %>
        <div>
            <img src="<%= nm.getImagePath() %>" width="80">
            <p>
                <%= nm.getMenuName() %><br>
                <%= nm.getDescription() %>
            </p>
            
        </div>
    <%           
        }
    %>
</body>
</html>
