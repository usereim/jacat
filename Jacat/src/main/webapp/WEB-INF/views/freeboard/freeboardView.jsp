<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
<script src="<c:url value='/resources/js/jquery-3.7.1.min.js'/>"></script>

</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	<main>
    <div>제목 : ${FreeBoard.title}</div>
    <div>내용 : ${FreeBoard.content}</div>
    <div>작성자 : ${FreeBoard.usersId}</div>
    <div>작성일 : ${FreeBoard.wDate}</div>

    <!-- 첨부파일 -->
    <div>
        <c:forEach var="file" items="${FreeBoard.filelist}">
            <div>
                <a download="${file.realFileName}" 
                   href="<c:url value='/uploads/${file.fileName}'/>">
                   ${file.fileName}
                </a><br>
                <c:if test="${fn:contains(file.type,'image')}">
                    <img width="300px" src="<c:url value='/uploads/${file.fileName}'/>">
                </c:if>
            </div>
        </c:forEach>
    </div>

    <!-- 게시글 수정/삭제 -->
    <c:if test="${sessionScope.user.id == FreeBoard.usersId}">
        <input type="button" value="수정" class="btn btn-primary" onclick="moveModifyPage(${FreeBoard.boardNum})">
        <form action="<c:url value='/freeboard/delete/${FreeBoard.boardNum}'/>" method="post">
            <input type="submit" value="삭제" class="btn btn-primary">
        </form>
    </c:if>

    <!-- 댓글 -->
    <h3>댓글</h3>
    <c:forEach var="comment" items="${FreeBoard.commentList}">
        <div style="margin-bottom:10px; border-bottom:1px solid #ddd; padding:5px;">
            <strong>${comment.usersID}</strong> :
            <span id="commentContent_${comment.commentNum}">${comment.content}</span>
            <a href="javascript:ccommentFn(${comment.commentNum})">답글</a>

            <c:if test="${sessionScope.user.id == comment.usersID}">
                <button type="button" onclick="editComment(${comment.commentNum})" class="btn btn-primary">수정</button>
            </c:if>
        </div>

        <!-- 대댓글 -->
        <c:forEach var="ccomment" items="${ccomentList}">
            <c:if test="${ccomment.parentCommentNum == comment.commentNum}">
                <div style="margin-left:40px; margin-top:5px; padding:5px; border-left:2px solid #ddd;">
                    <strong>${ccomment.usersID}</strong> : <span id="commentContent_${ccomment.commentNum}">${ccomment.content}</span>
                </div>
                
                 <!-- 대댓글 수정 버튼 -->
           		 <c:if test="${sessionScope.user.id == ccomment.usersID}">
                	<button type="button" onclick="editComment(${ccomment.commentNum})" class="btn btn-primary">수정</button>
           		 </c:if>
           	</c:if>
        </c:forEach>
    </c:forEach>

    <!-- 댓글 작성 -->
    <form action="<c:url value='/freeboard/comment'/>" method="post">
        <input type="hidden" name="boardNum" value="${FreeBoard.boardNum}"/>
        <textarea name="content" placeholder="댓글을 작성하세요" required></textarea>
        <button type="submit" class="btn btn-primary">댓글 작성</button>
    </form>

    <!-- 대댓글 작성 -->
    <form name="ccommentFrm" action="<c:url value='/freeboard/comment'/>" method="post">
        <input type="hidden" name="parentCommentNum" value=""/>
        <input type="hidden" name="boardNum" value="${FreeBoard.boardNum}"/>
        <textarea name="content" placeholder="대댓글을 작성하세요" required></textarea>
        <button type="button" onclick="clickFn()" class="btn btn-primary">대댓글 작성</button>
    </form>

    <!-- 댓글/대댓글 수정 폼 -->
    <form id="editCommentForm" style="display:none; margin-top:10px;">
        <input type="hidden" name="commentNum" id="editCommentNum"/>
        <textarea name="content" id="editCommentContent" required></textarea>
        <button type="button" onclick="submitEditComment()" class="btn btn-primary">수정 완료</button>
        <button type="button" onclick="cancelEdit()" class="btn btn-primary">취소</button>
    </form>

    <!-- 신고 -->
    <button type="button" onclick="openReportPopup(${FreeBoard.boardNum})" class="btn btn-primary">신고하기</button>
</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>

</body>
<script>
    // 대댓글 작성 선택
    function ccommentFn(commentNum){
        document.getElementsByName("parentCommentNum")[0].value = commentNum;
    }

    function clickFn(){
        let value = document.getElementsByName("parentCommentNum")[0].value;
        if(value == ""){
            alert("댓글을 선택해주세요");
        } else {
            $("input[name=parentCommentNum]").val(value);
            document.ccommentFrm.submit();
        }
    }

    // 게시글 수정 페이지 이동
    function moveModifyPage(boardNum){
        location.href="${pageContext.request.contextPath}/freeboard/freeboardModify/"+boardNum;
    }

    // 신고 팝업
    function openReportPopup(boardNum) {
       let reportWin =  window.open(
            '/jacat/freeboard/report/'+boardNum,
            'reportPopup',
            'width=500,height=400'
        );
       reportWin.onload =  function(){
           reportWin.document.getElementById("boardNum").value = boardNum;
       }
    }

    // 댓글 수정
    function editComment(commentNum) {
        const contentEl = document.getElementById("commentContent_" + commentNum);
        if(!contentEl) return; // 안전 체크

        const content = contentEl.innerText;
        document.getElementById("editCommentForm").style.display = "block";
        document.getElementById("editCommentNum").value = commentNum;
        document.getElementById("editCommentContent").value = content;
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
            success: function(response){
                // 화면 댓글 업데이트
                document.getElementById("commentContent_" + commentNum).innerText = content;
                cancelEdit(); // 폼 닫기
            },
            error: function(){
                alert("댓글 수정 실패");
            }
        });
    }
</script>
</html>