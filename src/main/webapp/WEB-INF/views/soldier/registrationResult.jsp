<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든 글러브 > 용병 등록</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	$(".registrationResultBtn").on("click", function() {
		window.close();
	})
	

}); // ready end
</script>
<style>
	body {
		text-align: center;
		font-family: "비트로 프라이드 OTF";
	}
	
	h4 {
		margin-top: 40px;
		margin-bottom: 35px;
	}

	img {
		width: 70px;
		height: 70px;
		margin-bottom: 80px;
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
<h4>${result}</h4>
<img src="${img}">
<br>
<a href="registerSoldier"><button class="registrationBtn">돌아가기</button></a>
<button class="registrationResultBtn">창 닫기</button>
</body>
</html>