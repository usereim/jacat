<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>자격증 정보</title>
		<style>
			body *{
				border:1px solid black;
			}
			main{
				height:70vh;
				
			}
			#licenseBoardNavBox{
				display:flex;
				align-items:center;
			}
			#licenseBoardNavBox li{
				width:30%;
				list-style:none;
			}
			#lListContentBox ul{
				display:flex;
				align-items:center;
				flex-wrap:wrap;
			}
			#lListContentBox ul li{
				width:23%;
				list-style:none;
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
			<div id="lListContentBox">
				<ul>
					<c:forEach var="lList" items="${lList}">
						
						<li>
							<a href="<c:url value='/licenses/lists/${lList.jmcd}'/>">${lList.jmfldnm }</a>
						</li>
						
					</c:forEach>
				</ul>
			</div>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>