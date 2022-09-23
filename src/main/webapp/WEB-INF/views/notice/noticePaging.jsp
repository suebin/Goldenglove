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
	<div class="confix">
	<% int totalCount = Integer.parseInt(request.getParameter("listCount"));
		int totalPage = 0; 
	
		if (totalCount % 10 == 0) {
			totalPage =  totalCount / 10;
		} else {
			totalPage =  totalCount / 10 + 1;
		} 
	%>		
		
		<ul class="paging">
			<c:choose>
				<c:when test="${ param.url eq '/notice'}">
					<li><a href="${param.url}?page=1">&lt;&lt;</a></li>
					<% for(int i=1; i<=totalPage; i++) { %>
					<li><a href="${param.url}?page=<%=i %>"><%= i %></a></li>
					<% } %>
					<li><a href="${param.url}?page=<%= totalPage %>">&gt;&gt;</a></li>
				</c:when>
				<c:when test="${ param.url eq '/noticeSearch'}">
					<li><a href="${param.url}?opt=${param.opt}&searchWord=${param.searchWord}&page=1">&lt;&lt;</a></li>
					<% for(int i=1; i<=totalPage; i++) { %>
					<li><a href="${param.url}?opt=${param.opt}&searchWord=${param.searchWord}&page=<%=i %>"><%= i %></a></li>
					<% } %>
					<li><a href="${param.url}?opt=${param.opt}&searchWord=${param.searchWord}&page=<%= totalPage %>">&gt;&gt;</a></li>
				</c:when>
			</c:choose>
		</ul>
	</div>
</body>
</html>