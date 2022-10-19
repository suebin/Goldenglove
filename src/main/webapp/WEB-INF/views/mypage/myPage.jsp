<%@page import="user.UserDTO"%>
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
<link href="/css/myPage.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	const position = {
			firstBase : "1루수",
			secondBase : "2루수",
			thirdBase : "3루수",
			catcher : "포수",
			pitcher : "투수",
			leftFielder : "좌익수",
			rightFielder : "우익수",
			centerFielder : "중견수",
			shortStop : "유격수"
	}
	const positionName = position.${loginInfo.getPosition()};
	$(".position").html(positionName);
	
	$("#updateUserBtn").on("click", function() {
		$("#passwordInputUser").removeAttr("hidden");
		$("#submitBtnUser").removeAttr("hidden");
		$("#passwordUser").focus();
		$("#updateUserBtn").attr("hidden", "hidden");
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
});
</script>
</head>
<body>
<%
	UserDTO user = (UserDTO)session.getAttribute("loginInfo"); 
	request.setAttribute("user", user);
%>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<div class="contentBox">
			<h1 class="h1">내정보</h1>
			<ul class="table">
				<li>
					<ul><li>이름 </li><li>${loginInfo.getName() }</li></ul>
					<ul><li>연락처 </li><li>${loginInfo.getPhone() }</li></ul>
					<ul><li>이메일 </li><li>${loginInfo.getEmail() }</li></ul>
					<ul><li>지역 </li><li>${loginInfo.getRegion() }</li></ul>
					<ul><li>포지션 </li><li class="position"></li></ul>
				</li>
				<li>
					<div class="card"><jsp:include page="/WEB-INF/views/components/card.jsp" /></div>
				</li>
			</ul>
			<ul class="pwTable" id="passwordInputUser" hidden>
				<li><span>비밀번호 </span><input type="password" id="passwordUser"></li>
				<li><div id="checkResultUser" class="red"></div></li>
			</ul>
			<button id="updateUserBtn" class="updateBtn">정보 수정</button>
			<button id="submitBtnUser" hidden>확인</button>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>