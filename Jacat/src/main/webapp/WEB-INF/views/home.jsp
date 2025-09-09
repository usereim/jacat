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
	<%@ include file="includes/header.jsp"%>
	<main>
		<div>
			<h2>2025년 인기 자격증</h2>
			<ol>
				<li>정보처리기사</li>
				<li>SQLD</li>
				<li>리눅스 마스터</li>
				<li>정보통신기사</li>
				<li>정보관리기술사</li>
			</ol>
		</div>
		<div>
			<h2><a href="#">공지사항</a></h2>
			<ol>
				<li>공지사항 1</li>
				<li>공지사항 2</li>
				<li>공지사항 3</li>
				<li>공지사항 4</li>
				<li>공지사항 5</li>
			</ol>
		</div>
	</main>
	<%@ include file="includes/footer.jsp" %>
</body>
</html>
