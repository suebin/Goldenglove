<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="team.TeamDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/teamUpdate.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	<%
		TeamDTO team = (TeamDTO)request.getAttribute("teamDTO");
		String[] positionMember = {team.getFirstBase(), team.getSecondBase(), team.getThirdBase(), team.getCatcher(), team.getPitcher(), team.getLeftFielder(), team.getRightFielder(), team.getCenterFielder(), team.getShortStop()};
		String[] position = {"firstBase", "secondBase", "thirdBase", "catcher", "pitcher", "leftFielder", "rightFielder", "centerFielder", "shortStop"};
		String[] modiPosition = {"","","","","","","","",""};
		for(int i = 0;i < position.length;i++) {
			if(positionMember[i].equals("")) {
				modiPosition[i] = positionMember[i];
			} else {
				if(positionMember[i].split(" ").length >= 1) {
					modiPosition[i] = positionMember[i].trim().replaceAll(" ", "</button><button>");
				}
			}
		}
	%>
	const positionMember = ["${teamDTO.getFirstBase()}", "${teamDTO.getSecondBase()}", "${teamDTO.getThirdBase()}", "${teamDTO.getCatcher()}", "${teamDTO.getPitcher()}", "${teamDTO.getLeftFielder()}", "${teamDTO.getRightFielder()}", "${teamDTO.getCenterFielder()}", "${teamDTO.getShortStop()}"];
	const position = ["firstBase", "secondBase", "thirdBase", "catcher", "pitcher", "leftFielder", "rightFielder", "centerFielder", "shortStop"];
	for(let i = 0; i < 9; i++) {
		if(positionMember[i] == "") {
			$("#" + position[i]).attr("hidden", "hidden");
		}else {
			$("#" + position[i]).removeAttr("hidden");
		}
	}
	
	//팀이름 중복조회
	$("#duplicate").on("click", function(e) {
		if($("#teamName").val() != '${loginInfo.teamName}') {
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
				} else if(btn.next().children().html() == "") {
					btn.next().removeAttr("hidden");
					btn.next().next().html("");
					btn.next().html("<button>" + server.result + "</button>");
				} else {
					const done = btn.next().text().split(" ");
					if(!done.includes(server.result)) {
						btn.next().removeAttr("hidden");
						btn.next().append("<button> " + server.result + "</button>");
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
				firstBase : $("#firstBase").html().replace(/<button>|<\/button>/g , "").trim(),
				secondBase : $("#secondBase").html().replace(/<button>|<\/button>/g , "").trim(),
				thirdBase : $("#thirdBase").html().replace(/<button>|<\/button>/g , "").trim(),
				catcher : $("#catcher").html().replace(/<button>|<\/button>/g , "").trim(),
				pitcher : $("#pitcher").html().replace(/<button>|<\/button>/g , "").trim(),
				leftFielder : $("#leftFielder").html().replace(/<button>|<\/button>/g , "").trim(),
				rightFielder : $("#rightFielder").html().replace(/<button>|<\/button>/g , "").trim(),
				centerFielder : $("#centerFielder").html().replace(/<button>|<\/button>/g , "").trim(),
				shortStop : $("#shortStop").html().replace(/<button>|<\/button>/g , "").trim()
		};
		$.ajax({
			url : "teamUpdateResult",
			data : {"teamDTO" : JSON.stringify(team)},
			dataType : "json",
			success : function(server) {
				if(server.result == "success") {
					alert("팀 수정이 완료되었습니다.");
					location.href = "/teampage";
				}
			}
		})
	})
	//삭제
	$(document).on("click", ".inputBox div div button",function(e) {
		if($(this).html() != '${loginInfo.getId()} ') {
			if(confirm("삭제 하시겠습니까?")) {
				$(this).remove();
			}			
		} else {
			alert("본인은 삭제할 수 없습니다.");
		}
	})
	
	$("#exitBtn").on("click", function() {
		history.back();
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<div class="teamContainer">
			<h2>Update Team</h2>
			<div class="teamName">
				팀 이름 
				<input type="text" autocomplete="off" name="teamName" id="teamName" value="${loginInfo.teamName }">
				<button type="button" id="duplicate">중복검사</button>
				<p id="teamNameResult"></p>
			</div>
			<div class="inputBoxCon">
				<div class="inputBox" style="background-image: url('images/playground.png'); background-size: 100% 100%;">
					<div class="firstBase">
						<span class="positionName">First Base</span>
						<input type="text" autocomplete="off" placeholder="전화번호 입력" name="firstBase">
						<input type="button" value="검색" />
						<div id="firstBase"><button><%=modiPosition[0]%></button></div>
						<p></p>
					</div>
					<div class="secondBase">
						<span class="positionName">Second Base</span>
						<input type="text" autocomplete="off" placeholder="전화번호 입력" name="secondBase">
						<input type="button" value="검색" />
						<div id="secondBase"><button><%=modiPosition[1]%></button></div>
						<p></p>
					</div>
					<div class="thirdBase">
						<span class="positionName">Third Base</span>
						<input type="text" autocomplete="off" placeholder="전화번호 입력" name="thirdBase">
						<input type="button" value="검색" />
						<div id="thirdBase"><button><%=modiPosition[2]%></button></div>
						<p></p>
					</div>
					<div class="catcher">
						<span class="positionName">Catcher</span>
						<input type="text" autocomplete="off" placeholder="전화번호 입력" name="catcher">
						<input type="button" value="검색" />
						<div id="catcher"><button><%=modiPosition[3]%></button></div>
						<p></p>
					</div>
					<div class="pitcher">
						<span class="positionName">Pitcher</span>
						<input type="text" autocomplete="off" placeholder="전화번호 입력" name="pitcher">
						<input type="button" value="검색" />
						<div id="pitcher"><button><%=modiPosition[4]%></button></div>
						<p></p>
					</div>
					<div class="leftFielder">
						<span class="positionName">Left Fielder</span>
						<input type="text" autocomplete="off" placeholder="전화번호 입력" name="leftFielder">
						<input type="button" value="검색" />
						<div id="leftFielder"><button><%=modiPosition[5]%></button></div>
						<p></p>
					</div>
					<div class="rightFielder">
						<span class="positionName">Right Fielder</span>
						<input type="text" autocomplete="off" placeholder="전화번호 입력" name="rightFielder">
						<input type="button" value="검색" />
						<div id="rightFielder"><button><%=modiPosition[6]%></button></div>
						<p></p>
					</div>
					<div class="centerFielder">
						<span class="positionName">Center Fielder</span>
						<input type="text" autocomplete="off" placeholder="전화번호 입력" name="centerFielder">
						<input type="button" value="검색" />
						<div id="centerFielder"><button><%=modiPosition[7]%></button></div>
						<p></p>
					</div>
					<div class="shortStop">
						<span class="positionName">Short Stop</span>
						<input type="text" autocomplete="off" placeholder="전화번호 입력" name="shortStop">
						<input type="button" value="검색" />
						<div id="shortStop"><button><%=modiPosition[8]%></button></div>
						<p></p>
					</div>
				</div>
			</div>
			<div class="btnBox">
				<button class="button" id="submitBtn" type="button">수정</button>
				<button class="button" id="exitBtn" type="button">취소</button>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>