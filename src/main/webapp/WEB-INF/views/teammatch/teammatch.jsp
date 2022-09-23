<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 매치</title>

<!-- css -->
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/teammatch.css" rel="stylesheet" />

<!-- js -->
<script src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="js/teammatch.js"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />

	<div class="confix">

		<!-- 선택한 지역과 날짜 데이터를 form으로 post 전송 -->
		<form action="teammatch" method="post">
			<input type="hidden" name="region" id="region" value="">
			<input type="hidden" name="possibleDate" id="possibleDate" value="">
		</form>

		<!-- 지역 및 날짜 선택 -->
		<div class="select_box">

			<!-- 지역 선택 -->
			<div class="select_region">
				<input type="button" value="전체" name="entire" id="entire"> 
				<input type="button" value="서울" name="seoul" id="seoul"> 
				<input type="button" value="경기" name="gyeonggi" id="gyeonggi"> 
				<input type="button" value="강원" name="gangwon" id="gangwon"> 
				<input type="button" value="충청" name="chungcheong" id="chungcheong">
				<input type="button" value="전라" name="jeolla" id="jeolla"> 
				<input type="button" value="제주" name="jeju" id="jeju"> 
				<input type="button" value="경상" name="gyeongsang" id="gyeongsang">
			</div>


			<!-- 날짜 선택 -->
			<div class="select_date">
			<div class="sec_cal">
				<div class="cal_nav">
					<a href="javascript:;" class="nav-btn go-prev">prev</a>
					<div class="year-month"></div>
					<a href="javascript:;" class="nav-btn go-next">next</a>
				</div>
				<div class="cal_wrap">
					<div class="days">
						<div class="day">MON</div>
						<div class="day">TUE</div>
						<div class="day">WED</div>
						<div class="day">THU</div>
						<div class="day">FRI</div>
						<div class="day">SAT</div>
						<div class="day">SUN</div>
					</div>
					<div class="dates"></div>
				</div>
			</div>
			</div>
			
		</div>

		<br>

		<!-- 매치 검색, 매치 등록 -->
		<div class="match_btn">
			<input type="button" id="searchbtn" value="매치 검색"> 
			<a href="registerteammatch"><input type="button" id="registerbtn" value="매치 등록"></a>
		</div>

		<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>