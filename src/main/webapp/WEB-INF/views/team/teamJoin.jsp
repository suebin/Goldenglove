<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브</title>
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/teamJoin.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	// 알림 날짜
	const now = new Date();
	const alarmDate = now.getFullYear() + "." + ("0" + (now.getMonth() + 1)).slice(-2) + "." + ("0" + (now.getDate())).slice(-2);
	
	
	$("#createBtn").on("click", function() {
		$("#createBox").removeAttr("hidden");
		$("#searchBox").attr("hidden", "hidden");
		$("#noneTeam").attr("hidden", "hidden");
	})
	
	$("#searchBtn").on("click", function() {
		$("#searchBox").removeAttr("hidden");
		$("#createBox").attr("hidden", "hidden");
		$("#searchTeamName").focus();
	})
	
	$("#exitBtn").on("click", function() {
		location.reload();
	})
	
	//팀이름 중복조회
	$("#duplicate").on("click", function(e) {
		if($("#teamName").val() == "") {
			$("#teamNameResult").html("입력해주세요.");
			$("#teamName").focus();
			$("#teamNameResult").attr("class", "red");
		} else {
			$.ajax({
				url : 'teamNameCheck',
				data : {
					"teamName" : $("#teamName").val() 
				},
				dataType : 'json',
				success : function(server) {
					if(server.result == "이미 사용중입니다.") {
						$("#teamName").val("");
						$("#teamName").focus();
						$("#teamNameResult").attr("class", "red");
					} else if(server.result == "사용 가능합니다."){
						$("#teamNameResult").attr("class", "green");
					}
					$("#teamNameResult").html(server.result);
				}
			})			
		}
	})
	
	//팀원추가 가입조회
	$("input:button").on("click", function(e) {
		const btn = $(this);
		$.ajax({
			url : 'userCheck',
			data : {
				"position" : $(this).prev().attr("name"),
				"phone" : $(this).prev().val()
			},
			dataType : 'json',
			success : function(server) {
				if(server.result == "전화번호를 확인해주세요." || server.result == "이미 가입된 팀이 존재합니다." || server.result == "등록된 포지션이 다릅니다.") {
					btn.prev().val("");
					btn.prev().focus();
					btn.next().next().attr("class", "red");
					btn.next().next().html(server.result);
				} else {
					const done = btn.next().html().trim().split(" ");
					if(!done.includes(server.result)) {
						btn.next().append(server.result+" ");
						btn.next().next().html("");
						btn.prev().val("");
					}
				}
			}
		})
	})
	//팀생성
	$("#submitBtn").on("click", function() {
		if($("#teamNameResult").html() == "") {
			alert("중복검사를 해주세요.");
		} else {
			const team = {
					teamId : '${loginInfo.getId()}',
					teamName : $("#teamName").val(),
					firstBase : $("#firstBase").html().trim(),
					secondBase : $("#secondBase").html().trim(),
					thirdBase : $("#thirdBase").html().trim(),
					catcher : $("#catcher").html().trim(),
					pitcher : $("#pitcher").html().trim(),
					leftFielder : $("#leftFielder").html().trim(),
					rightFielder : $("#rightFielder").html().trim(),
					centerFielder : $("#centerFielder").html().trim(),
					shortStop : $("#shortStop").html().trim()
			};
			$.ajax({
				url : "teamResult",
				data : {"teamDTO" : JSON.stringify(team)},
				dataType : "json",
				success : function(server) {
					if(server.result == "success") {
						alert("팀 생성이 완료되었습니다.");
						location.reload();				
					}
				}
			})			
		}
	})
	
	//팀가입
	$("#checkBtn").on("click", function() {
		$.ajax({
			url : "searchTeam",
			data : {"teamName" : $("#searchTeamName").val()},
			dataType : "json",
			success : function(server) {
				if(server.result == "팀 이름을 확인해주세요.") {
					$("#searchResult").html(server.result);
					$("#searchResult").attr("class", "red");
					$("#teamBtn").attr("hidden", "hidden");
					$(".teamBtn").attr("hidden", "hidden");
				} else {
					$("#searchResult").html("");
					$("#teamBtn").removeAttr("hidden");
					$(".teamBtn").removeAttr("hidden");
					$("#teamBtn").html(server.result);
				}
			}
		})
	})
	
	$("#teamBtn").on("click", function() {
		if("${teamRegisterInfo}" == "") {
			if(confirm("가입신청을 하시겠습니까?")) {
				$.ajax({
					url : "teamRegisterResult",
					data : {"teamName" : $("#teamBtn").html(), "alarmDate" : alarmDate},
					dataType : "json",
					success : function(server) {
						if(server.result == "success") {
							alert("신청이 완료되었습니다.");
							location.href="/"
						}
					}
				})
			}
		} else {
			alert("이미 신청중인 팀이 있습니다.")		;	
		}
	})
	
	$("#${loginInfo.position}").html("${loginInfo.id} ");
	
	// 수락
	$(document).on("click", "#true", function() {
		const teamName = $(this).attr("name");
		const result = $(this).attr("id");
		$.ajax({
			url : "registerResultUser",
			data : {"teamName" : teamName, "result" : result},
			dataType : "json",
			success : function(server) {
				if(server.result == "success") {
					location.reload();
				}
			}
		})
	})
	
	// 거절
	$(document).on("click", "#false", function() {
		const teamName = $(this).attr("name");
		const result = $(this).attr("id");
		$.ajax({
			url : "registerResultUser",
			data : {"teamName" : teamName, "result" : result},
			dataType : "json",
			success : function(server) {
				if(server.result == "false") {
					location.reload();
				}
			}
		})
	})
	
	$(document).on("click", "#waiting", function() {
		if(confirm("취소 하시겠습니까?")) {
			$.ajax({
				url : "registerResultUser",
				data : {"teamName" : "${teamRegisterInfo}", "result" : "false"},
				dataType : "json",
				success : function(server) {
					if(server.result == "false") {
						location.reload();
					}
				}
			})
		}
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<div class="teamContainer">
			<div id="noneTeam">
				<h1 class="h1">가입된 팀이 없습니다.</h1>
				<div class="btnBox">
					<button class="button" id="createBtn">팀 생성</button>
					<button class="button" id="searchBtn">팀 가입</button>
				</div>
			</div>
			<div id="createBox" hidden>
				<h2>Create Team</h2>
				<form autocomplete="off">
					<div class="teamName">
						팀 이름
						<input type="text" name="teamName" id="teamName">
						<button type="button" id="duplicate">중복검사</button>
						<p id="teamNameResult"></p>
					</div>
					<div class="inputBoxCon">
						<div class="inputBox" style="background-image: url('playground.png'); background-size: 100% 100%;">
							<!-- 1루수  -->
							<div class="firstBase">
								<input type="text" placeholder="전화번호 입력" name="firstBase">
								<input type="button" value="검색" />
								<p id="firstBase"></p>
								<p></p>
							</div>
							<!-- 2루수 --> 
							<div class="secondBase">
								<input type="text" placeholder="전화번호 입력" name="secondBase">
								<input type="button" value="검색" />
								<p id="secondBase"></p>
								<p></p>
							</div>
							<!-- 3루수  -->
							<div class="thirdBase">
								<input type="text" placeholder="전화번호 입력" name="thirdBase">
								<input type="button" value="검색" />
								<p id="thirdBase"></p>
								<p></p>
							</div>
							<!-- 포수 --> 
							<div class="catcher">
								<input type="text" placeholder="전화번호 입력" name="catcher">
								<input type="button" value="검색" />
								<p id="catcher"></p>
								<p></p>
							</div>
							<!-- 투수  -->
							<div class="pitcher">
								<input type="text" placeholder="전화번호 입력" name="pitcher">
								<input type="button" value="검색" />
								<p id="pitcher"></p>
								<p></p>
							</div>
							<!-- 좌익수 --> 
							<div class="leftFielder">
								<input type="text" placeholder="전화번호 입력" name="leftFielder">
								<input type="button" value="검색" />
								<p id="leftFielder"></p>
								<p></p>
							</div>
							<!-- 우익수  -->
							<div class="rightFielder">
								<input type="text" placeholder="전화번호 입력" name="rightFielder">
								<input type="button" value="검색" />
								<p id="rightFielder"></p>
								<p></p>
							</div>
							<!-- 중견수  -->
							<div class="centerFielder">
								<input type="text" placeholder="전화번호 입력" name="centerFielder">
								<input type="button" value="검색" />
								<p id="centerFielder"></p>
								<p></p>
							</div>
							<!-- 유격수 --> 
							<div class="shortStop">
								<input type="text" placeholder="전화번호 입력" name="shortStop">
								<input type="button" value="검색" />
								<p id="shortStop"></p>
								<p></p>
							</div>		
						</div>
					</div>
					<div class="btnBox">
						<button class="button" id="submitBtn" type="button">생성</button>
						<button class="button" id="exitBtn" type="button">취소</button>
					</div>
				</form>
			</div>
			<div id="searchBox" hidden>
				<h2>Team Join</h2>
				<table>
					<tr><td>가입하고 싶은 팀 이름을 입력해주세요 </td><td><input type="text" id="searchTeamName" autocapitalize="none"></td><td><button id="checkBtn" type="button">검색</button></td></tr>
				</table>
				<p id="searchResult"></p>
				<div class="teamBtn" hidden>
					<div class="BtnCon">
						<button id="teamBtn" type="button" hidden></button>
						<img alt="teamCardImg" src="/images/baseball.png">
					</div>
				</div>
			</div>
			<%
				if(request.getAttribute("teamRegisterInfo") != null) {%>
					<div>
						<h1>승인 대기 중인 팀</h1>
						<div class="registerBox">
						<div class="registerBtnCon" id="waiting">${teamRegisterInfo }</div>
						</div>
					</div>
				<%}
			%>
			<%	
				String[] arr =(String[])request.getAttribute("registerTeam");
				if(arr.length != 0) {%>
					<div>
						<h1>받은 요청</h1>
							<div class="register">
								<%
									for(int i = 0;i < arr.length;i++) {%>
										<div class="registerBox">
											<div class="registerBtnCon">
												<%=arr[i] %>
											</div>
											<div class="registerBtnBox">
												<input type="button" id="true" name="<%=arr[i]%>" value="승인" >
												<input type="button" id="false" name="<%=arr[i]%>" value="거절">							
											</div>
										</div>
									<%}
								%>
							</div>
					</div>
				<%}
			%>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>