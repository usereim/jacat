<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${boardTypeStr } 게시글 작성</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<style>
			#licenseBoardWriteContentBox{
				width:80%:
			}
			.preview-img {
		        max-width: 200px;
		        max-height: 200px;
		        margin-top: 10px;
		        margin-right: 10px;
		        border: 1px solid #ddd;
		        padding: 2px;
		    }
		</style>
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
		<main class="container mt-4">
			<section id="licenseQnABoardWriteSubtitleBox">
				<h2>${jmfldnm } ${boardTypeStr } 게시판</h2>
				<h3>새 글 작성</h3>
				<hr>
			</section>
			<section id="licenseBoardWriteContentBox">
				<div class="contentBox" class="card-body">
					<form 
						action="<c:url value='/licenses/lists/${jmcd }/${boardType }/write'/>" 
						method="post" 
						enctype="multipart/form-data">
						
						<div class="writeTitleBox mb-3 row">
							<label for="wtitle" class="col-sm-2 col-form-label">제목 : </label>
							<input type="text" name="title" id="wtitle" class="form-control" >
						</div>
						<div class="writeContentBox mb-3 row">
							<label for="wcontent" class="col-sm-2 col-form-label">내용 : </label>
							<textarea name="content" id="wcontent" class="form-control" rows="6"></textarea>
						</div>
						<div class="writeFileBox" class="mb-3 row">
							<input type="file" name="file" onchange="fileTypeValidateFn(this)" class="form-control">
						</div>
						<button type="submit" class="btn btn-primary">작성</button>
					</form>
				</div>
			</section>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
		
	</body>
</html>