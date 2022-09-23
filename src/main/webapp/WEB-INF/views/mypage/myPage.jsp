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
	$("#updateBtn").on("click", function() {
		$("#passwordInput").removeAttr("hidden");
	})
	
	const info = "${loginInfo.password}";
	$("#submitBtn").on("click", function() {
		if("${loginInfo.password}" == $("#password").val()) {
			window.location.href = "updateinfo";
		} else {
			$("#checkResult").html("비밀번호를 확인해주세요.");
			$("#password").val("");
			$("#password").focus();
		}
	})
});
</script>
</head>
<body>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<h1>내정보</h1>
		<p>팀이름 : ${loginInfo.name }</p>
		<p>연락처 : ${loginInfo.phone }</p>
		<p>이메일 : ${loginInfo.email }</p>
		<p>지역 : ${loginInfo.region }</p>
		<div id="passwordInput" hidden>
			<span>비밀번호 :</span>
			<input type="password" id="password">
			<button id="submitBtn">확인</button>
			<span id="checkResult"></span>
		</div>
		<button id="updateBtn">수정</button>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</body>
</html>