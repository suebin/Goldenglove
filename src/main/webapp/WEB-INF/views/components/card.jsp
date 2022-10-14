<%@page import="user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/card.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {

	});
</script>
</head>
<body>
<%
	UserDTO user = (UserDTO)session.getAttribute("loginInfo");
	int winCount = user.getWinCount();
	int loseCount = user.getLoseCount();
	double winningRate = (winCount == 0) ? 0.0 : (winCount / (winCount + loseCount)) * 100;
%>
	<div class="profile-card-6">
		<img src="img/${loginInfo.fileName }" class="img img-responsive">
		<div class="profile-name">${loginInfo.name }</div>
		<div class="profile-position">${loginInfo.position }</div>
		<div class="profile-overview">
			<div>
				<h3><%=winCount %></h3>
				<p>승</p>
			</div>
			<div>
				<h3><%=loseCount %></h3>
				<p>패</p>
			</div>
			<div>
				<h3><%=winningRate %></h3>
				<p>%</p>
			</div>
		</div>
	</div>
</body>
</html>