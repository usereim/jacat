<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	
	<main>
		<section id="tab_area">
			<div id="user_info_tab">
				회원 정보 조회
			</div>
			
			<div id="user_board_tab">
				회원 게시글 조회
			</div>
			
			<div id="user_comment_tab">
				회원 댓글 조회
			</div>
			
			<div id="user_favorite_license_tab">
				회원 관심자격증 조회
			</div>
		</section>
		
		<section id="content_area">
			<div id="content">
			
			</div>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			function userInfoTab() {
				$("#user_info_tab").css("backgroundColor", "#6495ed");
				
				$.ajax({
					url : "<c:url value='/mypage/view-user' />",
					type : "post",
					success : function(response) {
						let target = $("div#content");
						
						let div = $("<div>");
						div.text("아이디 : " + response.id);
						target.append(div);
						
						div = $("<div>");
						div.text("닉네임 : " + response.nick);
						target.append(div);
						
						div = $("<div>");
						div.text("이메일 : " + response.email);
						target.append(div);
						
						div = $("<div>");
						div.text("프로필 이미지 : ");
						if (response.realFileName != null) {									
							let img = $("<img>");
							img.attr("width", "300px")
							.attr("alt", "프로필 이미지")
							.attr("src", response.path + "/" + response.fileName);
							
							div.append(img);
							target.append(div);
						}
						
						let button = $("<button>");
						button.attr("type", "button").attr("id", "user_mod_btn").text("회원정보 수정")
						.on("click", function() {
							location.href = "<c:url value='/mypage/modify-user' />";
						});
						target.append(button);
						
					}, error : function(request, status, error) {
						console.log("code: " + request.status)
				        console.log("message: " + request.responseText)
				        console.log("error: " + error);
					}
				});
			}
			
			userInfoTab();
		});
	</script>
</body>
</html>