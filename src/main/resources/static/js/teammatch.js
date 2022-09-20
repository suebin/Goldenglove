function match_confirm(url) {
	if(confirm("매치결과를 승인하시겠습니까?")) {
		location.href=url;
	} else {
		return false;
	}
}

$(document).ready(function(){
	// 지역
	$("#local_all").on("click", function(){
		$(".select_local").removeClass("option_on");
		$("#local_all").removeClass("on").addClass("on");
		$("#local_value").val("");
	});
	$(".select_local").on("click", function(){
		$("#local_all").removeClass("on");
		$(".select_local").removeClass("option_on");
		$(this).addClass("option_on");
		$("#local_value").val($(this).attr("data-id"));
	});
	// 팀
	$("#team_all").on("click", function(){
		$(".select_team").removeClass("option_on");
		$("#team_all").removeClass("on").addClass("on");
		$("#team_value").val("");
	});
	$(".select_team").on("click", function(){
		$("#team_all").removeClass("on");
		$(".select_team").removeClass("option_on");
		$(this).addClass("option_on");
		$("#team_value").val($(this).attr("data-id"));
	});
	// 연령
	$("#age_all").on("click", function(){
		$(".select_age").removeClass("option_on");
		$("#age_all").removeClass("on").addClass("on");
		$("#age_value").val("");
	});
	$(".select_age").on("click", function(){
		$("#age_all").removeClass("on");
		$(".select_age").removeClass("option_on");
		$(this).addClass("option_on");
		$("#age_value").val($(this).attr("data-id"));
	});
	// 경기
	$("#type_all").on("click", function(){
		$(".select_type").removeClass("option_on");
		$("#type_all").removeClass("on").addClass("on");
		$("#type_value").val("");
	});
	$(".select_type").on("click", function(){
		$("#type_all").removeClass("on");
		$(".select_type").removeClass("option_on");
		$(this).addClass("option_on");
		$("#type_value").val($(this).attr("data-id"));
	});

	$(".month_back").on("click", function(){
		var nyear = $("#calendar_nyear").val();
		var nmonth = $("#calendar_nmonth").val();
		var para = $(this).attr("data-para");
		$.post("/newsite/system/match/match.ajax.php", {"gubun":"month_back", "nyear":nyear, "nmonth":nmonth, "para":para}, function(text) {
			//console.log(text);
			var text_arr = text.split("[:]");
			//alert(lang_value);
			if(lang_value == "english") {
				$("#match_table_year").html(text_arr[0]+" year");
			} else if(lang_value == "chinese") {
				$("#match_table_year").html(text_arr[0]+" 年");
			} else {
				$("#match_table_year").html(text_arr[0]+" 년");
			}
			if(lang_value == "english") {
				$("#match_table_month").html(text_arr[1]+" month");
			} else if(lang_value == "chinese") {
				$("#match_table_month").html(text_arr[1]+" 月");
			} else {
				$("#match_table_month").html(text_arr[1]+" 월");
			}
			$("#calendar_nyear").val(text_arr[0]);
			$("#calendar_nmonth").val(text_arr[1]);
			$("#calendar_nday").val("");
			$("#match_calendar").html("");
			$("#match_calendar").html(text_arr[2]);

			$(".select_day").on("click", function(){
				var day = $(this).attr("data-day");
				$(".select_day").removeClass("selectday");
				$(this).addClass("selectday");
				$("#calendar_nday").val(day);
				//alert($("#calendar_nday").val());
			});
			$(".match_search_submit").on("click", function(){
				$("#match_search").submit();
			});

		});
	});

	$(".month_forward").on("click", function(){
		var nyear = $("#calendar_nyear").val();
		var nmonth = $("#calendar_nmonth").val();
		var para = $(this).attr("data-para");
		$.post("/newsite/system/match/match.ajax.php", {"gubun":"month_forward", "nyear":nyear, "nmonth":nmonth, "para":para}, function(text) {
			//console.log(text);
			var text_arr = text.split("[:]");
			if(lang_value == "english") {
				$("#match_table_year").html(text_arr[0]+" year");
			} else if(lang_value == "chinese") {
				$("#match_table_year").html(text_arr[0]+" 年");
			} else {
				$("#match_table_year").html(text_arr[0]+" 년");
			}
			if(lang_value == "english") {
				$("#match_table_month").html(text_arr[1]+" month");
			} else if(lang_value == "chinese") {
				$("#match_table_month").html(text_arr[1]+" 月");
			} else {
				$("#match_table_month").html(text_arr[1]+" 월");
			}
			$("#calendar_nyear").val(text_arr[0]);
			$("#calendar_nmonth").val(text_arr[1]);
			$("#calendar_nday").val("");
			$("#match_calendar").html("");
			$("#match_calendar").html(text_arr[2]);

			$(".select_day").on("click", function(){
				var day = $(this).attr("data-day");
				$(".select_day").removeClass("selectday");
				$(this).addClass("selectday");
				$("#calendar_nday").val(day);
				//alert($("#calendar_nday").val());
			});
			$(".match_search_submit").on("click", function(){
				$("#match_search").submit();
			});
		});
	});

	$(".select_day").on("click", function(){
		var day = $(this).attr("data-day");
		$(".select_day").removeClass("selectday");
		$(this).addClass("selectday");
		$("#calendar_nday").val(day);
		//alert($("#calendar_nday").val());
	});

	$(".match_search_submit").on("click", function(){
		$("#match_search").submit();
	});

	$("#comment_view").on("click", function(){
		if($(".list05 > .comment").css("display") == "none") {
			$(".list05 > .comment").css("display", "block");
		} else {
			$(".list05 > .comment").css("display", "none");
		}
	});

	$("#send_comment").on("click", function(){
		var txt = $("#comm_txt").val();
		var sender = $(this).attr("data-sender");
		if(txt == "") {
			alert("내용을 입력해주세요.");
			return false;
		} else {
			$.post("/newsite/system/match/match.ajax.php", {"gubun":"send_comment", "txt":txt, "sender":sender}, function(text){
				//console.log(text);
				if(text == 1) {
					alert("개설자에게 메세지가 전송되었습니다.");
					$("#comm_txt").val("");
					$(".list05 > .comment").css("display", "none");
				}
			});
		}
	});

	$(".match_request").on("click", function(){
		var pcode = $(this).attr("data-pcode");
		var mt_id = $(this).attr("data-id");
		var param = $(this).attr("data-para");
		location.href="/newsite/system/match/match_update.php?pcode="+pcode+"&w=match_message&mt_id="+mt_id+"&"+param;
		//$(".match_join_div").css("display", "block");
	});

	$("#match_join_form").on("submit", function(){
		if($("#detail").val() == "") {
			alert("매치신청 메세지를 작성해주세요.");
			$("#detail").focus();
			return false;
		} 
		else if($("#mb_teamjoin").val() == "") {
			alert("팀이 있어야 신청 가능합니다.");
			return false;
		} 
		
		
		else {
			return true;
		}
	});

	$(".match_cancel").on("click", function(){
		var mt_id = $(this).attr("data-id");
		var pcode = $(this).attr("data-pcode");
		var para_value = $(this).attr("data-para");
		if(confirm("정말 매치신청을 취소하시겠습니까?")){
			location.href="/newsite/system/match/match_update.php?pcode="+pcode+"&w=match_cancel&mt_id="+mt_id+"&"+para_value;
		} else {
			return false;
		}
	});

	$("#match_form").on("submit", function(){
		if($("#mt_datetime").val() == "") {
			alert("경기일을 입력해주세요.");
			return false;
		}
		/*
		if($("#mt_stadium").val() == "") {
			alert("구장을 입력해주세요.");
			$("#mt_stadium").focus();
			return false;
		}*/
		/*
		if($("#mt_money_text").val() == "") {
			alert("금액을 입력해주세요.");
			$("#mt_money_text").focus();
			return false;
		}
		*/
		if($("#region").val() == "") {
			alert("경기가능지역을 입력해주세요.");
			return false;
		}
		if($("#mt_content").val() == "") {
			alert("내용을 입력해주세요.");
			$("#mt_content").focus();
			return false;
		}
		if(confirm("매치글을 등록하시겠습니까?")) {
			return true;
		} else {
			return false;
		}
	});

	$("#stadium_select").on("click", function(){
		var form_id = $(this).attr("data-formid");
		window.open('/newsite/system/match/match_stadium_select1.php?form_id='+form_id, 'popup', 'width=370, height=450, scrollbars=1');
	});

	$("#region_select").on("click", function(){
		window.open('/newsite/system/match/match_area1.php', 'popup', 'width=370, height=450, scrollbars=1');
	});

	$("#match_delete").on("click", function(){
		var pcode = $(this).attr("data-pcode");
		var mt_id = $(this).attr("data-id");
		if(confirm("등록하신 매치글을 삭제하시겠습니까?")) {
			location.href="/newsite/system/match/match_update.php?pcode="+pcode+"&w=d&mt_id="+mt_id;
		} else {
			return false;
		}
	});

	$("#match_reply_form").on("submit", function(){

		var mrt_content = $("#mrt_content").val();
		var mb_id = $("#mb_id").val();
		var mb_teamjoin2 = $("#mb_teamjoin2").val();
		if(mb_id == "") {
			alert("로그인 후 작성 가능합니다.");
			return false;
		} else if(mrt_content == "") {
			alert("내용을 입력해주세요.");
			return false;
		}else if(mb_teamjoin2 == "") {
			alert("팀이 있어야 댓글을 작성하실 수 있습니다.");
			return false;
		} else {
			return true;
		}
	});
	
	$(".select_stadium").on("click", function(){
		var ro_id = $(this).attr("data-id");
		location.href="/newsite/system/match/match_stadium_select2.php?ro_id="+ro_id;
	});

	$(".delete_match_reply").on("click", function(){
		var dataid = $(this).attr("data-id");
		var pcode = $(this).attr("data-pcode");
		var mt_id = $(this).attr("data-mtid");
		if(confirm("댓글을 삭제하시겠습니까?")) {
			location.href="/newsite/system/match/match_update.php?pcode="+pcode+"&w=del_reply&mt_id="+mt_id+"&mrt_id="+dataid;
		} else {
			return false;
		}
	});

});