<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	<main>
		<form class="text-primary-emphasis" method="post" enctype="multipart/form-data">
			제목 <input class="form-control form-control-sm"
				 type="text" name="title" value="${NoticeBoard.title}"><br>
				 
			내용 <input name="content" class="form-control form-control-sm">
			<br>
			
			첨부파일 <input class="form-control form-control-sm"
			 type="file" name="files" multiple class="btn btn-primary"><br>
			 
			<input  type="submit" value="수정" class="btn btn-primary">
		</form>
	</main>
</body>
<footer>
<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</footer>
</html>