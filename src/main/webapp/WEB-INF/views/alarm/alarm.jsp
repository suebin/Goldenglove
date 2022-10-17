<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/alarm.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js" ></script>
<script>
$(document).ready(function() {
	// 알람 내용 가져오기	
	$.ajax ({
		url: "alarm",
		data:{ homeName: "${loginInfo.getName()}" },
		type:"post",
		dataType:"json",
		success: function(res) {
			let result = "";
			
			for(let i=0; i< res.length; i++) {
				if(res[i].acceptance == -1 && res[i].homeName == "${loginInfo.getName()}") {
				 	result = "<p class='teammatchpage'>[신청] <strong>" + res[i].awayName + "</strong> 팀이 매칭 신청을 하였습니다.<br/>"
				 			+ "<strong># " + res[i].possibleDate + " / " + res[i].possibleTime + " / " + res[i].homePlace + " 경기</strong></p>";
				
				} else if (res[i].acceptance == 1 && res[i].awayName == "${loginInfo.getName()}") {
					result = "<p class='teammatchpage'>[수락] <strong>" + res[i].homeName + "</strong> 팀이 매칭 신청을 수락하였습니다.<br/>"
	 						+ "<strong># " + res[i].possibleDate + " / " + res[i].possibleTime + " / " + res[i].homePlace + " 경기</strong></p>";
				
				} else if (res[i].acceptance == 0 && res[i].cancleTeam != "${loginInfo.getName()}") {
					result = "<p class='teammatchpage'>[취소] <strong>" + res[i].cancleTeam + "</strong> 팀이 매칭을 취소하였습니다.<br/>"
							+ "<strong># " + res[i].possibleDate + " / " + res[i].possibleTime + " / " + res[i].homePlace + " 경기</strong></p>";
				
				} else if (res[i].applyJoin == 1 && res[i].teamLeader == "${loginInfo.getName()}") {
					result = "<p class='teampage'>[신청] <strong>" + res[i].teamMember + "</strong> 님이 팀 가입을 신청하였습니다.</p>";
		
				} else if (res[i].acceptJoin == 1 && res[i].teamMember == "${loginInfo.getName()}") {
					result = "<p class='teampage'>[수락] <strong>" + res[i].teamLeader + "</strong> 님이 팀 가입을 수락하였습니다.</p>";
		
				} else if (res[i].cancleJoin == 1 && res[i].teamMember == "${loginInfo.getName()}") {
					result = "<p class='teampage'>[거절] <strong>" + res[i].teamLeader + "</strong> 님이 팀 가입을 거절하였습니다.</p>";
		
				} else if (res[i].exitTeam == 1 && res[i].teamLeader == "${loginInfo.getName()}") {
					result = "<p class='teampage'>[탈퇴] <strong>" + res[i].teamMember + "</strong> 님이 팀을 탈퇴하였습니다.</p>";
		
				} else {
					result = "";
				}
				if (res[i].checked == 1 && result != "") {
					$(".list").prepend(
						"<li class='li clicked'>"
						+	"<span id='alarmSeq' style='display:none;'>" + res[i].seq + "</span>"
					 	+ 	result
						+	"<span>" + res[i].alarmDate + "</span>"
						+"</li>"
					)
				} else if (res[i].checked == 0 && result != "") {
					$(".list").prepend(
						"<li class='li'>"
						+	"<span id='alarmSeq' style='display:none;'>" + res[i].seq + "</span>"
						+	result
						+	"<span>" + res[i].alarmDate + "</span>"
						+"</li>"
					)
				}
			}
			
			// 알림 목록 다 클릭 시 빨간 원 사라짐
			const li = document.getElementsByClassName("li");
			let isClicked = 0;
			
			for (let item of li) {
				item.classList.contains("clicked") ? isClicked++ : false; 
			}
			if (isClicked != li.length) {
				$(".alarmCircle").removeClass("alarmHidden");
			} 
		}
	});
	
	// 알람 버튼 누르면 나옴
	$(".alarmImg").on("click", function() {
		$(".alarmCon").toggleClass("alarmHidden");
		
		if ($(".list").children().length == 0) {
			$(".list").prepend("<li><span class='noAlarm'> 최근에 받은 알림이 없습니다.</span></li>");
		}
	})
	
	// 알람 외부 영역 클릭 시 닫힘
	$(document).on("click", function(e) {
		if ($(".alarm").has(e.target).length == 0) {
			$(".alarmCon").addClass("alarmHidden");
		}
	}); 

	// 알람 목록 클릭 시
	$(document).on("click", ".li", function() {
		$(this).addClass("clicked");
		
		if ($(this).children("p").hasClass("teammatchpage")) {
			location.href = "teammatchpage?myTeamName=${loginInfo.getName()}";
			
		} else if ($(this).children("p").hasClass("teampage")) {
			location.href = "teampage";
		}
		
		$.ajax ({
			url: "checkAlarm",
			data:{ alarmSeq: $(this).children("#alarmSeq").html(), homeName: "${loginInfo.getName()}" },
			type:"post",
			dataType:"json",
			success: function(res) {
							
			}
		})
	}); 
});
</script>
</head>
<body>
<% if(session.getAttribute("loginInfo") != null) { %>
	<div class="alarm">
		<div class="alarmImg">
			<div class="alarmCircle alarmHidden"></div>
			<img src="/images/bell.png" alt="alarmBell">
		</div>
		
		<div class="alarmCon alarmHidden">
			<ul class="list">
			</ul>
		</div>
	</div>
<% } %>
</body>
</html>