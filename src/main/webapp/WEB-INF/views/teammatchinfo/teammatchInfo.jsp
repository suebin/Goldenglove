<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브 > 경기 정보</title>

<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/ranking.css" rel="stylesheet" />

<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {

				
	}); // ready end
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/components/header.jsp" />

	<div class="confix">


		<h2>수락을 기다리는 경기</h2>

		<c:forEach items="${teammatchlist1}" var="list">
			${list.homeName} VS ${list.awayName} <br>
			${list.possibleDate} ${list.possibleTime} <br>
			${list.region} ${list.homePlace} <br>
			<input type="button" class="acceptanceBtn" value="수락하기">
		</c:forEach>

		<h2>등록한 경기</h2>

		<c:forEach items="${teammatchlist2}" var="list">
			${list.homeName}<br>
			${list.possibleDate} ${list.possibleTime} <br>
			${list.region} ${list.homePlace} <br>
			<input type="button" value="등록 취소하기">
		</c:forEach>

		<h2>신청한 경기</h2>

		<c:forEach items="${teammatchlist3}" var="list">
			${list.homeName} VS ${list.awayName} <br>
			${list.possibleDate} ${list.possibleTime} <br>
			${list.region} ${list.homePlace} <br>
			<input type="button" value="신청 취소하기"><br>
		</c:forEach>

		<h2>예정된 경기</h2>
		
		<c:forEach items="${teammatchlist4}" var="list">
			${list.homeName} VS ${list.awayName} <br>
			${list.possibleDate} ${list.possibleTime} <br>
			${list.region} ${list.homePlace} <br>
			<!-- <input type="button" value="경기 취소하기"> -->
		</c:forEach>
		
		<h2>지난 경기</h2>
		
		<c:forEach items="${teammatchlist5}" var="list">
			${list.homeName} VS ${list.awayName} <br>
			${list.possibleDate} ${list.possibleTime} <br>
			${list.region} ${list.homePlace} <br>
			
		</c:forEach>

	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>