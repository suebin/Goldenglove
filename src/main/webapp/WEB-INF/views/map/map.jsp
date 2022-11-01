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
		
	   	<div class="voiceSearch">
	   		<span>🧭 음성으로 목적지를 검색해보세요</span>
	   		
	   		<div class="voiceBtn">
	   			<button id="startRecordBtn" type="button" onclick="startSpeechRecognition();">음성 검색 시작</button>
	   			<button id="endRecordBtn" type="button" onclick="endSpeechRecognition();">음성 검색 종료</button>
			</div>
		</div>
		
		<div class="map_wrap">
		    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
		
		    <div id="menu_wrap" class="bg_white">
		        <div class="option">
		            <div>
		                <form class="mapSearchForm" onsubmit="searchPlaces(); return false;">
		                    <span>장소 </span><input type="text" value="고척돔" id="keyword" size="15"> 
		                    <button id="textSearchBtn" type="submit">검색</button> 
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
<script type="text/javascript">
	// 음성 검색
	let recognition = null;
	
	function checkCompatibility() {
	  recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
	  recognition.lang = "ko";
	  recognition.maxAlternatives = 5;
	
	  if (!recognition) {
		  document.getElementById("startRecordBtn").addEventListener("onclick", () => {
			  alert("지원되지 않는 브라우저입니다.");
		  });
	  }
	}
	
	function startSpeechRecognition() {
	  recognition.addEventListener("result", (event) => {
	    const text = event.results[0][0].transcript;
	    document.getElementById("keyword").value = text;
	    $("#textSearchBtn").submit();
	  });
	
	  recognition.start();
	}
	
	function endSpeechRecognition() {
	  recognition.stop();
	}
	
	window.addEventListener('load', checkCompatibility);
</script>
</html>