<%@page import="com.pro.jacat.freeboard.vo.FreeBoardVO"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
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
    }
</style>
</head>
<body>
<div class="wrapper">
    <!-- 헤더 -->
    <c:import url="/WEB-INF/views/includes/header.jsp"/>

	
    <!-- 메인 콘텐츠 -->
    <div class="content">
        <main>
        <h2 id="ww">자유게시판</h2>
        <hr>
            <table>
                <tr>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
                <c:forEach var="freeboard" items="${FreeBoardList}">
                    <tr>
                        <td>
                            <a href="<c:url value='/freeboard/boards/${freeboard.boardNum}' />">
                                ${freeboard.title}
                            </a>
                        </td>
                        <td>${freeboard.usersId}</td>
                        <td>${freeboard.wDate}</td>
                        <td>${freeboard.visit}</td>
                    </tr>
                </c:forEach>
            </table>

            <!-- 글쓰기 버튼 오른쪽 정렬 -->
            <c:if test="${not empty sessionScope.user}">
                <div class="btn-container" style="text-align: right; margin-top: 12px;">
                    <button type="button" onclick="location.href='<c:url value='/freeboard/freeboardWrite'/>'" class="btn btn-primary">글쓰기</button>
                </div>
            </c:if>
        </main>
    </div>

    <!-- 푸터 -->
    <c:import url="/WEB-INF/views/includes/footer.jsp"/>
</div>
</body>
</html>