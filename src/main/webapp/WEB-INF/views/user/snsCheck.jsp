<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
alert("회원가입 페이지로 이동합니다.");
$(document).ready(function() {
});
</script>
</head>
<body>
<%
	RequestDispatcher dis = request.getRequestDispatcher("/signup");
	dis.forward(request, response);
%>
</body>
</html>