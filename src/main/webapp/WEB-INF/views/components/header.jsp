<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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
<script>
	$(document).ready(function() {
		
	});
</script>
</head>
<body>
	<div class="container">
		<header>
			<div class="confix">
				<a href="/" class="logo">골든글러브</a>
				<ul class="nav">
					<li><a href="teammatch">팀 매칭</a></li>
					<li><a href="ranking">랭킹</a></li>
					<li><a href="/notice">공지사항</a></li>
				</ul>
				<div class="loginBtnCon">
					<% if(session.getAttribute("loginInfo") == null) { %>
						<button type="button" class="loginBtn" onclick="location.href='/login'">Login</button>
						<button type="button" class="signupBtn" onclick="location.href='/signup'">Sign Up</button>
					<%} else { %>
						<div class="dropdown">
							<p class="dropdownBtn">${loginInfo.getName() } ▼</p>
							<div class="dropdown-contents">
								<a href="mypage">내 정보</a>
								<a href="#">경기 정보</a>
							</div>
						</div>
						<button type="button" onclick="location.href='/logout'">Log Out</button>					
					<button type="button" class="loginBtn" onclick="location.href='/login'">Login</button>
					<button type="button" class="signupBtn" onclick="location.href='/signup'">Sign Up</button>
					<%} else { %>
						<span>${loginInfo.getName() }</span>
						<button type="button" onclick="location.href='/logout'">Log Out</button>					
					<%} %>
				</div>
			</div>
		</header>
	</div>
</body>
</html>
