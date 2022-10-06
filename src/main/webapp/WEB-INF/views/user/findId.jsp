<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	$("#findBtn").on("click", function() {
		$.ajax({
			url : 'findidresult',
			data : {
				'name' : $('input[name="name"]').val(),
				'email' : $('input[name="email"]').val()
			},
			dataType : 'json',
			success : function(server) {
				alert(server.result);
			}
		})
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
		<div class="confix">
			<h1 class="h1">아이디 찾기</h1>
			<form autocomplete="off">
				<table>
					<tr>
						<td>
							<input type="text" name="name" pattern="[a-zA-Z가-힣]{1,30}" title="최대 30자리까지 입력가능합니다.(영어,한글)" required placeholder="이름">
						</td>
					</tr>
					<tr>
						<td>
							<input type="email" name="email" required placeholder="이메일">
						</td>
					</tr>
						<tr><td><button id="findBtn">아이디찾기</button></td></tr>
				</table>
			</form>
		</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>