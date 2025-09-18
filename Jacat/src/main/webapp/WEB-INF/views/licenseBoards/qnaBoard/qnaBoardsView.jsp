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
			function commentWriteFn(parentCommentNum){
				
				let comment = $("input[name=comment]").val();
				let jmcd = "${jmcd}";
				let boardNum = "${boardNum}";
				
				let url = "<c:url value='/licenses/lists/";
				url += jmcd;
				url += "/QnA/";
				url += boardNum;
				url += "/comment/write'/>";
				//console.log(url);
				$.ajax({
					url : url,
					type : "post",
					data : {
						"usersId" : '${sessionScope.user.id}',
						"licenseBoardsBoardNum" : boardNum,
						"content" : comment,
						"parentCommentNum" : parentCommentNum
					},
					success : function(cvo){
						//console.log(cvo);
						//console.log(cvo.usersId);
						console.log($("commentBox"+cvo.parentCommentNum));
						alert("댓글 작성이 완료되었습니다.");
						
						let addCommentBox = "";
						addCommentBox += "<div id='commentBox"+cvo.commentNum+"' class='comments'>";
						addCommentBox += "	<ul>";
						addCommentBox += "		<li>"+cvo.parentCommentNum+"</li>";
						addCommentBox += "		<li>"+cvo.nick+"</li>";
						addCommentBox += "		<li>"+cvo.content+"</li>";
						addCommentBox += "		<li>"+cvo.wDate+"</li>";
						addCommentBox += "		<li id='commentBtnBox"+cvo.commentNum+"'>";
						
						let loginYn = "${sessionScope.user}";
						if(loginYn != null && cvo.parentCommentNum == 0){
							addCommentBox += "<button type='button' onclick='childCommentWriteFn("+cvo.commentNum+")'>대댓글 작성</button>";
						}
						//console.log(loginYn);
						
						let loginId = "${sessionScope.user.id}";
						if(loginId == cvo.usersId){
							addCommentBox += "<button type='button' onclick='commentUpdateFn("+cvo.commentNum+")'>댓글 수정</button>";
							addCommentBox += "<button type='button' onclick='commentDeleteFn("+cvo.commentNum+")'>댓글 삭제</button>";
						}
						
						addCommentBox += "		</li>";
						addCommentBox += "	</ul>";
						addCommentBox += "</div>";
						
						if(cvo.parentCommentNum == 0){
							
							
								
							$("#commentListsId").prepend(addCommentBox);
							
						}
						else{
							
							let addChildCommentBox = $("commentBox"+cvo.parentCommentNum);
							
							addChildCommentBox.append(addCommentBox);
							
						}
						
						
					},
					error : function(cvo){
						
						//console.log(comment);
						//console.log(cvo);
						//console.log(cvo.id);
						alert("댓글 작성이 실패하였습니다.");
					}
				});
				
			}
			
			function childCommentWriteFn(commentNum){
				let parentCommentBox = $("#commentBox"+commentNum);
				
				let childCommentBox = "";
				childCommentBox += "<div class='childCommentInputBox'>";
				childCommentBox += "<label for='childCommentInput"+commentNum+"'>대댓글 작성</label>";
				childCommentBox += "<input type='text' name='childComment' id='childCommentInput"+commentNum+"'>";
				childCommentBox += "<button type='button' onclick='commentWriteFn("+commentNum+")'>작성</button>";
				childCommentBox += "</div>";
				
				$(".childCommentInputBox").remove();
				
				parentCommentBox.after(childCommentBox);
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
								<button type="button" onclick="commentWriteFn(0)">작성</button>
							</div>
							<hr>
						</c:otherwise>
					</c:choose>
					<div id="commentListsId" class="commentLists">
						<c:forEach var="i" items="${board.lComment }">
							<div id="commentBox${i.commentNum }" class="comments">
								<ul>
									<li>${i.parentCommentNum }</li>
									<li>${i.nick }</li>
									<li>${i.content }</li>
									<li>${i.wDate }</li>
									<li id="commentBtnBox${i.commentNum }">
										<c:if test="${not empty sessionScope && i.parentCommentNum == 0 }">
											<button type="button" onclick="childCommentWriteFn(${i.commentNum})">대댓글 작성</button>
										</c:if>
										
										<c:if test="${sessionScope.user.id == i.usersId}">
												<button type="button" onclick="commentUpdateFn(${i.commentNum})">댓글 수정</button>
												<button type="button" onclick="commentDeleteFn(${i.commentNum})">댓글 삭제</button>
										</c:if>
										
									</li>
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