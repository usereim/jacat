<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${boardTypeStr } 게시글 작성</title>
		<script src="<c:url value='/resources/js/jquery-3.7.1.min.js'/>"></script>
		<script>
			
			let boardTypeStr = "${boardTypeStr}";
		
			function fileTypeValidateFn(obj){
				let file_check = false;
				
				let file = $(obj)[0].files[0];
				let _this = $(obj);
				let regex;
				
				if(boardTypeStr == "QnA"){
					regex = /\.(jpe?g|png|gif|bmp|svg|webp)$/i;
					
					if (regex.test(file.name) && file.type.startsWith('image/')) {
				        $(".fileErrorMsg").remove();
				    	file_check = true;
				    } else {
				    	_this.val('');
				    	$(".fileErrorMsg").remove();
				        _this.after("<br class='fileErrorMsg'><span class='fileErrorMsg'>파일은 이미지만 업로드 할 수 있습니다.</span>");
				        file_check = false;
				    }
				}
				else{
					regex = /\.(jpe?g|png|gif|bmp|svg|webp|doc|docx|hwp|xls?x|ppt?x|pdf|txt)$/i;
					
					if (regex.test(file.name) && (file.type.startsWith('image/') || file.type.startsWith('application/'))) {
				        $(".fileErrorMsg").remove();
				    	file_check = true;
				    } else {
				    	_this.val('');
				    	$(".fileErrorMsg").remove();
				        _this.after("<br class='fileErrorMsg'><span class='fileErrorMsg'>파일은 이미지와 문서 파일만 업로드 할 수 있습니다.</span>");
				        file_check = false;
				    }
				}
				
				
			}
		
		</script>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<section id="licenseQnABoardWriteSubtitleBox">
				<h2>${jmfldnm } ${boardTypeStr } 게시판</h2>
				<h3>새글작성</h3>
				<hr>
			</section>
			<section id="licenseQnABoardWriteContentBox">
				<div class="contentBox">
					<form 
						action="<c:url value='/licenses/lists/${jmcd }/${boardType }/write'/>" 
						method="post" 
						enctype="multipart/form-data">
						
						<p class="writeTitleBox">
							<label for="wtitle">제목 : </label>
							<input type="text" name="title" id="wtitle">
						</p>
						<p class="writeContentBox">
							<label for="wcontent">내용 : </label>
							<textarea name="content" id="wcontent"></textarea>
						</p>
						<p class="writeFileBox">
							<input type="file" name="file" onchange="fileTypeValidateFn(this)">
						</p>
						<button type="submit">작성</button>
					</form>
				</div>
			</section>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
		
	</body>
</html>