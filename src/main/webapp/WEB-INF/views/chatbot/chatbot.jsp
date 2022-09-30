<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브</title>
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/chatbot.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js" ></script>
<script>
$(document).ready(function() {
	// 대화 시작
	$(".chatbotIcon").on("click", function() {
		$(".chat").removeClass("hidden");
		
		$.ajax ({
			url: "chatbot",
			data:{ request: "", event: "open"},
			type:"get",
			dataType:"json",
			success: function(res) {
				addBotAnswer("bot welcome", res.bubbles[0].data.description , "faqBtn notWork");
				
				for(i=0; i< res.quickButtons.length; i++) {
					$(".welcome:last-child .faqBtn").append(
						'<button>' + res.quickButtons[i].title + '</button>'
					)
				}
				
				// 퀵 FAQ 버튼
				if($(".faqBtn").hasClass("notWork")) {
					$(document).one("click", ".faqBtn button", quickBtn);

				} else {
					alert($(".faqBtn").hasClass("notWork"));
					$(document).on("click", ".faqBtn button", quickBtn);
				}
			}
		});
	});

	
	function quickBtn() {
		addMyAnswer($(this).html());
		
		$.ajax ({
			url: "chatbot",
			data:{ request: $(this).html(), event: "send"},
			type:"get",
			dataType:"json",
			success: function(res) {
				addBotAnswer("bot", res.bubbles[0].data.cover.data.description, "faqList");
				
				for(i=0; i< res.bubbles[0].data.contentTable.length; i++) {
					$(".bot:last-child .faqList").append(
						'<button>' + res.bubbles[0].data.contentTable[i][0].data.title + '</button>'
					)
				}
			}
		});
		
		scrollBottom();
	};

	
	// 세부 FAQ 버튼
	$(document).on("click", ".faqList button", function() {
		addMyAnswer($(this).html());
		
		$.ajax ({
			url: "chatbot",
			data:{ request: $(this).html(), event: "send"},
			type:"get",
			dataType:"json",
			success: function(res) {
				alert(res.bubbles[0].data.description);
			}
		})
		
		scrollBottom();
	});
		
		
	// 대화 종료
	$(".closeBtn").on("click", function() {
		$(".chat").addClass("hidden");
		
		// 퀵 버튼 동작 종료 제거
		if($(".faqBtn").hasClass("notWork")) {
			$(".faqBtn").removeClass("notWork");
		}
		$(".bottom").html("");
	});
	
	
	// 스크롤 맨 아래로
	function scrollBottom() {
		$(".chat").scrollTop($(".chat").height());
	};
	
	
	// 봇 대답 추가
	function addBotAnswer(botClassName, content, btnClass) {
		$(".bottom").append(
			'<div class="' + botClassName + '">'
			+	'<div class="botImg">'
			+		'<img alt="chatbot.png" src="/images/chatbot.png">'
			+	'</div>'
			+ 	'<div class="conBox">'
			+ 		'<span class="content">' 
			+ 			content
			+		'</span>'
			+		'<div class="' + btnClass + '"></div>'
			+	'</div>'
			+'</div>'
		)
	}
	
	
	// 내 대답 추가
	function addMyAnswer(content) {
		$(".bottom").append(
			'<div class="me">'
			+	'<span class="content">' 
			+		content
			+	'</span>'
			+'</div>'
		);
	}
	
});
</script>
</head>
<body>
	<div class="chatbotBox">
		<div class="chat hidden">
			<div class="top">
				<div class="botName">
					<div class="botImg">
						<img alt="chatbot.png" src="/images/chatbot.png">
					</div>
					<span>골든봇</span>
				</div>
				<div class="closeBtn">
					<button type="button">X</button>
				</div>
			</div>
			
			<div class="bottom">
			<!-- 	<div class="bot">
					<div class="botImg">
						<img alt="chatbot.png" src="/images/chatbot.png">
					</div>
					<span class="content">안녕하세요</span>
				</div>
				<div class="me">
					<span class="content">안녕하쇼</span>
				</div> -->
			</div>
			
			<div class="inputBox">
				<input id="request" type="text" name="request" placeholder="FAQ를 입력해주세요">
				<button type="button">✔</button>
			</div>
		</div>
		
		
		<div class="chatbotIcon">
			<img alt="chatbot.png" src="/images/chatbot.png">
			<span>FAQ</span>
		</div>
	</div>
</body>
</html>