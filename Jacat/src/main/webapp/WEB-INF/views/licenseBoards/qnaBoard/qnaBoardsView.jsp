<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>QnA 게시판 상세조회</title>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<section id="licenseQnABoardSubtitleBox">
				<h2>${board.licenseName } QnA 게시판</h2>
				<hr>
			</section>
			<section id="licenseQnABoardContentBox">
				<div class="contentInfoBox">
					<p class="contentTitle">${board.title }</p>
					<p class="contentAuthor">${board.nick }</p>
					<p class="contentWDate">${board.wDate }</p>
					<p class="contentVisitCount">${board.visitCount }</p>
				</div>
				<div class="contentBox">
					<p class="content">
						${board.content }
					</p>
				</div>
				<div class="fileBox">
					<h3 class="fileSubtitle">파일</h3>
					<c:forEach var="i" items="${board.lFile }">
						<p class="files">
							<span>${i.fileName }</span>
							<button>다운로드</button>
						</p>
					</c:forEach> 
				</div>
				<div class="commentBox">
					<h3 class="commentSubtitle">댓글</h3>
					<c:forEach var="i" items="${board.lComment }">
						<div class="comments">
							<ul>
								<li>${i.parentComment }</li>
								<li>${i.nick }</li>
								<li>${i.content }</li>
								<li>${i.wDate }</li>
							</ul>
						</div>
					</c:forEach>
				</div>
			</section>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>