<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
<script>
function ccommentFn(commentNum){
	document.getElementsByName("parentCommentNum")[0].value = commentNum;
}

function clickFn(){
	let value = document.getElementsByName("parentCommentNum")[0].value;
	if(value == ""){
		alert("댓글을 선택해주세요")
	}else{
		$("input[name=parentCommentNum]").val(value);
		document.ccommentFrm.submit();
	}
}
</script>
</head>
<body>
	<main>
		<div>제목 : ${FreeBoard.title}</div>
		<div>내용 : ${FreeBoard.content}</div>
		<div>작성자 : ${FreeBoard.usersId}</div>
		<div>작성일 : ${FreeBoard.wDate}</div>
		
		<div>
			<c:forEach var="file" items="${FreeBoard.filelist}">
				<div>
					<a  download="${file.realFileName}" 
						href="<c:url value="/uploads/${file.fileName}" />">
						${file.fileName}
					</a><br>
				
					<c:if test="${fn:contains(file.type, 'image')}">
						<img  width="300px"
					  	src="<c:url value="/uploads/${file.fileName}" />">
					</c:if>
				</div>
			</c:forEach>
		</div>
		<c:if test="${sessionScope.user.id == FreeBoard.usersId}">
			<input type="button" value="수정" onclick="moveModifyPage(${FreeBoard.boardNum})">
			<form 
				action="<c:url value="/freeboard/delete/${FreeBoard.boardNum}" />" 
				method="post">
				<input type="submit" value="삭제">
			</form>
		</c:if>
		
	<h3>댓글</h3>
	<c:forEach var="comment" items="${FreeBoard.commentList}">
    	<div style="margin-bottom:10px; border-bottom:1px solid #ddd; padding:5px;">
        <strong>${comment.usersID}</strong> : <a href="javascript:ccommentFn(${comment.commentNum})">${comment.content}</a>
    	</div>
    	<!-- 대댓글 영역 
    	대댓글 목록(ccomentList) forEach 비교 댓글번호와 부모댓글번호 비교 후 같으면 출력 
    	-->
    	<c:forEach var="ccomment" items="${ccomentList}">
                <c:if test="${ccomment.parentCommentNum == comment.commentNum}">
                    <div style="margin-left:40px; margin-top:5px; padding:5px; border-left:2px solid #ddd;">
                        <strong>${ccomment.usersID}</strong> : ${ccomment.content}
                    </div>
                </c:if>
        </c:forEach>
    </c:forEach>
    	
		
		<!-- 댓글 작성 폼 -->
   		<form action="<c:url value='/freeboard/comment'/>" method="post">
        <input type="hidden" name="boardNum" value="${FreeBoard.boardNum}"/>
        <textarea name="content" placeholder="댓글을 작성하세요" required></textarea>
        <input type="submit">댓글 작성</input>
    	</form>
    	
    	<!-- 대댓글 작성 폼 -->	
   		<form name="ccommentFrm" action="<c:url value='/freeboard/comment'/>" method="post">
        <input type="hidden" name="parentCommentNum" value=""/>
        <input type="hidden" name="boardNum" value="${FreeBoard.boardNum}"/>
        <textarea name="content" placeholder="대댓글을 작성하세요" required></textarea>
        <input type="button" onclick="clickFn()" value='댓글 작성'>
    	</form>
    	
    	<!-- 신고하기 버튼 -->
   		<button type="button" onclick="openReportPopup(${FreeBoard.boardNum})">신고하기</button>
</form>
    	
    	
    	
	</main>
</body>
<script>

	let boardNum = ${FreeBoard.boardNum};
	console.log(boardNum);
	
	let title = "${FreeBoard.title}";
	console.log(title);
	
	function moveModifyPage(boardNum){
		location.href="${pageContext.request.contextPath}/freeboard/freeboardModify/"+boardNum;
	}
	
	function openReportPopup(boardNum) {
	   let reportWin =  window.open(
	        '/jacat/freeboard/report/'+boardNum, // JSP 경로 (서버에서 바로 열기)
	        'reportPopup',
	        'width=500,height=400'
	    );
	   reportWin.onload =  function(){
		   
		   reportWin.document.getElementById("boardNum").value = boardNum;
	   }
	  
	}
</script>

</html>