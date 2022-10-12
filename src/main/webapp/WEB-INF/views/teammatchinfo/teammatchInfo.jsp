<%@page import="java.util.List"%>
<%@page import="teammatch.TeamMatchDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.LocalDateTime"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브 > 경기 정보</title>

<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/teammatch_info.css" rel="stylesheet" />
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		AOS.init();

		// 매치 수락 or 취소 날짜
		const now = new Date();
		const alarmDate = now.getFullYear() + "." + ("0" + (now.getMonth() + 1)).slice(-2) + "." + ("0" + (now.getDate())).slice(-2);

		// 1. 수락을 기다리는 경기 > 수락하기 버튼

		for (let i = 1; i < 100; i++) {

			var acceptance_btn = 'acceptance_btn' + i;

			$("#" + acceptance_btn).on("click", function() {
				var update = confirm("매치를 수락하시겠습니까 ?");
				if (update) {
					$.ajax({
						url : 'teammatchAcceptance',
						data : {'seq' : $("#teammatchlist1_seq" + i).val(), 'alarmDate': alarmDate, 'teamName': $("#teamName").val()},
						type : 'post',
						dataType : 'json',
						success : function(data) {
							alert(data.result);
							location.href = "teammatchpage?myTeamName=" + $("#teamName").val();
						}
					});
				} 
				else {
					alert("매치 수락을 취소하셨습니다.");
				}
			}) 	
		}	// acceptance_btn end	

		
		// 2. 등록한 경기 > 취소하기 버튼
		
		for (let i = 1; i < 100; i++) {
			var delete_registration_btn = 'delete_registration_btn' + i;
			
			$("#" + delete_registration_btn).on("click", function() {
				var update = confirm("매치를 취소하시겠습니까 ?");
				if (update) {
					$.ajax({
						url : 'deleteTeammatchRegistration',
						data : {'seq' : $("#teammatchlist2_seq" + i).val(), 'teamName': $("#teamName").val()},
						type : 'post',
						dataType : 'json',
						success : function(data) {
							alert(data.result);
							location.href = "teammatchpage?myTeamName=" + $("#teamName").val();
						}
					});
				} 
				else {
					alert("매치를 취소하지 않습니다.");
				}
			}) 	
		}	// delete_registration_btn end

		
		// 3. 신청한 경기 > 취소하기 버튼

		for (let i = 1; i < 100; i++) {
			var delete_add_btn = 'delete_add_btn' + i;

			$("#" + delete_add_btn).on("click", function() {

				var update = confirm("매치를 취소하시겠습니까 ?");
				if (update) {
					$.ajax({
						url : 'deleteAddTeammatch',
						data : {'seq' : $("#teammatchlist3_seq" + i).val(), 'alarmDate': alarmDate, 'cancleTeam': "${loginInfo.getName()}", 'teamName': $("#teamName").val()},
						type : 'post',
						dataType : 'json',
						success : function(data) {
							alert(data.result);
							location.href = "teammatchpage?myTeamName=" + $("#teamName").val();
						}
					});
				} 
				else {
					alert("매치를 취소하지 않습니다.");
				}
			}) 	
		}	// delete_registration_btn end	
		

		// 4. 예정된 경기 > 취소하기 버튼
		
		for (let i = 1; i < 100; i++) {
			
			var cancel_teammatch_btn = 'cancel_teammatch_btn' + i;
			
			$("#" + cancel_teammatch_btn).on("click", function() {
				var update = confirm("매치를 취소하시겠습니까 ?");
				if (update) {
					$.ajax({
						url : 'cancelTeammatch',
						data : {'seq' : $("#teammatchlist4_seq" + i).val(), 'alarmDate': alarmDate, 'cancleTeam': "${loginInfo.getName()}", 'teamName': $("#teamName").val()},
						type : 'post',
						dataType : 'json',
						success : function(data) {
							alert(data.result);
							location.href = "teammatchpage?myTeamName=" + $("#teamName").val();
						}
					});
				} 
				else {
					alert("매치를 취소하지 않습니다.");
				}
			})
		} // cancel_teammatch_btn	
		
		// 6. 승패 선택 버튼
		
			for (let i = 1; i < 100; i++) {
			
			var select_winner_btn = 'select_winner_btn' + i;
			
			$("#" + select_winner_btn).on("click", function() {
				var url = 'selectWinner?seq=' +  $("#teammatchlist6_seq" + i).val() + '&myTeam=' + $("#teamName").val() + '&team1=' + $("#teammatchlist6_homeName" + i).val() + '&team2=' + $("#teammatchlist6_awayName" + i).val() ;
				window.open(url, '승패 선택', "width=330, height=420");	
			})
		} // select_winner_btn	
		
		

		// 만약 경기 정보가 하나도 없는 섹터는 보이지 않도록 하기

		if ($("#teammatch__info_list1").length) {
			$(".teammatchlist1_box").show();
		} 
		else {
			$(".teammatchlist1_box").hide();
		}

		if ($("#teammatch__info_list2").length) {
			$(".teammatchlist2_box").show();
		}
		else {
			$(".teammatchlist2_box").hide();
		}

		if ($("#teammatch__info_list3").length) {
			$(".teammatchlist3_box").show();
		} 
		else {
			$(".teammatchlist3_box").hide();
		}

		if ($("#teammatch__info_list4").length) {
			$(".teammatchlist4_box").show();
		}
		else {
			$(".teammatchlist4_box").hide();
		}

		if ($("#teammatch__info_list5").length) {
			$(".teammatchlist5_box").show();
		} 
		else {
			$(".teammatchlist5_box").hide();
		}
		if ($("#teammatch__info_list6").length) {
			$(".teammatchlist6_box").show();
		} 
		else {
			$(".teammatchlist6_box").hide();
		}
		
}); // ready end

