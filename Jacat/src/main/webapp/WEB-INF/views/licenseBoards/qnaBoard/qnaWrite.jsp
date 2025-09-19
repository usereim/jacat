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
				<h2>${jmfldnm } QnA 게시판</h2>
				<h3>새글작성</h3>
				<hr>
			</section>
			<section id="licenseQnABoardWriteContentBox">
				<div class="contentBox">
					<form action="<c:url value='/licenses/lists/${jmcd }/QnA/write'/>" method="post">
						<p class="writeTitleBox">
							<label for="wtitle">제목 : </label>
							<input type="text" name="title" id="wtitle">
						</p>
						<p class="writeContentBox">
							<label for="wcontent">내용 : </label>
							<textarea name="content" id="wcontent"></textarea>
						</p>
						<!--p class="writeFileBox">
							<input type="file" name="file">
						</p-->
						<button type="submit">작성</button>
					</form>
				</div>
			</section>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
		
	</body>
</html>