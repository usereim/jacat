<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통합검색</title>
<style>
    .container {
        max-width: 1000px; /* list.jsp, view.jsp와 동일 사이즈 */
        margin: 0 auto;
        padding: 20px;
    }
    
    /* 결과 리스트 */
    .search-result {
        border-bottom: 1px solid #ddd;
        padding: 15px 0;
    }
    .search-result a {
        font-weight: bold;
        font-size: 16px;
        text-decoration: none;
        color: #333;
    }
    .search-result a:hover {
        color: #007bff;
    }
    .search-result p {
        margin-top: 5px;
        color: #555;
        font-size: 14px;
    }
</style>
</head>
<body>
<c:import url="/WEB-INF/views/includes/header.jsp"/>
<main class="container">

    <h2>통합 검색</h2>
    
    <hr>

    <!-- 결과 출력 -->
    <c:if test="${empty result}">
        <p>검색 결과가 없습니다.</p>
    </c:if>

    <c:forEach var="item" items="${result}">
        <div class="search-result">
            <c:choose>
                <c:when test="${item.jmcd != null}">
                    <a href="<c:url value='/licenses/lists/${item.jmcd}'/>">
                        ${item.title}
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/freeboard/boards/${item.boardNum}'/>">
                        ${item.title}
                    </a>
                </c:otherwise>
            </c:choose>
            <p>${fn:substring(item.content, 0, 120)}...</p>
        </div>
    </c:forEach>
</main>
<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>