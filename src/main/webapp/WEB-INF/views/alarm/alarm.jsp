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
			for(let i=0; i< res.length; i++) {
				if (res[i].checked == 1) {
					$(".list").prepend(
						"<li class='li clicked'>"
						+	"<span id='alarmSeq' style='display:none;'>" + res[i].seq + "</span>"
						+	"<p>["+ res[i].homePlace +"] <strong>" + res[i].awayName + "</strong> 팀이 매칭 신청을 하였습니다.</p>"
						+	"<span>" + res[i].alarmDate + "</span>"
						+"</li>"
					)
				} else if (res[i].checked == 0) {
					$(".list").prepend(
						"<li class='li'>"
						+	"<span id='alarmSeq' style='display:none;'>" + res[i].seq + "</span>"
						+	"<p>["+ res[i].homePlace +"] <strong>" + res[i].awayName + "</strong> 팀이 매칭 신청을 하였습니다.</p>"
						+	"<span>" + res[i].alarmDate + "</span>"
						+"</li>"
					)
				}
			}
			
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
		location.href = "teammatchpage?myTeamName=${loginInfo.getName()}";
		
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