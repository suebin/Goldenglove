<%@ page language="java" contentType="text/html; charset=UTF-8"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
					<li><a href="#">팀 매칭</a></li>
					<li><a href="#">랭킹</a></li>
					<li><a href="#">공지사항</a></li>
				</ul>
				<div class="loginBtnCon">
					<% if(session.getAttribute("loginInfo") == null) { %>
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
=======
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
=======
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
>>>>>>> 98c281c (header/footer)
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

<<<<<<< HEAD
=======
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
=======
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
>>>>>>> 98c281c (header/footer)
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

<<<<<<< HEAD
>>>>>>> 6a4948d (header)
          <div class="loginBtnCon">
            <button type="button" class="loginBtn">Login</button>
            <button type="button" class="logoutBtn">Logout</button>
          </div>
        </header>
      </div>
    </main>
  </body>
<<<<<<< HEAD
>>>>>>> 6a4948d (header)
=======
=======
>>>>>>> 98c281c (header/footer)
	});
</script>
</head>
<body>
	<div class="container">
		<header>
			<div class="confix">
				<a href="#" class="logo">골든글러브</a>
				<ul class="nav">
					<li><a href="#">팀 매칭</a></li>
					<li><a href="#">랭킹</a></li>
					<li><a href="#">공지사항</a></li>
<<<<<<< HEAD
<<<<<<< HEAD
				</ul>
				<div class="loginBtnCon">
					<button type="button" class="loginBtn">Login</button>
					<button type="button" class="signupBtn">Sign Up</button>
=======
					<li><a href="#">마이페이지</a></li>
					<li><a href="#">FAQ</a></li>
				</ul>
				<div class="loginBtnCon">
					<button type="button" class="loginBtn">Login</button>
					<button type="button" class="logoutBtn">Logout</button>
>>>>>>> 98c281c (header/footer)
=======
				</ul>
				<div class="loginBtnCon">
					<button type="button" class="loginBtn">Login</button>
					<button type="button" class="signupBtn">Sign Up</button>
>>>>>>> b6e38ca (main, header 생성)
				</div>
			</div>
		</header>
	</div>
</body>
<<<<<<< HEAD
>>>>>>> 98c281c (header/footer)
=======
>>>>>>> 6a4948d (header)
=======
>>>>>>> 98c281c (header/footer)
</html>
