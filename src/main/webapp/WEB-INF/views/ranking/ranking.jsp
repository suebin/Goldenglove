<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브</title>
<script src="js/jquery-3.6.0.min.js" ></script>
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/ranking.css" rel="stylesheet" />
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
$(document).ready(function() {
  AOS.init();
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	
	<div class="topRanking">
		<img alt="rankImg" src="/images/ranking.jpg">
		
		<div class="confix intro">
			<h1>RANKING</h1>
			<span>팀 랭킹을 확인해보세요</span>
		</div>
	</div>
	
	<div class="confix">
		<h2>Top 30</h2>
		<ul class="rankingList">
			<% int i = 1; %>
			<c:forEach items="${ list }" var="list">
				<% if(i <= 30) { %>
					<li data-aos="fade-up" data-aos-duration="1000">
						<div class="rankingNum">
						<% if (i == 1) {%>
							<img alt="defaultImg" src="/images/gold-medal.png">
						<% } else if (i == 2) {%>
							<img alt="defaultImg" src="/images/silver-medal.png">
						<% } else if (i == 3) {%>
							<img alt="defaultImg" src="/images/bronze-medal.png">
						<% } else {%>
							<span><%= i %></span> 
						<%} %>
						</div>
						
						<div class="rankingInfo">
							<div class="teamInfo">
								<span class="id">${ list.teamName }</span>
								<div class="region">
									<span>${ list.region }</span>
								</div>
							</div>
							
							<div class="winningRate">
								<span class="win">승 ${ list.winCount }</span>
								<span class="lose">패 ${ list.loseCount }</span>
								<span class="rate">승률 <fmt:formatNumber value="${list.winningRate}" pattern="0.000"/></span>
							</div>
						</div>
					</li>	
					<% i++; %>
				<% } %>
			</c:forEach>
		</ul>
	</div>
	
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>