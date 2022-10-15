<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브 > 용병 구하기</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/soldier.css" rel="stylesheet" />


<script src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="js/getSoldier.js"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	
	<div class="confix">
			<!-- 선택한 지역과 날짜 데이터 전송 -->
		
		<form action="teammatch" method="post">
			<input type="hidden" name="region" id="region" value=""> 
			<input type="hidden" name="year_month" id="year_month" value=""> 
			<input type="hidden" name="date" id="date" value=""> 
		</form>
	

		<!-- 지역 및 날짜 선택 -->
		
		<div class="select_box">

			<!-- 1. 날짜 선택 -->
			
			<div class="select_one"> 	
				<div class="select_date">
				<div class="cal_nav">
					<a href="javascript:;" class="nav-btn go-prev" style="color:#72CC82;">prev</a>
					<div class="year-month"></div>
					<a href="javascript:;" class="nav-btn go-next" style="color:#72CC82;">next</a>
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
					<div class="dates">
					</div>
				</div>
				</div>
			</div>		

			<!-- 2. 지역 선택 -->
			
			<div class="select_two">
				<div class="select_region">
					<input type="button" value="전체" name="0" id="0" class="region_btn"> 
					<input type="button" value="강원도" name="1" id="1" class="region_btn">
					<input type="button" value="광주광역시" name="2" id="2" class="region_btn"> 
					<input type="button" value="경기도" name="3" id="3" class="region_btn">
					<input type="button" value="경상남도" name="4" id="4" class="region_btn"> 
					<input type="button" value="경상북도" name="5" id="5" class="region_btn">
					<input type="button" value="대구광역시" name="6" id="6" class="region_btn"> 
					<input type="button" value="대전광역시" name="7" id="7" class="region_btn">
					<input type="button" value="부산광역시" name="8" id="8" class="region_btn">
					<input type="button" value="서울특별시" name="9" id="9" class="region_btn">
					<input type="button" value="세종특별자치시" name="10" id="10" class="region_btn">
					<input type="button" value="인천광역시" name="11" id="11" class="region_btn"> 
					<input type="button" value="울산광역시" name="12" id="12" class="region_btn">
					<input type="button" value="전라남도" name="13" id="13" class="region_btn">
					<input type="button" value="전라북도" name="14" id="14" class="region_btn">
					<input type="button" value="제주특별자치도" name="15" id="15" class="region_btn"> 
					<input type="button" value="충청남도" name="16" id="16" class="region_btn">
					<input type="button" value="충청북도" name="17" id="17" class="region_btn">
				</div>
			</div>
	
		</div>

		
		<!-- 용병 검색, 용병 등록 버튼 -->
		
		<div class="match_btn">
			<input type="button" id="searchbtn" class="search_btn" value="용병 검색">
			<input type="button" id="registerbtn" class="register_btn" value="용병 등록">
		</div>
	
		<!-- 용병 검색 버튼을 누르면 나오는 등록된 용병 리스트 -->
		
		<div class="teammatch_info">
			<div class="teammatch_info_hashtag"></div>
			<div class="teammatch_info_boxes"></div>
		</div>
	
	
	</div>
	
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>