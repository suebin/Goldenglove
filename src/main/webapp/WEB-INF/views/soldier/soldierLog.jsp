<%@page import="soldier.SoldierDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브 > 용병 로그</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/soldierLog.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	if($(".myListDate").text() == "") {
		$(".none_myList").append('등록 내역이 없습니다');
	}
	if($(".mateTeamList1").text() == "") {
		$(".none_mateTeamList").append('제의 받은 내역이 없습니다');
	}
	

	// 수락하기 버튼

	for (let i = 1; i < 100; i++) {

		var mateTeamAceptanceBtn = 'mateTeamAceptanceBtn' + i;

		$("#" + mateTeamAceptanceBtn).on("click", function() {
			var update = confirm("스카우트 제의를 수락하시겠습니까 ?");
			if (update) {
				$.ajax({
					url : 'mateTeamAceptance',
					data : {'seq' : $("#mateTeamList_seq" + i).val(), 'mateTeam' : $("#mateTeamList_mateTeam" + i).val(), 'soldierName' : "${loginInfo.getName()}"},
					type : 'post',
					dataType : 'json',
					success : function(data) {
						alert(data.result);
						location.reload();
					}
				});
			} 
			else {
				alert("매치 수락을 취소하셨습니다.");
			}
		}) 	
	}	// acceptance_btn end
	

}); // ready end
</script>
</head>
<body>

<%
LocalDateTime now = LocalDateTime.now();
int year = now.getYear();
int month = now.getMonthValue();
int day = now.getDayOfMonth();	

String today = year + "년 " + month + "월 " + day + "일";
%>

<c:set value="<%=today%>" var="today" />

	<h2 class="title">용병 로그</h2>
	<div class="confix">
	<div class="small_title">
		<h3>스카우트 제의</h3>
		<span>해당 날짜에 출전할 수 있도록 스카우트 제의를 수락해주세요 !</span>
	</div>
	
	<!-- 스카우트 제의  -->
	<div>
		<%
		List<SoldierDTO> list2 = (List<SoldierDTO>)request.getAttribute("list2");
		
		for(SoldierDTO dto : list2) {
			
				String mateTeam = dto.getMateTeam();
				String mateTeamDate = dto.getPossibleDate();
				int seq = dto.getSeq();
				
				int myYear =  Integer.parseInt(mateTeamDate.substring(0, 4));
				int myMonth = Integer.parseInt(mateTeamDate.substring(6, 8));
				int myDay = Integer.parseInt(mateTeamDate.substring(10, 12));
				
				// 시간이 지나지 않은 리스트만 보여준다.
				
				if (myYear >= year && myMonth >= month && myDay >= day || myYear >= year && myMonth > month || myYear > year) {
				
				if (mateTeam != null) {
				
					mateTeam = mateTeam.substring(0, mateTeam.length()-1);
					String[] mateTeamArr = mateTeam.split(",");
					
					for (int i=0; i<mateTeamArr.length; i++) {				
					
					mateTeam = mateTeamArr[i]; %>
					
					<div class="mateTeamList">
						<div class="mateTeamList1">
							<div class="mateTeam"><%= mateTeam %></div>	
							<div class="mateTeam_possibleDate"><%= mateTeamDate %></div>
						</div>
						<div class="mateTeamList2">
							<c:set var="a" value="${a+1}" />
							<button class="mateTeamAceptanceBtn" id="mateTeamAceptanceBtn${a}">수락하기</button>
						</div>	
						<input type="hidden" id="mateTeamList_seq${a}" value=<%= seq %>>
						<input type="hidden" id="mateTeamList_mateTeam${a}" value=<%= mateTeam %>>
					</div>
			<% 		}
				}
				}
			}%>		
					
			<div class="none_mateTeamList"></div>
	</div>


	
	<div class="small_title">
	<h3>용병 등록 내역</h3>
	<span>날짜가 지나지 않은 등록 내역을 보여드립니다</span>
	</div>
	
	<!-- 용병 등록 날짜  -->
	
	<div>
	<c:forEach items="${list1}" var="list">
		
		<c:set value="${list.possibleDate}" var="possibleDate" />
	
		<c:if test="${possibleDate >= today}">		
		<div class="myList">
				<img class="calendarIcon" src="/images/calendarIcon.png" />
				<span class="myListDate">${list.possibleDate}</span>	
		</div>
		</c:if>
	</c:forEach>
	</div>
	
	<div class="none_myList"></div>
	

	</div>
</body>
</html>