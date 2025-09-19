<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>

	<main>
		<p>회원 정보 수정</p>
		<p>아이디 : ${userVO.id }</p>
		<form action="" method="post" enctype="multipart/form-data">
			닉네임 : <input type="text" name="nick" value="${userVO.nick }"> <br>
			<div id="nick_message"></div>
			이메일 : <input type="text" name="email" value="${userVO.email }"> <br>
			<div id="email_message"></div>
			프로필 이미지 : <br>
			<c:if test="${not empty userVO.realFileName }">
				<img width="300px" alt="프로필 이미지" src=""> <br>
				<button type="button">프로필 이미지 삭제</button>
			</c:if>
			<c:if test="${empty userVO.realFileName }">
				프로필 이미지 등록 :
				<input type="file"> <br>
			</c:if>
			<input type="submit" value="수정하기"> <br>
		</form>
		<button type="button" id="">수정 취소</button>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			let nick = $("input[name=nick]").val();
			let email = $("input[name=email]").val();
			
			let nick_check = false;
			let email_check = false;
			
			$("input[name=nick]").keyup(function() {
				nick_check = false;
				
				let _nick = $("input[name=nick]").val();
				
				if (!checkNick()) {
					return false;
				} else {
					if (nick == _nick) {
						nick_check = true;
						$("#nick_message").text("");
					} else {
						$.ajax({
							url : "<c:url value='/user/nick-check' />",
							type : "post",
							data : {
								"nick" : _nick
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
				}
			});
			
			$("input[name=email]").keyup(function() {
				email_check = false;

				let _email = $("input[name=email]").val();

				if (!checkEmail()) {
					return false;
				} else {
					if (email == _email) {
						email_check = true;
						$("#email_message").text("");
					} else {
						$.ajax({
							url : "<c:url value='/user/email-check' />",
							type : "post",
							data : {
								"email" : _email
							},
							success : function(response) {
								if (response.code == 1) {
									$("#email_message").text("사용중인 이메일입니다.").css("color", "red");
									email_check = false;		
								} else {
									email_check = true;
								}
							},
							error : function() {
								email_check = false;
							}
						});
					}	
				}
			});
			
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
			
			$("form").submit(function() {
				if (!nick_check) {
					return false;
				}
				
				if (!email_check) {
					return false;
				}
				
				return true;
			});
		});
	</script>
</body>
</html>