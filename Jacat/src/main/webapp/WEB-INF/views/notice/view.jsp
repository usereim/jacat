<%@page import="com.pro.jacat.noticeBoard.vo.NoticeBoardVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	//1. request.getAttribute로 데이터 받기
	NoticeBoardVO board = (NoticeBoardVO)request.getAttribute("board");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
</head>
<body>
<c:import url="/WEB-INF/views/includes/header.jsp"/>
	<main>
	<div class="text-primary-emphasis">게시글번호 : ${noticeboard.boardNum}</div>
		<div class="text-primary-emphasis">제목 : ${noticeboard.title}</div>
		<div class="text-primary-emphasis">본문 : ${noticeboard.content}</div>
		<div class="text-primary-emphasis">작성자 : ${noticeboard.user.nick}</div>
		<div class="text-primary-emphasis">작성일 : ${noticeboard.wDate}</div>
		<div class="text-primary-emphasis">
		첨부파일 :
			<c:forEach var="file" items="${noticeboard.fileList}">
				<div>
					<a download="${file.realFileName}" 
						href="<c:url value="/uploads/${file.fileName}" />">
						${file.realFileName}
					</a><br>
					
					<c:if test="${fn:contains(file.type, 'image')}">
						<img  width="300px"
						  src="<c:url value="/uploads/${file.fileName}" />">
					</c:if>
				</div>
			</c:forEach>
		</div>
		
		<!-- 게시글 작성자와, 로그인한 사용자의 정보가 동일해야 수정삭제 버튼이 보임 -->
		<c:if test="${sessionScope.user.id == noticeboard.usersId}">
			<input class="btn btn-primary" type="button" value="수정" onclick="moveModifyPage(${noticeboard.boardNum})">
			<form action="<c:url value="/notice/delete/${noticeboard.boardNum}" />" method="post">
				<input class="btn btn-primary" type="submit" value="삭제" >
			</form>
		</c:if>
	</main>
</body>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
<script>
	function moveModifyPage(bno){
		location.href="${pageContext.request.contextPath}/notice/modify/"+bno;
	}
</script>

</html>