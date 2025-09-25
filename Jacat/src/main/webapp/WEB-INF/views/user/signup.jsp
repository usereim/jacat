<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	main {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	main h2 {
		margin-top: 20px;
		margin-bottom: 60px;
	}

	input.form-control {
		width : 350px;
	}
	
	form#form_area {
		width: 80%;
		margin: 0 auto;
		display: flex;
		flex-direction: column;
		align-items: flex-end;
		gap: 15px;
		margin-bottom : 60px;
	}
	
	.input_area {
		width: 70%;
		display: flex;
		flex-direction: column;
		margin-bottom: 10px;
		align-items: flex-start;
		gap: 10px;
	}
	
	.input {
		display: flex;
		gap: 5px;
	}
	
	.input_area label {
		font-size: 20px;
		width: 150px;
	}
</style>

<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>

	<main>
		<h2 class="text-primary">회원가입</h2>

		<form id="form_area" action="<c:url value='/user/join' />" method="post" id="sign_form" enctype="multipart/form-data">
			<div class="input_area">
				<div class="input">
					<label for="id" class="text-primary">아이디</label>
					<input type="text" name="id" id="id" class="form-control">
				</div>
				
				<div id="id_message" class="message"></div>
			</div>
			
			<div class="input_area">
				<div class="input">
					<label for="nick" class="text-primary">닉네임</label>
					<input type="text" name="nick" id="nick" class="form-control">
				</div>
				
				<div id="nick_message" class="message"></div>
			</div>
			
			<div class="input_area">
				<div class="input">
					<label for="pw" class="text-primary">비밀번호</label>
					<input type="password" name="pw" id="pw" class="form-control">
				</div>
				
				<div id="pw_message" class="message"></div>
			</div>
			
			<div class="input_area">
				<div class="input">
					<label for="re_pw" class="text-primary">비밀번호 확인</label>
					<input type="password" name="re_pw" id="re_pw" class="form-control">
				</div>
				
				<div id="re_pw_message" class="message"></div>
			</div>
			
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
					<button type="button" id="code_btn" class="btn btn-primary" disabled>인증</button> <br>
				</div>
				
				<div id="code_message" class="message"></div>
			</div>
			
			<div class="input_area">
				<div class="input">
					<label for="profile" class="text-primary">프로필 이미지</label>
					<input type="file" name="profile" id="profile" class="form-control">
				</div>
				
				<div id="profile_message" class="message"></div>
			</div>
			
			<input type="submit" class="btn btn-primary" id="submit" value="회원가입">
		</form>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>

	<script>
		$(function() {
			$(".message").css("color", "red");

			let id_check = false;
			let pw_check = false;
			let email_check = false;
			let nick_check = false;
			let profile_check = true;

			$("input[name=id]").keyup(
					function() {
						id_check = false;

						let id = $("input[name=id]").val();

						if (!checkId()) {
							return false;
						} else {
							$.ajax({
								url : "<c:url value='/user/id-check' />",
								type : "post",
								data : {
									"id" : id
								},
								success : function(response) {
									if (response.code == 1) {
										$("#id_message").text("사용중인 아이디입니다.")
												.css("color", "red");
										$("#id").removeClass("is-valid")
										$("#id").addClass("is-invalid");
										id_check = false;
									} else {
										$("#id").addClass("is-valid");
										$("#id").removeClass("is-invalid");
										id_check = true;
									}
								},
								error : function() {
									id_check = false;
								}
							});
						}
					});

			$("input[name=nick]").keyup(
					function() {
						nick_check = false;

						let nick = $("input[name=nick]").val();

						if (!checkNick()) {
							return false;
						} else {
							$.ajax({
								url : "<c:url value='/user/nick-check' />",
								type : "post",
								data : {
									"nick" : nick
								}, success : function(response) {
									if (response.code == 1) {
										$("#nick_message").text("사용중인 닉네임입니다.")
												.css("color", "red");
										$("#nick").removeClass("is-valid")
										$("#nick").addClass("is-invalid");
										nick_check = false;
									} else {
										$("#nick").addClass("is-valid");
										$("#nick").removeClass("is-invalid");
										nick_check = true;
									}
								}, error : function() {
									email_check = false;
								}
							});
						}
					});

			$("input[name=email]").keyup(
					function() {
						email_check = false;

						let email = $("input[name=email]").val();

						if (!checkEmail()) {
							return false;
						} else {
							$.ajax({
								url : "<c:url value='/user/email-check' />",
								type : "post",
								data : {
									"email" : email
								},
								success : function(response) {
									if (response.code == 1) {
										$("#email_message")
												.text("사용중인 이메일입니다.").css(
														"color", "red");
										$("#email").removeClass("is-valid")
										$("#email").addClass("is-invalid");
										email_check = false;
										$("#email_btn").prop("disabled", true);
									} else {
										$("#email").addClass("is-valid");
										$("#email").removeClass("is-invalid");
										email_check = true;
										$("#email_btn").prop("disabled", false);
									}
								},
								error : function() {
									email_check = false;
									$("#email_btn").prop("disabled", true);
								}
							});
						}
					});

			$("#email_btn").click(function() {
				let email = $("input[name=email]").val();
				
				if (checkEmail()) {
					$.ajax({
						url : "<c:url value='/mail/send-mail' />",
						type : "post",
						data : {
							"email" : email
						},
						success : function(response) {
							if(response == "success") {
								$("#email_message").text("");
								$("#email").addClass("is-valid");
								$("#email").removeClass("is-invalid");
								$("#code_btn").prpo("disabled", false);
							} else {
								$("#email_message").text("인즌번호 전송에 실패하였습니다. 이메일을 확인해 주세요.").css("color", "red");
								$("#email").addClass("is-invalid");
								$("#email").removeClass("is-valid");
							}
						},
						error : function() {

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
								email_check = true;
								$("#code_message").text("");
								$("#code").addClass("is-valid");
								$("#code").removeClass("is-invalid");
								$("#code_btn").prop("disabled", true);
							} else {
								email_check = false;
								$("#code_message").text("인증에 실패하였습니다. 인증번호를 확인해주세요.").css("color", "red");
								$("#code").addClass("is-invalid");
								$("#code").removeClass("is-valid");
								$("#code_btn").prop("disabled", false);
							}
						}, error : function() {
							email_check = false;
						}
					});
				}
			});
			
			$("input[name=profile]").change(function() {
				profile_check = false;
				
				let file = $(this)[0].files[0];
				let _this = $(this);
				let regex = /\.(jpe?g|png|gif|bmp|svg|webp)$/i;
				
				if (regex.test(file.name) && file.type.startsWith('image/')) {
			        $("#profile_message").text("");
			        $("#profile").addClass("is-valid");
					$("#profile").removeClass("is-invalid");
			    	profile_check = true;
			    } else {
			    	_this.val('');
			    	$("#profile").addClass("is-invalid");
					$("#profile").removeClass("is-valid");
			        $("#profile_message").text("프로필 이미지는 이미지 파일만 업로드 할수 있습니다.");
			        profile_check = false;
			    }
			}); 

			function checkId() {
				let regex = /^[a-z0-9]{5,20}$/;
				let id = $("input[name=id]").val();

				if (regex.test(id)) {
					$("#id_message").text("");
					$("#id").addClass("is-valid");
					$("#id").removeClass("is-invalid");
					return true;
				} else {
					$("#id_message").text("아이디는 5~20자의 영문 소문자, 숫자만 사용 가능합니다.")
							.css("color", "red");
					$("#id").removeClass("is-valid")
					$("#id").addClass("is-invalid");
					return false;
				}
			}

			function checkEmail() {
				let regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
				let email = $("input[name=email]").val();

				if (regex.test(email)) {
					$("#email_message").text("");
					$("#email").addClass("is-valid");
					$("#email").removeClass("is-invalid");
					return true;
				} else {
					$("#email_message").text("이메일 양식을 확인해주세요").css("color",
							"red");
					$("#email").removeClass("is-valid")
					$("#email").addClass("is-invalid");
					return false;
				}
			}

			function checkNick() {
				let regex = /^[a-z0-9]{8,16}$/;
				let nick = $("input[name=nick]").val();

				if (regex.test(nick)) {
					$("#nick_message").text("");
					$("#nick").addClass("is-valid");
					$("#nick").removeClass("is-invalid");
					return true;
				} else {
					$("#nick_message").text("닉네임은 8~16자의 영문 소문자, 숫자만 사용 가능합니다")
							.css("color", "red");
					$("#nick").removeClass("is-valid")
					$("#nick").addClass("is-invalid");
					return false;
				}
			}
			
			function checkPw() {
				let regex = /^(?=.*[a-z])(?=.*[0-9])[a-zA-Z0-9!@#$%^&*()\-_+={[}\]|\:;"'<,>.?\/]{8,16}$/;
				let pw = $("input[name=pw]").val();

				if (regex.test(pw)) {
					$("#pw_message").text("");
					$("#pw").removeClass("is-invalid")
					$("#pw").addClass("is-valid");
					pw_check = true;
				} else {
					$("#pw_message").text(
							"비밀번호는 8~16자의 영문 대/소문자, 숫자, 특수문자만 사용가능합니다.").css(
							"color", "red");
					$("#pw").removeClass("is-valid")
					$("#pw").addClass("is-invalid");
					pw_check = false;
				}
			}
			
			
			function reCheckPw() {
				let rePw = $("input[name=re_pw]").val();
				let pw = $("input[name=pw]").val();

				if (pw == '') {
					checkPw();
				}

				if (rePw == pw) {
					$("#re_pw_message").text("");
					$("#re_pw").removeClass("is-invalid")
					$("#re_pw").addClass("is-valid");
					pw_check = true;
				} else {
					$("#re_pw_message").text("입력한 비밀번호와 일치하지 않습니다.").css("color",
							"red");
					$("#re_pw").removeClass("is-valid")
					$("#re_pw").addClass("is-invalid");
					pw_check = false;
				}
			}
			
			$("input[name=pw]").keyup(function() {
				checkPw();
			});

			$("input[name=re_pw]").keyup(function() {
				reCheckPw();
			});
			
			$("form").submit(function() {
				if (!id_check) {
					return false;
				}
				
				if (!pw_check) {
					return false;
				}
				
				if (!email_check) {
					return false;
				}
				
				if (!nick_check) {
					return false;
				}
				
				if (!profile_check) {
					return false;
				}
				
				$("input[name=re_pw]").prop("disabled", true);
				$("input[name=code]").prop("disabled", true);
				return true;
			});
		});
	</script>
</body>
</html>