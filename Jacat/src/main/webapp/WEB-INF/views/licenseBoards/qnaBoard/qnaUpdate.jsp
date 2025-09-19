<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${jmfldnm } QnA 게시판 글 수정 페이지</title>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<section id="licenseQnABoardUpdateSubtitleBox">
				<h2>${jmfldnm } QnA 게시판</h2>
				<h3>글 수정</h3>
				<hr>
			</section>
			<section id="licenseQnABoardUpdateContentBox">
				<div class="contentBox">
					<form action="<c:url value='/licenses/lists/${jmcd }/QnA/${board.boardNum}/update'/>" method="post">
						<p class="writeTitleBox">
							<label for="utitle">제목 : </label>
							<input type="text" name="title" id="utitle" value="${board.title }">
						</p>
						<p class="updateContentBox">
							<label for="ucontent">내용 : </label>
							<textarea name="content" id="ucontent">${board.content }</textarea>
						</p>
						<!--p class="writeFileBox">
							<input type="file" name="file">
						</p-->
						<button type="submit">수정</button>
					</form>
				</div>
			</section>
			
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>