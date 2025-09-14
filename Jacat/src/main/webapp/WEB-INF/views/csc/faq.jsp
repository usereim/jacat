<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
<script>
	function viewFAQ(obj, boardNum) {
		let p;
		if($(obj).children("p").text() == '') {
			$.ajax({
				url : "<c:url value='/csc/view' />",
				type : "post",
				data : {
					"boardNum" : boardNum,
					"type" : "Q"
				}, success : function(response) {
					p = $("<p>");
					p.text(response.content);
					$(obj).append(p);
				}, error : function() {
				}
			});
		} else {
			$(obj).children("p").remove();
		}
	}
	
	$(function() {
		$("#addBtn").click(function() {
			location.href = "<c:url value='/csc/write/Q' />";
		});
	});
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
				<a href="<c:url value='/csc/tab/I'/>">1:1 문의</a>
			</div>
			<div id="appeal">
				<a href="<c:url value="/csc/tab/A"/>">정지 회원 이의신청</a>
			</div>
		</div>
		
		<div id="content">
			<c:forEach var="boards" items="${boardsList }">
				<div class="faq-list" onclick="viewFAQ(this, ${boards.boardNum})">
					<h3>${boards.title }</h3>
				</div>
			</c:forEach>
			<c:if test="${sessionScope.user.grade eq 'A'}">
				<button type="button" id="addBtn">FAQ등록</button>
			</c:if>
		</div>
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>