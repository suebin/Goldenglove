<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
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
					$("#idCheckResult").html(server.result);
				} else if(server.result == "아이디와 비밀번호가 일치하지 않습니다.") {
					alert(server.result);
					$('input[name="id"]').val("");
					$('input[name="id"]').focus();			
					$('input[name="password"]').val("");
					$("#idCheckResult").html(server.result);
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
		<h1>로그인</h1>
		<form action="loginResult" method="post" id="loginForm">
			<table>
				<tr>
					<td>아이디 :</td>
					<td>
						<input type="text" name="id" pattern="[a-z0-9]{3,15}" title="최대 15자리까지 입력가능합니다.(영어,숫자)" required>
					</td>
					<td><p id="idCheckResult"></p></td>
				</tr>
				<tr>
					<td>비밀번호 :</td>
				<td>
					<input type="password" name="password" pattern="^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*_=+-]).{8,15}$" title="최소 8자리, 최대 15자리까지 입력하능합니다.(영어,특수문자,숫자 필수)" required>
				</td>
			</tr>
				<tr><td colspan="2"><input type="submit" value="로그인"></td></tr>
			</table>
		</form>
		</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>