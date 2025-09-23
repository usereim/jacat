<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시험장 정보</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	
	<main>
		<section id="content_area">
			<div id="content">
				<p>시험장 이름 : ${center.examAreaNm }</p>
				<p>시험장 주소 : ${center.address }</p>
				<p>지사 명 : ${center.brchNm}</p>
				<p>장소위치 안내 : ${center.plceLoctGid }</p>
				<p>전화번호 : ${center.telNo }</p>
			</div>
			
			<button type="button" id="back_btn">뒤로가기</button>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
	
	<script>
		$(function() {
			$("#back_btn").click(function() {
				location.href = "<c:url value='/licenses/center/list' />";
			});
		});
	</script>
</body>
</html>