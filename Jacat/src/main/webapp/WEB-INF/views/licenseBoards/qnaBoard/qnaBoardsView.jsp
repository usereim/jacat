<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${jmfldnm } QnA 게시판 상세조회 페이지</title>
		<script src="<c:url value='/resources/js/jquery-3.7.1.min.js'/>"></script>
		<script>
			
			const jmcd = "${jmcd}";
			const boardNum = "${boardNum}";
		
			//게시글 수정 이동 함수
			function moveUpdateBoardFn(){
				location.href="<c:url value='/licenses/lists/"+jmcd+"/QnA/"+boardNum+"/update'/>";
				//console.log(jmcd);
				//console.log(boardNum);
			}
			
			//댓글 작성 함수
			function commentWriteFn(parentCommentNum){
				
				let commentLength = $("input[name=comment]").length;
				
				let comment = $("input[name=comment]").val();
				
				if(commentLength > 1){
				
					comment = $("input[name=comment]").last().val();
				
				}
				
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
							addCommentBox += "<button type='button' onclick='commentUpdateInputFransformFn("+cvo.commentNum+")'>댓글 수정</button>";
							addCommentBox += "<button type='button' onclick='commentDeleteFn("+cvo.commentNum+")'>댓글 삭제</button>";
						}
						
						addCommentBox += "		</li>";
						addCommentBox += "	</ul>";
						addCommentBox += "</div>";
						
						if(cvo.parentCommentNum == 0){
							
							$("#commentListsId").prepend(addCommentBox);
							
						}
						else{
							
							let addChildCommentBox = $("#commentBox"+cvo.parentCommentNum);
							
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
			
			//대댓글 작성 입력폼 생성 함수
			function childCommentWriteFn(commentNum){
				let parentCommentBox = $("#commentBox"+commentNum);
				//console.log($("input[name=comment]").length);
				let childCommentBox = "";
				childCommentBox += "<div class='childCommentInputBox'>";
				childCommentBox += "<label for='childCommentInput"+commentNum+"'>대댓글 작성 : </label>";
				childCommentBox += "<input type='text' name='comment' id='childCommentInput"+commentNum+"'placeholder='대댓글을 작성하세요.'>";
				childCommentBox += "<button type='button' onclick='commentWriteFn("+commentNum+")'>작성</button>";
				childCommentBox += "<button type='button' onclick='commentInputRemoveFn()'>X</button>";
				childCommentBox += "</div>";
				
				let childCommentInputBox = $(".childCommentInputBox");
				
				//만약 자식댓글박스가 부모댓글박스에 없다면 자식댓글박스 추가
				//만약 그렇지 않다면 자식댓글박스가 부모댓글박스에 있다면 자식댓글박스 제거
				
				//만약 자식댓글박스가 부모댓글박스가 아닌 다른 곳에 있다면 다른 자식댓글박스 제거
				
				childCommentInputBox.remove();				
				parentCommentBox.after(childCommentBox);
				
			}
			
			//대댓글 입력폼 제거 함수
			function commentInputRemoveFn(){
				let childCommentInputBox = $(".childCommentInputBox");
				childCommentInputBox.remove();
				
				//console.log(jmcd+"/"+boardNum);
				
			}
			
			//댓글 수정 입력폼 변환 함수
			function commentUpdateInputFransformFn(commentNum){
				let commentLine = $("#commentLine"+commentNum);
				let comment = $("#commentLine"+commentNum).val();
				
				let readComment;
				let rurl = "<c:url value='/licenses/lists/"+jmcd+"/QnA/"+boardNum+"/comment/read-one'/>";
				
				
				$.ajax({
					url : rurl,
					type : "post",
					data : {
						"boardNum" : boardNum,
						"commentNum" : commentNum
					},
					success : function(cvo){
						readComment = cvo.content;
						console.log("데이터 읽기 성공!");
					},
					error : function(){
						console.log("데이터 읽기 실패..");
					}
				});
				
				console.log(commentLine);
				console.log(comment);
				
				let printInputTag = "";
				printInputTag += "<label for='updateCommentInput"+commentNum+"'>댓글 수정 : </label>";
				printInputTag += "<input type='text' name='commentUpdate' id='updateCommentInput"+commentNum+"' value='"+readComment+"'>";
				printInputTag += "<button type='button' onclick='commentUpdateFn("+commentNum+")'>수정완료</button>";
				printInputTag += "<button type='button' onclick='updateCommentInputRemoveBtnFn()'>X</button>"
				
				commentLine.html("");
				commentLine.html(printInputTag);
				
			}
			
			//댓글 수정 입력폼 제거 함수
			function updateCommentInputRemoveBtnFn(){
				
			}
			
			//댓글 수정 함수
			function commentUpdateFn(commentNum){
				
				let upurl = "<c:url value='/licenses/lists/"+jmcd+"/QnA/"+boardNum+"/comment/update'/>"
				let commentLine = $("#commentLine"+commentNum);
				let comment = $("#commentLine"+commentNum).val();
				console.log(commentLine);
				console.log(comment);
				
				$.ajax({
					url : upurl,
					type : "post",
					data : {
						"commentNum" : commentNum,
						"content" : comment
					},
					success : function(cvo){
						alert("댓글 수정에 성공하였습니다.");
						commentLine.html("");
						commentLine.html(cvo.content);
					},
					error : function(cvo){
						alert("댓글 수정에 실패하였습니다.");
					}
				});
			}
			
			//댓글 삭제 함수
			function commentDeleteFn(commentNum){
				let url = "<c:url value='/licenses/lists/"+jmcd+"/QnA/"+boardNum+"/comment/delete'/>";
				console.log(url);
				$.ajax({
					url : url,
					type : "post",
					data : {
						"commentNum" : commentNum
					},
					success : function(res){
						if(res == 1){
							alert("댓글 삭제에 성공하였습니다.");
						}
						else{
							alert("댓글 삭제에 실패하였습니다.");
						}
					},
					error : function(){
						alert("댓글 삭제에 실패하였습니다.");
					}
				});
			}
			
			function reportPopupFn(){
				let reportPopupOpen = 
					window.open("<c:url value='/licenses/lists/"+jmcd+"/QnA/"+boardNum+"/report'/>"
							,"lboardReport"
							,"width=500,height=400");
				
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
					<%--<c:forEach var="lfile" items="${board.lFile }">--%>
						<p class="files">
							<a download="${board.lFile.realFileName }" 
								href="<c:url value='/uploads/licenses/boards/files/${board.boardNum }/${board.lFile.fileName }'/>">
								${board.lFile.realFileName }
							</a><br>
						</p>
						<c:if test="${fn:contains(board.lFile.type, 'image')}">
							<img 
							class="imgPreview"
							width="80%" 
							alt="${board.lFile.realFileName }" 
							src="<c:url value='/uploads/licenses/boards/files/${board.boardNum }/${board.lFile.fileName }'/>">
						</c:if>
					<%--</c:forEach>--%> 
				</div>
				<hr>
				<c:if test="${sessionScope.user.id == board.usersId}">
					<div class="updateDeleteBtnBox">
						<button type="button" onclick="moveUpdateBoardFn()">글 수정하기</button>
						<form action="<c:url value='/licenses/lists/${jmcd }/QnA/${board.boardNum }/delete'/>" method="post">
							<button type="submit">글 삭제하기</button>
						</form>
					</div>
					<hr>
				</c:if>
				<c:if test="${sessionScope.user.id != board.usersId && not empty sessionScope.user}">
					<div class="reportBtnBox">
						<button type="button" onclick="reportPopupFn()">신고하기</button>
					</div>
					<hr>
				</c:if>
				<div class="commentBox">
					<h3 class="commentSubtitle">댓글</h3>
					<c:choose>
						<c:when test="${empty sessionScope.user }">
							
						</c:when>
						<c:otherwise>
							<div class="commentWrite">
								<label for="commentInput">댓글 작성 : </label>
								<input type="text" name="comment" id="commentInput" placeholder="댓글을 작성하세요.">
								<button type="button" onclick="commentWriteFn(0)">작성</button>
							</div>
							<hr>
						</c:otherwise>
					</c:choose>
					<div id="commentListsId" class="commentLists">
						<c:forEach var="i" items="${board.lComment }">
						<c:choose>
							<c:when test="${i.parentCommentNum != 0 }">
								
							</c:when>
							<c:otherwise>
								
							</c:otherwise>
						</c:choose>
							<div id="commentBox${i.commentNum }" class="comments">
								<ul>
									<li>${i.commentNum }</li>
									<li>${i.parentCommentNum }</li>
									<li>${i.nick }</li>
									<li id="commentLine${i.commentNum }">${i.content }</li>
									<li>${i.wDate }</li>
									<li id="commentBtnBox${i.commentNum }">
										<c:if test="${not empty sessionScope && i.parentCommentNum == 0 }">
											<button type="button" onclick="childCommentWriteFn(${i.commentNum})">대댓글 작성</button>
										</c:if>
										
										<c:if test="${sessionScope.user.id == i.usersId}">
												<button type="button" onclick="commentUpdateInputFransformFn(${i.commentNum})">댓글 수정</button>
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