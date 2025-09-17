<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정지 회원 이의신청</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
<script>
	function clickFn(boardNum) {
		location.href = "<c:url value='/csc/view/A/" + boardNum + "' />";
	}
	
	function addFn() {
		location.href = "<c:url value='/csc/write/A' />";
	}
</script>
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
		
		<div id="content">
			<p>정지회원 이의신청</p>
			<c:if test="${not empty sessionScope.suspend}">
				<ul>
					<c:forEach var="csc" items="${cscList}">
						<li onclick="clickFn(${csc.boardNum})">
							${csc.title }
						</li>
					</c:forEach>
				</ul>
				<button type="button" id="add_btn" onclick="addFn()">이의 신청 하기</button>
			</c:if>
		</div>
		<br>
		
		<!-- 세션의 이메일 인증 여부 확인하여 이메일 인증이 되었으면 화면에 안만듬 -->
		<c:if test="${empty sessionScope.suspend}">
			<div id="email">
				아이디 : <input type="text" name="id"> <br>
				<div id="id_message"></div>
				이메일 : <input type="text" name="email"> <br>
				<div id="email_message"></div>
				<button type="button" id="emailBtn" disabled>인증번호 전송</button> <br>
				인증 번호 : <input type="text" name="code"> <br>
				<button type="button" id="codeBtn" disabled>인증번호 확인</button> <br>
			</div>
		</c:if>
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			let id;
			let email;
			
			function sessionSuspend() {
				id = $("input[name=id]").val();
				
				$.ajax({
					url : "<c:url value='/csc/session-suspend' />",
					type : "post",
					data : {
						"id" : id
					}, success : function(response) {
						console.log(response);
					}, error : function() {
						
					}
				});
			}
			
			$("input[name=id]").keyup(function() {
				id = $("input[name=id]").val();
				
				$.ajax({
					url : "<c:url value='/user/id-suspend' />",
					type : "post",
					data : {
						"id" : id
					}, success : function(response) {
						if (response.code == 0) {
							$("#id_message").text("정지회원이 아닙니다.").css("color", "red");
							$("#emailBtn").prop("disabled", true);
						} else {
							$("#id_message").text("");
							$("#emailBtn").prop("disabled", false);
						}
					}, error : function() {
						
					}
				});
			});
			
			$("input[name=email]").keyup(function() {
				email = $("input[name=email]").val();
				id = $("input[name=id]").val();
				
				$.ajax({
					url : "<c:url value='/user/idmail-check' />",
					type : "post",
					data : {
						"id" : id,
						"email" : email
					}, success : function(response) {
						if (response.code == 0) {
							$("#email_message").text("등록되지 않은 회원 정보입니다.").css("color", "red");
							$("#emailBtn").prop("disabled", true);
						} else {
							$("#email_message").text("");
							$("#emailBtn").prop("disabled", false);
						}
					}, error : function() {
						
					}
					
				});
			});
			
			$("#emailBtn").click(function() {
				email = $("input[name=email]").val();
				
				$.ajax({
					url : "<c:url value='/mail/send-mail' />",
					type : "post",
					data : {
						"email" : email
					}, success : function(response) {
						if (response == 'success') {
							$("#emailBtn").prop("disabled", true);
							$("#codeBtn").prop("disabled", false)
						} else {
							$("#codeBtn").prop("disabled", true);
						}
					}, error : function() {
						
					}
				});
			});
			
			$("#codeBtn").click(function() {
				let code = $("input[name=code]").val();
				
				$.ajax({
					url : "<c:url value='/mail/code-check' />",
					type : "post",
					data : {
						"code" : code
					}, success : function(response) {
						if (response == 'success') {
							// 세션에 이메일 인증 여부 저장
							sessionSuspend();
							location.href = "<c:url value='/csc/tab/A' />";
						} else if (response == 'fail') {
						}
					}, error : function() {
						
					}
				});
			});
		});
	</script>
</body>
</html>