<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>자격증 정보</title>
		<style>
			
			#lListNavBox ul li{
				width:20%;
				list-style:none;
				text-align:center;
			}
			
			#lListContentBox ul{
				display:flex;
				align-items:center;
				justify-content:center;
				flex-wrap:wrap;
			}
			#lListContentBox ul li{
				width:18%;
				
			}
		</style>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<div id="lListSubtitleBox">
				<h2>자격증 목록</h2>
			</div>
			<hr>
			<div id="lListNavBox">
				<ul class="nav nav-underline">
					<li class="nav-item">
						<a href="<c:url value='/licenses/lists'/>" class="nav-link">자격증 목록</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value='/licenses/center/list'/>" class="nav-link">시험장 정보</a>
					</li>
				</ul>
			</div>
			<hr>
			<div id="lListContentBox">
				<ul class="nav nav-underline">
					<c:forEach var="lList" items="${lList}">
						
						<li class="nav-item">
							<a href="<c:url value='/licenses/lists/${lList.jmcd}'/>" class="nav-link">${lList.jmfldnm }</a>
						</li>
						
					</c:forEach>
				</ul>
			</div>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>