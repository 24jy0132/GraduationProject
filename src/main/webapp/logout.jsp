<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログアウト</title>
<script>
        window.onload = function () {
            alert("ログアウトしました");
            window.location.href = "<%=request.getContextPath()%>/index.jsp";
        };
    </script>
</head>
<body>

</body>
</html>