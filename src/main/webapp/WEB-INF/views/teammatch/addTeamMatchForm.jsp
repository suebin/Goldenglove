<%@page import="soldier.SoldierDTO"%>
<%@page import="java.util.List"%>
<%@page import="user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>골든글러브 > 매치 신청</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/card.css" rel="stylesheet" />
<link href="/css/teamPage.css" rel="stylesheet" />
<link href="/css/teammatch_registration.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<style>
	.matchRegistrationForm {
		margin: 30px 0;
		text-align: center;
	}
</style>
<script>
$(document).ready(function() {
	// 선택하기 버튼
	
	for (let i = 1; i < 100; i++) {
		
		$('#selectedBtn_box'+ i).hide();
		
		var selectBtn = 'selectBtn' + i;
		var name="";
		
		$("#" + selectBtn).on("click", function() {
			
			if(name == "") {name = $("#name" + i).val();}
			else {name += $("#name" + i).val();}
			
			$('input.awayPerson').attr('value', name);
			
			$('#selectBtn_box' + i).hide();
			$('#selectedBtn_box' + i).show();
			
			$('div#card' + i).css('border', '7px solid #00912e');
			
		}) 	
	}	// selectBtn end
	
	// 선택 취소하기 버튼
	
	for (let i = 1; i < 100; i++) {

		var selectedBtn = 'selectedBtn' + i;
		var name="";
		
		$("#" + selectedBtn).on("click", function() {
			
			var start = $('input.awayPerson').val().indexOf($("#name" + i).val());
			var end = start + $("#name" + i).val().length;
			
			name = $('input.awayPerson').val().substr(0, start) + $('input.awayPerson').val().substr(end);
			
			$('input.awayPerson').attr('value', name);
			
			$('#selectBtn_box' + i).show();
			$('#selectedBtn_box' + i).hide();
			
			$('div#card' + i).css('border', '3px solid var(--point-color)');
			
			
		}) 	
	}	// selectedBtn end
	
	
	// 카드
	
	const r = {
			1 : "--color: hsl(36, 100%, 50%);",		
			2 : "--color:hsl(237, 63%, 19%);",		
			3 : "--color: hsl(357, 100%, 49%);",
			4 : "--color: hsl(172, 94%, 21%);"
		}
		const medal = {
				1 : "images/gold-medal.png",
			2 : "images/silver-medal.png",			
				3 : "images/bronze-medal.png",			
				4 : "images/baseball.png",
		}
		
		$(".defaultCard .medalImg").attr("src", medal["4"]);
		$(".defaultCard .cardCon").attr("style", r["4"]);
		
		$.ajax({
			url : "tierResult",
			data : {"name" : $(".profile-name").html()},
			dataType : "json",
			success : function(server) {
				$(".teamCard .cardCon").attr("style", r[server]);
				$(".teamCard .medalImg").attr("src", medal[server]);
			}
		})	
		
		$(".modalLink").on("click",function() {
			$.ajax({
				url : "modalResult",
				data : {"name" : $(this).find(".profile-name").html()},
				dataType : "json",
				success : function(server) {
					$(".modalName").html(server.name);
					$(".modalPhone").html(server.phone);
					$(".modalEmail").html(server.email);
					$(".modalRegion").html(server.region);
					let modalPosition = server.position;
					switch (server.position) {
					case "firstBase":
						modalPosition = "1루수";
						break;
					case "secondBase":
						modalPosition = "2루수";
						break;
					case "thirdBase":
						modalPosition = "3루수";
						break;
					case "catcher":
						modalPosition = "포수";
						break;
					case "pitcher":
						modalPosition = "투수";
						break;
					case "leftFielder":
						modalPosition = "좌익수";
						break;
					case "rightFielder":
						modalPosition = "우익수";
						break;
					case "centerFielder":
						modalPosition = "중견수";
						break;
					case "shortStop":
						modalPosition = "유격수";
						break;
					}
					$(".position").html(modalPosition);
					}
				})
			})
			
			// 용병 리스트가 없는 경우
			
		
			if($(".soldierCard").text() == "") {
				$(".none_soldier_box").append('<div class="none_soldier"><img src="/images/cautionIcon.png"/><span>해당 날짜에 가능한 용병은 없습니다</span></div>');
			}
	
}); // ready end
</script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	
	<div class="confix">
		<div class="teammatch_registration_title">팀 매칭 신청</div>
		<div class="teammatch_registration_notice">
			<h2>Step 1</h2>
			<span>이번 경기에 출전할 우리 팀 선수를 선택해주세요</span>
		</div>
	<div class="cardBox teamCard">
			<%
				UserDTO[] all = (UserDTO[])request.getAttribute("allMember");
				for(int i = 0;i < all.length;i++) {
					request.setAttribute("user", all[i]);%>				
					
					<c:set var="a" value="${a+1}" />
					<div class="card" id="card${a}">
						<jsp:include page="/WEB-INF/views/components/card.jsp"/>
						
						<div  class="selectBtn_box" id="selectBtn_box${a}">
							<button class="selectBtn" id="selectBtn${a}">선택하기</button>
							<input type="hidden" id="name${a}" value="<%= all[i].getName() %>,"> 
						</div>
						
						<div class="selectedBtn_box" id="selectedBtn_box${a}">
							<button class="selectedBtn" id="selectedBtn${a}">선택 취소하기</button>
						</div>
					</div>	
				<%}				
			%>
		</div>
		
		<div class="teammatch_registration_notice">
			<h2>Step 2</h2>
			<span>이번 경기에 출전할 용병 선수를 선택해주세요.</span>
		</div>
		
		<div class="cardBox defaultCard">
			<%
				List<SoldierDTO> soldierList = (List<SoldierDTO>)request.getAttribute("soldierList");
			
				if (soldierList.size() != 0) {
			
				for(SoldierDTO dto :soldierList) { %>				
					
					<c:set var="a" value="${a+1}" />
					<div class="card soldierCard" id="card${a}">
						<div id="ex1" class="modal" style="z-index:1000;">	
							<ul class="modalCon">
								<li><span>이름 </span><span class="modalName"></span></li>
								<li><span>연락처 </span><span class="modalPhone"></span></li>
								<li><span>이메일 </span><span class="modalEmail"></span></li>
								<li><span>지역 </span><span class="modalRegion"></span></li>
								<li><span>포지션 </span><span class="position"></span></li>
							</ul>
						<div class="a">
							<a href="#" rel="modal:close">Close</a>
						</div>
						</div>
						<a class="modalLink" href="#ex1" rel="modal:open">
							<div class="cardCon">
							<div class="card__border"></div>
							<div class="card__border-line"></div>
							<div class="profile-card-6">
								<div class="card__img">
									<div class="img__team"><img class="medalImg" alt="rankingImg"></div>
									<div class="img__athlete">
										<div class="img__Wrapper">
											<img src="img/<%= dto.getFileName() %>" class="img img-responsive">
										</div>
									</div>
								</div>
							<div class="card__text">
								<div class="profile-position" style="--bg-color: hsl(1, 100%, 44%); --text-color: hsl(0, 0%, 100%);"><%= dto.getPosition() %></div>
								<div class="profile-name"><%= dto.getSoldierName()  %></div>
								<div class="profile-overview">'
									<div><h3 class="soldier_winCount"><%= dto.getWinCount() %></h3><p>승</p></div>
									<div><h3 class="soldier_loseCount"><%= dto.getLoseCount() %></h3><p>패</p></div>
									<div><h3 class="soldier_winningRate"><%= dto.getWinningRate() %></h3><p></p></div>
								</div>
							</div>
							
							</div>
							</div>
						</a>
							
						<div class="soldierPossibleDate"><span>⌚ <%= dto.getPossibleDate() %></span></div>

						
						<div  class="selectBtn_box" id="selectBtn_box${a}">
							<button class="selectBtn" id="selectBtn${a}">선택하기</button>
							<input type="hidden" id="name${a}" value="<%= dto.getSoldierName() %>,"> 
						</div>
						
						<div class="selectedBtn_box" id="selectedBtn_box${a}">
							<button class="selectedBtn" id="selectedBtn${a}">선택 취소하기</button>
						</div>
					</div>	
				<%}	
				}
			%>
		</div>
		
		<div class="none_soldier_box"></div>	
		
		
		<!-- 매치 신청 폼 -->
		<form class="matchRegistrationForm" action="addTeammatch" method="post">
			<input type="hidden" name="awayName" value=${param.awayName}>
			<input type="hidden" name="seq" value=${param.seq}>
			<input type="hidden" name="homeName" value=${param.homeName}>
			<input type="hidden" name="region" value=${param.region}>
			<input type="hidden" name="possibleDate" value=${param.possibleDate}>
			<input type="hidden" name="possibleTime" value=${param.possibleTime}>
			<input type="hidden" name="homePlace" value=${param.homePlace}>
			<input type="hidden" name="alarmDate" value=${param.alarmDate}>
			<input type="hidden" name="awayPerson" class="awayPerson" value="">
			<input type="submit" value="매치 신청하기">
		</form>
		
	
	
	</div>
	
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>