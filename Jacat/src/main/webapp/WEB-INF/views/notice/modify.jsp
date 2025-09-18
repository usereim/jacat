<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<body>
	<!-- <form action="http://localhost:8080/c/board/modify"> -->
	<!-- <form action="/c/board/modify"> -->
	<!-- <form action="modify"> -->
	<!-- <form action=""> -->
	<form method="post">
		<input type="text" name="title" value="${board.title}"><br>
		<textarea name="body">${board.body}</textarea><br>
		<input type="submit" value="수정">
	</form>
</body>
</html>