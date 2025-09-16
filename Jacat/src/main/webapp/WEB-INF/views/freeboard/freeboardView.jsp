<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<main>
		<div>제목 : ${FreeBoard.title}</div>
		<div>내용 : ${FreeBoard.content}</div>
		<div>작성자 : ${FreeBoard.usersId}</div>
		<div>작성일 : ${FreeBoard.wDate}</div>
		
		<div>
			<c:forEach var="file" items="${FreeBoard.filelist}">
				<div>
					<a  download="${file.realFileName}" 
						href="<c:url value="/uploads/${file.fileName}" />">
						${file.fileName}
					</a><br>
				
					<c:if test="${fn:contains(file.type, 'image')}">
						<img  width="300px"
					  	src="<c:url value="/uploads/${file.fileName}" />">
					</c:if>
				</div>
			</c:forEach>
		</div>
		<c:if test="${sessionScope.user.id == FreeBoard.usersId}">
			<input type="button" value="수정" onclick="moveModifyPage(${FreeBoard.boardNum})">
			<form 
				action="<c:url value="/freeboard/delete/${FreeBoard.boardNum}" />" 
				method="post">
				<input type="submit" value="삭제">
			</form>
		</c:if>
		
		<h3>댓글</h3>
		<c:forEach var="comment" items="${FreeBoard.commentList}">
    	<div style="margin-bottom:10px; border-bottom:1px solid #ddd; padding:5px;">
        <strong>${comment.usersID}</strong> : ${comment.content}
    	</div>
		</c:forEach>
		
		<!-- 댓글 작성 폼 -->
   		<form action="<c:url value='/freeboard/comment'/>" method="post">
        <input type="hidden" name="boardNum" value="${FreeBoard.boardNum}"/>
        <textarea name="content" placeholder="댓글을 작성하세요" required></textarea>
        <input type="submit">댓글 작성</input>
    	</form>
	</main>
</body>

<script>
	let boardNum = ${FreeBoard.boardNum};
	console.log(boardNum);
	
	let title = "${FreeBoard.title}";
	console.log(title);
	
	function moveModifyPage(boardNum){
		location.href="${pageContext.request.contextPath}/freeboard/freeboardModify/"+boardNum;
	}
</script>

</html>