<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>골든글러브</title>
<link href="/css/main.css" rel="stylesheet" />
<link href="/css/common.css" rel="stylesheet" />
<script src="js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		/* submit시 중복검사 여부 확인 */
		$("#signupForm").on("submit", function(e) {
			if($("#idCheckResult").text() == "" || $("#nameCheckResult").text() == "" || $("#phoneCheckResult").text() == "" || $("#emailCheckResult").text() == "") {
				e.preventDefault();
				alert("중복검사를 해주세요.");
			}else {
				alert("회원가입이 완료되었습니다. 팀원 등록 페이지로 이동합니다.");
			}
		})

		/* 중복검사 */
		$("input:button").on("click", function(e) {
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
					}
					checkInput.parent().next().find("p").html(server.result);
				}
			})
		})
	});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/components/header.jsp" />
		<div class="confix">
			<h1>회원가입</h1>
			<form action="signupResult" method="post" id="signupForm">
				<table>
					<tr>
						<td>아이디 :</td>
						<td>
							<input type="text" name="id" pattern="[a-z0-9]{3,15}" title="최대 15자리까지 입력가능합니다.(영어,숫자)" required>
							<input type="button" value="중복검사" id="idDuplicate">
						</td>
						<td>
							<p id="idCheckResult"></p>
						</td>
					</tr>
					<tr>
						<td>비밀번호 :</td>
						<td>
							<input type="password" name="password" pattern="^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*_=+-]).{8,15}$" title="최소 8자리, 최대 15자리까지 입력하능합니다.(영어,특수문자,숫자 필수)" required>
						</td>
					</tr>
					<tr>
						<td>팀 이름 :</td>
						<td>
							<input type="text" name="name" pattern="[a-zA-Z0-9가-힣]{1,30}" title="최대 30자리까지 입력가능합니다.(영어,숫자,한글)" required>
							<input type="button" value="중복검사" id="nameDuplicate">
						</td>
						<td>
							<p id="nameCheckResult"></p>
						</td>
					</tr>
					<tr>
						<td>연락처 :</td>
						<td>
							<input type="text" name="phone" placeholder="ex)01012345678" pattern="[0-9]{11}" title="숫자만 입력해주세요." required>
							<input type="button" value="중복검사" id="phoneDuplicate">
						</td>
						<td>
							<p id="phoneCheckResult"></p>
						</td>
					</tr>
					<tr>
						<td>이메일 :</td>
						<td>
							<input type="email" name="email" required>
							<input type="button" value="중복검사" id="emailDuplicate">
						</td>
						<td>
							<p id="emailCheckResult"></p>
						</td>
					</tr>
					<tr>
						<td>지역 :</td>
						<td>
							<select name="region" required>
								<option value="" disabled selected=>==선택==</option>
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
						<td colspan="3"><input type="submit" value="회원가입"></td>
					</tr>
				</table>
			</form>
		</div>
	<jsp:include page="/WEB-INF/views/components/footer.jsp" />
</body>
</html>