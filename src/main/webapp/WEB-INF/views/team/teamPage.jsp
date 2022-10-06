<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	$("#updateTeamBtn").on("click", function() {
		$("#passwordInputTeam").removeAttr("hidden");
		$("#passwordTeam").focus();
	})
	
	const info = "${loginInfo.password}";
	$("#submitBtnTeam").on("click", function() {
		if ("${loginInfo.password}" == $("#passwordTeam").val()) {
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
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<h1>${loginInfo.getTeamName() }</h1>
		<jsp:include page="/WEB-INF/views/components/position.jsp" />
		<div id="passwordInputTeam" hidden>
			<span>비밀번호 :</span>
			<input type="password" id="passwordTeam">
			<button id="submitBtnTeam">확인</button>
			<span id="checkResultTeam"></span>
		</div>
		<button id="updateTeamBtn">팀 수정</button>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>