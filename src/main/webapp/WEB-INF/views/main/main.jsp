<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>골든글러브</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link rel="stylesheet" href="/css/owl.carousel.min.css">
<link rel="stylesheet" href="/css/owl.theme.default.min.css">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="js/jquery-3.6.0.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/owl.carousel.min.js" defer></script>
<script>
$(document).ready(function() {
 	AOS.init();
 	
	history.replaceState({}, null, location.pathname);
	
	// 매칭
	const now = new Date();
	const today = now.getFullYear() + "." + ("0" + (now.getMonth() + 1)).slice(-2) + "." + ("0" + (now.getDate())).slice(-2);
	
	$.ajax({
		url: "mainMatching",
		data: {today: today},
		type:"post",
		dataType:"json",
		success: function(res) {
			if (res.length == 0) {
				let matching = result("Who's Next", '', '', '', "Who's Next");
				$(".matchingListBox").append( matching );
				$(".timePlace").css("display", "none");
				
			} else {
				for(let j=0; j<res.length; j++) {
					let matching = result(res[j].homeName, res[j].possibleDate, res[j].possibleTime, res[j].homePlace, res[j].awayName);
					$(".matchingListBox").append( matching );
				}
				
				// 슬라이드 시작
				$('#slide').owlCarousel({
			        items: 1,
					loop: true,
					dots: true,
				    autoplay:true,
					autoplayTimeout: 3000
			    });
			}
			
			// 오늘의 매칭 리턴
			function result(homeName, possibleDate, possibleTime, homePlace, awayName) {
				let result = '<li class="owl-item">'
							+	'<div class="team">'
							+		'<img class="badge" alt="badge1" src="/images/badge1.png">'
							+		'<span class="teamName">' + homeName + '</span>'
							+	'</div>'
								
							+	'<div class="center">'
							+		'<span class="vs">vs</span>'
							+		'<span class="timePlace">' + possibleDate + ' ' + possibleTime + '<br>' + homePlace + '</span>'
							+	'</div>'
								
							+	'<div class="team">'
							+		'<span class="teamName awayTeam">' + awayName + '</span>'
							+		'<img class="badge" alt="badge2" src="/images/badge2.png">'
							+	'</div>'
							+'</li>';
				
				return result;		
			}
		}
	})
	
	
	// 랭킹
	$.ajax({
		url: "mainRanking",
		type:"post",
		dataType:"json",
		success: function(res) {
			let i = 1;
			let rankNum = "";
			
			for(let j=0; j<res.length; j++) {
				if(i <= 10) { 
					if (i == 1) { 
						rankNum = '<img alt="defaultImg" src="/images/gold-medal.png">';
					} else if (i == 2) { 
						rankNum = '<img alt="defaultImg" src="/images/silver-medal.png">';
					} else if (i == 3) {
						rankNum = '<img alt="defaultImg" src="/images/bronze-medal.png">';
					} else {
						rankNum = '<span>' + i + '</span>'
					} 
					
					$(".rankingList").append(
						'<li>'
						+	rankNum
						+	'<span class="teamInfo">' + res[j].teamName + '</span>'
						+	'<span class="result">' + res[j].winCount + '</span>'
						+	'<span class="result">' + res[j].loseCount + '</span>'
						+	'<span class="result">' + res[j].winningRate.toFixed(3) + '</span>'
						+'</li>'
					)
					i++;
				}
			}
		}
	})
	
	// 공지
	$.ajax({
		url: "mainNotice",
		type:"post",
		dataType:"json",
		success: function(res) {
			
			if (res.length == 0) {
				$(".noticeList").append( '<li class="noList"><span>최근 공지사항이 없습니다.</span></li>' );
			
			} else {
				for(let j=0; j<res.length; j++) {
					$(".noticeList").append(
						'<li>'
						+     '<ul onclick="location.href=' + '\'noticeDetail?rowNum=' + res[j].rowNum + '\'">'
						+     	 '<li class="title">' + res[j].title + '</li>'
						+     	 '<li class="date">' + res[j].writingTime.substring(0,11) + '</li>'
						+     '</ul>'
						+ '</li>'
					)
				}
			}
		}
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />

	<div class="mainTop">
		<img class="mainImg" alt="mainImg" src="/images/mainImg.jpg">
		<img class="mainImgMobile" alt="mainImgMobile" src="/images/mainImgMobile.jpg">
		
		<div class="intro">
			<div class="confix">
				<span>Start matching with Golden Glove now</span>
			</div>
		</div>
	</div>
	
	<div class="todayMatching">
		<div class="confix">
			<h3>UPCOMING MATCH</h3>
			<div id="slide" class="owl-carousel owl-theme owl-loaded">
				<div class="matchingList owl-stage-outer">
					<ul class="matchingListBox owl-stage"></ul>
				</div>
			</div>
		</div>
	</div>
	
	<div class="info">
		<div class="confix">
			<div class="ranking" data-aos="fade-right" data-aos-duration="1000">
				<h3>TEAM RANKING</h3>
				<ul class="rankingList">
					<li>
						<span>N.</span>
						<span>TEAM</span>
						<span class="result">W</span>
						<span class="result">L</span>
						<span class="result">WPCT</span>
					</li>
				</ul>
			</div>
	
			<div class="notice" data-aos="fade-left" data-aos-duration="1000">
				<div class="noticeTop">
					<h3>LATEST NOTICE</h3>
					<a href="notice">VIEW ALL</a>
				</div>
				
				<ul class="noticeList">
					<li>
						<span class="title">제목</span>
						<span>작성일</span>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<div class="joinAdvice">
		<div class="joinAdviceTxt confix">
	        <span>LOOKING FOR A TEAM?</span><h3>Join Our Site!</h3>
	        <span>지금 바로 가입하여 손쉽게 경기 매칭에 성공하세요</span><br/>
	        <span>골든글러브에서는 경기할 팀을 연결해 줄 뿐만 아니라 지금까지의 모든 경기 관리도 가능합니다</span>
	    </div> 
    </div> 

	<div class="proSchedule">
		<div class="confix">
	        <h3>PRO MATCH SCHEDULE</h3>
	        <span class="desc">프로 경기 일정을 확인해보세요</span>
	        <ul class="proList" data-aos="fade-up" data-aos-duration="2000">
	        	<li>
	        		<a href="https://www.koreabaseball.com/Schedule/Schedule.aspx" target="blank">
		        		<img class="mainPro1" alt="mainProImg" src="/images/mainPro1.jpg">
		        		
		        		<span class="siteBtnBox">
			        		<span>신한은행 SOL KBO 리그</span>
			        		<span class="siteBtn">바로가기</span>
		        		</span>
	        		</a>
	        	</li>
	        	<li>
	        		<a href="http://mbcplus.com/sports/kbo/schedule.do" target="blank">
		        		<img class="mainPro2" alt="mainProImg" src="/images/mainPro2.jpg">
		        		
		        		<span class="siteBtnBox">
			        		<span>MBC PLUS</span>
			        		<span class="siteBtn">바로가기</span>
		        		</span>
	        		</a>
       			</li>
	        	<li>
	        		<a href="https://sports.news.naver.com/kbaseball/schedule/index" target="blank">
		        		<img class="mainPro3" alt="mainProImg" src="/images/mainPro3.jpg">
	        			
	        			<span class="siteBtnBox">
			        		<span>NAVER SPORTS</span>
			        		<span class="siteBtn">바로가기</span>
		        		</span>
	        		</a>
	        	</li>
	        </ul>
        </div>
    </div> 
    
	<jsp:include page="/WEB-INF/views/chatbot/chatbot.jsp" />
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>