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
	$(".updateBtn").on("click", function(){
		location.href='noticeUpdate?rowNum=' + $(".rowNum").html();
	})

	$(".deleteBtn").on("click", function(){
		let msg = confirm("정말로 삭제하시겠습니까?");
		
		if (msg == 1) {
			location.href='noticeDelete?rowNum=' + $(".rowNum").html();
		}
	})
	
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<jsp:include page="/WEB-INF/views/notice/noticeHeader.jsp" />
	
	<div class="confix">
		<h2>공지사항</h2>
		<ul class="noticeDetail">
			<li>
				<ul class="noticeHeader">
					<li class="rowNum">${ list.rowNum }</li>
					<li class="title">${ list.title }</li>
					<li>${ list.writer }</li>
				</ul>
				<ul class="noticeHeader">
					<li>작성일 &nbsp;${ list.writingTime }</li>
					<li>조회수 ${ list.viewCount }</li>
				</ul>
			</li>
			<li>
				<ul class="noticeContents">
					<li style="white-space:pre;">${ list.contents }</li>	
				</ul>
			</li>
		</ul>
		
		<div class="nextPrevBtn">
			<div class="next">
				<span class="moveBtn">다음글</span>
				<c:choose>
					 <c:when test="${list.rowNum + 1 != totalCount + 1 }">
						<a href="/noticeDetail?rowNum=${list.rowNum +1}">${ nextTitle }</a>
					 </c:when>
					 <c:otherwise>
					   <span> ${ nextTitle } </span>
					 </c:otherwise>
				</c:choose>
			</div>
			
			<div class="prev">
				<span class="moveBtn">이전글</span>
				<c:choose>
					 <c:when test="${list.rowNum -1 != 0}">
						<a href="/noticeDetail?rowNum=${list.rowNum-1}">${ prevTitle }</a>
					 </c:when>
					 <c:otherwise>
					   <span> ${ prevTitle } </span>
					 </c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<div class="btnContainer">
			<button class="backBtn" type="button"><a href="notice?page=1">목록</a></button>
			
			<c:if test="${loginInfo.getId() == 'admin'}">
				<button class="updateBtn" type="button" >수정</button>
				<button class="deleteBtn" type="button">삭제</button>
			</c:if>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
	
</body>
</html>