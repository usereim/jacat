<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<style>
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
</head>
<body>
<c:import url="/WEB-INF/views/includes/header.jsp"/>
<main class="container mt-4">
	<h2>글 작성</h2>
	<hr>
    <div class="card">
        <div class="card-header fw-bold">글쓰기</div>
        <div class="card-body">
            <form action="" method="post" enctype="multipart/form-data">
                
                <!-- 제목 -->
                <div class="mb-3 row">
                    <label for="title" class="col-sm-2 col-form-label">제목</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요" required>
                    </div>
                </div>
                
                <!-- 본문 -->
                <div class="mb-3 row">
                    <label for="content" class="col-sm-2 col-form-label">본문</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" id="content" name="content" rows="6" placeholder="본문을 작성하세요" required></textarea>
                    </div>
                </div>
                
                <!-- 첨부파일 -->
                <div class="mb-3 row">
                    <label for="file" class="col-sm-2 col-form-label">첨부파일</label>
                    <div class="col-sm-10">
                        <input class="form-control" type="file" id="file" name="file" multiple accept="image/*">
                        <!-- 이미지 미리보기 영역 -->
                        <div id="preview" class="d-flex flex-wrap"></div>
                    </div>
                </div>
                
                <!-- 등록 버튼 -->
                <div class="mb-3 row">
                    <div class="offset-sm-2 col-sm-10">
                        <button type="submit" class="btn btn-primary">등록하기</button>
                    </div>
                </div>
                
            </form>
        </div>
    </div>
</main>
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
</body>
</html>