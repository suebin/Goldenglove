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
	// 알림 날짜
	const now = new Date();
	const alarmDate = now.getFullYear() + "." + ("0" + (now.getMonth() + 1)).slice(-2) + "." + ("0" + (now.getDate())).slice(-2);
	
	
	$("#updateTeamBtn").on("click", function() {
		$("#passwordInputTeam").removeAttr("hidden");
		$("#passwordTeam").focus();
	})
	
	const info = "${loginInfo.password}";
	$("#submitFormTeam").on("submit", function(e) {
		if ("${loginInfo.password}" == $("#passwordTeam").val()) {
		} else {
			e.preventDefault();
			$("#checkResultTeam").html("비밀번호를 확인해주세요.");
			$("#checkResultTeam").attr("class", "red");
			$("#passwordTeam").val("");
			$("#passwordTeam").focus();
		}
	})
	
	$("#exitTeamBtn").on("click", function() {
		if(confirm("팀에서 탈퇴하시겠습니까?")) {
			location.href="exitTeam";
			
			$.ajax({
				url : "exitTeamAlarm",
				data : {"id" : "${loginInfo.getId()}", "teamName" : "${loginInfo.getTeamName()}", "alarmDate" : alarmDate},
				dataType : "json",
				success : function(server) {
				}
			})
		}
	})
	
	// 수락
	$(document).on("click", "#true", function() {
		const id = $(this).attr("name");
		const result = $(this).attr("id");
		$.ajax({
			url : "registerResult",
			data : {"id" : id, "result" : result, "alarmDate" : alarmDate},
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
		const id = $(this).attr("name");
		const result = $(this).attr("id");
		$.ajax({
			url : "registerResult",
			data : {"id" : id, "result" : result, "alarmDate" : alarmDate},
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
	<div class="confix teamPage">
		<div class="myTeam">
			<div class="myTeamName">
				<h1>${loginInfo.getTeamName() }</h1>
				
				<% String teamId = (String)request.getAttribute("teamId");
				String loginId = (String)request.getAttribute("loginId");
				
				if(teamId.equals(loginId)) { %>
					<button id="updateTeamBtn">팀 수정</button>
				<%}	%>
			</div>
			<div class="cardBox teamCard">
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
		</div>
		
		<div id="passwordInputTeam" hidden>
			<form id="submitFormTeam" action="teamUpdate">
				<span>비밀번호</span>
				<input type="password" id="passwordTeam">
				<button id="submitBtnTeam">확인</button>
			</form>
			<span id="checkResultTeam"></span>
		</div>
		<% String teamId2 = (String)request.getAttribute("teamId");
			String loginId2 = (String)request.getAttribute("loginId");
			if(teamId2.equals(loginId2)) { %>
				<div>
					<h2>승인 대기 중인 요청</h2>
					<div class="cardBox defaultCard">
					<%
						UserDTO[] teamRegisterInfoUser = (UserDTO[])request.getAttribute("teamRegisterInfo");
						for(int i = 0;i < teamRegisterInfoUser.length;i++) {
							request.setAttribute("user", teamRegisterInfoUser[i]);%>
							<div class="card">
								<jsp:include page="/WEB-INF/views/components/card.jsp"/>
								
								<div class="acceptRejectBtn">
									<button id="true" name="<%=teamRegisterInfoUser[i].getId()%>">승인</button>
									<button id="false" name="<%=teamRegisterInfoUser[i].getId()%>">거절</button>
								</div>
							</div>
						<%}		
						
						if(teamRegisterInfoUser.length == 0) {%>
							<span>승인 대기 중인 요청이 없습니다.</span>
						<%}
						
					%>
					</div>
				</div>	
				<div>
					<h2>보낸 요청</h2>
					<div class="cardBox defaultCard">
					<%
						UserDTO[] registerUser = (UserDTO[])request.getAttribute("registerUser");
						for(int i = 0;i < registerUser.length;i++) {
							request.setAttribute("user", registerUser[i]);%>
							<div class="card">
								<jsp:include page="/WEB-INF/views/components/card.jsp"/>
							</div>
							
						<%}
						
						if(registerUser.length == 0) {%>
							<span>보낸 요청이 없습니다.</span>
						<%}
					%>
					</div>
				</div>			
			<%} else {%>
				<button id="exitTeamBtn">팀 탈퇴</button>
			<%}
		%>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>