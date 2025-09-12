<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<style>

</style>
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
		
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
		});
	</script>
</body>
</html>