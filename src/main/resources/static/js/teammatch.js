// 지역 및 날짜 선택

$(document).ready(function() {
	
		// 캘린더 함수 호출
		
		calendarInit();
		
		// 선택한 날짜 form에 저장
		
		for (var i=1; i<31; i++) {
			$(".dates").on('click', "#" +i, function(){ 	
				$('input[name=date]').attr('value', '.' + $(this).text());
				
			});
			
			// 선택한 날짜는 색상으로 표시
			
			$(".dates").on('click', "#" +i, function(){ 	
				$(this).css("background-color", "#FFFBCC");				
			});
		}
		
		// 선택한 지역 form에 저장
		
		$("#0").on("click", function() {
			$('input[name=region]').attr('value', '강원도');
		})
		$("#1").on("click", function() {
			$('input[name=region]').attr('value', '강원도');
		})
		$("#2").on("click", function() {
			$('input[name=region]').attr('value', '광주광역시');
		})
		$("#3").on("click", function() {
			$('input[name=region]').attr('value', '경기도');
		})
		$("#4").on("click", function() {
			$('input[name=region]').attr('value', '경상남도');
		})
		$("#5").on("click", function() {
			$('input[name=region]').attr('value', '경상북도');
		})
		$("#6").on("click", function() {
			$('input[name=region]').attr('value', '대구광역시');
		})
		$("#7").on("click", function() {
			$('input[name=region]').attr('value', '대전광역시');
		})
		$("#8").on("click", function() {
			$('input[name=region]').attr('value', '부산광역시');
		})
		$("#9").on("click", function() {
			$('input[name=region]').attr('value', '서울특별시');
		})
		$("#10").on("click", function() {
			$('input[name=region]').attr('value', '세종특별자치시');
		})
		$("#11").on("click", function() {
			$('input[name=region]').attr('value', '인천광역시');
		})
		$("#12").on("click", function() {
			$('input[name=region]').attr('value', '울산광역시');
		})
		$("#13").on("click", function() {
			$('input[name=region]').attr('value', '전라남도');
		})
		$("#14").on("click", function() {
			$('input[name=region]').attr('value', '전라북도');
		})
		$("#15").on("click", function() {
			$('input[name=region]').attr('value', '제주특별자치도');
		})
		$("#16").on("click", function() {
			$('input[name=region]').attr('value', '충청남도');
		})
		$("#17").on("click", function() {
			$('input[name=region]').attr('value', '충청북도');
		})

		
		// 매치 검색 버튼
		
		$("#searchbtn").on("click", function() {

			$.ajax({
				url : 'teammatch',
				data : {
					'region' : $("#region").val(),
					'year_month' : $("#year_month").val(),
					'date' : $("#date").val()
				},
				type : 'post',
				dataType : 'json',
				success : function(response) {
					alert(response.model1);
					alert(response.model2);
				}
			});

		}) // searchbtn end
		
		// 매치 등록 버튼
		
		$("#registerbtn").on("click", function() {
			
			// 로그인을 한 상태여야 매치 등록을 할 수 있다.
			
			if ($(".dropdownBtn").text() == "") {
				alert("로그인이 필요한 서비스입니다.");
			}
			else {
				location.href= "registerteammatch?region=" +  $("#region").val() + "&year_month=" + $("#year_month").val() + "&date=" + $("#date").val()
			}
		}) // registerbtn end

	}); // ready end


	
/*
    달력 렌더링 할 때 필요한 정보 목록 

    현재 월(초기값 : 현재 시간)
    금월 마지막일 날짜와 요일
    전월 마지막일 날짜와 요일
    
    출처: https://songsong.dev/11 [송송은 오늘도 열심히 코딩 하네:티스토리]
*/

// 캘린더 함수	

function calendarInit() {

    // 날짜 정보 가져오기
    
    var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
    var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
    var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
  
    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    
    // 달력에서 표기하는 날짜 객체
  
    var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
    var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
    var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일

    // kst 기준 현재시간
    // console.log(thisMonth);

    // 캘린더 렌더링
    
    renderCalender(thisMonth);

    function renderCalender(thisMonth) {

        // 렌더링을 위한 데이터 정리
        
        currentYear = thisMonth.getFullYear();
        currentMonth = thisMonth.getMonth();
        currentDate = thisMonth.getDate();

        // 이전 달의 마지막 날 날짜와 요일 구하기
        
        var startDay = new Date(currentYear, currentMonth, 0);
        var prevDate = startDay.getDate();
        var prevDay = startDay.getDay();

        // 이번 달의 마지막날 날짜와 요일 구하기
        
        var endDay = new Date(currentYear, currentMonth + 1, 0);
        var nextDate = endDay.getDate();
        var nextDay = endDay.getDay();

        // console.log(prevDate, prevDay, nextDate, nextDay);

        // 현재 연도 및 월 표기
        
        $('.year-month').text(currentYear + '.' + (currentMonth + 1));
        
        // 현재 연도 및 월 데이터 form에 입력
        
		$('input[name=year_month]').attr('value', currentYear + '.' + (currentMonth + 1));

        // 렌더링 html 요소 생성
        
        calendar = document.querySelector('.dates')
        calendar.innerHTML = '';
        
        // 지난달
        
        for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disable">' + i + '</div>'
        }
        
        // 이번달
        
        for (var i = 1; i <= nextDate; i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day current" id='+ i +'>' + i + '</div>'
        }
        
        // 다음달
        
        for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable">' + i + '</div>'
        }

        // 오늘 날짜 표기
        
        if (today.getMonth() == currentMonth) {
            todayDate = today.getDate();
            var currentMonthDate = document.querySelectorAll('.dates .current');
            currentMonthDate[todayDate -1].classList.add('today');
        }
    }

    // 이전달로 이동
    
    $('.go-prev').on('click', function() {
        thisMonth = new Date(currentYear, currentMonth - 1, 1);
        renderCalender(thisMonth);
    });

    // 다음달로 이동
    
    $('.go-next').on('click', function() {
        thisMonth = new Date(currentYear, currentMonth + 1, 1);
        renderCalender(thisMonth); 
    });
}
