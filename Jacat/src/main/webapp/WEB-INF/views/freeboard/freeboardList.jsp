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

    .wrapper {
        min-height: 100%;
        display: flex;
        flex-direction: column;
    }

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

    /* 글번호 추가 → 맨 앞 */
    th:nth-child(1), td:nth-child(1) { width: 10%; text-align: center; }
    th:nth-child(2), td:nth-child(2) { width: 45%; text-align: left; }
    th:nth-child(3), td:nth-child(3) { width: 15%; text-align: center; }
    th:nth-child(4), td:nth-child(4) { width: 15%; text-align: center; }
    th:nth-child(5), td:nth-child(5) { width: 15%; text-align: center; }

    th {
        background-color: #2780e3;
        color: #ffffff;
        font-size: 15px;
        border-bottom: 2px solid #222;
    }

    table tr {
        border-bottom: 1px solid #ccc;
    }
    table tr:nth-child(even) {
        background-color: #f7f7f7;
    }

    td:nth-child(2) a {
        font-weight: bold;
        color: #000;
    }
    td:nth-child(2) a:hover {
        text-decoration: underline;
    }

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

    iframe.footer-frame {
        width: 100%;
        height: 150px;
        border: none;
    }
</style>
</head>
<body>
<div class="wrapper">
    <c:import url="/WEB-INF/views/includes/header.jsp"/>

    <div class="content">
        <main>
        <h2 id="ww">자유게시판</h2>
        <hr>
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
                <c:forEach var="freeboard" items="${FreeBoardList}" varStatus="status">
                    <tr>
                        <td>${status.count}</td> <!-- 글번호 (1부터 증가) -->
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

            <c:if test="${not empty sessionScope.user}">
                <div class="btn-container" style="text-align: right; margin-top: 12px;">
                    <button type="button" onclick="location.href='<c:url value='/freeboard/freeboardWrite'/>'" class="btn btn-primary">글쓰기</button>
                </div>
            </c:if>
        </main>
    </div>

    <c:import url="/WEB-INF/views/includes/footer.jsp"/>
</div>
</body>
</html>