</script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	
	<div class="topMatchInfo">
		<img alt="matchIfoImg" src="/images/vs.jpg">
 	</div>
 	
	<div class="confix">

		<%
		// 현재 시간과 날짜 구하기 (시간이 지난 경기 정보는 보이지 않도록 하기 위해 필요한 정보)

		LocalDateTime now = LocalDateTime.now();

		int year = now.getYear();
		int month = now.getMonthValue();
		int day = now.getDayOfMonth();

		int hour = now.getHour();
		
		String time= "";
		
		if (hour < 10) {
			time = "0" + hour + ":00";
		}
		else {
			time = hour + ":00";
		}

		String today = year + "." + month + "." + day;
		%>

		<!-- 현재 시간과 날짜 -->

		<c:set value="<%=today%>" var="today" />
		<c:set value="<%=today.length()%>" var="todayLen" />
		<c:set value="<%=time%>" var="time" />

		<!-- 자신의 팀 저장해두기 -->
		
		<input type="hidden" id="teamName" value=${loginInfo.getTeamName()}> 
		
		<!-- 1. 수락을 기다리는 경기 -->

		<div class="teammatchlist1_box" data-aos="fade-up"
			data-aos-duration="1000">

			<h2>수락을 기다리는 경기</h2>

			<c:forEach items="${teammatchlist1}" var="list">
				
				<c:set value="${list.possibleDate}" var="possibleDate" />
				<c:set value="${list.possibleTime}" var="possibleTime" />
				
				
				<!-- 날짜와 시간이 지나지 않은 경기만 보여준다. -->

				<c:if
					test="${(possibleDate > today and possibleDateLen >= todayLen)  or (possibleDate == today and possibleTime >= time)}"> 

					<div class="teammatch_info_list" id="teammatch__info_list1">
						<div class="teammatch_info">
							<div class="teammatch_info_title">${list.homeName} VS
								${list.awayName}</div> <div class="teammatch_info_date">${list.possibleDate}
								${list.possibleTime}</div> <div class="teammatch_info_location">${list.region}
								${list.homePlace}</div>
						</div>
						<div class="teammatch_info_btn">
							<c:set var="a" value="${a+1}" />
							<input type="button" class="btn" id="acceptance_btn${a}"
								value="수락하기">
						</div>
						<input type="hidden" id="teammatchlist1_seq${a}" value=${list.seq}>
					</div>
					</c:if>

				<!-- 해당 경기 정보 seq를 저장 -->
			</c:forEach>
		</div>


		<!-- 2. 등록한 경기 -->

		<div class="teammatchlist2_box" data-aos="fade-up"
			data-aos-duration="1000">

				<h2>등록한 경기</h2>	

			<c:forEach items="${teammatchlist2}" var="list">
	
				<c:set value="${list.possibleDate}" var="possibleDate" />
				<c:set value="${list.possibleDate.length()}" var="possibleDateLen" />
				<c:set value="${list.possibleTime}" var="possibleTime" />
			
	
				<!-- 날짜와 시간이 지나지 않은 경기만 보여준다. -->

				<c:if
					test="${(possibleDate > today and possibleDateLen >= todayLen)  or (possibleDate == today and possibleTime >= time)}">	
			
					<div class="teammatch_info_list" id="teammatch__info_list2">
						<div class="teammatch_info">
							<div class="teammatch_info_title">${list.homeName} VS &nbsp;  ?
								${list.awayName}</div> <div class="teammatch_info_date">${list.possibleDate}
								${list.possibleTime}</div> <div class="teammatch_info_location">${list.region}
								${list.homePlace}</div>
						</div>
						<div class="teammatch_info_btn">
							<c:set var="b" value="${b+1}" />
							<input type="button" class="btn" id="delete_registration_btn${b}"
								value="취소하기">
						</div>
						<input type="hidden" id="teammatchlist2_seq${b}" value=${list.seq}>
					</div>
				</c:if>

			</c:forEach>
		</div>


		<!-- 3. 신청한 경기 -->

		<div class="teammatchlist3_box" data-aos="fade-up"
			data-aos-duration="1000">

			<h2>신청한 경기</h2>

			<c:forEach items="${teammatchlist3}" var="list">

				<c:set value="${list.possibleDate}" var="possibleDate" />
				<c:set value="${list.possibleTime}" var="possibleTime" />

				<!-- 날짜와 시간이 지나지 않은 경기만 보여준다. -->

				<c:if
					test="${(possibleDate > today and possibleDateLen >= todayLen)  or (possibleDate == today and possibleTime >= time)}">

					<div class="teammatch_info_list" id="teammatch__info_list3">
						<div class="teammatch_info">
							<div class="teammatch_info_title">${list.homeName} VS
								${list.awayName}</div> <div class="teammatch_info_date">${list.possibleDate}
								${list.possibleTime}</div> <div class="teammatch_info_location">${list.region}
								${list.homePlace}</div>
						</div>
						<div class="teammatch_info_btn">
							<c:set var="c" value="${c+1}" />
							<input type="button" class="btn" id="delete_add_btn${c}" value="취소하기">
						</div>
						<input type="hidden" id="teammatchlist3_seq${c}" value=${list.seq}>
					</div>

				</c:if>


			</c:forEach>
		</div>


		<!-- 4. 예정된 경기 -->

		<div class="teammatchlist4_box" data-aos="fade-up"
			data-aos-duration="1000" >

			<h2>예정된 경기</h2>

			<c:forEach items="${teammatchlist4}" var="list">

				<c:set value="${list.possibleDate}" var="possibleDate" />
				<c:set value="${list.possibleTime}" var="possibleTime" />

				<!-- 날짜와 시간이 지나지 않은 경기만 보여준다. -->

				<c:if
					test="${(possibleDate > today and possibleDateLen >= todayLen)  or (possibleDate == today and possibleTime >= time)}">
					
					<div class="teammatch_info_list" id="teammatch__info_list4">
						<div class="teammatch_info">
							<div class="teammatch_info_title">${list.homeName} VS
								${list.awayName}</div> <div class="teammatch_info_date">${list.possibleDate}
								${list.possibleTime}</div> <div class="teammatch_info_location">${list.region}
								${list.homePlace}</div>
						</div>
						<div class="teammatch_info_btn">
							<c:set var="d" value="${d+1}" />
							<input type="button" class="btn" id="cancel_teammatch_btn${d}"
								value="취소하기">
						</div>
					</div>

				</c:if>

				<input type="hidden" id="teammatchlist4_seq${d}" value=${list.seq}>
			</c:forEach>
		</div>


		<!-- 5. 지난 경기 -->

		<div class="teammatchlist5_box" data-aos="fade-up"
			data-aos-duration="1000">

			<h2>지난 경기</h2>
			

			<c:forEach items="${teammatchlist5}" var="list">

				<c:set value="${list.possibleDate}" var="possibleDate" />
				<c:set value="${list.possibleTime}" var="possibleTime" />

					<div class="teammatch_info_list" id="teammatch__info_list5">
						<div class="teammatch_info">
							<span class="teammatch_info_title">${list.winner} VS
								${list.loser}</span> <span class="teammatch_info_date">${list.possibleDate}
								${list.possibleTime}</span> <span class="teammatch_info_location">${list.region}
								${list.homePlace}</span>
						</div>
					</div>

				<input type="hidden" class="teammatchlist5_seq" value=${list.seq}>
			</c:forEach>
		</div>
		
		<!-- 6. 승패 선택 -->

		<div class="teammatchlist6_box" data-aos="fade-up"
			data-aos-duration="1000" >

			<h2>승패 선택</h2>

			<c:forEach items="${teammatchlist4}" var="list">

				<c:set value="${list.possibleDate}" var="possibleDate" />
				<c:set value="${list.possibleTime}" var="possibleTime" />

				<!-- 날짜와 시간이 지난 경기만 보여준다. -->

				<c:if
					test="${(possibleDate < today and possibleDateLen < todayLen)  or (possibleDate == today and possibleTime < time)}">
					
					<div class="teammatch_info_list" id="teammatch__info_list6">
						<div class="teammatch_info">
							<div class="teammatch_info_title">${list.homeName} VS
								${list.awayName}</div> <div class="teammatch_info_date">${list.possibleDate}
								${list.possibleTime}</div> <div class="teammatch_info_location">${list.region}
								${list.homePlace}</div>
						</div>
						<div class="teammatch_info_btn">
							<c:set var="e" value="${e+1}" />
							<input type="button" class="btn" id="select_winner_btn${e}"
								value="승패 선택">
						</div>
					</div>

				</c:if>

				<input type="hidden" id="teammatchlist6_seq${e}" value=${list.seq}>
				<input type="hidden" id="teammatchlist6_homeName${e}" value=${list.homeName}>
				<input type="hidden" id="teammatchlist6_awayName${e}" value=${list.awayName}>
			</c:forEach>
		</div>
		
		
		<div class="finish"></div>
		
		<!-- 자신의 팀 저장해두기 -->
		
		<input type="hidden" id="teamName" value=${loginInfo.getTeamName()}> 

	</div>

	<jsp:include page="/WEB-INF/views/components/footer.jsp" />

</body>
</html>