<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/login.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	$("#loginForm").on("submit", function(e) {
		e.preventDefault();
		$.ajax({
			url : 'loginCheck',
			type : 'post',
			data : {
				'id' : $('input[name="id"]').val(),
				'password' : $('input[name="password"]').val()
			},
			dataType : 'json',
			success : function(server) {
				if(server.result == "존재하지 않는 아이디입니다.") {
					alert(server.result);
					$('input[name="id"]').val("");
					$('input[name="id"]').focus();			
					$('input[name="password"]').val("");
				} else if(server.result == "아이디와 비밀번호가 일치하지 않습니다.") {
					alert(server.result);
					$('input[name="id"]').val("");
					$('input[name="id"]').focus();			
					$('input[name="password"]').val("");
				} else if(server.result == "아이디와 비밀번호가 일치하지 않습니다.") {
					alert(server.result);
				} else {
					location.href = '/';
				}
			}
		})
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
		<div class="confix">
		<h1 class="h1">로그인</h1>
		<form action="loginResult" method="post" id="loginForm" autocomplete="off">
			<table class="table">
				<tr>
					<td>
						<input type="text" name="id" pattern="[a-z0-9]{3,15}" title="최대 15자리까지 입력가능합니다.(영어,숫자)" required placeholder="아이디">
					</td>
				</tr>
				<tr>
				<td>
					<input type="password" name="password" pattern="^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*_=+-]).{8,15}$" title="최소 8자리, 최대 15자리까지 입력하능합니다.(영어,특수문자,숫자 필수)" required placeholder="비밀번호">
				</td>
			</tr>
				<tr><td><button type="submit" class="login">로그인</button></td></tr>
				<tr><td><button onclick="location.href='kakaoLogin'" class="kakaoLogin">카카오 로그인</button></td></tr>
				<tr><td><button onclick="location.href='naverLogin'" class="naverLogin">네이버 로그인</button></td></tr>
			</table>
		</form>
		<div class="findBox">
		<table class="table2">
			<tr><td>아이디를 잊어버리셨나요?</td><td><button onclick="location.href='findid'">아이디 찾기</button></td></tr>
			<tr><td>비밀번호가 기억나지 않으신가요?</td><td><button onclick="location.href='findpw'">비밀번호 찾기</button></td></tr>
			<tr><td>아직 회원이 아니신가요?</td><td><button onclick="location.href='signup'">회원가입</button></td></tr>
		</table>
		</div>
		</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>