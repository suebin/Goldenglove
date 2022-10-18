<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">



<title>골든글러브 > 용병 등록</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />

<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		
	}); // ready end
</script>
</head>
<body>

	<div class="confix">
	
	<div class="soldierRegistration">
		
		<div class="title">용병 등록</div>
		

		<form action="registerSoldier" method="post" id="registerSoldierForm">
			<input type="text" name="region" value="${loginInfo.getRegion()}"  />
			<input type="text" name="position" value="${loginInfo.getPosition()}" />
			<input type="text" name="soldierName" value="${loginInfo.getName()}" />
			<input type="text" name="email" value="${loginInfo.getEmail()}" />
			<input type="text" name="teamName" value="${loginInfo.teamName()}" />
			<input type="text" name="fileName" value="${loginInfo.fileName()}" />
		</form>
		
	</div>
	
	</div>

</body>
</html>