<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 등록</title>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	
	<main>
		<c:choose>
			<c:when test="${type eq 'Q'}">
				<p>FAQ 등록</p>
			</c:when>
		</c:choose>
		
		
		<form action="<c:url value='/csc/write/${type }'/>" method="post"
			enctype="multipart/form-data"> 
			제목 : <input type="text" name="title"> <br>
			내용 : <input type="text" name="content"> <br>
			이미지 : <input type="file" name="file" multiple><br>
			
			<input type="submit" value="글 등록">
		</form>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>