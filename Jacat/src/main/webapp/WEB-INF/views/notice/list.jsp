<%@page import="com.pro.jacat.noticeBoard.vo.NoticeBoardVO"%>
<%@page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
    body {
        font-family: '맑은 고딕', Arial, sans-serif;
        font-size: 14px;
        color: #000;
        margin: 0;
        height: 100%;
    }

    /* 전체 레이아웃 */
    .wrapper {
        min-height: 100%;
        display: flex;
        flex-direction: column;
    }
    
    #noticeText{
    	font-size: calc(1.325rem + .9vw);
    	}
    /* 메인 콘텐츠 영역 */
    .content {
        flex: 1;
        padding: 20px 0;
        box-sizing: border-box;
        width: 80%;
        margin: 0 auto;
    }

    main h2 {
        margin: 10px 0;
        font-size: 20px;
        text-align: left;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 15px;
        table-layout: fixed;
    }

    th, td {
        border: 1px solid #222;
        padding: 10px 8px;
        line-height: 1.6;
        height: 40px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    th:nth-child(1), td:nth-child(1) { width: 55%; text-align: left; }
    th:nth-child(2), td:nth-child(2) { width: 15%; text-align: center; }
    th:nth-child(3), td:nth-child(3) { width: 15%; text-align: center; }
    th:nth-child(4), td:nth-child(4) { width: 15%; text-align: center; }

    /* 헤더 강조 */
    th {
    background-color: #2780e3; /* btn-primary 색상 */
    color: #ffffff; /* 흰색 글씨로 대비 */
    font-size: 15px;
    border-bottom: 2px solid #222;
	}

    /* 테이블 행 구분선과 배경 */
    table tr {
        border-bottom: 1px solid #ccc;
    }
    table tr:nth-child(even) {
        background-color: #f7f7f7;
    }

    /* 제목 링크 강조 */
    td:first-child a {
        font-weight: bold;
        color: #000;
    }
    td:first-child a:hover {
        text-decoration: underline;
    }

    /* 버튼 스타일 */
    .btn {
        padding: 6px 14px;
        border: 1px solid #222;
        border-radius: 4px;
        background: #fff;
        cursor: pointer;
        font-size: 14px;
    }

    .btn-primary {
        background: #f4f4f4;
    }

    /* 푸터 */
    iframe.footer-frame {
        width: 100%;
        height: 150px;
        border: none;
        display: fixed;
		bottom : 0;    
		}
	footer {
	    width: 100%;
	    background-color: #f1f1f1;
	    position: flexbox;
	    bottom: 0;
	    left: 0;
	    text-align: center;
	    line-height: 80px; /* 세로 가운데 정렬 */
}
		
</style>
</head>
 <c:import url="/WEB-INF/views/includes/header.jsp"/>
<body>
	<main>
	<h2 id="noticeText">공지사항</h2>
	<hr>
		<table>
		<tr class="text-primary-emphasis">
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="noticeboard" items="${boardList}">
			<tr class="text-primary-emphasis">
				<td>
						<!-- 리스트에서 게시글 클릭시 넘어가는 url  -->
					<a href="<c:url value="/notice/boards/${noticeboard.boardNum}" />">
						${noticeboard.title} 
					</a>
				</td> 
				<td>${noticeboard.usersId}</td>
				<td>${noticeboard.wDate}</td>
			</tr>
		
		</c:forEach>
		
		</table>
		
		 <!-- 글쓰기 버튼 오른쪽 정렬 -->
            <c:if test="${sessionScope.user.grade == 'A'}">
                <div class="btn-container" style="text-align: right; margin-top: 12px;">
                    <button type="button" onclick="location.href='<c:url value='/notice/write'/>'" class="btn btn-primary">글쓰기</button>
                </div>
            </c:if>
	</main>
</body>
<footer>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</footer>
</html>