<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
	<!-- <form action="http://localhost:8080/c/board/modify"> -->
	<!-- <form action="/c/board/modify"> -->
	<!-- <form action="modify"> -->
	<!-- <form action=""> -->
	<form method="post">
		<input type="text" name="title" value="${NoticeBoard.title}"><br>
		<textarea name="body">${NoticeBoard.content}</textarea><br>
		<input type="file" name="files" multiple>첨부파일<br>
		<input type="submit" value="수정">
	</form>
</body>
</html>