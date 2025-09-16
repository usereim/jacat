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
					let file = response.file;
					
					p = $("<p>");
					p.text(response.content);
					$(obj).append(p);
					
					
					if (file.boardsBoardNum == 0) {
					} else {
						let img = $("<img>");
						img.attr("width", "300px")
						.attr("src", "<c:url value='/uploads/boards/" + file.boardsBoardNum + "/" + file.fileName + "' />");
						$(obj).append(img);
					}
				}, error : function() {
				}
			});
		} else {
			$(obj).children("p").remove();
			$(obj).children("img").remove();
		}
	}
	
	function modify(boardNum) {
		location.href = "<c:url value='/csc/modify/Q/"+ boardNum + "' />";
	}
	
	function deleteFn(boardNum) {
		$.ajax({
			url : "<c:url value='/csc/delete' />",
			type : "post",
			data : {
				"boardType" : "Q",
				"boardNum" : boardNum
			}, success : function(response) {
				if (response == 'delete success') {
					$("." + boardNum).remove();
				}
			}, error: function() {
				
			}
		});
	}
	
	$(function() {
		$("#addBtn").click(function() {
			location.href = "<c:url value='/csc/write/Q' />";
		});
	});
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
				<a href="<c:url value='/csc/tab/I'/>">1:1 문의</a>
			</div>
			<div id="appeal">
				<a href="<c:url value="/csc/tab/A"/>">정지 회원 이의신청</a>
			</div>
		</div>

		<div id="content">
			<c:forEach var="boards" items="${boardsList }">
				<div class="${boards.boardNum }">
					<div class="faq-list" onclick="viewFAQ(this, ${boards.boardNum})">
						<h3>${boards.title }</h3>
					</div>
					<c:if test="${sessionScope.user.grade eq 'A' }">
						<button type="button" id="modBtn"
							onclick="modify(${boards.boardNum})">수정</button>
						<button type="button" id="delBtn"
							onclick="deleteFn(${boards.boardNum})">삭제</button>
					</c:if>
				</div>
			</c:forEach>
			<c:if test="${sessionScope.user.grade eq 'A'}">
				<button type="button" id="addBtn">FAQ등록</button>
			</c:if>
		</div>
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>