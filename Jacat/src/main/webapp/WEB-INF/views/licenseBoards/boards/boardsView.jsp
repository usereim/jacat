<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${jmfldnm } ${boardTypeStr } 게시판 상세조회 페이지</title>
		<style>
			main{
				/* height:750px; */
			}
			#licenseBoardContentBox{
				width:80%;
				margin:0 auto;
			}
			/* #lboardContentBox{
				height:50%;
			} */
			.board-info { 
				padding: 15px; 
				border: 1px solid #ddd; 
				border-radius: 8px; 
				margin-bottom: 20px; 
				position: relative; 
				}
			.board-info div { 
				margin-bottom: 10px; 
				font-size: 16px; 
				}
			.file-preview img { 
				max-width: 300px; 
				margin-top: 5px; 
			}
			/*---------------------------------------*/
		    .comment-box { 
			    margin-bottom: 10px; 
			    border-bottom: 1px solid #ddd; 
			    padding: 10px; 
			    border-radius: 5px; 
		    }
		    .ccomment-box { 
			    margin-left: 40px; 
			    margin-top: 5px; 
			    padding: 10px; 
			    border-left: 2px solid #ddd; 
			    border-radius: 5px; 
		    }
		    /*---------------------------------------*/
		    
		    button, input[type=submit], input[type=button] { 
		    	margin-top: 5px; 
		    }
		    #reportBtnBox{
		    	position:absolute;
		    	top:10px;
		    	right:10px;
		    }
		    #contentInfoSubBox{
		    	display:flex;
		    	justify-content:space-between;
		    }
		    #contentTitle{
		    	text-align:left;
		    }
			.parentsComment{
				border:1px solid #ddd;
			}
			.childComments{
				margin-left:50px;
			}
			.comments table{
				width:100%;
			}
			.comments table tr{
				display:flex;
				border-bottom:1px solid #ddd;
			}
			.comments td:first-child{width:10%; text-aligh:right;}
			.comments td:nth-child(2){width:40%; text-align:left;}
			.comments td:nth-child(3){width:10%; text-align:center;}
			.comments td:last-child{width:40%; text-align:right;}
			
		</style>
		<script src="<c:url value='/resources/js/jquery-3.7.1.min.js'/>"></script>
		<script>
			
			const jmcd = "${jmcd}";
			const boardNum = "${boardNum}";
			const boardType = "${boardType}";
			const boardTypeStr = "${boardTypeStr}";
		
			//게시글 수정 이동 함수
			function moveUpdateBoardFn(){
				
				location.href="<c:url value='/licenses/lists/"+jmcd+"/"+boardType+"/"+boardNum+"/update'/>";
				//console.log(jmcd);
				//console.log(boardNum);
			}
			
			//게시글 삭제 확인 함수
			function deleteYnConfirmFn(){
				
				let deleteConfirm = confirm("게시글을 삭제하시겠습니까?");
				
				let durl = "";  
				durl += "<c:url value='/licenses/lists/";
				durl += jmcd;
				durl += "/"+boardType+"/";
				durl += boardNum;
				durl += "/delete'/>";
				
				let reurl = "";
				reurl += "<c:url value='/licenses/lists/";
				reurl += jmcd;
				reurl += "/"+boardType+"'/>";
				
				
				if(deleteConfirm){
					$.ajax({
						url : durl,
						type : "post",
						data : {
							"boardNum" : boardNum
						},
						success : function (){
							alert("게시글 삭제가 완료되었습니다.");
							location.href = reurl;
						},
						error : function (){
							alert("게시글 삭제에 실패했습니다.");
						}
					}); 
				}
				
			}
			
			//댓글 작성 함수
			function commentWriteFn(parentCommentNum){
				
				let commentLength = $("input[name=comment]").length;
				
				let comment = $("input[name=comment]").val();
				
				let commentBox = $("input[name=comment]");
				
				if(commentLength > 1){
				
					comment = $("input[name=comment]").last().val();
					commentBox = $("input[name=comment]").last();
				
				}
				
				let url = "<c:url value='/licenses/lists/";
				url += jmcd;
				url += "/"+boardType+"/";
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
						addCommentBox += "<div id='commentBox"+cvo.commentNum+"' class='comments parentsComment'>";
						addCommentBox += "	<table>";
						addCommentBox += "		<tr>";
						addCommentBox += "			<td>"+cvo.nick+"</td>";
						addCommentBox += "			<td>"+cvo.content+"</td>";
						addCommentBox += "			<td>"+cvo.wDate+"</td>";
						addCommentBox += "			<td id='commentBtnBox"+cvo.commentNum+"'>";
						
						let loginYn = "${sessionScope.user}";
						if(loginYn != null && cvo.parentCommentNum == 0){
							addCommentBox += "<button type='button' onclick='childCommentWriteFn("+cvo.commentNum+","+cvo.parentCommentNum+")' class='btn btn-primary'>대댓글 작성</button>";
						}
						//console.log(loginYn);
						
						let loginId = "${sessionScope.user.id}";
						if(loginId == cvo.usersId){
							addCommentBox += "<button type='button' onclick='commentUpdateInputFransformFn("+cvo.commentNum+")' class='btn btn-primary'>댓글 수정</button>";
							addCommentBox += "<button type='button' onclick='commentDeleteFn("+cvo.commentNum+")' class='btn btn-primary'>댓글 삭제</button>";
						}
						
						addCommentBox += "			</td>";
						addCommentBox == "		<tr>";
						addCommentBox += "	</table>";
						addCommentBox += "</div>";
						
						if(cvo.parentCommentNum == 0){
							
							$("#commentListsId").append(addCommentBox);
							//console.log(commentBox);
							commentBox.val("");
						}
						
						else{
							
							let addChildCommentBox = $("#commentBox"+cvo.parentCommentNum);
							
							addChildCommentBox.append(addCommentBox);
							
						}
						$("#childCommentInput").val("");
						
					},
					error : function(cvo){
						
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
				childCommentBox += "<button type='button' onclick='commentWriteFn("+commentNum+")' class='btn btn-primary'>작성</button>";
				childCommentBox += "<button type='button' onclick='commentInputRemoveFn()' class='btn btn-primary'>X</button>";
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
				
				let readComment = "";
				let rurl = "<c:url value='/licenses/lists/"+jmcd+"/"+boardType+"/"+boardNum+"/comment/read-one'/>";
				
				
				$.ajax({
					url : rurl,
					type : "post",
					data : {
						"licenseBoardsBoardNum" : boardNum,
						"commentNum" : commentNum
					},
					success : function(cvo){
						readComment = cvo.content;
						$("#updateCommentInput"+commentNum).val(readComment);
						//console.log("데이터 읽기 성공!");
						//console.log(readComment);
						//alert("댓글 수정에 성공하였습니다.");
					},
					error : function(){
						console.log("데이터 읽기 실패..");
						//alert("댓글 수정에 실패하였습니다.");
					}
				});
				
				let printInputTag = "";
				printInputTag += "<label for='updateCommentInput"+commentNum+"'>댓글 수정 : </label>";
				printInputTag += "<input type='text' name='commentUpdate' id='updateCommentInput"+commentNum+"' value='"+readComment+"'>";
				printInputTag += "<button type='button' onclick='commentUpdateFn("+commentNum+")' class='btn btn-primary'>수정완료</button>";
				printInputTag += "<button type='button' onclick='updateCommentInputRemoveBtnFn("+commentNum+")' class='btn btn-primary'>X</button>"
				
				commentLine.html("");
				commentLine.html(printInputTag);
				//console.log("??");
			}
			
			//댓글 수정 입력폼 제거 함수
			function updateCommentInputRemoveBtnFn(commentNum){
				
				let rurl = "<c:url value='/licenses/lists/"+jmcd+"/"+boardType+"/"+boardNum+"/comment/read-one'/>";
				let commentLine = $("#commentLine"+commentNum);
				
				let commentTag = "";
				commentTag += "<table>";
				commentTag += "<tr>";
				commentTag += "<td>";
				commentTag += "";
				commentTag += "";
				
				$.ajax({
					url : rurl,
					type : "post",
					data : {
							"commentNum" : commentNum
					},
					success : function(cvo){
						commentLine.html(cvo.content);
					},
					error : function(cvo){
						
					}
				});
			}
			
			//댓글 수정 함수
			function commentUpdateFn(commentNum){
				
				let upurl = "<c:url value='/licenses/lists/"+jmcd+"/"+boardType+"/"+boardNum+"/comment/update'/>"
				let commentLine = $("#commentLine"+commentNum);
				let comment = $("#updateCommentInput"+commentNum).val();
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
				
				let commentDeleteYn = confirm("댓글을 삭제하시겠습니까?");
				
				if(commentDeleteYn){
					let commentBox = $("#commentBox"+commentNum);

					let url = "<c:url value='/licenses/lists/"+jmcd+"/"+boardType+"/"+boardNum+"/comment/delete'/>";
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
								commentBox.remove();
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
			}
			
			function reportPopupFn(){
				let reportPopupOpen = 
					window.open("<c:url value='/licenses/lists/"+jmcd+"/"+boardType+"/"+boardNum+"/report'/>"
							,"lboardReport"
							,"width=500,height=400");
				
			}
			
		</script>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<section id="licenseBoardSubtitleBox">
				<h2>${jmfldnm } ${boardTypeStr } 게시판</h2>
				<hr>
			</section>
			<section id="licenseBoardContentBox" class="board-info">
				<div class="contentInfoBox">
					<c:if test="${sessionScope.user.id != board.usersId && not empty sessionScope.user}">
						<div class="reportBtnBox" id="reportBtnBox">
							<button type="button" onclick="reportPopupFn()" class="btn btn-primary">신고하기</button>
						</div>
					</c:if>
					<h3 id="contentTitle"><span>제목 : </span>${board.title }</h3>
					<hr>
					<div id="contentInfoSubBox">
						<div class="contentAuthor"><span>작성자 : </span>${board.nick }</div>
						<div class="contentWDate"><span>작성일 : </span>${board.wDate }</div>
						<div class="contentVisitCount"><span>조회수 : </span>${board.visitCount }</div>
					</div>
				</div>
				<hr>
				<div class="contentBox" >
					<div class="content" id="lboardContentBox">
						${board.content }
					</div>
				</div>
				<hr>
				<div class="fileBox file-preview">
					<h3 class="fileSubtitle">파일</h3>
					<%--<c:forEach var="lfile" items="${board.lFile }">--%>
						<p class="files">
							<a download="${board.lFile.realFileName }" 
								href="<c:url value='/uploads/licenses/boards/files/${board.boardNum }/${board.lFile.fileName }'/>"
								class="img-fluid mt-2">
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
						<button type="button" onclick="moveUpdateBoardFn()" class="btn btn-primary">글 수정하기</button>
						<button type="button" onclick="deleteYnConfirmFn()" class="btn btn-primary">글 삭제하기</button>
					</div>
					<hr>
				</c:if>
				<div class="commentBox">
					<h3 class="commentSubtitle">댓글</h3>
					
					<c:if test="${not empty sessionScope.user }">
						<div class="commentWrite">
							<label for="commentInput">댓글 작성 : </label>
							<input type="text" name="comment" id="commentInput" placeholder="댓글을 작성하세요.">
							<button type="button" onclick="commentWriteFn(0)" class="btn btn-primary">작성</button>
						</div>
						<hr>
					</c:if>
					
					<div id="commentListsId" class="commentLists">
						<c:forEach var="i" items="${board.lComment }">
							<c:if test="${not empty i.content && i.parentCommentNum == 0}">
								<%-- <c:if test="${i.parentCommentNum == 0 }"> --%>
									<div id="commentBox${i.commentNum }" class="comments parentsComment">
										<table>
											<tr>
												<%-- <li>${i.commentNum }</li> --%>
												<%-- <li>${i.parentCommentNum }</li> --%>
												<td>${i.nick }</td>
												<td id="commentLine${i.commentNum }">${i.content }</td>
												<td>${i.wDate }</td>
												<td id="commentBtnBox${i.commentNum }">
													<c:if test="${not empty sessionScope && i.parentCommentNum == 0 }">
														<button 
															type="button" 
															onclick="childCommentWriteFn(${i.commentNum})" 
															class="btn btn-primary"
														>대댓글 작성</button>
														<c:if test="${sessionScope.user.id == i.usersId}">
															<button 
															type="button" 
															onclick="commentUpdateInputFransformFn(${i.commentNum})"
															 class="btn btn-primary">댓글 수정</button>
															<button 
															type="button" 
															onclick="commentDeleteFn(${i.commentNum})"
															 class="btn btn-primary">댓글 삭제</button>
														</c:if>
													</c:if>
												</td>
											</tr>
										</table>
										
										<c:forEach var="j" items="${board.lComment }">
											<c:if test="${j.parentCommentNum == i.commentNum }">
												<div id="commentBox${j.commentNum }" class="comments childComments">
													<table>
														<tr>
															<%-- <li>${j.commentNum }</li> --%>
															<%-- <li>${j.parentCommentNum }</li> --%>
															<td>${j.nick }</td>
															<td id="commentLine${j.commentNum }">${j.content }</td>
															<td>${i.wDate }</td>
															<td id="commentBtnBox${j.commentNum }">
																<c:if test="${sessionScope.user.id == j.usersId}">
																	<button 
																	type="button" 
																	onclick="commentUpdateInputFransformFn(${j.commentNum})"
																	 class="btn btn-primary">댓글 수정</button>
																	<button 
																	type="button" 
																	onclick="commentDeleteFn(${j.commentNum})"
																	 class="btn btn-primary">댓글 삭제</button>
																</c:if>
															</td>
														</tr>
													</table>
												</div>
											</c:if>
										</c:forEach>
									</div>
								</c:if>
							<%-- </c:if> --%>					
						</c:forEach>
					</div>
				</div>
			</section>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>