<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 매치</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/teammatch.css" rel="stylesheet" />

<script src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="js/teammatch.js"></script>
<script>
	$(document).ready(function() {
		
		// 지역 선택
		$("#entire").on("click", function() {
			$('input[name=region]').attr('value', '전체');
		})
		$("#seoul").on("click", function() {
			$('input[name=region]').attr('value', '서울');
		}) 
		$("#gyeonggi").on("click", function() {
			$('input[name=region]').attr('value', '경기');
		}) 
		$("#gangwon").on("click", function() {
			$('input[name=region]').attr('value', '강원');
		}) 
		$("#chungcheong").on("click", function() {
			$('input[name=region]').attr('value', '충청');
		}) 
		$("#jeolla").on("click", function() {
			$('input[name=region]').attr('value', '전라');
		}) 
		$("#jeju").on("click", function() {
			$('input[name=region]').attr('value', '제주');
		})
		$("#gyeongsang").on("click", function() {
			$('input[name=region]').attr('value', '경상');
		}) 
		
		
		
		$("#searchbtn").on("click", function(){
			
			$.ajax({
				url: 'teammatch',
				data: {'region':$("#region").val()},
				type: 'post',
				dataType: 'json',
				success: function(response) {
					alert(response.process);
				}
			});
			
		}) // searchbtn end
		
	}); // ready end
</script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<form action="teammatch" method="post" >
			<input type="hidden" name="region" id="region" value=""> 
			<input type="hidden" name="possibleDate" id="possibleDate" value="">
		</form>	
			<div>
				<!-- 지역 선택 -->
				<div>
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
				<div>
					<p>
						Date: <input type="text" name="date">
					</p>
				</div>
			</div>


			<div>
				<input type="button" id="searchbtn" value="매치 검색">
				<a href="registerteammatch"><button type="button">매치 등록</button></a>
			</div>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>