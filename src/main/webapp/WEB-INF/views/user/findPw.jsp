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
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	$("#findForm").on("submit", function(e) {
		e.preventDefault();
		$.ajax({
			url : 'findpwresult',
			data : {
				'id' : $('#id').val(),
				'name' : $('#name').val(),
				'email' : $('#email').val()
			},
			dataType : 'json',
			success : function(server) {
				if(server.result == "success") {
					$("#updateBox").removeAttr("hidden");
					$("#inputBox").attr("hidden", "hidden");
					$("#id2").val(server.id);
					$("#name2").val(server.name);
					$("#email2").val(server.email);
				} else {
					alert(server.result);
				}
			}
		})
	})
	
	$("#updateForm").on("submit", function() {
		alert("비밀번호가 수정되었습니다. 로그인 후 이용해주세요.")
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
		<div class="confix">
			<h1 class="h1">비밀번호 찾기</h1>
			<form id="findForm">
				<table id="inputBox">
					<tr>
						<td>
							<input type="text" id="id" name="id" pattern="[a-z0-9]{3,15}" title="최대 15자리까지 입력가능합니다.(영어,숫자)" required placeholder="아이디">
						</td>
					<tr>
						<td>
							<input type="text" id="name" name="name" pattern="[a-zA-Z가-힣]{1,30}" title="최대 30자리까지 입력가능합니다.(영어,한글)" required placeholder="이름">
						</td>
					</tr>
					<tr>
						<td>
							<input type="email" id="email" name="email" required placeholder="이메일">
						</td>
					</tr>
						<tr><td><button type="submit">비밀번호 찾기</button></td></tr>
				</table>
			</form>
			<form action="updatePassword" id="updateForm">
				<table id="updateBox" hidden>
					<tr><td><input type="password" name="password" pattern="^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*_=+-]).{8,15}$" title="최소 8자리, 최대 15자리까지 입력하능합니다.(영어,특수문자,숫자 필수)" required plceholder="새로운 비밀번호를 입력해주세요."></td></tr>
					<tr><td><input type="text" id="id2" name="id" hidden></td></tr>
					<tr><td><input type="text" id="name2" name="name" hidden></td></tr>
					<tr><td><input type="text" id="email2" name="email" hidden></td></tr>
					<tr><td><button type="submit">수정</button></td></tr>
				</table>
			</form>
		</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>