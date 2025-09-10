<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<main>
		<div id="content">
			<h2>이메일 인증</h2>
			<p>아이디 : <p><input type="text" name="id">
			<p>이메일 : <p><input type="text" name="email">
			<button type="button" id="emailBtn">인증 번호</button>
			<div id="message"></div>
			<br>
			<p>이메일 인증 : <p><input type="text" name="code">
			<button type="button" id="codeBtn" disabled>인증</button>
		</div>
			<button type="button" id="loginBtn">로그인</button>
	</main>
	
	<script>
		$(function() {
			let id = $("input[name=id]").val();
			let email = $("input[name=email]").val();
			let pw_check = false;
			
			$("loginBtn").click(function() {
				location.href = "<c:url value='/user/login' />";
			});
			
			$("#emailBtn").click(function() {
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
								sendMail();
							} else {
								$("#message").text("등록된 아이디, 이메일이 없습니다.").css("color", "red");
							}
						}, error : function() {
							
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
								changeContent();
							} else {
								
							}
						}, error : function() {
							email_check = false;
						}
					});
				}
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
							$("#codeBtn").removeAttr("disabled");
						}
					},
					error : function() {

					}
				});
			}
			
			function changeContent() {
				let content = $("#content");
				content.children().remove();
				
				let h2 = $("<h2>");
				h2.text("비밀번호 변경");
				content.append(h2);
				
				let p1 = $("<p>").text("수정 비밀번호 : ");
				content.append(p1);
				
				let input1 = $("<input>").attr("type", "password").attr("name", "pw")
				.on("keyup", function() {
					checkPw();
				});
				content.append(input1);
				
				let div1 = $("<div>").attr("id", "pw_message");
				content.append(div1);
				
				let p2 = $("<p>").text("비밀번호 확인 : ");
				content.append(p2);
				
				let input2 = $("<input>").attr("type", "password").attr("name", "re_pw")
				.on("keyup", function() {
					reCheckPw();
				});
				content.append(input2);
				
				let div2 = $("<div>").attr("id", "re_pw_message");
				content.append(div2);
				
				let button = $("<button>").attr("type", "button").attr("id", "pwChangeBtn").text("비밀번호 변경")
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

				/* reCheckPw(); */
			}
			
			function reCheckPw() {
				let rePw = $("input[name=re_pw]").val();
				let pw = $("input[name=pw]").val();

				/* if (pw == '') {
					checkPw();
				} */

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