<%@page import="user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">



<title>골든글러브 > 매치 등록</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/teamPage.css" rel="stylesheet" />
<link href="/css/teammatch_registration.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		
		// 팀 소개 글자수 85자 이하로 제한
		
		$("#comment").on('keyup', function() {
			$('#comment_cnt').html($(this).val().length + " / 85");
			
			if($(this).val().length > 85) {
				$(this).val($(this).val().substring(0, 85));
				$('#comment_cnt').html("85 / 85");
			}
		});
	}); // ready end
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<div class="teammatch_registration_title">팀 매칭 등록</div>
		<div class="teammatch_registration_notice">
			<h2>Step 1</h2>
			<span>이번 경기에 출전할 선수를 선택해주세요.</span>
		</div>
		
		<div class="cardBox teamCard">
			<%
				UserDTO[] all = (UserDTO[])request.getAttribute("allMember");
				for(int i = 0;i < all.length;i++) {
					request.setAttribute("user", all[i]);%>				
					<div class="card">
						<jsp:include page="/WEB-INF/views/components/card.jsp"/>
						
						<div class="leader">
							<span>Team Leader</span>
						</div>
					</div>	
				<%}				
			%>
		</div>
		
		<div class="teammatch_registration_notice">
			<h2>Step 2</h2>
			<span>등록 폼을 작성해주세요.</span>
		</div>
		
		<div class="teammatch_registration">
			
		<form action="registerTeammatch" method="post" id="registerTeammatchForm">
			
			<div class="teammatch_registration_elements"> 
				<div class="teammatch_registratioin_element">
					<div>팀 이름</div>
					<input type="text" name="homeName" value=${loginInfo.getTeamName()} readonly>
				</div>
				
				<div class="teammatch_registratioin_element">
					<div>날짜</div>
					<input type="text" name="possibleDate" value=${param.year_month}${param.date} readonly> 
				</div>
				
				<div class="teammatch_registratioin_element">
					<div>경기 장소</div>
					<input type="text" name="homePlace" id="homePlace" value="" required>
				</div>
				
				<div class="teammatch_registratioin_element">
					<div>팀 소개</div>
					<textarea cols="27" rows="4" name="comment" id="comment" value="" required></textarea>
					<div id="comment_cnt">0 / 85</div>
				</div>
			</div>

			<div class="teammatch_registration_elements">
				<div class="teammatch_registratioin_element">
					<div>지역</div>
					<input type="text" name="region" value=${param.region} readonly>
				</div>
			
				<div class="teammatch_registratioin_element">	
					<div>시간</div> 
					<select name="possibleTime" id="possibleTime" value="" required>
					<option>00:00</option>
					<option>01:00</option>
					<option>02:00</option>
					<option>03:00</option>
					<option>04:00</option>
					<option>05:00</option>
					<option>06:00</option>
					<option>07:00</option>
					<option>08:00</option>
					<option>09:00</option>
					<option>10:00</option>
					<option>11:00</option>
					<option selected>12:00</option>
					<option>13:00</option>
					<option>14:00</option>
					<option>15:00</option>
					<option>16:00</option>
					<option>17:00</option>
					<option>18:00</option>
					<option>18:00</option>
					<option>19:00</option>
					<option>20:00</option>
					<option>21:00</option>
					<option>22:00</option>
					<option>23:00</option>
					</select>
				</div>

				<div class="teammatch_registratioin_element">
					<div>팀원 수</div>
					<select name="headCount" id="headCount" value="" required>
					<option selected>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
					<option>6</option>
					<option>7</option>
					<option>8</option>
					<option>9</option>
					<option>10</option>
					<option>11</option>
					<option>12</option>
					<option>13</option>
					<option>14</option>
					<option>15</option>
					<option>16</option>
					<option>17</option>
					<option>18</option>
					<option>19</option>
					<option>20</option>
					<option>21</option>
					<option>22</option>
					<option>23</option>
					<option>24</option>
					<option>25</option>
					<option>26</option>
					<option>27</option>
					<option>28</option>
					<option>29</option>
					<option>30</option>
					</select>
				</div>
				
			</div>
			
		</form>
		</div>
		
		<div class="teammatch_registration_btn"> 
				<input type="submit" value="매치 등록">
		</div>

	
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>