<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<link href="/css/updateInfo.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	/* 변경 여부 */
	if($('input[name="phone"]').val() == "${loginInfo.phone}") {
		$("#phoneCheckResult").html("기존동일");
	}
	if($('input[name="email"]').val() == "${loginInfo.email}") {
		$("#emailCheckResult").html("기존동일");
	}
	$("input:text").on("change", function(e) {
		$(this).parent().next().find("p").html("");
	})
	
	/* submit시 중복검사 여부 확인 */
	$("#updateForm").on("submit", function(e) {
		if($("#phoneCheckResult").text() == "" || $("#emailCheckResult").text() == "") {
			e.preventDefault();
			alert("중복검사를 해주세요.");
		}else {
			alert("수정이 완료되었습니다.");
		}
	})

	/* 중복검사 */
	$(".input").next().on("click", function(e) {
		e.preventDefault();
		const checkInput = $(this); 
		$.ajax({
			url : 'duplicateCheck',
			data : {
				'id' : e.target.id,
				'value' : checkInput.prev().val()
			},
			dataType : 'json',
			success : function(server) {
				if(server.result == "이미 사용중입니다.") {
					checkInput.prev().val("");
					checkInput.prev().focus();
					checkInput.next().attr("class", "red");
				} else if(server.result == "사용 가능합니다.") {
					checkInput.next().attr("class", "green");
				}
				checkInput.next().removeAttr("hidden");
				checkInput.next().html(server.result);
			}
		})
	})
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
		<div class="confix">
			<div class="contentBox">
				<h1 class="h1">내정보 수정</h1>
				<form action="updateResult" method="post" id="updateForm" enctype="multipart/form-data" autocomplete="off">
					<table class="table">
						<tr>
							<td>이름 </td>
							<td>
								<input type="text" name="name" pattern="[a-zA-Z0-9가-힣]{1,30}" title="최대 30자리까지 입력가능합니다.(영어,숫자,한글)" required value="${loginInfo.getName() }" readonly>
							</td>
						</tr>
						<tr>
							<td>연락처 </td>
							<td>
								<input class="input" type="text" name="phone" placeholder="ex)01012345678" pattern="[0-9]{11}" title="숫자만 입력해주세요." required value="${loginInfo.getPhone() }">
								<button id="phoneDuplicate">중복검사</button>
								<p id="phoneCheckResult" hidden></p>
							</td>
						</tr>
						<tr>
							<td>이메일 </td>
							<td>
								<input class="input" type="email" name="email" required value="${loginInfo.getEmail() }">
								<button id="emailDuplicate">중복검사</button>
								<p id="emailCheckResult" hidden></p>
							</td>
						</tr>
						<tr>
							<td>지역 </td>
							<td>
								<select name="region" required>
									<option value="" disabled selected>==선택==</option>
									<option value="강원도">강원도</option>
									<option value="광주광역시">광주광역시</option>
									<option value="경기도">경기도</option>
									<option value="경상남도">경상남도</option>
									<option value="경상북도">경상북도</option>
									<option value="대구광역시">대구광역시</option>
									<option value="대전광역시">대전광역시</option>
									<option value="부산광역시">부산광역시</option>
									<option value="서울특별시">서울특별시</option>
									<option value="세종특별자치시">세종특별자치시</option>
									<option value="인천광역시">인천광역시</option>
									<option value="울산광역시">울산광역시</option>
									<option value="전라남도">전라남도</option>
									<option value="전라북도">전라북도</option>
									<option value="제주특별자치도">제주특별자치도</option>
									<option value="충청남도">충청남도</option>
									<option value="충청북도">충청북도</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>포지션 </td>
							<td>
								<select name="position" required>
									<option value="" disabled selected=>==선택==</option>
									<option value="firstBase">1루수</option>
									<option value="secondBase">2루수</option>
									<option value="thirdBase">3루수</option>
									<option value="catcher">포수</option>
									<option value="pitcher">투수</option>
									<option value="leftFielder">좌익수</option>
									<option value="rightFielder">우익수</option>
									<option value="centerFielder">중견수</option>
									<option value="shortStop">유격수</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>프로필 사진 </td>
							<td><input type="file" name="photo"></td>
						</tr>
					</table>
					<button type="submit" class="submitBtn">수정</button>
				</form>
			</div>
		</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>