<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>골든글러브 > 팀 매칭</title>
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/map.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1a1b7f220a5f1e98529737ae5c98de99&libraries=services"></script>
<script type="text/javascript" src="js/map.js" defer></script>
<script>
$(document).ready(function() {
});
</script>
</head>
<body>
	<div class="map">
		<div class="title">
			<h2>Search the place</h2>
			<span>매칭 신청 전에 경기 장소를 검색해보세요.</span>
			<span>장소 목록을 누르면 길찾기로 연결됩니다.</span>
		</div>
		
		<div class="map_wrap">
		    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
		
		    <div id="menu_wrap" class="bg_white">
		        <div class="option">
		            <div>
		                <form class="mapSearchForm" onsubmit="searchPlaces(); return false;">
		                    <span>장소 </span><input type="text" value="고척돔" id="keyword" size="15"> 
		                    <button type="submit">검색</button> 
		                </form>
		            </div>
		        </div>
		        <hr>
		        <ul id="placesList"></ul>
		        <div id="pagination"></div>
		    </div>
		</div>
	</div>
</body>
</html>