<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style>
	input.form-control {
		width: 350px;
	}
	
	main {
		width: 1200px;
		margin: 0 auto;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	main h2 {
		margin-bottom: 60px;
	}
	
	form#form_area {
		width: 80%;
		margin: 0 auto;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 15px;
		margin-bottom : 60px;
	}
	
	.input_area {
		width: 50%;
		display: flex;
		margin-bottom: 10px;
		align-items: center;
	}
	
	.input_area label {
		font-size: 20px;
		width: 20%;
	}
	
	#btn_area {
		display: flex;
		gap: 15px;
		margin-bottom: 60px;
	}
</style>

<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>

	<main>
		<h2 class="text-primary">로그인</h2>
		<form id="form_area" action="<c:url value='/user/login'/>" method="post">
			<div class="input_area">
				<label for="id" class="text-primary">아이디</label>
				<input type="text" name="id" id="id" class="form-control">
			</div>
			
			<div class="input_area">
				<label for="pw" class="text-primary">비밀번호</label>
				<input type="password" name="pw" id="pw" class="form-control">
			</div>
			
			<input type="submit" value="로그인" class="btn btn-primary">
		</form>
		
		<section id="btn_area">
			<button type="button" id="idSearchBtn" class="btn btn-primary">아이디 찾기</button>
			<button type="button" id="pwSearchBtn" class="btn btn-primary">비밀번호 찾기</button>
			<button type="button" id="signupBtn" class="btn btn-primary">회원가입</button>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			$("#idSearchBtn").click(function() {
				location.href = "<c:url value='/user/id-search' />";
			});
			
			$("#pwSearchBtn").click(function() {
				location.href = "<c:url value='/user/pw-search' />";
			});
			
			$("#signupBtn").click(function() {
				location.href = "<c:url value='/user/signup' />";
			});
		});
	</script>
</body>
</html>