<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정지 회원 이의신청</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	<main>
		<div id="tab">
			<div id="faq">
				<a href="<c:url value="/csc/tab/Q"/>">FAQ</a>
			</div>
			<div id="inquiry">
				<a href="<c:url value="/csc/tab/I"/>">1:1 문의</a>
			</div>
			<div id="appeal">
				<a href="<c:url value="/csc/tab/A"/>">정지 회원 이의신청</a>
			</div>
		</div>
		
		
		<div id="email">
			아이디 : <input type="text" name="id"> <br>
			<div id="id_message"></div>
			이메일 : <input type="text" name="email"> <br>
			<button type="button" id="emailBtn">인증번호 전송</button> <br>
			인증 번호 : <input type="text" name="code"> <br>
			<button type="button" id="codeBtn" disabled>인증번호 확인</button> <br>
		</div>
		<div id="content">
			<p>정지회원 이의신청</p>
		</div>
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			$("input[name=id]").keyup(function() {
				let id = $("input[name=id]").val();
				
				$.ajax({
					url : "<c:url value='/user/id-suspend' />",
					type : "post",
					data : {
						"id" : id
					}, success : function(response) {
						if (response.code == 0) {
							$("#id_message").text("정지회원이 아닙니다.").css("color", "red");
						} else {
							$("#id_message").text("");
						}
					}, error : function() {
						
					}
				});
			});
		});
	</script>
</body>
</html>