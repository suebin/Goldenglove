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
<link href="/css/teammatch_info.css" rel="stylesheet" />
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		
		// 수락을 기다리는 경기 > 수락하기 버튼
		
		$("#acceptance_btn").on("click", function() {
			var update = confirm("매치를 수락하시겠습니까 ?");
			
			if(update) {
				$.ajax({
					url: 'teammatchAcceptance',
					data: {'seq':$(".teammatchlist1_seq").val(), 'acceptance':1},
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
		
		
				
	}); // ready end
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/components/header.jsp" />

	<div class="confix">

		<h2>수락을 기다리는 경기</h2>
	
		<c:forEach items="${teammatchlist1}" var="list">

		<div class="teammatch_info_list">
			<div class="teammatch_info">
				<span class="teammatch_info_title">${list.homeName} VS ${list.awayName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
			<div class="teammatch_info_btn"><input type="button" class="btn" id="acceptance_btn" value="수락하기"></div>
		</div>
		
			<input type="hidden" class="teammatchlist1_seq" value=${list.seq}>
		</c:forEach>
		


		<h2>등록한 경기</h2>

		<c:forEach items="${teammatchlist2}" var="list">
		<div class="teammatch_info_list">
			<div class="teammatch_info">
				<span class="teammatch_info_title">${list.homeName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
			<div class="teammatch_info_btn"><input type="button" class="btn" value="취소하기"></div>
		</div>
		</c:forEach>
		


		<h2>신청한 경기</h2>
		
		<c:forEach items="${teammatchlist3}" var="list">
		<div class="teammatch_info_list">
			<div class="teammatch_info" >
				<span class="teammatch_info_title">${list.homeName} VS ${list.awayName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
			<div class="teammatch_info_btn"><input type="button" class="btn" value="취소하기"></div>
		</div>
		</c:forEach>
		

		<h2>예정된 경기</h2>
		
		<c:forEach items="${teammatchlist4}" var="list">
		<div class="teammatch_info_list">
			<div class="teammatch_info" >
				<span class="teammatch_info_title">${list.homeName} VS ${list.awayName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
			<div class="teammatch_info_btn"><input type="button" class="btn" id="teammatch_delete_btn" value="취소하기"></div>
		</div>
		</c:forEach>
		
		<h2>지난 경기</h2>
		
		<c:forEach items="${teammatchlist5}" var="list">
		<div class="teammatch_info_list">
			<div class="teammatch_info" >
				<span class="teammatch_info_title">${list.homeName} VS ${list.awayName}</span>
				<span class="teammatch_info_date">${list.possibleDate} ${list.possibleTime}</span>
				<span class="teammatch_info_location">${list.region} ${list.homePlace}</span>
			</div>
		</div>
		</c:forEach>

	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>