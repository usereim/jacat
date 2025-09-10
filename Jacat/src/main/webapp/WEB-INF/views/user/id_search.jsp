<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<main>
		<h2>아이디 찾기</h2>
		
		이메일 : <input type="text" name="email">
		<button type="button" id="emailBtn" disabled>인증 번호</button>
		<div id="email_message"></div>
		<br>
		이메일 인증 : <input type="text" name="code">
		<button type="button" id="codeBtn" disabled>인증</button>
		<br>
		<div id="result_id"></div>
		
		<button type="button" id="idSearchBtn" disabled>아이디 찾기</button>
		<button type="button" id="pwSearchBtn">비밀번호 찾기</button>
		<button type="button" id="loginBtn">로그인</button>
	</main>
	
	<script>
		$(function() {
			$("#pwSearchBtn").click(function() {
				location.href = "<c:url value='/user/pw-search' />";
			});
			
			$("#loginBtn").click(function() {
				location.href = "<c:url value='/user/login' />";
			});
			
			$("input[name=email]").keyup(function() {
				$("#emailBtn").prop("disabled", true);
				$("#idSearchBtn").prop("disabled", true);
				$("#codeBtn").prop("disabled", true);
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
								$("#emailBtn").prop("disabled", false);
							} else {
								$("#email_message").text("등록되지 않은 이메일입니다.").css("color", "red");
								$("#emailBtn").prop("disabled", true);
							}
						}, error : function() {
							
						}
					});
				} else {
					$("#email_message").text("이메일 양식을 확인해주세요").css("color",
							"red");
				}
			});
			
			$("#emailBtn").click(function() {
				let email = $("input[name=email]").val();
				
				$.ajax({
					url : "<c:url value='/mail/send-mail' />",
					type : "post",
					data : {
						"email" : email
					}, success : function(response) {
						if (response == 'success') {
							$("#codeBtn").prop("disabled", false);
						}
					}, error : function() {
						
					}
				});
			});
			
			$("#codeBtn").click(function() {
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
								$("#idSearchBtn").prop("disabled", false);
							} else {
								
							}
						}, error : function() {
							
						}
					});
				}
			});
			
			$("#idSearchBtn").click(function() {
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