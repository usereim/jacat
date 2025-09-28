<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 등록</title>
<style>
	h2 {
		text-align: center;
		margin-top: 60px;
	}
	
	#form_area {
		width: 70%;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 20px;
		margin: 0 auto;
		margin-top: 100px;
	}

	#input_area {
		display: flex;
		gap: 10px;
		align-items: center;
	}
	
	#input_area > input {
		width: 300px;
	}	
</style>
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
				<h2 class="text-primary-emphasis">FAQ 등록</h2>
			</c:when>
			<c:when test="${type eq 'I' }">
				<h2 class="text-primary-emphasis">1:1문의 등록</h2>
			</c:when>
			<c:when test="${type eq 'A' }">
				<h2 class="text-primary-emphasis">정지회원 이의신청 등록</h2>
			</c:when>
		</c:choose>
		
		
		<form id="form_area" action="<c:url value='/csc/write/${type }'/>" method="post"
			enctype="multipart/form-data"> 
			
			<div id="input_area">
				<label for="title" class="text-primary-emphasis">제목</label>
				<input type="text" id="title" name="title" class="form-control">
			</div>
			
			<div id="input_area">
				<label for="content" class="text-primary-emphasis">내용</label>
				<input type="text" id="content" name="content" class="form-control">			
			</div>
			
			<div id="input_area">
				<label for="img" class="text-primary-emphasis">이미지</label>			
				<input type="file" id="img" name="img" class="form-control">
			</div>
			
			<input type="submit" value="글 등록" class="btn btn-primary">
		</form>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
</body>
</html>