<%@page import="user.UserDTO"%>
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
<link href="/css/teamPage.css" rel="stylesheet" />
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
	
	$("#exitTeamBtn").on("click", function() {
		if(confirm("팀에서 탈퇴하시겠습니까?")) {
			location.href="exitTeam";
		}
	})
	
	// 수락
	$(document).on("click", "#true", function() {
		const id = $(this).prev().html();
		const result = $(this).attr("id");
		$.ajax({
			url : "registerResult",
			data : {"id" : id, "result" : result},
			dataType : "json",
			success : function(server) {
				if(server.result == "success") {
					alert("승인");
					location.reload();
				}
			}
		})
	})
	
	// 거절
	$(document).on("click", "#false", function() {
		const id = $(this).prev().prev().html();
		const result = $(this).attr("id");
		$.ajax({
			url : "registerResult",
			data : {"id" : id, "result" : result},
			dataType : "json",
			success : function(server) {
				if(server.result == "false") {
					alert("거절");
					location.reload();
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
		<h1>${loginInfo.getTeamName() }</h1>
		<div class="cardBox">
			<%
				UserDTO[] all = (UserDTO[])request.getAttribute("allMember");
				for(int i = 0;i < all.length;i++) {
					request.setAttribute("user", all[i]);%>
					<div class="card">
						<jsp:include page="/WEB-INF/views/components/card.jsp"/>
					</div>	
				<%}
			%>
		</div>
		<div id="passwordInputTeam" hidden>
			<span>비밀번호 :</span>
			<input type="password" id="passwordTeam">
			<button id="submitBtnTeam">확인</button>
			<span id="checkResultTeam"></span>
		</div>
		<% String teamId = (String)request.getAttribute("teamId");
			String loginId = (String)request.getAttribute("loginId");
			String[] teamRegisterInfoUser = (String[])request.getAttribute("teamRegisterInfo");
			if(teamId.equals(loginId)) { %>
				<button id="updateTeamBtn">팀 수정</button>
				<div>
					<h1>승인 대기 중인 요청</h1>
					<%
						for(int i = 0;i < teamRegisterInfoUser.length;i++) {%>
							<p><%=teamRegisterInfoUser[i]%></p>
							<button id="true">승인</button>
							<button id="false">거절</button>
						<%}
					%>
				</div>				
			<%} else {%>
				<button id="exitTeamBtn">팀 탈퇴</button>
			<%}
		%>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>