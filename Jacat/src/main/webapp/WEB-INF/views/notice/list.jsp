<%@page import="com.pro.jacat.noticeBoard.vo.NoticeBoardVO"%>
<%@page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
 <c:import url="/WEB-INF/views/includes/header.jsp"/>
<body>
		<c:if test="${not empty sessionScope.user}">
		<a href="<c:url value="/notice/noticeBoardWrite" />">글쓰기</a>
		</c:if>
	<main>
		<table>
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="noticeboard" items="${boardList}">
			<tr>
				<td>
					<a href="<c:url value="/notice/boards/${noticeboard.boardNum}" />">
						${noticeboard.title}
					</a>
				</td> 
				<td>${noticeboard.usersId}</td>
				<td>${noticeboard.wDate}</td> 
			</tr>
		
		</c:forEach>
		
		</table>
	</main>
</body>
</html>
