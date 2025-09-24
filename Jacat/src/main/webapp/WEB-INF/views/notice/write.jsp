<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
	<body>
	<form action="<c:url value="/notice/write" />" method="post" enctype="multipart/form-data">
		제목<input type="text" name="title"><br>
		본문<input type="text" name=content><br>
		첨부파일<input type="file" name="files" multiple><br>
		<input type="submit" value="등록하기">
	</form>
</body>
</html>