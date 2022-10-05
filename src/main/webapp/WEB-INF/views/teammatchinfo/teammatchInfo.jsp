<%@page import="java.util.List"%>
<%@page import="teammatch.TeamMatchDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.time.LocalDateTime" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브 > 경기 정보</title>

<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/teammatch_info.css" rel="stylesheet" />
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	AOS.init();
		
	// 1. 수락을 기다리는 경기 > 수락하기 버튼
	
	for (var i=0; i<100; i++) {  // ★★ 궁금한 점 : teammatchlist1 의 길이를 구하는 방법 ★★
		
		var acceptance_btn = 'acceptance_btn' + i;
		
		$("#"+acceptance_btn).on("click", function() {
				
				var update = confirm("매치를 수락하시겠습니까 ?");
				
				if(update) {
					$.ajax({
						url: 'teammatchAcceptance',
						data: {'seq':$(".teammatchlist1_seq").val()},
						type: 'post',
						dataType: 'json',
						success: function(data){
							alert(data.result);
							location.href="teammatchpage?myTeamName=${loginInfo.getName()}";
						}
					});
				}
				else {
					alert("매치 수락을 취소하셨습니다.");
				}
			}) // acceptance_btn end		
		}
	
	
	// 2. 등록한 경기 > 취소하기 버튼
	
	for (var i=0; i<100; i++) {  
		
		var delete_registration_btn = 'delete_registration_btn' + i;
		
		$("#"+ delete_registration_btn).on("click", function() {
				
				var update = confirm("매치를 취소하시겠습니까 ?");
				
				if(update) {
					$.ajax({
						url: 'deleteTeammatchRegistration',
						data: {'seq':$(".teammatchlist2_seq").val()},
						type: 'post',
						dataType: 'json',
						success: function(data){
							alert(data.result);
							location.href="teammatchpage?myTeamName=${loginInfo.getName()}";
						}
					});
				}
				else {
					alert("매치를 취소하지 않습니다.");
				}
			}) // delete_registration_btn end		
		}
	
	
	// 3. 신청한 경기 > 취소하기 버튼
	
	for (var i=0; i<100; i++) {  
		
		var delete_add_btn = 'delete_add_btn' + i;
		
		$("#"+ delete_add_btn).on("click", function() {
				
				var update = confirm("매치를 취소하시겠습니까 ?");
				
				if(update) {
					$.ajax({
						url: 'deleteAddTeammatch',
						data: {'seq':$(".teammatchlist3_seq").val()},
						type: 'post',
						dataType: 'json',
						success: function(data){
							alert(data.result);
							location.href="teammatchpage?myTeamName=${loginInfo.getName()}";
						}
					});
				}
				else {
					alert("매치를 취소하지 않습니다.");
				}
			}) // delete_registration_btn end		
		}
	
	// 4. 예정된 경기 > 취소하기 버튼
	
	for (var i=0; i<100; i++) {  
		
		var cancel_teammatch_btn = 'cancel_teammatch_btn' + i;
		
		$("#"+ cancel_teammatch_btn).on("click", function() {
				
				var update = confirm("매치를 취소하시겠습니까 ?");
				
				if(update) {
					$.ajax({
						url: 'cancelTeammatch',
						data: {'seq':$(".teammatchlist4_seq").val()},
						type: 'post',
						dataType: 'json',
						success: function(data){
							alert(data.result);
							location.href="teammatchpage?myTeamName=${loginInfo.getName()}";
						}
					});
				}
				else {
					alert("매치를 취소하지 않습니다.");
				}
			}) 
		}	// cancel_teammatch_btn	
		
		
	// 만약 경기 정보가 하나도 없는 섹터는 보이지 않도록 하기
		
	if ($(".teammatchlist1_existence").val() == "") {
		$(".teammatchlist1_box").hide();	
	}
	else {
		$(".teammatchlist1_box").show();
	}
		
	if ($(".teammatchlist2_existence").val() == "") {
		$(".teammatchlist2_box").hide();	
	}
	else {
		$(".teammatchlist2_box").show();
	}
	
	if ($(".teammatchlist3_existence").val() == "") {
		$(".teammatchlist3_box").hide();	
	}
	else {
		$(".teammatchlist3_box").show();
	}
	
	if ($(".teammatchlist4_existence").val() == "") {
		$(".teammatchlist4_box").hide();	
	}
	else {
		$(".teammatchlist4_box").show();
	}
	
	if ($(".teammatchlist5_existence").val() == "") {
		$(".teammatchlist5_box").hide();	
	}
	else {
		$(".teammatchlist5_box").show();
	}
	
				
}); // ready end
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/components/header.jsp" />

	<div class="confix">
		
