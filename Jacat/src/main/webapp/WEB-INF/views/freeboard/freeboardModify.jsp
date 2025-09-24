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
	<form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/freeboard/modify/${FreeBoardModify.boardNum}">
    <label>제목</label>
    <input type="text" name="title" value="${FreeBoardModify.title}"><br>

    <label>내용</label>
    <textarea name="content">${FreeBoardModify.content}</textarea><br>

    <label>첨부파일</label>
    <input type="file" name="file" multiple><br>

    <!-- 기존 첨부파일 리스트 출력 -->
    <c:forEach var="file" items="${FreeBoardModify.filelist}">
        <p>
            ${file.realFileName}
            <!-- 필요하면 삭제 버튼이나 다운로드 링크 추가 가능 -->
        </p>
    </c:forEach>

    <input type="submit" value="수정">
</form>
</body>
</html>