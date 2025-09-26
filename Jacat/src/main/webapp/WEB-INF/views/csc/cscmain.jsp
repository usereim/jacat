<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<style>
	#section_area {
		display: flex;
		flex-direction: column;
		gap: 40px;
		align-items: center;
	}
	
	#lListNavBox {
		width: 100%
	}
	
	.nav-underline {
		width: 80%;
		display: flex;
		justify-content: space-around;
		margin: 0 auto;
	}
	
	#lListNavBox ul li{
		width:20%;
		text-align:center;
	}
	
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	
	<main>
		<section id="section_area">
			<h2 class="text-primary-emphasis">고객센터</h2>
			<div id="lListNavBox">
				<ul class="nav nav-underline">
					<li class="nav-item">
						<a href="<c:url value="/csc/tab/Q"/>" class="nav-link">FAQ</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value="/csc/tab/I"/>" class="nav-link">1:1 문의</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value="/csc/tab/A"/>" class="nav-link">정지 회원 이의신청</a>
					</li>
				</ul>
			</div>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
	</script>
</body>
</html>