<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
	main {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	section#section_area h2 {
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
		margin-bottom: 10px;
		align-items: center;
		gap: 10px;
	}
	
	.input_area label {
		font-size: 20px;
		width: 20%;
	}
	
	input.form-control {
		width: 350px;
	}
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>

	<main>
		<section id="section_area">
			<h2 class="text-primary">이메일 인증</h2>
			
			<div class="input_area">
				<label for="id" class="text-primary">아이디</label>
				<input type="text" name="id" id="id" class="form-control">
			</div>
			
			<div class="input_area">
				<label for="email" class="text-primary">이메일</label>
				<input type="text" name="email" id="email" class="form-control">
				<button type="button" id="email_btn" class="btn btn-primary">인증번호 전송</button>
			</div>
			
			<div id="message"></div>
			
			<div class="input_area">
				<label for="code" class="text-primary">인증번호</label>
				<input type="text" name="code" class="form-control">
				<button type="button" id="code_btn" class="btn btn-primary" disabled>인증</button>
			</div>
			
			<button type="button" id="login_btn" class="btn btn-primary">로그인</button>
		</section>
		
			
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			let id = $("input[name=id]").val();
			let email = $("input[name=email]").val();
			let pw_check = false;
			
			$("login_btn").click(function() {
				location.href = "<c:url value='/user/login' />";
			});
			
			$("#email_btn").click(function() {
				id = $("input[name=id]").val();
				email = $("input[name=email]").val();
				
				if (id != '' && email != '') {
					$.ajax({
						url : "<c:url value='/user/idmail-check' />",
						type : "post",
						data : {
							"id" : id,
							"email" : email
						}, success : function(response) {
							if (response.code == 1) {
								$("#message").text("");
								sendMail();
							} else {
								$("#message").text("등록된 아이디, 이메일이 없습니다.").css("color", "red");
							}
						}, error : function() {
							
						}
					});
				}
			});
			
			$("#code_btn").click(function() {
				let code = $("input[name=code]").val();
				
				if (code != '') {
					$.ajax({
						url : "<c:url value='/mail/code-check' />",
						type : "post",
						data : {
							"code" : code
						}, success : function(response) {
							if (response == "success") {
								changeContent();
							} else {
								
							}
						}, error : function() {
							email_check = false;
						}
					});
				}
			});
			
			$("#login_btn").click(function() {
				location.href = "<c:url value='/user/login' />";
			});
			
			function sendMail() {
				email = $("input[name=email]").val(); 
				
				$.ajax({
					url : "<c:url value='/mail/send-mail' />",
					type : "post",
					data : {
						"email" : email
					},
					success : function(response) {
						if(response == "success") {
							$("#code_btn").removeAttr("disabled");
						}
					},
					error : function() {

					}
				});
			}
			
			function changeContent() {
				let content = $("#section_area");
				content.children("div").remove();
				content.children("button").remove();
				
				let h2 = content.children("h2").detach();
				h2.text("비밀번호 변경");
				content.append(h2);
				
				let inputArea = $("<div>").attr("class", "input_area text-primary").css({
					"disply" : "flex",
					"flex-direction" : "column",
					"align-items" : "flex-start",
					"gap" : "10px"
				});
				
				let input = $("<div>").attr("class", "input").css({
					"display" : "flex",
					"align-items" : "flex-end",
					"gap" : "10px"
				});
				
				let label = $("<label>").attr("for", "pw").text("비밀번호");
				input.append(label);
				
				let pw = $("<input>").attr("type", "password").attr("name", "pw").attr("id", "pw").attr("class", "form-control")
				.on("keyup", function() {
					checkPw();
				});
				input.append(pw);
				inputArea.append(input);
				
				let pwMessage = $("<div>").attr("id", "pw_message");
				inputArea.append(pwMessage);
				content.append(inputArea);
				
				inputArea = $("<div>").attr("class", "input_area text-primary").css({
					"disply" : "flex",
					"flex-direction" : "column",
					"align-items" : "flex-start",
					"gap" : "10px",
				});
				
				input = $("<div>").attr("class", "input").css({
					"display" : "flex",
					"align-items" : "flex-end",
					"justify-content" : "center",
					"gap" : "10px"
				});
				
				label = $("<label>").attr("for", "re_pw").text("비밀번호 확인");
				input.append(label);
				
				let rePw = $("<input>").attr("type", "password").attr("name", "re_pw").attr("id", "re_pw").attr("class", "form-control")
				.on("keyup", function() {
					reCheckPw();
				});
				input.append(rePw);
				inputArea.append(input);
				
				let rePwMessage = $("<div>").attr("id", "re_pw_message");
				inputArea.append(rePwMessage);
				content.append(inputArea);
				
				let button = $("<button>").attr("type", "button").attr("id", "pwChange_btn").attr("class", "btn btn-primary").text("비밀번호 변경")
				.on("click", function() {
					pwChange();
				});
				content.append(button);
			}
			
			function checkPw() {
				let regex = /^(?=.*[a-z])(?=.*[0-9])[a-zA-Z0-9!@#$%^&*()\-_+={[}\]|\:;"'<,>.?\/]{8,16}$/;
				let pw = $("input[name=pw]").val();

				if (regex.test(pw)) {
					$("#pw_message").text("");
					pw_check = true;
				} else {
					$("#pw_message").text(
							"비밀번호는 8~16자의 영문 대/소문자, 숫자, 특수문자만 사용가능합니다.").css(
							"color", "red");
					pw_check = false;
				}

			}
			
			function reCheckPw() {
				let rePw = $("input[name=re_pw]").val();
				let pw = $("input[name=pw]").val();

				if (rePw == pw) {
					$("#re_pw_message").text("");
					pw_check = true;
				} else {
					$("#re_pw_message").text("입력한 비밀번호와 일치하지 않습니다.").css("color",
							"red");
					pw_check = false;
				}
			}
			
			function pwChange() {
				let pw = $("input[name=pw]").val();
				
				if (pw_check == true) {
					$.ajax({
						url : "<c:url value='/user/pw-search' />",
						type : "post",
						data : {
							"pw" : pw,
							"email" : email
						}, success : function(response) {
							if (response.code == 1) {
								alert("비밀번호가 변경되었습니다.");
								location.href = "<c:url value='/user/login' />";
							} else {
								alert("비밀번호가 변경되지 않았습니다.");
								location.href = "<c:url value='/user/pw-search' />";
							}
						}, error : function() {
							
						}
					});
				}
			}
		});
	</script>
</body>
</html>