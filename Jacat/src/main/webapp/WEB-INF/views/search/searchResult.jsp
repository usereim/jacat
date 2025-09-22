<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>검색 결과</h2>

<!-- 검색창 -->
<form action="${pageContext.request.contextPath}/search/result" method="get">
    <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요">
    <button type="submit">검색</button>
</form>

<hr>

<!-- 결과 출력 -->
<c:if test="${empty result}">
    <p>검색 결과가 없습니다.</p>
</c:if>

<c:forEach var="item" items="${result}">
     <div>
        <c:choose>
            <c:when test="${item.jmcd != null}">
                <a href="<c:url value='/licenses/lists/${item.jmcd}'/>">
                    <strong>${item.title}</strong>
                </a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/freeboard/boards/${item.boardNum}'/>">
                    <strong>${item.title}</strong>
                </a>
            </c:otherwise>
        </c:choose>
        <br>
        ${item.content}<br>
    </div>
    <hr>
</c:forEach>

</body>
</html>