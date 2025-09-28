<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<style>
	h2 {
		text-align: center;
		margin-top: 60px;
	}
	
	#form_area {
		width: 70%;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 20px;
		margin: 0 auto;
		margin-top: 100px;
	}
	
	#input_area {
		display: flex;
		gap: 10px;
		align-items: center;
	}
	
	#input_area > input {
		width: 300px;
	}	
	
	#btn_area {
		display: flex;
		gap: 15px;
	}
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />

	<main>
		<c:choose>
			<c:when test="${csc.boardType eq 'Q'}">
				<h2 class="text-primary-emphasis">FAQ 수정</h2>
			</c:when>
			<c:when test="${csc.boardType eq 'I' }">
				<h2 class="text-primary-emphasis">1:1문의 수정</h2>
			</c:when>
			<c:when test="${csc.boardType eq 'A' }">
				<h2 class="text-primary-emphasis">정지회원 이의신청 수정</h2>
			</c:when>
		</c:choose>

		<form id="form_area" action="<c:url value="/csc/modify/${csc.boardType }/false/${csc.boardNum }" />" method="post"
			enctype="multipart/form-data">
			
			<div id="input_area">
				<label for="title" class="text-primary-emphasis">제목</label>
				<input type="text" id="title" name="title" value="${csc.title }" class="form-control">
			</div>
			
			<div id="input_area">
				<label for="content" class="text-primary-emphasis">내용</label>
				<input type="text" id="content" name="content" value="${csc.content }" class="form-control">
			</div>
			
			<c:choose>
				<c:when test="${csc.boardsFile.boardsBoardNum != 0 }">
					<div id="input_area" class="img_target">
						<label for="img" class="text-primary-emphasis">이미지</label>
						<img width="300px" id="img"
							src="<c:url value="/uploads/boards/${csc.boardsFile.boardsBoardNum}/${csc.boardsFile.fileName } "/>">
						<button type="button" id="img_delete_btn" class="btn btn-primary">이미지 삭제</button>
					</div>
				</c:when>
				<c:otherwise>
					<div id="input_area">
						<label for="img" class="text-primary-emphasis">이미지</label>
						<input type="file" id="img" name="img" class="form-control">
					</div>
				</c:otherwise>
			</c:choose>
			
			<div id="btn_area">
				<button type="button" id="cancle_btn" class="btn btn-primary">수정 취소</button>
				<input type="submit" value="수정하기" class="btn btn-primary">

			</div>
		</form>
	</main>

	<c:import url="/WEB-INF/views/includes/footer.jsp" />

	<script>
		$(function() {
			$("#img_delete_btn").click(function() {
				$("#img").remove();
				$("#img_delete_btn").remove();

				let img = $("<input>").attr("type", "file").attr("id", "img").attr("name", "img").attr("class", "form-control")
				$(".img_target").append(img);
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