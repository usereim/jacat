<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page session="false" %> --%>
<html lang="ko" dir="ltr">
<head>
	<meta charset="UTF-8">
	<title>자격증 정보의 모든 것! 자캣</title>
	<style>
		body *{
			border:1px solid black;
		}
		main{
			height:70vh;
			display:flex;
			justify-content:space-evenly;
		}
		main>div{
			width:40vw;
		}
		h2{
			text-align:center;
		}
	</style>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	<main>
		<div>
			<h2>2025년 인기 자격증</h2>
			<ol>
				<c:forEach var="lList" items="${lList}" end="9">
					<li>
						<a href="<c:url value='/licenses/lists/${lList.jmcd}'/>">${lList.jmfldnm }</a>
					</li>
				</c:forEach>
			</ol>
		</div>
		<div>
			<h2><a href="<c:url value='/notice/list'/>">공지사항</a></h2>
			<ol>
				<c:forEach var="nList" items="${nList }" end="9">
					<li>
						<a href="<c:url value='/notice/boards/${nList.boardNum}'/>">${nList.title }</a>
					</li>
				</c:forEach>
			</ol>
		</div>
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>
