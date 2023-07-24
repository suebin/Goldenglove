<%@page import="com.musamanru.goldenglove.user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/card.css" rel="stylesheet" />
<link href="/css/myPage.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script>
$(document).ready(function() {
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
	
	//모달 한개만
	$(document).on("click", ".modalLink${user.name }", function() {
		$(".jquery-modal").attr("hidden", "hidden");
		$("#ex1${user.name }").parent().removeAttr("hidden");
	})

});
</script>
</head>
<body>
<div id="ex1${user.name }" class="modal" style="z-index:1000;">
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
<div>
	<%
		String teamId = (String)request.getAttribute("teamId");
		UserDTO user = (UserDTO)request.getAttribute("user");
		String winning = String.format("%.3f", user.getWinningRate());
		String userId = user.getId();
		if(teamId != null && teamId.equals(userId)) {%>
			<p class="leaderCheck">⚾Team Leader</p>		
		<%}
	%>
	<a class="modalLink modalLink${user.name }" href="#ex1${user.name }" rel="modal:open">
		<div class="cardCon">
			<div class="card__border"></div>
			<div class="card__border-line"></div>
			<div class="profile-card-6">
				<div class="card__img">
			        <div class="img__team">
			            <img class="medalImg" alt="rankingImg">
			        </div>
			        <div class="img__athlete">
			        	<div class="img__Wrapper">
			            	<img src="img/${user.fileName }" class="img img-responsive">
			        	</div>
			        </div>
			    </div>
			    <div class="card__text">
			        <div class="profile-position" style="--bg-color: hsl(1, 100%, 44%); --text-color: hsl(0, 0%, 100%);">
			        	${user.position }
		        	</div>
			        <div class="profile-name">${user.name }</div>
			        <div class="profile-overview">
						<div>
							<h3>${user.winCount }</h3>
							<p>승</p>
						</div>
						<div>
							<h3>${user.loseCount }</h3>
							<p>패</p>
						</div>
						<div>
							<h3><%=winning %></h3>
						</div>
					</div>
			    </div>
			</div>
		</div>
	</a>
</div>
</body>
</html>