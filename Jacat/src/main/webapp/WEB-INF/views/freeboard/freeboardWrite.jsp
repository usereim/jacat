<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="" method="post" enctype="multipart/form-data">
		<input type="text" name="title">제목<br>
		<input type="text" name=content>본문<br>
		<input type="file" name="file" multiple>첨부파일<br>
		<input type="submit" value="등록하기">
	</form>
</body>
</html>