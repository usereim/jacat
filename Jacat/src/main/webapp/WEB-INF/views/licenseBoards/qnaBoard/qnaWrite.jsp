<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>QnA 게시글 작성</title>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<section id="licenseQnABoardWriteSubtitleBox">
				<h2>${board.licenseName } QnA 게시판</h2>
				<h3>글쓰기</h3>
				<hr>
			</section>
			<section id="licenseQnABoardWriteContentBox">
				<div class="contentBox">
					<form action="<c:url value='/licenses/QnA/write'/>" method="post">
						<p class="writeTitleBox">
							<label for="title">제목 : </label>
							<input type="text" name="title" id="title">
						</p>
						<p class="writeContentBox">
							<label for="content">내용 : </label>
							<textarea name="content" id="content"></textarea>
						</p>
						<p class="writeFileBox">
							<input type="file" name="file" multiple>
						</p>
						<button type="submit">작성</button>
					</form>
				</div>
			</section>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
		
	</body>
</html>