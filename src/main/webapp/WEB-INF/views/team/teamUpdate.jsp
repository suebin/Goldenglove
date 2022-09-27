<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		/* 추가버튼 클릭시 버튼hidden 두번째 input */
		$("input:button").on("click", function() {
			$(this).attr("hidden","hidden");
			$(this).prev().removeAttr("hidden");
			$(this).prev().focus();
		})
		/* submit시 input 값 합치기 */
		$("#teamForm").on("submit", function() {
			for(let i = 1;i <= 9;i++){
				$("#name" + i).val($("#name" + i).val() + "," + $("#name" + i).next().val());				
			}
			alert("팀원 수정이 완료되었습니다");
		})
	});
</script>
</head>
<body>
<%
	
%>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<h1>팀원 수정</h1>
		<h3>팀 이름 : ${loginInfo.getName() }</h3>
		<form action="teamUpdateResult" method="post" id="teamForm">
			<input type="text" name="teamName" value="${loginInfo.getName() }" hidden>
			<table>
				<tr>
					<td>1루수 :</td>
					<td>
						<input type="text" id="name1" name="firstBase" value="${teamDTO.getFirstBase().split(',')[0] }">
						<input type="text" hidden value="${teamDTO.getFirstBase().split(',')[1] }">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>2루수 :</td>
					<td>
						<input type="text" id="name2" name="secondBase" value="${teamDTO.getSecondBase().split(',')[0] }">
						<input type="text" hidden value="${teamDTO.getSecondBase().split(',')[1] }">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>3루수 :</td>
					<td>
						<input type="text" id="name3" name="thirdBase" value="${teamDTO.getThirdBase().split(',')[0] }">
						<input type="text" hidden value="${teamDTO.getThirdBase().split(',')[1] }">
						<input type="button" value="추가">	
					</td>
				</tr>
				<tr>
					<td>포수 :</td>
					<td>
						<input type="text" id="name4" name="catcher" value="${teamDTO.getCatcher().split(',')[0] }">
						<input type="text" hidden value="${teamDTO.getCatcher().split(',')[1] }">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>투수 :</td>
					<td>
						<input type="text" id="name5" name="pitcher" value="${teamDTO.getPitcher().split(',')[0] }">
						<input type="text" hidden value="${teamDTO.getPitcher().split(',')[1] }">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>좌익수 :</td>
					<td>
						<input type="text" id="name6" name="leftFielder" value="${teamDTO.getLeftFielder().split(',')[0] }">
						<input type="text" hidden value="${teamDTO.getLeftFielder().split(',')[1] }">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>우익수 :</td>
					<td>
						<input type="text" id="name7" name="rightFielder" value="${teamDTO.getRightFielder().split(',')[0] }">
						<input type="text" hidden value="${teamDTO.getRightFielder().split(',')[1] }">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>중견수 :</td>
					<td>
						<input type="text" id="name8" name="centerFielder" value="${teamDTO.getCenterFielder().split(',')[0] }">
						<input type="text" hidden value="${teamDTO.getCenterFielder().split(',')[1] }">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>유격수 :</td>
					<td>
						<input type="text" id="name9" name="shortStop" value="${teamDTO.getShortStop().split(',')[0] }">
						<input type="text" hidden value="${teamDTO.getShortStop().split(',')[1] }">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="수정"></td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>