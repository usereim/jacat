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

<style>
	#content {
		display: flex;
		flex-direction: column;
		gap: 20px;
		align-items: center;
	}
	
	table {
		width: 80%;
        border-collapse: collapse;
        font-size: 15px;
        table-layout: fixed;
    	margin: 0 auto;
    }

    td {
        border: 1px solid #222;
        padding: 10px 8px;
        line-height: 1.6;
        height: 40px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    td:nth-child(1) { width: 30%; text-align: left; font-weight: bold;}
    td:nth-child(2) { width: 70%; text-align: left; }

    /* 테이블 행 구분선과 배경 */
    table tr {
        border-bottom: 1px solid #ccc;
    }
    table tr:nth-child(even) {
        background-color: #f7f7f7;
    }

    /* 제목 링크 강조 */
    td:first-child a {
        font-weight: bold;
        color: #000;
    }
    td:first-child a:hover {
        text-decoration: underline;
    }
    
    #btn_area {
    	display: flex;
    	gap: 15px;
    }
    
    #reply_area {
    	width: 80%;
    	margin: 0 auto;
    	margin-top: 60px;
    }
    
    #input_area {
    	width: 50%;
    	display: flex;
    	gap: 15px;
    	align-items: center;
    	margin-bottom: 20px;
    }
    
    #input_area input {
    	width: 150px;
    }
</style>

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
		location.href = "<c:url value='/csc/modify/${board.boardType}/"+ boardNum + "' />";
	}
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	<main>
		<div id="content">
			<c:if test="${board.boardType == 'A' }">
				<h2 class="text-primary-emphasis">정지회원 이의신청글 상세보기</h2>
			</c:if>
			<c:if test="${board.boardType == 'I' }">
				<h2 class="text-primary-emphasis">1:1 문의글 상세보기</h2>
			</c:if>
		
			<table>
				<tr>
					<td>게시글 번호</td>
					<td>${board.boardNum }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td>${board.title }</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>${board.content }</td>
				</tr>
				
				<c:if test="${board.boardsFile.fileName != null }">
				<tr>
					<td>이미지</td>
					<td>
						<img width="300px"
						src="<c:url value="/uploads/boards/${board.boardsFile.boardsBoardNum }/${board.boardsFile.fileName }" />">
					</td>
				</tr>
			</c:if>
			</table>

			<div id="btn_area">
				<button type="button" onclick="modFn(${board.boardNum})" class="btn btn-primary">수정하기</button>
				<button type="button" onclick="delFn(${board.boardNum })" class="btn btn-primary">삭제하기</button>
			</div>
		</div>

		<c:if test="${board.boardType == 'I' }">
			<div id="reply_area">
				<h3 class="text-primary-emphasis">댓글</h3>
				
				<div id="input_area">
					<label for="reply">댓글</label>
					<input type="text" id="reply" name="content" class="form-control">
					<button type="button" id="add_reply_btn" class="btn btn-primary">댓글 작성</button>
				</div>
				
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
			modBtn.attr("type", "button").attr("class", "btn btn-primary")
			.text("수정")
			.on("click", function() {
				let commentNum = Number($(this).parent().attr("id"));
				modComment(commentNum, this);
			});
			
			target.before(modBtn);
			
			$(obj).remove();
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
					modBtn.attr("type", "button").attr("class", "btn btn-primary").attr("id", "mod_btn")
					.text("댓글 수정")
					.on("click", function() {
						let commentNum = Number($(this).parent().attr("id"));
						
						modCommentForm(commentNum, this);
					});
					
					reply.append(modBtn);
					
					let delBtn = $("<button>");
					delBtn.attr("type", "button").attr("class", "btn btn-primary")
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