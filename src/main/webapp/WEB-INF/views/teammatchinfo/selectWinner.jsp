<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브 > 승패 선택</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/selectWinner.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {

}); // ready end
</script>
</head>
<body>
	<div class= title>
		<h2>승패 선택</h2>
		<span>이번 경기의 승패를 선택해주세요</span>
	</div>
	
	<form action="selectWinner" method="post">
		<input type="hidden" name="seq" value=${param.seq}>
		<input type="hidden" name="myTeam" value=${param.myTeam}>
		<input type="hidden" name="team1" value=${param.team1}>
		<input type="hidden" name="team1_user" value=${param.team1_user}>
		<input type="hidden" name="team2" value=${param.team2}>
		<input type="hidden" name="team2_user" value=${param.team2_user}>
		<input type="hidden" name="result" value=1>
		<input type="submit" class="winBtn" value="WIN">	
	</form>
	
	<form action="selectWinner" method="post">
		<input type="hidden" name="seq" value=${param.seq}>
		<input type="hidden" name="myTeam" value=${param.myTeam}>
		<input type="hidden" name="team1" value=${param.team1}>
		<input type="hidden" name="team1_user" value=${param.team1_user}>
		<input type="hidden" name="team2" value=${param.team2}>
		<input type="hidden" name="team2_user" value=${param.team2_user}>
		<input type="hidden" name="result" value=0>
		<input type="submit" class="loseBtn" value="LOSE">	
	</form>
	
</body>
</html>