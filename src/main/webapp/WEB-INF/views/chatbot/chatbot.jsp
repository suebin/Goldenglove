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
	$(".chatbotIcon").on("click", function() { start("FAQ", "open") });
	$(".inputBox button").on("click", inputStart);
	$("#request").on("keyup", enterKey);
	
	function enterKey(e) {
		if(e.keyCode == 13) inputStart();
	}
	
	function inputStart() {
		if ($("#request").val() != '') {
			addMyAnswer($("#request").val() );
			start($("#request").val(), "send");
		}
	}
	
	function start(req, event) {
		$(".chat").removeClass("hidden");
		
		$.ajax ({
			url: "chatbot",
			data:{ request: req, event: event},
			type:"post",
			dataType:"json",
			success: function(res) {
				addBotAnswer("bot welcome", res.bubbles[0].data.description , "faqBtn work");
				
				for(i=0; i< res.quickButtons.length; i++) {
					$(".welcome:last-child .faqBtn").append(
						'<button>' + res.quickButtons[i].title + '</button>'
					)
				}
				
			 	onceBtnAction();
				setTimeout(scrollBottom, 70);
			}
		});
	}
	
	// 퀵 FAQ 버튼 등장 후 1번만 실행
	function onceBtnAction() {
		$(document).on("click", ".faqBtn button", function() {
			if($(".faqBtn").hasClass("work")) {
				$(document).one("mousemove", ".faqBtn button", quickBtn);
			} 
			$(".faqBtn:last-child").removeClass("work");
		});
	}

	// 퀵 FAQ 버튼 실행 후
	let response;		// 퀵버튼 success res 담을 전역변수
	
	function quickBtn() {
		addMyAnswer($(this).html());
		
		$.ajax ({
			url: "chatbot",
			data:{ request: $(this).html(), event: "send"},
			type:"post",
			async: false,
			dataType:"json",
			success: function(res) {
				
				addBotAnswer("bot", res.bubbles[0].data.cover.data.description, "faqList work");
				
				for(i=0; i< res.bubbles[0].data.contentTable.length; i++) {
					$(".bot:last-child .faqList").append(
						'<button>' + res.bubbles[0].data.contentTable[i][0].data.title + '</button>'
					)
				}
				
				response = res;		// 퀵버튼 success res 담기
			}
		});
		setTimeout(scrollBottom, 70);
	};

	
	// 세부 FAQ 버튼 실행 후
	$(document).on("click", ".faqList button", function() {
		let res = response;			// 퀵버튼 success res 담기
		let req = "";
		addMyAnswer($(this).html());
		
		// 세부버튼 내용과 $(this).html() 내용이 같으면 해당 버튼 세부 내용 req에 담기
		for(i=0; i< res.bubbles[0].data.contentTable.length; i++) {
			if ($(this).html() == res.bubbles[0].data.contentTable[i][0].data.title) {
				req = res.bubbles[0].data.contentTable[i][0].data.data.action.data.postbackFull;
			}
		}
		
		$.ajax ({
			url: "chatbot",
			data:{ request: req, event: "send"},
			type:"post",
			dataType:"json",
			success: function(res) {
				addBotTextAnswer("bot", res.bubbles[0].data.description);
			}
		})
		
		setTimeout(scrollBottom, 70);
	});
	
		
	// 대화 종료
	$(".closeBtn").on("click", function() {
		close();
	});
	
	// 챗봇 외부 영역 클릭 시 닫힘
	$(document).on("click", function(e) {
		if ($(".chatbotBox").has(e.target).length == 0) {
			close();
		}
	}); 
	
	function close() {
		$(".chat").addClass("hidden");
		$(".bottom").html("");
		$("#request").val("");
	}
	
	
	// 스크롤 맨 아래로
	function scrollBottom() {
		$(".chat").scrollTop($(".chat").height() * 100);
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
		
		setTimeout(scrollBottom, 70);
	}
	
	function addBotTextAnswer(botClassName, content) {
		$(".bottom").append(
			'<div class="' + botClassName + '">'
			+	'<div class="botImg">'
			+		'<img alt="chatbot.png" src="/images/chatbot.png">'
			+	'</div>'
			+ 	'<div class="conBox">'
			+ 		'<span class="content">' 
			+ 			content
			+		'</span>'
			+	'</div>'
			+'</div>'
		)
		
		setTimeout(scrollBottom, 70);
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
		
		setTimeout(scrollBottom, 70);
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
			
			<div class="bottom"></div>
			
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