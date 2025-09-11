<%@page import="com.pro.jacat.freeboard.vo.FreeBoardVO"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<c:if test="${not empty sessionScope.user}">
		<a href="<c:url value="/freeboard/freeboardWrite" />">글쓰기</a>
		</c:if>
	<main>
		<table>
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="freeboard" items="${FreeBoardList}">
			<tr>
				<td>
					<a href="<c:url value="/freeboard/boards/${freeboard.boardNum}" />">
						${freeboard.title}
					</a>
				</td> 
				<td>${freeboard.usersId}</td>
				<td>${freeboard.wDate}</td>
				<td>${freeboard.visit}</td> 
			</tr>
		
		</c:forEach>
		
		</table>
	</main>
</body>
</html>