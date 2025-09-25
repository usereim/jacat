<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재확인</title>
<style>
	#section_area {
		display: flex;
		flex-direction: column;
		gap: 40px;
		align-items: center;
		margin-top: 200px;
	}
	
	#content {
		display: flex;
		gap: 15px;
		justify-content: center;
		align-items: center;
	}
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	
	<main>
		<section id="section_area">
			<h2 class="text-primary-emphasis">비밀번호 확인</h2>
			
			<div id="content">
				<label for="pw" class="text-primary-emphasis">비밀번호</label>
				<input type="password" name="pw" id="pw"> <br>
				<button type="button" id="pw_cert_btn" class="btn btn-primary">비밀번호 확인</button>
			</div>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		// 입력한 비밀번호가 로그인한 사용자의 정보와 일치하는지 검증
		$("#pw_cert_btn").click(function() {
			let pw = $("#pw").val();
			
			$.ajax({
				url : "<c:url value='/mypage/pw-cert' />",
				type : "post",
				data :{
					"pw" : pw
				}, success : function(response) {
					if (response.code == 1) {
						alert("비밀번호 인증 성공, 마이페이지로 이동합니다.");
						location.href = "<c:url value='/mypage/main' />";
					} else if (response.code == 0) {
						alert("비밀번호를 확인해 주세요.");
					} else {
						location.href = "<c:url value='/' />";
					}
				}, error : function() {
					
				}
			});
		});
	</script>
</body>
</html>