<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<script src="<c:url value='/resources/js/jquery-3.7.1.min.js'/>"></script>
<style>
    main { max-width: 900px; margin: 20px auto; }
    .board-info { padding: 15px; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 20px; position: relative; }
    .board-info div { margin-bottom: 10px; font-size: 16px; }
    .file-preview img { max-width: 300px; margin-top: 5px; }
    .comment-box { margin-bottom: 10px; border-bottom: 1px solid #ddd; padding: 10px; border-radius: 5px; }
    .ccomment-box { margin-left: 40px; margin-top: 5px; padding: 10px; border-left: 2px solid #ddd; border-radius: 5px; }
    textarea { width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ccc; }
    button, input[type=submit], input[type=button] { margin-top: 5px; }
</style>
</head>
<body>
<c:import url="/WEB-INF/views/includes/header.jsp"/>

<main>
    <h2>게시글</h2>
    <hr>

    <!-- 게시글 정보 -->
    <div class="board-info">
        <!-- 신고하기 버튼 오른쪽 위 -->
        <div style="position: absolute; top: 10px; right: 10px;">
            <button type="button" onclick="openReportPopup(${FreeBoard.boardNum})" class="btn btn-primary btn-sm">신고하기</button>
        </div>

        <div><strong>제목:</strong> ${FreeBoard.title}</div>
        <div><strong>내용:</strong> ${FreeBoard.content}</div>
        <div><strong>작성자:</strong> ${FreeBoard.usersId}</div>
        <div><strong>작성일:</strong> ${FreeBoard.wDate}</div>

        <!-- 첨부파일 -->
        <div class="file-preview">
            <c:forEach var="file" items="${FreeBoard.filelist}">
                <div>
                    <a download="${file.realFileName}" href="<c:url value='/uploads/${file.fileName}'/>">
                        ${file.fileName}
                    </a>
                    <c:if test="${fn:contains(file.type,'image')}">
                        <img src="<c:url value='/uploads/${file.fileName}'/>" class="img-fluid mt-2">
                    </c:if>
                </div>
            </c:forEach>
        </div>

        <!-- 수정/삭제 -->
        <c:if test="${sessionScope.user.id == FreeBoard.usersId}">
            <input type="button" value="수정" class="btn btn-primary" onclick="moveModifyPage(${FreeBoard.boardNum})">
            <form action="<c:url value='/freeboard/delete/${FreeBoard.boardNum}'/>" method="post" style="display:inline;">
                <input type="submit" value="삭제" class="btn btn-primary">
            </form>
        </c:if>
    </div>

    <!-- 댓글 -->
    <h4>댓글</h4>
    <c:forEach var="comment" items="${FreeBoard.commentList}">
        <div class="comment-box">
            <input type="checkbox" class="deleteCommentChk" value="${comment.commentNum}" />
            <strong>${comment.usersID}</strong> : 
            <span id="commentContent_${comment.commentNum}">${comment.content}</span>
            <a href="javascript:ccommentFn(${comment.commentNum})">답글</a>
            <c:if test="${sessionScope.user.id == comment.usersID}">
                <button type="button" onclick="editComment(${comment.commentNum})" class="btn btn-sm btn-primary">수정</button>
            </c:if>
        </div>

        <!-- 대댓글 -->
        <c:forEach var="ccomment" items="${ccomentList}">
            <c:if test="${ccomment.parentCommentNum == comment.commentNum}">
                <div class="ccomment-box">
                    <input type="checkbox" class="deleteCommentChk" value="${ccomment.commentNum}" />
                    <strong>${ccomment.usersID}</strong> : 
                    <span id="commentContent_${ccomment.commentNum}">${ccomment.content}</span>
                    <c:if test="${sessionScope.user.id == ccomment.usersID}">
                        <button type="button" onclick="editComment(${ccomment.commentNum})" class="btn btn-sm btn-primary">수정</button>
                    </c:if>
                </div>
            </c:if>
        </c:forEach>
    </c:forEach>

    <!-- 선택 삭제 버튼 오른쪽 아래 -->
    <div style="text-align: right; margin-top: 10px;">
        <button type="button" onclick="deleteSelectedComments()" class="btn btn-primary btn-sm">선택 삭제</button>
    </div>

    <!-- 댓글 작성 -->
    <form action="<c:url value='/freeboard/comment'/>" method="post" class="mt-3">
        <input type="hidden" name="boardNum" value="${FreeBoard.boardNum}"/>
        <textarea name="content" placeholder="댓글을 작성하세요" required></textarea>
        <button type="submit" class="btn btn-primary mt-2">댓글 작성</button>
    </form>

    <!-- 대댓글 작성 -->
    <form name="ccommentFrm" action="<c:url value='/freeboard/comment'/>" method="post" class="mt-2">
        <input type="hidden" name="parentCommentNum" value=""/>
        <input type="hidden" name="boardNum" value="${FreeBoard.boardNum}"/>
        <textarea name="content" placeholder="대댓글을 작성하세요" required></textarea>
        <button type="button" onclick="clickFn()" class="btn btn-primary mt-2">대댓글 작성</button>
    </form>

    <!-- 댓글/대댓글 수정 폼 -->
    <form id="editCommentForm" style="display:none; margin-top:10px;">
        <input type="hidden" name="commentNum" id="editCommentNum"/>
        <textarea name="content" id="editCommentContent" required></textarea>
        <button type="button" onclick="submitEditComment()" class="btn btn-primary mt-2">수정 완료</button>
        <button type="button" onclick="cancelEdit()" class="btn btn-primary mt-2">취소</button>
    </form>

</main>

<c:import url="/WEB-INF/views/includes/footer.jsp"/>

<script>
    function ccommentFn(commentNum){
        document.getElementsByName("parentCommentNum")[0].value = commentNum;
    }

    function clickFn(){
        let value = document.getElementsByName("parentCommentNum")[0].value;
        if(value == ""){ alert("댓글을 선택해주세요"); }
        else { document.ccommentFrm.submit(); }
    }

    function moveModifyPage(boardNum){
        location.href="${pageContext.request.contextPath}/freeboard/freeboardModify/"+boardNum;
    }

    function openReportPopup(boardNum) {
        let reportWin =  window.open('/jacat/freeboard/report/'+boardNum,'reportPopup','width=500,height=400');
        reportWin.onload = function(){
            reportWin.document.getElementById("boardNum").value = boardNum;
        }
    }

    function editComment(commentNum) {
        const contentEl = document.getElementById("commentContent_" + commentNum);
        if(!contentEl) return;
        document.getElementById("editCommentForm").style.display = "block";
        document.getElementById("editCommentNum").value = commentNum;
        document.getElementById("editCommentContent").value = contentEl.innerText;
        document.getElementById("editCommentForm").scrollIntoView({behavior:"smooth"});
    }

    function cancelEdit() {
        document.getElementById("editCommentForm").style.display = "none";
    }

    function submitEditComment() {
        const commentNum = document.getElementById("editCommentNum").value;
        const content = document.getElementById("editCommentContent").value;
        $.ajax({
            url: '${pageContext.request.contextPath}/freeboard/comment/modify',
            method: 'POST',
            data: { commentNum: commentNum, content: content },
            success: function(){
                document.getElementById("commentContent_" + commentNum).innerText = content;
                cancelEdit();
            },
            error: function(){ alert("댓글 수정 실패"); }
        });
    }

    function deleteSelectedComments() {
        let selected = [];
        document.querySelectorAll('.deleteCommentChk:checked').forEach(cb => selected.push(cb.value));
        if(selected.length === 0){ alert("삭제할 댓글을 선택해주세요."); return; }
        if(!confirm("선택한 댓글을 삭제하시겠습니까?")) return;

        $.ajax({
            url: '${pageContext.request.contextPath}/freeboard/comment/delete',
            method: 'POST',
            traditional: true,
            data: { commentNums: selected },
            success: function(){
                selected.forEach(num => {
                    const el = document.getElementById("commentContent_" + num);
                    if(el) el.parentElement.remove();
                });
            },
            error: function(){ alert("댓글 삭제 실패"); }
        });
    }
</script>
</body>
</html>