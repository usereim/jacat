<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${jmfldnm } ${boardTypeStr } 게시판</title>
		<style>
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
			#licenseBoardContentBox ul{
				display:flex;
				align-items:center;
				flex-wrap:wrap;
			}
			#licenseBoardContentBox ul li{
				width:23%;
				list-style:none;
			}
			#licenseBoardPagenationBox>ul{
				display:flex;
				justify-content:center;
				
			}
			#licenseBoardPagenationBox>ul>li{
				list-style:none;
				width:8%;
			}
		</style>
		<script src="<c:url value='/resources/js/jquery-3.7.1.min.js'/>"></script>
		<script>
			let jmcd = "${jmcd}";
			let boardType = "${boardType}"
			function moveWriteFn(){
				//console.log(jmcd);
				location.href="<c:url value='/licenses/lists/"+jmcd+"/"+boardType+"/write'/>";
				//console.log("<c:url value='/resource/js/jquery-3.7.1.min.js'/>");
				//console.log("<c:url value=''/>");
			}
		</script>
	</head>
	<body>
		
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<div id="licenseBoardSubtitleBox">
				<h2>${jmfldnm } ${boardTypeStr } 게시판</h2>
				<ul id="licenseBoardNavBox">
					<li class="nav-item">
						<a href="<c:url value='/licenses/lists' />" class="nav-link">자격증 목록</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value='/licenses/lists/${jmcd }' />" class="nav-link">${jmfldnm } 상세정보</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value='/licenses/lists/${jmcd }/QnA' />" class="nav-link">자격증 QnA</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value='/licenses/lists/${jmcd }/dataroom' />" class="nav-link">자격증 자료실</a>
					</li>
				</ul>
			</div>
			<hr>
			<div id="licenseBoardContentBox">
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
									<a href="<c:url value="/licenses/lists/${board.licenseListJmcd }/${boardType }/${board.boardNum}"/>">
										${board.title }
									</a>
								</td>
								<td>
									${board.nick }
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
			<div id="licenseBoardBtnBox">
				<c:choose>
					<c:when test="${empty sessionScope.user }">
					
					</c:when>
					<c:otherwise>
						<button type="button" onclick="moveWriteFn()">글쓰기</button>
					</c:otherwise>
				</c:choose>
			</div>
			<%-- 
			<div id="licenseBoardPagenationBox">
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
			--%>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>