<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />

<title>골든글러브 > 팀 매칭</title>

<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/teammatch.css" rel="stylesheet" />

<!-- js -->
<script src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="js/teammatch.js"></script>
<script>
	$(document).ready(function() {

	}); // ready end
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />

	<div class="confix">
		<form method="get" name="match_search" id="match_search"
			action="/newsite/web/page.php#match_list" autocomplete="off">
			<input type="hidden" name="lang" value="korean"> <input
				type="hidden" name="pcode" value="11"> <input type="hidden"
				name="calendar_nyear" id="calendar_nyear" value="2022"> <input
				type="hidden" name="calendar_nmonth" id="calendar_nmonth" value="09">
			<input type="hidden" name="calendar_nday" id="calendar_nday" value="">

			<input type="hidden" name="local_value" id="local_value" value="">
			<input type="hidden" name="team_value" id="team_value" value="">
			<input type="hidden" name="age_value" id="age_value" value="">
			<input type="hidden" name="type_value" id="type_value" value="">
			<p class="top_count">
				(<b>3</b>경기가 등록되어 있습니다.)
			</p>



			<div class="match_info_wrap">
				<div class="lt">
					<p class="top">매치등록은 신중하게 작성하여 주시기 바랍니다.</p>
					<div class="match_option_wrap">

						<div class="option01">
							<p class="on cursor match_search_submit" id="local_all"
								data-id="">전체 지역</p>
							<ul>
								<li class="cursor select_local  match_search_submit"
									data-id="1/">서울</li>
								<li class="cursor select_local  match_search_submit"
									data-id="2/">경기</li>
								<li class="cursor select_local  match_search_submit"
									data-id="3/">강원</li>
								<li class="cursor select_local  match_search_submit"
									data-id="4/">충청</li>
								<li class="cursor select_local  match_search_submit"
									data-id="5/">전라</li>
								<li class="cursor select_local  match_search_submit"
									data-id="7/">제주</li>
								<li class="cursor select_local  match_search_submit"
									data-id="6/">경상</li>
							</ul>
						</div>
						<!--<div class="option02">
				<p class="on cursor match_search_submit" id="team_all" data-id="">전체 팀</p>
				<ul>
									<li class="cursor select_team  match_search_submit" data-id="청소년">청소년</li>
									<li class="cursor select_team  match_search_submit" data-id="대학생">대학생</li>
									<li class="cursor select_team  match_search_submit" data-id="직장인">직장인</li>
									<li class="cursor select_team  match_search_submit" data-id="일반동호회">일반동호회</li>
									<li class="cursor select_team  match_search_submit" data-id="여성팀">여성팀</li>
									<li class="cursor select_team  match_search_submit" data-id="기타단체">기타단체</li>
								</ul>
			</div>
			<div class="option03">
				<p class="on cursor match_search_submit" id="age_all" data-id="">전체 연령</p>
				<ul>
									<li class="cursor select_age  match_search_submit" data-id="10대">10대</li>
									<li class="cursor select_age  match_search_submit" data-id="20대">20대</li>
									<li class="cursor select_age  match_search_submit" data-id="30대">30대</li>
									<li class="cursor select_age  match_search_submit" data-id="40대">40대</li>
									<li class="cursor select_age  match_search_submit" data-id="50대">50대</li>
									<li class="cursor select_age  match_search_submit" data-id="60대이상">60대이상</li>
								</ul>
			</div>-->
						<div class="option04">
							<p class="on cursor match_search_submit" id="type_all" data-id="">전체
								경기</p>
							<ul>
								<li class="cursor select_type  match_search_submit" data-id="1">풋살</li>
								<li class="cursor select_type  match_search_submit" data-id="2">축구</li>
							</ul>
						</div>
					</div>
				</div>

				<div class="rt">
					<div class="match_table_title">
						<span class="prev month_back cursor" data-para=""><img
							src="http://www.baro-match.co.kr/newsite/web/korean/image/match/prev.png"></span>
						<span id="match_table_year">2022 년</span> <span
							id="match_table_month">09월</span> <span
							class="next month_forward cursor" data-para=""><img
							src="http://www.baro-match.co.kr/newsite/web/korean/image/match/next.png"></span>
					</div>
					<div class="match_table_content">
						<table class="match_table" summary="매치신청 달력">
							<caption>매치신청달력</caption>
							<colgroup>
								<col style="width: 14.28%;">
								<col style="width: 14.28%;">
								<col style="width: 14.28%;">
								<col style="width: 14.28%;">
								<col style="width: 14.28%;">
								<col style="width: 14.28%;">
								<col style="width: 14.28%;">
							</colgroup>
							<thead>
								<tr class="center">
									<th>SUN</th>
									<th>MON</th>
									<th>TUE</th>
									<th>WED</th>
									<th>THU</th>
									<th>FRI</th>
									<th>SAT</th>
								</tr>
							</thead>
							<tbody id="match_calendar">
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td class="select_day cursor match_search_submit" data-day="1"><p
											class="day">1</p>
										<p class="txt">1경기</p></td>
									<td class="select_day cursor match_search_submit" data-day="2"><p
											class="day">2</p></td>
									<td class="select_day cursor match_search_submit" data-day="3"><p
											class="day">3</p></td>
								</tr>
								<tr>
									<td class="select_day cursor match_search_submit" data-day="4"><p
											class="day">4</p></td>
									<td class="select_day cursor match_search_submit" data-day="5"><p
											class="day">5</p></td>
									<td class="select_day cursor match_search_submit" data-day="6"><p
											class="day">6</p></td>
									<td class="select_day cursor match_search_submit" data-day="7"><p
											class="day">7</p></td>
									<td class="select_day cursor match_search_submit" data-day="8"><p
											class="day">8</p></td>
									<td class="select_day cursor match_search_submit" data-day="9"><p
											class="day">9</p></td>
									<td class="select_day cursor match_search_submit" data-day="10"><p
											class="day">10</p></td>
								</tr>
								<tr>
									<td class="select_day cursor match_search_submit" data-day="11"><p
											class="day">11</p></td>
									<td class="select_day cursor match_search_submit" data-day="12"><p
											class="day">12</p></td>
									<td class="select_day cursor match_search_submit" data-day="13"><p
											class="day">13</p></td>
									<td class="select_day cursor match_search_submit" data-day="14"><p
											class="day">14</p></td>
									<td class="select_day cursor match_search_submit" data-day="15"><p
											class="day">15</p></td>
									<td class="select_day cursor match_search_submit" data-day="16"><p
											class="day">16</p></td>
									<td class="select_day cursor match_search_submit" data-day="17"><p
											class="day">17</p></td>
								</tr>
								<tr>
									<td class="select_day cursor match_search_submit" data-day="18"><p
											class="day">18</p></td>
									<td class="select_day cursor match_search_submit" data-day="19"><p
											class="day">19</p></td>
									<td class="today select_day cursor match_search_submit"
										data-day="20"><p class="day">20</p></td>
									<td class="select_day cursor match_search_submit" data-day="21"><p
											class="day">21</p></td>
									<td class="select_day cursor match_search_submit" data-day="22"><p
											class="day">22</p></td>
									<td class="select_day cursor match_search_submit" data-day="23"><p
											class="day">23</p></td>
									<td class="select_day cursor match_search_submit" data-day="24"><p
											class="day">24</p>
										<p class="txt">1경기</p></td>
								</tr>
								<tr>
									<td class="select_day cursor match_search_submit" data-day="25"><p
											class="day">25</p></td>
									<td class="select_day cursor match_search_submit" data-day="26"><p
											class="day">26</p></td>
									<td class="select_day cursor match_search_submit" data-day="27"><p
											class="day">27</p></td>
									<td class="select_day cursor match_search_submit" data-day="28"><p
											class="day">28</p></td>
									<td class="select_day cursor match_search_submit" data-day="29"><p
											class="day">29</p></td>
									<td class="select_day cursor match_search_submit" data-day="30"><p
											class="day">30</p></td>
									<td>&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>


			<div>
				<button type="button">매치 검색</button>
				<a href="registermatch"><button type="button">매치 등록</button></a>
			</div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>