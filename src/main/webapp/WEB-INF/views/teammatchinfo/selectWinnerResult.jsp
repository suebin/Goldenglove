<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브 > 승패 선택</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	(".closeBtn").on("click", function() {
		window.close();
}); // ready end
</script>
<style>
	body {
		text-align: center;
		font-family: "비트로 프라이드 OTF";
	}
	
	h4 {
		margin-top: 100px;
		margin-bottom: 35px;
	}
	
	button {
		width: 70px;
		height: 28px;
		border-radius: 8px;
		border: none;
		background-color: #feca00;
		font-weight: bold;
	}
</style>
</head>
<body>
<h4>${message}</h4>
<br>
<button class="closeBtn">창 닫기</button>
</body>
</html>