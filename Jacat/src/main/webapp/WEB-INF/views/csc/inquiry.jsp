<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
<script>
		$(function() {
			$("#addBtn").click(function() {
				location.href = "<c:url value='/csc/write/I' />";
			});
			
			
		});
		
		function viewFn(boardsNum) {
			location.href = "<c:url value='/csc/view/I/" + boardsNum + "' />";
		}
		
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
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

		<div>
			<ul>
				<c:forEach var="boards" items="${boardsList }">
					<li onclick="viewFn(${boards.boardNum})">${boards.title }</li>
				</c:forEach>
			</ul>

			<c:if test="${sessionScope.user.id != null and sessionScope.user.grade == 'G'}">
				<button type="button" id="addBtn">문의 작성하기</button>
			</c:if>
		</div>
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>