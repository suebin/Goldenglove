<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>골든글러브 > 용병 구하기</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/card.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/soldier.css" rel="stylesheet" />

<!-- flatpickr (날짜 선택하는 라이브러리) -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css"
	href="https://npmcdn.com/flatpickr/dist/themes/confetti.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script src="js/jquery-3.6.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<script>
$(document).ready(function() {

	// 용병 검색 form > 날짜 선택

	var dateSelector = document.querySelector('#dateSelector');
	dateSelector.flatpickr({
		dateFormat : "Y년 m월 d일"
	});

	// 용병 검색 > 리스트

	$(".searchSoldierBtn").on("click", function() {
		$.ajax({
			url : 'getSoldier',
			data : {'region' : $("#regionSelector").val(),'position' : $("#positionSelector").val(),'possibleDate' : $("#dateSelector").val()},
			type : 'post',
			dataType : 'json',
			success : function(list) {
				document.querySelector('.cardBox').innerHTML = '';
				//document.querySelector('.none_cardBox').innerHTML = '';

				// 용병 리스트가 있는 경우

				if (list.length != 0) {
					for (var i = 0; i < list.length; i++) {
						$('.cardBox').append(
							'<div class="card">'
									+ '<div id="ex1" class="modal" style="z-index:1000;">'
									+ '<ul class="modalCon">'
									+ '<li><span>이름 </span><span class="modalName"></span></li>'
									+ '<li><span>연락처 </span><span class="modalPhone"></span></li>'
									+ '<li><span>이메일 </span><span class="modalEmail"></span></li>'
									+ '<li><span>지역 </span><span class="modalRegion"></span></li>'
									+ '<li><span>포지션 </span><span class="position"></span></li>'
									+ '</ul>'
									+ '<div class="a">'
									+ '<a href="#" rel="modal:close">Close</a>'
									+ '</div>'
									+ '</div>'
									+ '<a class="modalLink" href="#ex1" rel="modal:open">'
									+ '<div class="cardCon">'
									+ '<div class="card__border"></div>'
									+ '<div class="card__border-line"></div>'
									+ '<div class="profile-card-6">'
									+ '<div class="card__img">'
									+ '<div class="img__team">'
									+ '<img class="medalImg" alt="rankingImg">'
									+ '</div>'
									+ '<div class="img__athlete">'
									+ '<div class="img__Wrapper">'
									+ '<img src="img/' +list[i].fileName + '" class="img img-responsive">'
									+ '</div>'
									+ '</div>'
									+ '</div>'
									+ '<div class="card__text">'
									+ '<div class="profile-position" style="--bg-color: hsl(1, 100%, 44%); --text-color: hsl(0, 0%, 100%);">'
									+ list[i].position
									+ '</div>'
									+ '<div class="profile-name">'
									+ list[i].soldierName
									+ '</div>'
									+ '<div class="profile-overview">'
									+ '<div><h3 class="soldier_winCount">'
									+ list[i].winCount
									+ '</h3><p>승</p></div>'
									+ '<div><h3 class="soldier_loseCount">'
									+ list[i].loseCount
									+ '</h3><p>패</p></div>'
									+ '<div><h3 class="soldier_winningRate">'
									+ list[i].winningRate.toFixed(3)
									+ '</h3><p></p></div>'
									+ '</div></div></div></div></a>'
									+ '<div class="possibleDate"><span>⌚ '
									+ list[i].possibleDate
									+ '</span></div>'
									+ '<div class="addSoldierBtn_box"><input type="button" class="addSoldier_btn" id="addSoldier_btn' + i + '" value="스카우트 하기"></div></div>'
									+ '<input type="hidden" id="soldier_seq' + i + '" value="' + list[i].seq + '">'
									+ '<input type="hidden" id="soldier_teamName' + i + '" value="' + list[i].teamName + '">')

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

						$(".defaultCard .medalImg").attr("src",medal["4"]);
						$(".defaultCard .cardCon").attr("style",r["4"]);

						$.ajax({
							url : "tierResult",
							data : {"name" : $(".profile-name").html()},
							dataType : "json",
							success : function(server) {
								$(".teamCard .cardCon").attr("style",r[server]);
								$(".teamCard .medalImg").attr("src",medal[server]);
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
					}
				}

				// 용병 리스트가 없는 경우

				else {
					alert('해당 날짜에 등록된 용병이 없습니다.');
					location.reload();

				}

				// 스카우트 하기 버튼

				for (let i = 0; i < 100; i++) {
					
					var addSoldier_btn = 'addSoldier_btn'+ i;

					$("#" + addSoldier_btn).on("click", function() {
						
						// 로그인을 하지 않은 경우

						if ($(".dropdownBtn").text() == "") {
							alert("로그인이 필요한 서비스입니다.");
						}

						// 로그인을 한 경우

						else {
							var update = confirm("용병에게 스카우트를 제의하시겠습니까 ?");
							if (update) {

								$.ajax({
									url : 'addSoldier',
									data : {'seq' : $("#soldier_seq" + i).val(),'soldierTeamName' : $("#soldier_teamName" + i).val(), 'soldierName' : $(this).parent().parent().find(".profile-name").html()},
									type : 'post',
									dataType : 'json',
									success : function(data) {
										alert(data.result);
									}
								});
							} else {
								alert("용병 스카우트를 취소하셨습니다.");
							}

						}

					})
				} // addSoldier_btn end	

			} // success end

		}); // ajax end

	}) // searchSoldierBtn end

	// default card

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
		data : {
			"name" : $(".profile-name").html()
		},
		dataType : "json",
		success : function(server) {
			$(".teamCard .cardCon").attr("style", r[server]);
			$(".teamCard .medalImg").attr("src", medal[server]);
		}
	})

	$(".modalLink").on("click", function() {
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

	// 용병 등록 작은 창

	$(".registerSoldierBtn").on("click",function() {
		if ($(".dropdownBtn").text() == "") {
			alert("로그인이 필요한 서비스입니다.");
		} else {
			window.open('registerSoldier', '용병 등록', "width=330, height=460"
					+ ", left = " + Math.ceil(( window.screen.width - 330 )/2)
					+ ", top = " + Math.ceil(( window.screen.height - 460 )/2));
		}
	})

	// 용병 로그 작은 창

	$(".soldierLogBtn").on("click", function() {
		if ($(".dropdownBtn").text() == "") {
			alert("로그인이 필요한 서비스입니다.");
		} else {
			window.open('soldierLog', '용병 로그', "width=500, height=600"
					+ ", left = " + Math.ceil(( window.screen.width - 500 )/2) 
					+ ", top = " + Math.ceil(( window.screen.height - 650 )/2));
		}
	})

	
 	// 스카우트 하기 버튼
	for (let i = 0; i < 100; i++) {
		var addSoldier_btn = 'addSoldier_btn' + i;
		
		$("#" + addSoldier_btn).on("click", function() {
			
			// 로그인을 하지 않은 경우
			
			if ($(".dropdownBtn").text() == "") {alert("로그인이 필요한 서비스입니다.");}
			
			// 로그인을 한 경우
			
			else {
				var update = confirm("용병에게 스카우트를 제의하시겠습니까 ?");
				
				if (update) {
					$.ajax({
						url : 'addSoldier',
						data : {'seq' : $("#soldier_seq" + i).val(),'soldierTeamName' : $("#soldier_teamName" + i).val(), 'soldierName' : $(this).parent().parent().find(".profile-name").html()},
						type : 'post',
						dataType : 'json',
						success : function(data) {
							alert(data.result);
						}
					});
				} else {
					alert("용병 스카우트를 취소하셨습니다.");
				}
			}
		})
	} // addSoldier_btn end	 
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />

	<div class="getSoldier">
		<img src="/images/getSoldier.jpg" />

		<div class="confix intro">
			<h1>Scout for your team</h1>
			<span>용병을 구해 강력한 팀을 만들어보세요!</span>
		</div>
	</div>


	<div class="confix">
	
<%

		 // 현재 날짜 구하기        
		LocalDate now = LocalDate.now();        
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");        
		String formatedNow = now.format(formatter);

%>	
		<c:set value="<%=formatedNow%>" var="today" />
	
		<div class="getSoldierTitle">
			<h2>Search your player</h2>
			<span>원하는 날짜에 용병 등록 및 스카우트가 가능합니다.</span>
		</div>

		<!-- 용병 검색 form -->

		<div class="soldier_boxes">
			<div class="soldier_box">
				<form action="getSoldier" method="post" id="searchSoldierForm">

					<select name="region" id="regionSelector">
						<option selected>지역 전체</option>
						<option>강원도</option>
						<option>광주광역시</option>
						<option>경기도</option>
						<option>경상남도</option>
						<option>경상북도</option>
						<option>대구광역시</option>
						<option>대전광역시</option>
						<option>부산광역시</option>
						<option>서울특별시</option>
						<option>세종특별자치시</option>
						<option>인천광역시</option>
						<option>울산광역시</option>
						<option>전라남도</option>
						<option>전라북도</option>
						<option>제주특별자치도</option>
						<option>충청남도</option>
						<option>충청북도</option>
					</select> <select name="position" id="positionSelector">
						<option selected>포지션 전체</option>
						<option>1루수</option>
						<option>2루수</option>
						<option>3루수</option>
						<option>포수</option>
						<option>투수</option>
						<option>좌익수</option>
						<option>우익수</option>
						<option>중견수</option>
						<option>유격수</option>
					</select> <input name="possibleDate" id="dateSelector" placeholder="날짜" />
					<input type="button" class="searchSoldierBtn" value="용병 검색"
						style="border: none;" />
				</form>
			</div>


			<!-- 용병 등록 -->
			<div class="soldier_box">
				<button class="registerSoldierBtn">
					<img class="plusIcon" src="/images/plusIcon.png" /><span>용병 등록</span>
				</button>
				<button class="soldierLogBtn">
					<img class="baseballIcon" src="/images/baseball.png" /><span>용병 로그</span>
				</button>
			</div>

		</div>

		<!-- 용병 로그 -->


		<!-- 용병 리스트 -->

		<div class="cardBox defaultCard cardContainer">
			<% UserDTO user = (UserDTO)session.getAttribute("defaultlist"); %> 
			<c:forEach items="${defaultList}" var="list">
			<c:set value="${list.possibleDate}" var="possibleDate" />	
			<c:set var="b" value="${b+1}" />
			<c:if test="${possibleDate >= today}">  
				<div class="card">
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
					<div class="img__team">
					<img class="medalImg" alt="rankingImg">
					</div>
					<div class="img__athlete">
					<div class="img__Wrapper">
					<img src="img/${list.fileName}" class="img img-responsive">
					</div>
					</div>
					</div>
					<div class="card__text">
					<div class="profile-position" style="--bg-color: hsl(1, 100%, 44%); --text-color: hsl(0, 0%, 100%);">${list.position}</div>
					<div class="profile-name">${list.soldierName}</div>
					<div class="profile-overview">
					<div><h3 class="soldier_winCount">${list.winCount}</h3><p>승</p></div>
					<div><h3 class="soldier_loseCount">
					${list.loseCount}
					</h3><p>패</p></div>
					<div><h3 class="soldier_winningRate">
					<fmt:formatNumber value="${list.winningRate}" pattern="0.000"/><br/>
					</h3><p></p></div>
					</div></div></div></div></a>
					<div class="possibleDate"><span>⌚ 
					${list.possibleDate}
					</span></div>
					<div class="addSoldierBtn_box"><input type="button" class="addSoldier_btn" id="addSoldier_btn${b}" value="스카우트 하기"></div></div>
					<input type="hidden" id="soldier_seq${b}" value="${list.seq}">
					<input type="hidden" id="soldier_teamName${b}" value="${list.teamName}">
			</c:if>
			</c:forEach>
		</div>

		<div class="none_cardBox"></div>


	</div>


	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>