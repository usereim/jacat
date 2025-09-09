<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<main>
		<h2>회원가입</h2>

		<form action="<c:url value='/user/join' />" method="post" id="sign_form" enctype="multipart/form-data">
			아이디 : <input type="text" name="id">
			<br>
			<div id="id_message" class="message"></div>
			닉네임 : <input type="text" name="nick">
			<br>
			<div id="nick_message" class="message"></div>
			비밀번호 : <input type="password" name="pw">
			<br>
			<div id="pw_message" class="message"></div>
			비밀번호 확인 : <input type="password" name="re_pw">
			<br>
			<div id="re_pw_message" class="message"></div>
			이메일 : <input type="text" name="email">
			<button type="button" id="emailBtn" disabled>인증하기</button>
			<br>
			<div id="email_message" class="message"></div>
			이메일 인증번호 : <input type="text" name="code">
			<button type="button" id="codeBtn" disabled>인증하기</button> <br>
			프로필 이미지 : <input type="file" name="profile">
			<br>
			<div id="profile_message" class="message"></div>
			<br>
			<input type="submit" value="회원가입">
		</form>
	</main>

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
										id_check = false;
									} else {
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
								},
								success : function(response) {
									if (response.code == 1) {
										$("#nick_message").text("사용중인 닉네임입니다.")
												.css("color", "red");
										nick_check = false;
									} else {
										nick_check = true;
									}
								},
								error : function() {
									nick_check = false;
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
										email_check = false;
										$("#emailBtn").prop("disabled", true);
									} else {
										email_check = true;
										$("#emailBtn").prop("disabled", false);
									}
								},
								error : function() {
									email_check = false;
									$("#emailBtn").prop("disabled", true);
								}
							});
						}
					});

			$("#emailBtn").click(function() {
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
								$("#codeBtn").removeAttr("disabled");
							}
						},
						error : function() {

						}
					});
				}
			});
			
			$("#codeBtn").click(function() {
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
								$("#codeBtn").prop("disabled", true);
							} else {
								email_check = false;
								$("#codeBtn").prop("disabled", false);
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
			    	profile_check = true;
			    } else {
			    	_this.val('');
			        $("#profile_message").text("프로필 이미지는 이미지 파일만 업로드 할수 있습니다.");
			        profile_check = false;
			    }
			}); 

			function checkId() {
				let regex = /^[a-z0-9]{5,20}$/;
				let id = $("input[name=id]").val();

				if (regex.test(id)) {
					$("#id_message").text("");
					return true;
				} else {
					$("#id_message").text("아이디는 5~20자의 영문 소문자, 숫자만 사용 가능합니다.")
							.css("color", "red");
					return false;
				}
			}

			function checkEmail() {
				let regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
				let email = $("input[name=email]").val();

				if (regex.test(email)) {
					$("#email_message").text("");
					return true;
				} else {
					$("#email_message").text("이메일 양식을 확인해주세요").css("color",
							"red");
					return false;
				}
			}

			function checkNick() {
				let regex = /^[a-z0-9]{8,16}$/;
				let nick = $("input[name=nick]").val();

				if (regex.test(nick)) {
					$("#nick_message").text("");
					return true;
				} else {
					$("#nick_message").text("닉네임은 8~16자의 영문 소문자, 숫자만 사용 가능합니다")
							.css("color", "red");
					return false;
				}
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

				reCheckPw();
			}
			
			
			function reCheckPw() {
				let rePw = $("input[name=re_pw]").val();
				let pw = $("input[name=pw]").val();

				if (pw == '') {
					checkPw();
				}

				if (rePw == pw) {
					$("#re_pw_message").text("");
					pw_check = true;
				} else {
					$("#re_pw_message").text("입력한 비밀번호와 일치하지 않습니다.").css("color",
							"red");
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