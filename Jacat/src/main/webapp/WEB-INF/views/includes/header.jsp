<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>jacatHeader</title>
		<style>
			header{
				height:10vh;
			}
			#headerBox{
				display:flex;
				flex-direction:row;
				justify-content:space-between;
			}
			#navigationBar{
				display:flex;
				justify-content:space-around;
			}
			#mainLogo{
				width:5vh;
				height:5vh;
			}
		</style>
	</head>
	<body>
		<header>
			<div id="headerBox">
				<a href="<c:url value='/'/>">
					<img 
					src="<c:url value="/resources/img/jacat_main_logo.png"/>"
					id="mainLogo">
				</a>
				<form action="${pageContext.request.contextPath}/search/result" method="get">
					<input type="text" id="searchBox" name="keyword">
					<button type="submit">🔎</button>
				</form>
				
				<c:choose>
					<c:when test="${empty sessionScope.user }">
						<a href="<c:url value='/user/login'/>">
							로그인
						</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/user/logout'/>">
							로그아웃
						</a>
					</c:otherwise>
				</c:choose>
				
			</div>
			<nav id="navigationBar">
				<a href="<c:url value='/notice'/>">공지사항</a>
				<a href="<c:url value='/csc/main'/>">고객센터</a>
				<a href="<c:url value='/freeboard/boards'/>">자유게시판</a>
				<a href="<c:url value='/licenses/lists'/>">자격증 정보</a>
				<c:choose>
					<c:when test="${empty sessionScope.user}">
						<a href="javascript:alert('로그인후 이용해 주세요.')">마이페이지</a>
						<a href="javascript:alert('로그인후 이용해 주세요.')">캘린더</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/mypage/pw-cert'/>">마이페이지</a>
						<a href="<c:url value='/calendar/main'/>">캘린더</a>
					</c:otherwise>
				</c:choose>
			</nav>
		</header>
	</body>
</html>