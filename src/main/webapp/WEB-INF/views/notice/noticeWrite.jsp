<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브</title>
<script src="js/jquery-3.6.0.min.js" ></script>
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/notice.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js" ></script>
<script>
$(document).ready(function() {
	
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	
	<div class="confix">
		<h2>공지 작성</h2>
		<form action="noticeWrite" method="post" class="noticeWrite">
			<div class="flexBox">
				<span>제목</span><input type="text" name="title" class="title"><br/>
			</div>
			<textarea class="contents" rows="15" cols="100" name="contents" placeholder="여기에 입력하세요"></textarea><br/>
			<input type="hidden" name="writer" value="${session.id}"><br/>
			<div class="btnContainer">
				<button class="writeBtn" type="submit" >글쓰기</button>
			</div>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>