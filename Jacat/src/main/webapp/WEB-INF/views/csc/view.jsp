<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:choose>
	<c:when test="${board.boardType eq 'I' }">
		<title>1:1문의</title>
	</c:when>
	<c:when test="${board.boardType eq 'A' }">
		<title>정지회원 이의신청</title>
	</c:when>
</c:choose>

<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
<script>
	function delFn(boardNum) {
		$.ajax({
			url : "<c:url value='/csc/delete' />",
			type : "post",
			data : {
				"boardType" : '${board.boardType}',
				"boardNum" : ${board.boardNum }
			}, success : function(response) {
				if (response == 'delete success') {
					location.href = "<c:url value='/csc/tab/${board.boardType}' />";
				}
			}, error: function() {
				
			}
		});
	}
	
	function modFn(boardNum) {
		location.href = "<c:url value='/csc/modify/A/"+ boardNum + "' />";
	}
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	<main>
		<div id="content">
			<p>${board.boardNum }</p>
			<p>${board.title }</p>
			<p>${board.content }</p>
			<c:if test="${board.boardsFile.fileName != null }">
				<img width="300px"
					src="<c:url value="/uploads/boards/${board.boardsFile.boardsBoardNum }/${board.boardsFile.fileName }" />">
			</c:if>
			<c:if test="${board.boardType == 'A' }">
				<button type="button" onclick="modFn(${board.boardNum})">수정하기</button>
			</c:if>
			<button type="button" onclick="delFn(${board.boardNum })">삭제하기</button>
		</div>

		<c:if test="${board.boardType == 'I' }">
			<div id="reply_area">
				댓글 : <input type="text" name="content">
				<button type="button" id="add_reply_btn">댓글 작성</button>

				<div id="reply_list"></div>
			</div>
		</c:if>

	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp" />

	<script>
		$(function() {
			if ('${board.boardType}' == 'I') {
				$.ajax({
					url : "<c:url value='/csc/view-reply' />",
					type : "post",
					data : {
						"boardNum" : '${board.boardNum}'
					}, success : function(response) {
						addReply(response);
					}, error : function() {
						
					}
				});
			} else {
				return false;
			}
			
			$("#add_reply_btn").click(function() {
				if ('${board.usersId}' == '${sessionScope.user.id}' || '${sessionScope.user.grade}' == 'A') {
					let content = $("input[name=content]").val();
					let usersId = '${board.usersId}';
					let boardNum = '${board.boardNum}';
					$.ajax({
						url : "<c:url value='/csc/add-reply' />",
						type : "post",
						data : {
							"content" : content,
							"usersId" : usersId,
							"boardsBoardNum" : boardNum
						}, success : function(response) {
							$("input[name=content]").val("");
							addReply(response);
						}, error : function() {
							
						}
					});
				}
			});
		});
		
		function delComment(commentNum) {
			$.ajax({
				url : "<c:url value='/csc/delete-reply' />",
				type : "post",
				data : {
					"commentNum" : commentNum,
					"boardNum" : '${board.boardNum}'
				}, success : function(response) {
					addReply(response);
				}, error : function() {
					
				}
				
			});
		}
		
		function modComment(commentNum) {
			let content = $("#" + commentNum).children("input[name=mod_reply]").val();
			
			$.ajax({
				url : "<c:url value='/csc/mod-reply' />",
				type : "post",
				data : {
					"content" : content,
					"commentNum" : commentNum,
					"boardsBoardNum" : '${board.boardNum}'
				}, success : function(response) {
					addReply(response);
				}, error : function() {
					
				}
			});
		}
		
		function modCommentForm(commentNum, obj) {
			let target = $(obj);
			
			let modInput = $("<input>");
			modInput.attr("type", "text").attr("name", "mod_reply");
			
			target.before(modInput);
			
			let modBtn = $("<button>");
			modBtn.attr("type", "button")
			.text("수정")
			.on("click", function() {
				let commentNum = Number($(this).parent().attr("id"));
				modComment(commentNum, this);
			});
			
			target.before(modBtn);
		}
		
		function addReply(response) {
			let reply_list = $("#reply_list");
			
			reply_list.children(".reply").remove();
			
			for (let i = 0; i < response.length; ++i) {
				let reply = $("<div>");
				reply
				.attr("id", "" + response[i].commentNum)
				.attr("class", "reply");
				
				reply_list.append(reply);
				
				let _usersId = $("<p>");
				_usersId.text("작성자 : " + response[i].usersId);
				
				reply.append(_usersId);
				
				let _content = $("<p>");
				_content.text("내용 : " + response[i].content);
				
				reply.append(_content);
				
				if (response[i].usersId == '${board.usersId}') {
					let modBtn = $("<button>");
					modBtn.attr("type", "button")
					.text("댓글 수정")
					.on("click", function() {
						let commentNum = Number($(this).parent().attr("id"));
						
						modCommentForm(commentNum, this);
					});
					
					reply.append(modBtn);
					
					let delBtn = $("<button>");
					delBtn.attr("type", "button")
					.text("댓글 삭제")
					.on("click", function() {
						let commentNum = Number($(this).parent().attr("id"));
						
						delComment(commentNum);
					});
					
					reply.append(delBtn);
				}
				
				reply_list.append(reply);
			}
		}
	</script>
</body>
</html>