<%

LocalDateTime now = LocalDateTime.now();

int year = now.getYear();
int month = now.getMonthValue();
int day = now.getDayOfMonth();

%>

<!-- 시간이 지나면 사라지도록 하기 -->

<%-- <%=year%>
<%=month%>
<%=day%> --%>


		<!-- 1. 수락을 기다리는 경기 -->
		
		<div class="teammatchlist1_box" data-aos="fade-up" data-aos-duration="1000">
		
		<h2>수락을 기다리는 경기</h2>

		<c:forEach items="${teammatchlist1}" var="list">
		<c:set var="a" value="${a+1}" />

		<div class="teammatch_info_list">
			<div class="teammatch_info">
				<span class="teammatch_info_title">${list.homeName} VS ${list.awayName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
			<div class="teammatch_info_btn"><input type="button" class="btn" id="acceptance_btn${a}" value="수락하기"></div>
		</div>
			
			<input type="hidden" class="teammatchlist1_seq" value=${list.seq}>
		</c:forEach>
		
		<input type="hidden" class="teammatchlist1_existence" value=${a}>
	
		</div>
		
	
		<!-- 2. 등록한 경기 -->
		
		<div class="teammatchlist2_box" data-aos="fade-up" data-aos-duration="1000">
		
		<h2>등록한 경기</h2>
		
		<c:forEach items="${teammatchlist2}" var="list">
		<c:set var="b" value="${b+1}" />
		
		<div class="teammatch_info_list">
			<div class="teammatch_info">
				<span class="teammatch_info_title">${list.homeName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
			<div class="teammatch_info_btn"><input type="button" class="btn" id="delete_registration_btn${b}" value="취소하기"></div>
		</div>
			
			<input type="hidden" class="teammatchlist2_seq" value=${list.seq}>
		</c:forEach>
		
		<input type="hidden" class="teammatchlist2_existence" value=${b}>
	
		</div>
	
	
	<!-- 3. 신청한 경기 -->	
	
		<div class="teammatchlist3_box" data-aos="fade-up" data-aos-duration="1000">
		
		<h2>신청한 경기</h2>
		
		<c:forEach items="${teammatchlist3}" var="list">
		<c:set var="c" value="${c+1}" />
		<div class="teammatch_info_list" >
			<div class="teammatch_info" >
				<span class="teammatch_info_title">${list.homeName} VS ${list.awayName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
			<div class="teammatch_info_btn"><input type="button" class="btn" id="delete_add_btn${c}" value="취소하기"></div>
		</div>
	
			<input type="hidden" class="teammatchlist3_seq" value=${list.seq}>
		</c:forEach>
		
		<input type="hidden" class="teammatchlist3_existence" value=${c}>	
	
		</div>
		
	
		<!-- 4. 예정된 경기 -->	
		
		<div class="teammatchlist4_box" data-aos="fade-up" data-aos-duration="1000">
		
		<h2>예정된 경기</h2>
		
		<c:forEach items="${teammatchlist4}" var="list">
		<c:set var="d" value="${d+1}" />
		<div class="teammatch_info_list">
			<div class="teammatch_info" >
				<span class="teammatch_info_title">${list.homeName} VS ${list.awayName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
			<div class="teammatch_info_btn"><input type="button" class="btn" id="cancel_teammatch_btn${d}" value="취소하기"></div>
		</div>
		
			<input type="hidden" class="teammatchlist4_seq" value=${list.seq}>
		</c:forEach>
		
		<input type="hidden" class="teammatchlist4_existence" value=${d}>
		
		</div>
		
		
		<!-- 5. 지난 경기 -->
		
		<div class="teammatchlist5_box" data-aos="fade-up" data-aos-duration="1000">
		
		<h2>지난 경기</h2>
		
		<c:forEach items="${teammatchlist5}" var="list">
		<c:set var="e" value="${e+1}" />
		<div class="teammatch_info_list">
			<div class="teammatch_info" >
				<span class="teammatch_info_title">${list.homeName} VS ${list.awayName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
		</div>
		
			<input type="hidden" class="teammatchlist5_seq" value=${list.seq}>
		</c:forEach>

		<input type="hidden" class="teammatchlist5_existence" value=${e}>
		
		</div>
		
		
	</div>
	
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />

</body>
</html>