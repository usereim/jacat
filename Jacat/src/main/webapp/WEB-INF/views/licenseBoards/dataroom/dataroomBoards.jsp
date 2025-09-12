<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>자격증 자료실</title>
		<style>
			body *{
				border:1px solid black;
			}
			main{
				height:70vh;
			}
			#licenseDataroomNavBox{
				display:flex;
				align-items:center;
			}
			#licenseDataroomNavBox li{
				width:30%;
				list-style:none;
			}
			#licenseDataroomContentBox ul{
				display:flex;
				align-items:center;
				flex-wrap:wrap;
			}
			#licenseDataroomContentBox ul li{
				width:23%;
				list-style:none;
			}
			#licenseDataroomPagenationBox>ul{
				display:flex;
				justify-content:center;
				
			}
			#licenseDataroomPagenationBox>ul>li{
				list-style:none;
				width:8%;
			}
		</style>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<div id="licenseDataroomSubtitleBox">
				<h2>자격증 자료실</h2>
				<ul id="licenseDataroomNavBox">
					<li>
						<a href="<c:url value='/licenses/lists' />">자격증 목록</a>
					</li>
					<li>
						<a href="<c:url value='/licenses/QnA' />">자격증 QnA</a>
					</li>
					<li>
						<a href="<c:url value='/licenses/dataroom' />">자격증 자료실</a>
					</li>
				</ul>
				<button type="button">+</button>
			</div>
			<hr>
			<div id="licenseDataroomContentBox">
				<table>
					<thead>
						<tr>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<!--  -->
					</tbody>
				</table>
			</div>
			<div id="licenseDataroomPagenationBox">
				<ul>
					<li><a href="#">&lt;&lt;</a></li>
					<li><a href="#">&lt;</a></li>
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
					<li><a href="#">6</a></li>
					<li><a href="#">7</a></li>
					<li><a href="#">8</a></li>
					<li><a href="#">9</a></li>
					<li><a href="#">10</a></li>
					<li><a href="#">&gt;</a></li>
					<li><a href="#">&gt;&gt;</a></li>
				</ul>
			</div>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>