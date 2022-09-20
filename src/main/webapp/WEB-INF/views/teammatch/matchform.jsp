<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">



<title>매치 등록</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {

	}); // ready end
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">

		<h1>매치 등록</h1>
		<br>

		<form action="registerteammatch" method="post">
			<div>
				팀 이름 &nbsp;<input type="text" name="teamName">
			</div>
			
			<div>
				지역 &nbsp;<input type="text" name="region">
			</div>

			<div>
				날짜 &nbsp;<input type="text" name="possibleDate"> <select name="possibleTime">
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

			<div>
				장소 &nbsp;<input type="text" name="homePlace">
			</div>

			<div>
				팀원 수 &nbsp;<input type="text" name="headCount">
			</div>

			<div>
				남기는 한마디<br>
				<textarea cols="30" rows="4" name="comment"></textarea>
			</div>

			<input type="submit" value="매치 등록">
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>