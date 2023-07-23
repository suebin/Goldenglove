<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.musamanru.goldenglove.user.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>골든글러브 > 용병 등록</title>
<link href="/css/soldier_registration.css" rel="stylesheet" />

<!-- flatpickr (날짜 선택하는 라이브러리) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		
		// 날짜 선택
		
		var dateSelector = document.querySelector('#possibleDate');
		dateSelector.flatpickr({dateFormat: "Y년 m월 d일"});
	}); // ready end
</script>
</head>
<body>

	<div class="confix">
	
	<div class="soldierRegistration">
		
		<div class="soldierRegistration_title">
			<h2>용병 등록</h2>
			<span>용병으로 출전하고 싶은 날짜를 선택하세요</span>
		</div>

		<form action="registerSoldier" method="post" id="registerSoldierForm">
			<input type="text" name="possibleDate" id="possibleDate" placeholder="날짜 선택하기" /> 
			<input type="hidden" name="region" value="${loginInfo.getRegion()}"  />
			<input type="hidden" name="position" value="${loginInfo.getPosition()}" />
			<input type="hidden" name="soldierName" value="${loginInfo.getName()}" />
			<input type="hidden" name="phone" value="${loginInfo.getPhone()}" />
			<input type="hidden" name="email" value="${loginInfo.getEmail()}" />
			<input type="hidden" name="teamName" value="${loginInfo.getTeamName()}" /> 
			<input type="hidden" name="fileName" value="${loginInfo.getFileName()}" />
			<input type="hidden" name="winningRate" value="${loginInfo.getWinningRate()}" />
			<input type="hidden" name="winCount" value="${loginInfo.getWinCount()}" />
			<input type="hidden" name="loseCount" value="${loginInfo.getLoseCount()}" />
			<input type="submit" class="registerSoldierBtn" value="등록" />
		</form>
		
	</div>
	
	</div>

</body>
</html>