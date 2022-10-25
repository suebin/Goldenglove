<%@page import="user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브 > 팀 프로필</title>
<script src="js/jquery-3.6.0.min.js"></script>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/card.css" rel="stylesheet" />
<link href="/css/teamPage.css" rel="stylesheet" />
<script>
$(document).ready(function() {

}); // ready end
</script>
</head>
<body>
<div class="confix">

	<% String teamName = (String)request.getAttribute("teamName"); %>
	
	<h2><%= teamName %></h2>
	
	<div class="cardBox defaultCard">
			<%
				UserDTO[] teamMember = (UserDTO[])request.getAttribute("teamMember");
				for(int i = 0;i < teamMember.length;i++) {
					request.setAttribute("user", teamMember[i]);%>				
					<div class="card">
						<jsp:include page="/WEB-INF/views/components/card.jsp"/>
					</div>	
				<%}				
			%>
			</div>
</div>
</body>
</html>