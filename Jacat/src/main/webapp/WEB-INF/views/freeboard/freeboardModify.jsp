<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post">
		<input type="text" name="title" value="${FreeBoardModify.title}"><br>
		<textarea name="content">${FreeBoardModify.content}</textarea><br>
		<input type="submit" value="수정">
	</form>
</body>
</html>