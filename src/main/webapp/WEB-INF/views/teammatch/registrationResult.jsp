<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든 글러브 > 매치 등록</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	alert('${result}');
	location.href = "teammatchpage?myTeamName=${loginInfo.getTeamName()}"; 
}); // ready end
</script>
</head>
<body></body>
</html>
