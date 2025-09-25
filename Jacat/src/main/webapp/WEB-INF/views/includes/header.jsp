<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>jacatHeader</title>
		<link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.8/dist/cosmo/bootstrap.min.css" rel="stylesheet">
		<link href="<c:url value='/resources/css/common.css'/>" rel="stylesheet" type="text/css">
		<style>
			
			main{
				padding: 5vh 0;
			}
			#headerUserBox>p{
				display:flex;
				flex-direction:column;
				align-items:flex-end;
			}
			a{
				color:black;
				text-decoration:bold;
			}
			
		</style>
	</head>
	<body>
		<header>
			<section id="headerSection">
				<div id="headerBox">
					<a href="<c:url value='/'/>" class="navbar-brand">
						<img 
						src="<c:url value="/resources/img/jacat_main_logo.png"/>"
						id="mainLogo">
					</a>
					<form 
					action="${pageContext.request.contextPath}/search/result" 
					onsubmit="return validateSearch();" 
					method="get"
					class="d-flex"
					>
						<input type="text" id="searchBox" name="keyword" class="form-control me-sm-2">
						<button type="submit" class="btn btn-secondary my-2 my-sm-0">🔎</button>
					</form>
					
					<div id="headerUserBox">
						<p>
							<c:choose>
								<c:when test="${empty sessionScope.user }">
									<a href="<c:url value='/user/login'/>">
										로그인
									</a>
								</c:when>
								<c:otherwise>
									<span>${sessionScope.user.nick } 님 환영합니다!</span>
									<a href="<c:url value='/user/logout'/>">
										로그아웃
									</a>
								</c:otherwise>
							</c:choose>
						</p>
					</div>
					
				</div>
				<nav id="navigationBar navbarColor01" class="navbar navbar-expand-lg bg-primary" data-bs-theme="dark">
					<ul class="navbar-nav">
						<li class="nav-item">
							<a href="<c:url value='/notice/list'/>" class="nav-link">공지사항</a>
						</li>
						<li class="nav-item">
							<a href="<c:url value='/csc/main'/>" class="nav-link">고객센터</a>
						</li>
						<li class="nav-item">
							<a href="<c:url value='/freeboard/boards'/>" class="nav-link">자유게시판</a>
						</li>
						<li class="nav-item">
							<a href="<c:url value='/licenses/lists'/>" class="nav-link">자격증 정보</a>
						</li>
						<c:choose>
							<c:when test="${empty sessionScope.user}">
								<li class="nav-item">
									<a href="javascript:alert('로그인후 이용해 주세요.')" class="nav-link">마이페이지</a>
								</li>
								<li class="nav-item">
									<a href="javascript:alert('로그인후 이용해 주세요.')" class="nav-link">캘린더</a>
								</li>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${sessionScope.user.grade == 'A' }">
										<li class="nav-item">
											<a href="<c:url value='/adminPage/main'/>" class="nav-link">관리자페이지</a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="nav-item">
											<a href="<c:url value='/mypage/pw-cert'/>" class="nav-link">마이페이지</a>
										</li>
									</c:otherwise>
								</c:choose>
								<li class="nav-item">
									<a href="<c:url value='/calendar/main'/>" class="nav-link">캘린더</a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
			</section>
		</header>
	</body>
	<script>
	function validateSearch() {
    const keyword = document.getElementById("searchBox").value.trim();
    if (keyword === "") {
        alert("검색어를 입력해주세요.");
        return false; // submit 중단
    	}
    return true; // 정상 제출
	}
	</script>
	

</html>