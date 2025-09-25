<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<style>
	td {
        border: 1px solid #222;
        padding: 10px 8px;
        line-height: 1.6;
        height: 40px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    td:nth-child(1) { width: 20%; text-align: left; font-weight: bold;}
    td:nth-child(2) { width: 80%; text-align: left; }

    /* 테이블 행 구분선과 배경 */
    table tr {
        border-bottom: 1px solid #ccc;
    }
    table tr:nth-child(even) {
        background-color: #f7f7f7;
    }

    /* 제목 링크 강조 */
    td:first-child a {
        font-weight: bold;
        color: #000;
    }
    td:first-child a:hover {
        text-decoration: underline;
    }
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>

	<main>
		<section id="section_area">
			<h2>회원 정보 수정</h2>
			
			<form action="<c:url value='/user/modify' />" method="post" enctype="multipart/form-data">
				<table>
					<tr>
						<td>아이디</td>
						<td>${userVO.id }</td>
					</tr>
				
				</table>
			
				닉네임 : <input type="text" name="nick" value="${userVO.nick }"> <br>
				<div id="nick_message"></div>
				이메일 : <input type="text" name="email" value="${userVO.email }"> <br>
				<div id="email_message"></div>
				프로필 이미지 : <br>
				<c:if test="${not empty userVO.realFileName }">
					<img id="profile_img" width="300px" alt="프로필 이미지" src="<c:url value='/uploads/profile/${userVO.id }/${userVO.fileName }'/>"> <br>
					<button type="button" id="profile_delete_btn">프로필 이미지 삭제</button>
				</c:if>
				<c:if test="${empty userVO.realFileName }">
					<input type="file" name="profile"> <br>
				</c:if>
				<input type="submit" id="submit" value="수정하기"> <br>
			</form>
			
			
			<button type="button" id="cancle_btn">수정 취소</button>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			let nick = $("input[name=nick]").val();
			let email = $("input[name=email]").val();
			
			let nick_check = true;
			let email_check = true;
			
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
									certEmail();
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
			
			function certEmail() {
				if ($("#email_btn").attr("id") === undefined) {
					let target = $("#email_message");
					
					let button = $("<button>").attr("type", "button").attr("id", "email_btn").text("인증 번호 전송")
					.on("click", function() {
						email = $("input[name=email]").val();
						
						$.ajax({
							url : "<c:url value='/mail/send-mail' />",
							type : "post",
							data : {
								"email" : email
							}, success : function(response) {
								if (response == 'success') {
									let target = $("#email_btn");
									
									let input = $("<input>").attr("type", "text").attr("name", "code").attr("placeholder", "인증 번호 입력");
									target.after(input);
									
									target = $("input[name=code]");
									let button = $("<button>").attr("type", "button").attr("id", "code_btn").text("인증")
									.on("click", function() {
										let code = $("input[name=code]").val();
										
										$.ajax({
											url : "<c:url value='/mail/code-check' />",
											type : "post",
											data : {
												"code" : code
											}, success : function(response) {
												if (response == 'success') {
													email_check = true;
													$("#code_btn").prop("disabled", true);
												} else if (response == 'fail') {
													email_check = false;
												}
											}, error : function() {
												
											}
										});
									});
									target.after(button);
								}
							}, error : function() {
								
							}
						});
					});
					target.before(button);
					
					
				} else {
					
				}
			}
			
			$("#profile_delete_btn").click(function() {
				let target = $("#submit");
				
				$("#profile_img").remove();
				$("#profile_delete_btn").remove();
				
				let input = $("<input>").attr("type", "file").attr("name", "profile");
				target.before(input);
			});
			
			$("#cancle_btn").click(function() {
				location.href = "<c:url value='/mypage/view-user' />";
			});
			
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