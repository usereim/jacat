<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 등록</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
<script>
	
	$(function() {
		let file_check = true;
		
		$("input[name=img]").change(function() {
			file_check = false;
			
			let file = $(this)[0].files[0];
			let _this = $(this);
			let regex = /\.(jpe?g|png|gif|bmp|svg|webp)$/i;
			
			if (file.name == '') {
				file_check = true;
			}
			
			if (regex.test(file.name) && file.type.startsWith('image/')) {
		        file_check = true;
		    } else {
		    	_this.val('');
		        file_check = false;
		    }
		}); 
		
		$("form").submit(function() {
			if (!file_check) {
				return false;
			}
			
			return true;
		});
	});
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	
	<main>
		<c:choose>
			<c:when test="${type eq 'Q'}">
				<p>FAQ 등록</p>
			</c:when>
			<c:when test="${type eq 'I' }">
				<p>1:1문의 등록</p>
			</c:when>
		</c:choose>
		
		
		<form action="<c:url value='/csc/write/${type }'/>" method="post"
			enctype="multipart/form-data"> 
			제목 : <input type="text" name="title"> <br>
			내용 : <input type="text" name="content"> <br>
			이미지 : <input type="file" name="img"><br>
			
			<input type="submit" value="글 등록">
		</form>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>