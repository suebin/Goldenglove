<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	$(".insertBtn").on("click", function(){
		location.href='/noticeWrite';
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
	<jsp:include page="/WEB-INF/views/notice/noticeHeader.jsp" />
	
	<div class="confix">
		<h2>공지사항</h2>
		
		<span class="totalCount">총 ${ totalCount }개</span>
		<ul class="notice">
			<li>
				<ul class="noticeHeader">
					<li>번호</li>
					<li class="title">제목</li>
					<li class="writer">작성자</li>
					<li>조회수</li>
					<li>작성일</li>
				</ul>
			</li>
			<c:choose>
				<c:when test="${ totalCount == 0 }">
					<li class="noList">게시물이 없습니다.</li>
				</c:when>
				<c:otherwise>
					<c:forEach items="${ pagingList }" var="list" >
						<li>
							<ul class="noticeList" onclick="location.href='noticeDetail?rowNum=${list.rowNum}'">
								<li>${ list.rowNum }</li>
								<li class="title">${ list.title }</li>	
								<li class="writer">${ list.writer }</li>	
								<li>${ list.viewCount }</li>	
								<li>${fn:substring(list.writingTime,0,11)}</li>	
							</ul>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</ul>
		
		<jsp:include page="noticePaging.jsp" >
			<jsp:param name="listCount" value="${ totalCount }" /> 
			<jsp:param name="url" value="${ requestUrl }" />
			<jsp:param name="opt" value="${ searchMap.opt }" />
			<jsp:param name="searchWord" value="${ searchMap.searchWord }" />
		</jsp:include> 
		
		<div class="searchForm">
			<form action="noticeSearch">
				<select name="opt">
					<option value="writer">작성자</option>
					<option value="title">제목</option>
					<option value="contents">내용</option>
				</select>
				<input type="text" name="searchWord">
				<div class="btnContainer searchBtnBox">
					<button class="searchBtn" type="submit">검색</button>
				</div>
			</form>		
		</div>
		
		<c:if test="${loginInfo.getName() == 'admin'}">
			<div class="btnContainer">
				<button class="insertBtn" type="button" >글쓰기</button>
			</div>
		</c:if>
	</div>
	
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>