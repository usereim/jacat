<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<main>
		<h2>로그인</h2>
		<br>
		<form action="<c:url value='/user/login'/>" method="post">
			아이디 : <input type="text" name="id"><br>
			비밀번호 : <input type="password" name="pw"><br>
			<br>
			<input type="submit" value="로그인">
		</form>
		
		<br>
		<button type="button">아이디 찾기</button>
		<button type="button">비밀번호 찾기</button>
	</main>
</body>
</html>