<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>자격증 질문 게시판</title>
		<style>
			body *{
				border:1px solid black;
			}
			main{
				height:70vh;
			}
			#licenseQnANavBox{
				display:flex;
				align-items:center;
			}
			#licenseQnANavBox li{
				width:30%;
				list-style:none;
			}
			#licenseQnAContentBox ul{
				display:flex;
				align-items:center;
				flex-wrap:wrap;
			}
			#licenseQnAContentBox ul li{
				width:23%;
				list-style:none;
			}
			#licenseQnAPagenationBox>ul{
				display:flex;
				justify-content:center;
				
			}
			#licenseQnAPagenationBox>ul>li{
				list-style:none;
				width:8%;
			}
		</style>
		<script src="<c:url value='/resource/js/jquery-3.7.1.min.js'/>"></script>
		<script>
			function moveWriteFn(){
				location.href="<c:url value='/licenses/QnA/write'/>";
			}
		</script>
	</head>
	<body>
		
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<div id="licenseQnASubtitleBox">
				<h2>자격증 질문 게시판</h2>
				<ul id="licenseQnANavBox">
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
			<div id="licenseQnAContentBox">
				<table>
					<thead>
						<tr>
							<!-- <th>번호</th> -->
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${boardList }">
							<tr>
								<td>
									<a href="<c:url value="/licenses/QnA/view/${board.boardNum}"/>">
										${board.title }
									</a>
								</td>
								<td>
									${board.usersId }
								</td>
								<td>
									${board.wDate }
								</td>
								<td>
									${board.visitCount }
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div id="licenseQnABtnBox">
				<button type="button" onclick="moveWriteFn()">글쓰기</button>
			</div>
			<div id="licenseQnAPagenationBox">
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