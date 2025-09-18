<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${jmfldnm } QnA 게시판 상세조회</title>
		<script src="<c:url value='/resources/js/jquery-3.7.1.min.js'/>"></script>
		<script>
			function commentWriteFn(){
				
				let comment = $("input[name=comment]").val();
				let jmcd = "${jmcd}";
				let boardNum = "${boardNum}";
				
				let url = "<c:url value='licenses/lists/";
				url += jmcd;
				url += "/QnA/";
				url += boardNum;
				url += "/comment/write'/>";
				
				alert(url);
				
				$.ajax({
					url : url,
					type : "post",
					data : {
						"usersId" : '${sessionScope.user.id}',
						"licenseBoardsBoardNum" : boardNum,
						"content" : comment
					},
					success : function(cvo){
						console.log(cvo);
						console.log(url);
						console.log("<c:url value='licenses/lists/"+jmcd+"/QnA/"+boardNum+"/comment/write'/>");
					},
					error : function(cvo){
						
						console.log(comment);
						console.log(cvo);
						console.log(url);
						console.log("<c:url value='licenses/lists/"+jmcd+"/QnA/"+boardNum+"/comment/write'/>");
					}
				});
				
			}
		</script>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<section id="licenseQnABoardSubtitleBox">
				<h2>${jmfldnm } QnA 게시판</h2>
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
				<hr>
				<div class="commentBox">
					<h3 class="commentSubtitle">댓글</h3>
					<c:choose>
						<c:when test="${empty sessionScope.user }">
							
						</c:when>
						<c:otherwise>
							<div class="commentWrite">
								<label for="commentInput">댓글 작성 : </label>
								<input type="text" name="comment" id="commentInput">
								<button type="button" onclick="commentWriteFn()">작성</button>
							</div>
							<hr>
						</c:otherwise>
					</c:choose>
					<div class="commentLists">
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
				</div>
			</section>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>