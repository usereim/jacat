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