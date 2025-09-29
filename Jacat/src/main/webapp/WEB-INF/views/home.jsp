<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page session="false" %> --%>
<html lang="ko" dir="ltr">
<head>
	<meta charset="UTF-8">
	<title>자격증 정보의 모든 것! 자캣</title>
	<style>
		main{
			height:750px;
			display:flex;
			justify-content:space-evenly;
		}
		main>section{
			width:40%;
		}
		h2{
			text-align:center;
		}
		ol{
			border:1px solid #ddd;
			border-radius:5px;
		}
		ol li{
			font-size:25px;
		}
		h2 a{
			text-decoration:none;
		}
		ol li a{
			text-decoration:none;
		}
		ol li a:hover{
			font-weight:bold;
		}
	</style>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	<main>
		<section>
			<h2>${nowYear }년 인기 자격증</h2>
			<ol>
				<c:forEach var="lList" items="${lList}" end="9">
					<li>
						<a href="<c:url value='/licenses/lists/${lList.jmcd}'/>">${lList.jmfldnm }</a>
					</li>
				</c:forEach>
			</ol>
		</section>
		<section>
			<h2><a href="<c:url value='/notice/list'/>">공지사항</a></h2>
			<ol>
				<c:forEach var="nList" items="${nList }" end="9">
					<li>
						<a href="<c:url value='/notice/boards/${nList.boardNum}'/>">${nList.title }</a>
					</li>
				</c:forEach>
			</ol>
		</section>
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>
