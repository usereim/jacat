<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<style>
	#section_area {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 15px;
	}
	
	form#form_area {
		width: 80%;
		margin: 0 auto;		
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 20px;
	}

	table {
        border-collapse: collapse;
        font-size: 15px;
        table-layout: fixed;
        margin: 0 auto;
    }

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
    td:nth-child(2) { width: 40%; text-align: left; }
    td:nth-child(3) { width: 40%; text-align: left; }

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
    
    input.form-control {
    	width: 200px;
    }
    
    #btn_area {
    	display: flex;
    	gap: 20px;
    }
    
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>

	<main>
		<section id="section_area">
			<h2 class="text-primary-emphasis">회원 정보 수정</h2>
			
			<form id="form_area" action="<c:url value='/user/modify' />" method="post" enctype="multipart/form-data">
				<table>
					<tr>
						<td>아이디</td>
						<td>${userVO.id }</td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td><input type="text" id="nick" name="nick" class="form-control" value="${userVO.nick }"></td>
						<td id="nick_message"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>
							<input type="text" id="email" name="email" class="form-control" value="${userVO.email }">
							<button type="button" id="email_btn" class="btn btn-primary" disabled>인증번호 전송</button>
						</td>
						<td id="email_message"></td>
					</tr>
					<tr>
						<td>인증번호</td>
						<td>
							<input type="text" id="code" name="code" class="form-control">
							<button type="button" id="code_btn" class="btn btn-primary" disabled>인증</button>
						</td>
						<td id="code_message"></td>
					</tr>
					<tr>
						<td>프로필 이미지</td>
						<td id="profile_target">
							<c:if test="${not empty userVO.realFileName }">
								<img id="profile_img" width="300px" alt="프로필 이미지" src="<c:url value='/uploads/profile/${userVO.id }/${userVO.fileName }'/>"> 
								<button type="button" id="profile_delete_btn" class="btn btn-primary">프로필 이미지 삭제</button>
							</c:if>
							<c:if test="${empty userVO.realFileName }">
								<input type="file" id="profile" name="profile"> 
							</c:if>
						</td>
						<td id="profile_message"></td>
					</tr>
				</table>
				
				<div id="btn_area">
					<input type="submit" id="submit" value="수정하기" class="btn btn-primary">
					<button type="button" id="cancle_btn" class="btn btn-primary">수정 취소</button>
				</div>				
			</form>
			
			
			
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			let nick = $("input[name=nick]").val();
			let email = $("input[name=email]").val();
			
			let nick_check = true;
			let email_check = true;
			let profile_check = true;
			
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
									$("#email_btn").prop("disabled", false);
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
			
			$("#email_btn").click(function() {
				let email = $("#email").val();
				
				$.ajax({
					url : "<c:url value='/mail/send-mail' />",
					type : "post",
					data : {
						"email" : email
					}, success : function(response) {
						if (response == "success") {
							$("#code_btn").prop("disabled", false);
						} else {
							
						}
					}, error : function() {
						
					}
				});
			}); 
		
			$("#code_btn").click(function() {
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
							$("#code_message").text("");
						} else if (response == 'fail') {
							email_check = false;
							$("#code_message").text("코드를 확인해주세요").css("color", "red");
						}
					}, error : function() {
						
					}
				});
			});
			
			$("#profile_delete_btn").click(function() {
				let target = $("#profile_target");
				
				$("#profile_img").remove();
				$("#profile_delete_btn").remove();
				
				let input = $("<input>").attr("type", "file").attr("name", "profile").attr("id", "profile");
				target.append(input);
			});
			
			$("#cancle_btn").click(function() {
				location.href = "<c:url value='/mypage/view-user' />";
			});
			
			$("#profile").change(function() {
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
			
			$("form").submit(function() {
				if (!nick_check) {
					return false;
				}
				
				if (!email_check) {
					return false;
				}
				
				if (!profile_check) {
					return false;
				}
				
				return true;
			});
		});
	</script>
</body>
</html>