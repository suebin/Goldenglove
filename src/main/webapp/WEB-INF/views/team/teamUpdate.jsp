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
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	<%
		TeamDTO team = (TeamDTO)request.getAttribute("teamDTO");
		String[] positionMember = {team.getFirstBase(), team.getSecondBase(), team.getThirdBase(), team.getCatcher(), team.getPitcher(), team.getLeftFielder(), team.getRightFielder(), team.getCenterFielder(), team.getShortStop()};
		String[] position = {"firstBase", "secondBase", "thirdBase", "catcher", "pitcher", "leftFielder", "rightFielder", "centerFielder", "shortStop"};
		String[] modiPosition = {"","","","","","","","",""};
		String a = "aaa";
		for(int i = 0;i < position.length;i++) {
			if(positionMember[i].equals("")) {
				modiPosition[i] = positionMember[i];
			} else {
				if(positionMember[i].split(" ").length > 1) {
					modiPosition[i] = positionMember[i].replaceAll(" ", "</button><button>");
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
				"id" : $(this).prev().val()
			},
			dataType : 'json',
			success : function(server) {
				if(server.result == "아이디를 확인해주세요." || server.result == "이미 가입된 팀이 존재합니다." || server.result == "등록된 포지션이 다릅니다.") {
					btn.prev().val("");
					btn.prev().focus();
					btn.parent().parent().next().children().children("span").attr("class", "red");
					btn.parent().parent().next().children().children("span").html(server.result);
				} else {
					const done = btn.parent().next().children("div").html().trim().split(" ");
					if(!done.includes(server.result)) {
						btn.parent().next().children("div").append("<button>" + server.result + "</button>");
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
	$(document).on("click", "td div button",function(e) {
		if(confirm("삭제 하시겠습니까?")) {
			$(this).remove();
		}
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<h1>팀 수정</h1>
		<table>
			<tr>
				<td>팀 이름 </td>
				<td>
					<input type="text" autocomplete="off" name="teamName" id="teamName" value="${loginInfo.teamName }">
					<button type="button" id="duplicate">중복검사</button>
				</td>
				<td><p id="teamNameResult"></p></td>
			</tr>
			<tr>
				<td>1루수 </td>
				<td>
					<input type="text" autocomplete="off" placeholder="아이디를 입력해주세요" name="firstBase">
					<input type="button" value="검색" />
				</td>
				<td>
					<div id="firstBase"><button><%=modiPosition[0] %></button></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span></span>
				<td>
			</tr>
			<tr>
				<td>2루수 </td>
				<td>
					<input type="text" autocomplete="off" placeholder="아이디를 입력해주세요" name="secondBase">
					<input type="button" value="검색" />
				</td>
				<td>
					<div id="secondBase"><button><%=modiPosition[1] %></button></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span></span>
				<td>
			</tr>
			<tr>
				<td>3루수 </td>
				<td>
					<input type="text" autocomplete="off" placeholder="아이디를 입력해주세요" name="thirdBase">
					<input type="button" value="검색" />
				</td>
				<td>
					<div id="thirdBase"><button><%=modiPosition[2] %></button></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span></span>
				<td>
			</tr>
			<tr>
				<td>포수 </td>
				<td>
					<input type="text" autocomplete="off" placeholder="아이디를 입력해주세요" name="catcher">
					<input type="button" value="검색" />
				</td>
				<td>
					<div id="catcher"><button><%=modiPosition[3] %></button></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span></span>
				<td>
			</tr>
			<tr>
				<td>투수 </td>
				<td>
					<input type="text" autocomplete="off" placeholder="아이디를 입력해주세요" name="pitcher">
					<input type="button" value="검색" />
				</td>
				<td>
					<div id="pitcher"><button><%=modiPosition[4] %></button></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span></span>
				<td>
			</tr>
			<tr>
				<td>좌익수 </td>
				<td>
					<input type="text" autocomplete="off" placeholder="아이디를 입력해주세요" name="leftFielder">
					<input type="button" value="검색" />
				</td>
				<td>
					<div id="leftFielder"><button><%=modiPosition[5] %></button></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span></span>
				<td>
			</tr>
			<tr>
				<td>우익수 </td>
				<td>
					<input type="text" autocomplete="off" placeholder="아이디를 입력해주세요" name="rightFielder">
					<input type="button" value="검색" />
				</td>
				<td>
					<div id="rightFielder"><button><%=modiPosition[6] %></button></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span></span>
				<td>
			</tr>
			<tr>
				<td>중견수 </td>
				<td>
					<input type="text" autocomplete="off" placeholder="아이디를 입력해주세요" name="centerFielder">
					<input type="button" value="검색" />
				</td>
				<td>
					<div id="centerFielder"><button><%=modiPosition[7] %></button></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span></span>
				<td>
			</tr>
			<tr>
				<td>유격수 </td>
				<td>
					<input type="text" autocomplete="off" placeholder="아이디를 입력해주세요" name="shortStop">
					<input type="button" value="검색" />
				</td>
				<td>
					<div id="shortStop"><button><%=modiPosition[8] %></button></div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span></span>
				<td>
			</tr>
		</table>
		<button id="submitBtn" type="button">수정</button>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>