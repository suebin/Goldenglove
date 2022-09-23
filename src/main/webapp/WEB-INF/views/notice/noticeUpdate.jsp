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
<script>
$(document).ready(function() {

});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	
	<div class="confix">
		<h2>공지 수정</h2>
		<form action="noticeUpdate" method="post" class="noticeUpdate">
			<div class="flexBox">
				<span>글번호</span><input class="listNum" type="text" name="rowNum" value=${ updateDetail.rowNum} readonly ><br/>
			</div>
			<div class="flexBox">
				<span>제목</span><input class="title" type="text" name="title" value=${ updateDetail.title }><br/>
			</div>
			<textarea class="contents" rows="10" cols="100" name="contents">${ updateDetail.contents }</textarea><br/>
		
			<div class="btnContainer">
				<button class="completeBtn" type="submit" >수정완료</button>
			</div>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>