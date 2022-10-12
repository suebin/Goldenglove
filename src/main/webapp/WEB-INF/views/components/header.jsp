<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html5>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="description" content="" />
<meta name="author" content="golden-glove team" />
<meta name="generator" content="Hugo 0.88.1" />
<title>골든글러브</title>
<link href="/css/header.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/header.js" defer></script>
<script>
$(document).ready(function() {

})
</script>
</head>
<body>
	<div class="container">
		<header>
			<div class="confix">
				<a href="/" class="logo">골든글러브</a>
				
				<div class="mobileBtn">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
				
				<ul class="nav">
					<li><a href="teammatch">팀 매칭</a></li>
					<li><a href="ranking">랭킹</a></li>
					<li><a href="/notice">공지사항</a></li>
				</ul>
				
				<div class="loginBtnCon">
					<jsp:include page="/WEB-INF/views/alarm/alarm.jsp" />
					
					<% if(session.getAttribute("loginInfo") == null) { %>
						<button type="button" class="loginBtn" onclick="location.href='/login'">Login</button>
						<button type="button" class="signupBtn" onclick="location.href='/signup'">Sign Up</button>
					<%} else { %>
						<div class="dropdown">
							<div class="dropdownBtn">
								<span class="teamName">${loginInfo.getName() }</span><span>▼</span>
							</div>
							<div class="dropdown-contents">
								<a href="mypage">내 정보</a>
								<a href="teampage">팀 정보</a>
								<a href="teammatchpage?myTeamName=${loginInfo.getName()}">경기 정보</a>
							</div>
						</div>
						<button type="button" onclick="location.href='/logout'">Log Out</button>								
					<%} %>
				</div>
			</div>
		</header>
	</div>
</body>
</html>
