<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<style>
	#content{
	height:180px;
	text-align: left; 
	}
    /* 이미지 미리보기 스타일 */
    .preview-img {
        max-width: 200px;
        max-height: 200px;
        margin-top: 10px;
        margin-right: 10px;
        border: 1px solid #ddd;
        padding: 2px;
    }
</style>
</head><c:import url="/WEB-INF/views/includes/header.jsp"/>
	<body>
	
	<main>
		<h2>공지사항 글작성</h2>
		<hr>
		<form action="<c:url value="/notice/write" />" method="post" enctype="multipart/form-data">
			제목 <input name="title" class="form-control form-control-sm" type="text" placeholder="제목을 입력하세요."><br>
			본문 <input id=content class="form-control form-control-sm" type="text"><br>
			첨부파일 <input type="file" name="files" multiple class="btn btn-outline-primary"
					class="form-control form-control-sm"><br>
			<input type="submit" value="등록하기" class="form-control form-control-sm">
		</form>
	</main>
</body>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
    // 이미지 선택 시 미리보기
    $("#file").on("change", function() {
        $("#preview").empty(); // 이전 이미지 삭제
        const files = this.files;
        if(files) {
            Array.from(files).forEach(file => {
                if(file.type.startsWith("image/")) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const img = $("<img>").attr("src", e.target.result).addClass("preview-img");
                        $("#preview").append(img);
                    }
                    reader.readAsDataURL(file);
                }
            });
        }
    });
</script>
</html>