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

	});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<div class="confix">
		<h1>팀원 등록</h1>
		<form action="">
			<table>
				<tr>
					<th>팀 이름 :</th>
					<th><%=request.getAttribute("name")%></th>
				</tr>
				<tr>
					<td>1루수 :</td>
					<td>
						<input type="text" name="firstBase">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>2루수 :</td>
					<td>
						<input type="text" name="secondBase">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>3루수 :</td>
					<td>
						<input type="text" name="thirdBase">
						<input type="button" value="추가">	
					</td>
				</tr>
				<tr>
					<td>포수 :</td>
					<td>
						<input type="text" name="catcher">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>투수 :</td>
					<td>
						<input type="text" name="pitcher">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>좌익수 :</td>
					<td>
						<input type="text" name="leftFielder">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>우익수 :</td>
					<td>
						<input type="text" name="rightFielder">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>중견수 :</td>
					<td>
						<input type="text" name="centerFielder">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td>유격수 :</td>
					<td>
						<input type="text" name="shortStop">
						<input type="button" value="추가">
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="팀원등록"></td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>