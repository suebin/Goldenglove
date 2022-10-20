<%@page import="user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>골든글러브 > 용병 구하기</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/soldier.css" rel="stylesheet" />

<!-- flatpickr (날짜 선택하는 라이브러리) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- swiper (슬라이더) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

<script src="js/jquery-3.6.0.min.js"></script>

<script>
$(document).ready(function() {
	
	// 용병 검색 form > 날짜 선택
	
	var dateSelector = document.querySelector('#dateSelector');
	dateSelector.flatpickr({dateFormat: "Y년 m월 d일"});
	
	
	// 용병 검색 > 리스트
	
	$(".searchSoldierBtn").on("click", function() {
		$.ajax({
			url: 'getSoldier',
			data: {'region':$("#regionSelector").val(),'position':$("#positionSelector").val(), 'possibleDate':$("#dateSelector").val()},
			type: 'post',
			dataType: 'json',
			success: function(list){
				
							
			} // success end
		
		
		}); // ajax end
	
	}) // searchSoldierBtn end
	
	
	// 용병 리스트 페이지 슬라이딩
	
	const swiper = new Swiper('.swiper', {
		  direction: 'horizontal',
		  spaceBetween: 30,
		  loop: true,
		  
		  pagination: {
		    el: '.swiper-pagination',
			    clickable: true,
		  },
		  navigation: {
		    nextEl: '.swiper-button-next',
		    prevEl: '.swiper-button-prev',
		  },
		});
	
	
	// 용병 등록 작은 창
	
	$(".registerSoldierBtn").on("click", function() {
		
		if ($(".dropdownBtn").text() == "") {
			alert("로그인이 필요한 서비스입니다.");	
		}
		else {
		window.open('registerSoldier', '용병 등록', "width=330, height=420");
		}
	})
	
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	
	<div class="confix">
	
	<!-- 용병 검색 form -->
	
	<div class="soldier_boxes">
	<div class="soldier_box">
	<form action="getSoldier" method="post" id="searchSoldierForm">
	
	<select name="region" id="regionSelector">
		<option selected>지역 전체</option>
		<option>강원도</option>
		<option>광주광역시</option>
		<option>경기도</option>
		<option>경상남도</option>
		<option>경상북도</option>
		<option>대구광역시</option>
		<option>대전광역시</option>
		<option>부산광역시</option>
		<option>서울특별시</option>
		<option>세종특별자치시</option>
		<option>인천광역시</option>
		<option>울산광역시</option>
		<option>전라남도</option>
		<option>전라북도</option>
		<option>제주특별자치도</option>
		<option>충청남도</option>
		<option>충청북도</option>
	</select>
	
	<select name="position" id="positionSelector">
		<option selected>포지션 전체</option>
		<option>1루수</option>
		<option>2루수</option>
		<option>3루수</option>
		<option>포수</option>
		<option>투수</option>
		<option>좌익수</option>
		<option>우익수</option>
		<option>중견수</option>
		<option>유격수</option>
	</select>
	
	<input name="possibleDate" id="dateSelector" placeholder="날짜" />
	<input type="button" class="searchSoldierBtn" value="용병 검색" style="border:none;"/>
	</form>
	</div>
	
	
	<!-- 용병 등록 -->
	<button class="soldier_box registerSoldierBtn">+ 용병 등록</button>
	</div>
	
	
	<!-- 용병 리스트 : swiper 페이징 처리해야 함 !!! -->
<%
	UserDTO user = (UserDTO)session.getAttribute("loginInfo"); 
	request.setAttribute("user", user);
%>

	<div id="soldier-slide" class="swiper">
		<div class="swiper-wrapper">
		
			<div class="swiper-slide" id="slide0">
				<div class="card"><jsp:include page="/WEB-INF/views/components/card.jsp" /></div>
				<div class="card"><jsp:include page="/WEB-INF/views/components/card.jsp" /></div>
				<div class="card"><jsp:include page="/WEB-INF/views/components/card.jsp" /></div>
			</div>
			<div class="swiper-slide" id="slide1"></div>
			<div class="swiper-slide"></div>

		</div>
		
		<div class="swiper-pagination"></div>
		
		<div class="swiper-button-prev"></div>
		<div class="swiper-button-next"></div>
	</div>



	</div>
	
	
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>