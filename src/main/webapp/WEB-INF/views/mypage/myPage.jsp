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
	$("#position").html(positionName);
	
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
			<table class="table">
				<tr><td width="20%">이름 </td><td width="20%">${loginInfo.getName() }</td><td rowspan="5" width="40%" class="card"><jsp:include page="/WEB-INF/views/components/card.jsp" /></td></tr>
				<tr><td>연락처 </td><td>${loginInfo.getPhone() }</td></tr>
				<tr><td>이메일 </td><td>${loginInfo.getEmail() }</td></tr>
				<tr><td>지역 </td><td>${loginInfo.getRegion() }</td></tr>
				<tr><td>포지션 </td><td id="position"></td></tr>
			</table>
			<table class="table" id="passwordInputUser" hidden>
				<tr><td width="20%">비밀번호 </td><td><input type="password" id="passwordUser"></td></tr>
				<tr><td></td><td id="checkResultUser" class="red"></td></tr>
			</table>
			<button id="updateUserBtn" class="updateBtn">정보 수정</button>
			<button id="submitBtnUser" hidden>확인</button>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>