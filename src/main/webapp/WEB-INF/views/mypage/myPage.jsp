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
	$("#updateUserBtn").on("click", function() {
		$("#passwordInputUser").removeAttr("hidden");
		$("#passwordUser").focus();
	})
	
	$("#updateTeamBtn").on("click", function() {
		$("#passwordInputTeam").removeAttr("hidden");
		$("#passwordTeam").focus();
	})
	
	const info = "${loginInfo.password}";
	$("#submitBtnUser").on("click", function() {
		if("${loginInfo.password}" == $("#passwordUser").val()) {
			window.location.href = "updateinfo";
		} else {
			$("#checkResultUser").html("비밀번호를 확인해주세요.");
			$("#passwordUser").val("");
			$("#passwordUser").focus();
		}
	})
	
	$("#submitBtnTeam").on("click", function() {
		if("${loginInfo.password}" == $("#passwordTeam").val()) {
			window.location.href = "teamUpdate";
		} else {
			$("#checkResultTeam").html("비밀번호를 확인해주세요.");
			$("#passwordTeam").val("");
			$("#passwordTeam").focus();
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
		<p>팀이름 : ${loginInfo.getName() }</p>
		<p>연락처 : ${loginInfo.getPhone() }</p>
		<p>이메일 : ${loginInfo.getEmail() }</p>
		<p>지역 : ${loginInfo.getRegion() }</p>
		<div id="passwordInputUser" hidden>
			<span>비밀번호 :</span>
			<input type="password" id="passwordUser">
			<button id="submitBtnUser">확인</button>
			<span id="checkResultUser"></span>
		</div>
		<div id="passwordInputTeam" hidden>
			<span>비밀번호 :</span>
			<input type="password" id="passwordTeam">
			<button id="submitBtnTeam">확인</button>
			<span id="checkResultTeam"></span>
		</div>
		<jsp:include page="/WEB-INF/views/components/position.jsp" />
		<button id="updateUserBtn">정보 수정</button>
		<button id="updateTeamBtn">팀원 수정</button>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</body>
</html>