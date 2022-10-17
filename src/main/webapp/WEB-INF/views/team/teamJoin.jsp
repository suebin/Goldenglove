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
	// 알림 날짜
	const now = new Date();
	const alarmDate = now.getFullYear() + "." + ("0" + (now.getMonth() + 1)).slice(-2) + "." + ("0" + (now.getDate())).slice(-2);
	
	
	$("#createBtn").on("click", function() {
		$("#createBox").removeAttr("hidden");
		$("#searchBox").attr("hidden", "hidden");
	})
	
	$("#searchBtn").on("click", function() {
		$("#searchBox").removeAttr("hidden");
		$("#createBox").attr("hidden", "hidden");
		$("#searchTeamName").focus();
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
				"id" : $(this).prev().val()
			},
			dataType : 'json',
			success : function(server) {
				if(server.result == "아이디를 확인해주세요." || server.result == "이미 가입된 팀이 존재합니다." || server.result == "등록된 포지션이 다릅니다.") {
					btn.prev().val("");
					btn.prev().focus();
					btn.parent().next().children("span:eq(1)").attr("class", "red");
					btn.parent().next().children("span:eq(1)").html(server.result);
				} else {
					const done = btn.parent().next().children("span:eq(0)").html().trim().split(" ");
					if(!done.includes(server.result)) {
						btn.parent().next().children("span:eq(0)").append(server.result+" ");											
					}
				}
			}
		})
	})
	//팀생성
	$("#submitBtn").on("click", function() {
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
				} else {
					$("#searchResult").html("");
					$("#teamBtn").removeAttr("hidden");
					$("#teamBtn").html(server.result);
				}
			}
		})
	})
	
	$("#teamBtn").on("click", function() {
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
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<h1>가입된 팀이 없습니다.</h1>
		<button id="createBtn">팀 생성</button>
		<button id="searchBtn">팀 가입</button>
		<div id="createBox" hidden>
			<form autocomplete="off">
				<table>
					<tr>
						<td>팀 이름 </td>
						<td>
							<input type="text" name="teamName" id="teamName">
							<button type="button" id="duplicate">중복검사</button>
						</td>
						<td><p id="teamNameResult"></p></td>
					</tr>
					<tr>
						<td>1루수 </td>
						<td>
							<input type="text" placeholder="아이디를 입력해주세요" name="firstBase">
							<input type="button" value="검색" />
						</td>
						<td>
							<span id="firstBase"></span>
							<span></span>
						</td>
					</tr>
					<tr>
						<td>2루수 </td>
						<td>
							<input type="text" placeholder="아이디를 입력해주세요" name="secondBase">
							<input type="button" value="검색" />
						</td>
						<td>
							<span id="secondBase"></span>
							<span></span>
						</td>
					</tr>
					<tr>
						<td>3루수 </td>
						<td>
							<input type="text" placeholder="아이디를 입력해주세요" name="thirdBase">
							<input type="button" value="검색" />
						</td>
						<td>
							<span id="thirdBase"></span>
							<span></span>
						</td>
					</tr>
					<tr>
						<td>포수 </td>
						<td>
							<input type="text" placeholder="아이디를 입력해주세요" name="catcher">
							<input type="button" value="검색" />
						</td>
						<td>
							<span id="catcher"></span>
							<span></span>
						</td>
					</tr>
					<tr>
						<td>투수 </td>
						<td>
							<input type="text" placeholder="아이디를 입력해주세요" name="pitcher">
							<input type="button" value="검색" />
						</td>
						<td>
							<span id="pitcher"></span>
							<span></span>
						</td>
					</tr>
					<tr>
						<td>좌익수 </td>
						<td>
							<input type="text" placeholder="아이디를 입력해주세요" name="leftFielder">
							<input type="button" value="검색" />
						</td>
						<td>
							<span id="leftFielder"></span>
							<span></span>
						</td>
					</tr>
					<tr>
						<td>우익수 </td>
						<td>
							<input type="text" placeholder="아이디를 입력해주세요" name="rightFielder">
							<input type="button" value="검색" />
						</td>
						<td>
							<span id="rightFielder"></span>
							<span></span>
						</td>
					</tr>
					<tr>
						<td>중견수 </td>
						<td>
							<input type="text" placeholder="아이디를 입력해주세요" name="centerFielder">
							<input type="button" value="검색" />
						</td>
						<td>
							<span id="centerFielder"></span>
							<span></span>
						</td>
					</tr>
					<tr>
						<td>유격수 </td>
						<td>
							<input type="text" placeholder="아이디를 입력해주세요" name="shortStop">
							<input type="button" value="검색" />
						</td>
						<td>
							<span id="shortStop"></span>
							<span></span>
						</td>
					</tr>
				</table>
				<button id="submitBtn" type="button">생성</button>
			</form>
		</div>
		<div id="searchBox" hidden>
				<table>
					<tr><td>팀 이름 </td><td><input type="text" id="searchTeamName" autocapitalize="none"></td><td><p id="searchResult"></p><button id="teamBtn" type="button" hidden></button></td></tr>
				</table>
				<button id="checkBtn" type="button">검색</button>
		</div>
		<%
			if(request.getAttribute("teamRegisterInfo") != null) {%>
				<div>
					<h1>승인 대기 중인 팀</h1>
					<p>${teamRegisterInfo }</p>
				</div>
			<%}
		%>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>