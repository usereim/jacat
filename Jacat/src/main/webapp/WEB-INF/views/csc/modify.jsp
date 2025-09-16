<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />

	<main>
		<div>게시글 타입 : ${csc.boardType }</div>

		<form action="<c:url value="/csc/modify/${csc.boardType }/false/${csc.boardNum }" />" method="post"
			enctype="multipart/form-data">
			제목 : <input type="text" name="title" value="${csc.title }"> <br>
			내용 : <input type="text" name="content" value="${csc.content }">
			<br>

			<c:choose>
				<c:when test="${csc.boardsFile.boardsBoardNum != 0 }">
					<img width="300px" class="img"
						src="<c:url value="/uploads/boards/${csc.boardsFile.boardsBoardNum}/${csc.boardsFile.fileName } "/>">
					<button type="button" id="img_delete_btn">이미지 삭제</button>
					이미지 : <input type="file" name="img" disabled>
				</c:when>
				<c:otherwise>
					이미지 : <input type="file" name="img">
				</c:otherwise>
			</c:choose>


			

			<button type="button" id="cancle_btn">수정 취소</button>
			<input type="submit" value="수정하기">
		</form>
	</main>

	<c:import url="/WEB-INF/views/includes/footer.jsp" />

	<script>
		$(function() {
			$("#img_delete_btn").click(function() {
				$(".img").remove();
				$("#img_delete_btn").remove();

				$("input[name=img]").prop("disabled", false);
				$("form").attr("action", "<c:url value='/csc/modify/${csc.boardType}/true/${csc.boardNum}' />");
			});

			$("#cancle_btn").click(function() {
				location.href = "<c:url value='/csc/tab/Q'/>";
			});

			$("form").submit(function() {
				$("input[name=img]").prop("disabled", false);
			});
		});
	</script>
</body>
</html>