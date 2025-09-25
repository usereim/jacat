<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style>
	main {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	main h2 {
		margin-top: 150px;
		margin-bottom: 60px;
	}
	
	section#section_area {
		width: 70%;
		margin: 0 auto;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 15px;
		margin-bottom : 60px;
	}
	
	.input_area {
		width: 65%;
		display: flex;
		flex-direction: column;
		margin-bottom: 10px;
		align-items: flex-start;
		gap: 10px;
	}
	
	.input {
		width: 100%;
		display: flex;
		gap: 5px;
		align-items: center;
	}
	
	.input_area label {
		font-size: 20px;
		width: 20%;
	}
	
	input.form-control {
		width: 350px;
	}
	
	#btn_area {
		display: flex;
		gap: 15px;
		margin-bottom: 60px;
	}
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	
	<main>
		<h2 class="text-primary">아이디 찾기</h2>
		
		<section id="section_area">
			<div class="input_area">
				<div class="input">
					<label for="email" class="text-primary">이메일</label>
					<input type="text" name="email" id="email" class="form-control">
					<button type="button" id="email_btn" class="btn btn-primary" disabled>인증번호 전송</button>
				</div>
				
				<div id="email_message" class="message"></div>
			</div>
			
			<div class="input_area">
				<div class="input">
					<label for="code" class="text-primary">인증번호</label>
					<input type="text" name="code" id="code" class="form-control">
					<button type="button" id="code_btn" class="btn btn-primary" disabled>인증</button>
				</div>
				
				<div id="code_message" class="message"></div>
			</div>
			
			<div id="result_id" class="text-primary" style="font-size: 24px;"></div>
		</section>
		
		<section id="btn_area">
			<button type="button" id="idSearch_btn" class="btn btn-primary" disabled>아이디 찾기</button>
			<button type="button" id="pwSearch_btn" class="btn btn-primary">비밀번호 찾기</button>
			<button type="button" id="login_btn" class="btn btn-primary">로그인</button>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			$("#pwSearch_btn").click(function() {
				location.href = "<c:url value='/user/pw-search' />";
			});
			
			$("#login_btn").click(function() {
				location.href = "<c:url value='/user/login' />";
			});
			
			$("input[name=email]").keyup(function() {
				$("#email_btn").prop("disabled", true);
				$("#idSearch_btn").prop("disabled", true);
				$("#code_btn").prop("disabled", true);
				$("input[name=code]").val("");
				
				let regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
				let email = $("input[name=email]").val();
				
				if (regex.test(email)) {
					$("#email_message").text("");
					
					$.ajax({
						url : "<c:url value='/user/email-check' />",
						type : "post",
						data : {
							"email" : email
						}, success : function(response) {
							if (response.code == 1) {
								$("#email_btn").prop("disabled", false);
							} else {
								$("#email_message").text("등록되지 않은 이메일입니다.").css("color", "red");
								$("#email_btn").prop("disabled", true);
							}
						}, error : function() {
							
						}
					});
				} else {
					$("#email_message").text("이메일 양식을 확인해주세요").css("color",
							"red");
				}
			});
			
			$("#email_btn").click(function() {
				let email = $("input[name=email]").val();
				
				$.ajax({
					url : "<c:url value='/mail/send-mail' />",
					type : "post",
					data : {
						"email" : email
					}, success : function(response) {
						if (response == 'success') {
							$("#code_btn").prop("disabled", false);
						}
					}, error : function() {
						
					}
				});
			});
			
			$("#code_btn").click(function() {
				let code = $("input[name=code]").val();
				
				if (code == '') {
					return false;	
				} else {
					$.ajax({
						url : "<c:url value='/mail/code-check' />",
						type : "post",
						data : {
							"code" : code
						}, success : function(response) {
							if (response == "success") {
								$("#code_message").text("");
								$("#code").addClass("is-valid");
								$("#code").removeClass("is-invalid");
								$("#code_btn").prop("disabled", true);
								$("#idSearch_btn").prop("disabled", false);
							} else {
								$("#code_message").text("인증에 실패하였습니다. 인증번호를 확인해주세요.").css("color", "red");
								$("#code").addClass("is-invalid");
								$("#code").removeClass("is-valid");
								$("#code_btn").prop("disabled", false);
							}
						}, error : function() {
							
						}
					});
				}
			});
			
			$("#idSearch_btn").click(function() {
				let email = $("input[name=email]").val();
				
				$.ajax({
					url : "<c:url value='/user/id-search' />",
					type : "post",
					data : {
						"email" : email
					}, success : function(response) {
						$("#result_id").text("회원님의 아이디는 " + response + " 입니다.");
					}, error : function() {

					}
				});
			});
		});
	</script>
	
</body>
</html>