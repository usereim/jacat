<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<style>
	#section_area {
		display: flex;
		flex-direction: column;
		gap: 40px;
		align-items: center;
	}
	
	#lListNavBox {
		width: 100%
	}
	
	.nav-underline {
		width: 80%;
		display: flex;
		justify-content: space-around;
		margin: 0 auto;
	}
	
	#lListNavBox ul li{
		width:20%;
		text-align:center;
	}
	
	#content {
		width: 100%;
		display: flex;
		flex-direction: column;
		gap: 10px;
		align-items: center;
	}
	
	dl {
		width: 80%;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 15px;
		text-align: center;
	}
	
	dt {
		font-size: 30px;
	}
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
<script>
	function viewFAQ(obj, boardNum) {
		let dd;
		if($(obj).next("dd").text() == '') {
			$.ajax({
				url : "<c:url value='/csc/view' />",
				type : "post",
				data : {
					"boardNum" : boardNum,
					"type" : "Q"
				}, success : function(response) {
					let file = response.boardsFile;
					
					dd = $("<dd>");
					dd.text(response.content);
					$(obj).after(dd);
					
					
					if (file.boardsBoardNum == 0) {
					} else {
						let img = $("<img>");
						img.attr("width", "300px")
						.attr("src", "<c:url value='/uploads/boards/" + file.boardsBoardNum + "/" + file.fileName + "' />");
						$(obj).parent().append(img);
					}
				}, error : function() {
				}
			});
		} else {
			$(obj).next("dd").remove();
			$(obj).next("img").remove();
		}
	}
	
	function modify(boardNum) {
		location.href = "<c:url value='/csc/modify/Q/"+ boardNum + "' />";
	}
	
	function deleteFn(boardNum, obj) {
		$.ajax({
			url : "<c:url value='/csc/delete' />",
			type : "post",
			data : {
				"boardType" : "Q",
				"boardNum" : boardNum
			}, success : function(response) {
				if (response == 'delete success') {
					$("." + boardNum).remove();
					$(obj).parent("#btn_area").remove();
				}
			}, error: function() {
				
			}
		});
	}
	
	$(function() {
		$("#addBtn").click(function() {
			location.href = "<c:url value='/csc/write/Q' />";
		});
	});
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	<main>
		<section id="section_area">
			<h2 class="text-primary-emphasis">FAQ</h2>
			<div id="lListNavBox">
				<ul class="nav nav-underline">
					<li class="nav-item">
						<a href="<c:url value="/csc/tab/Q"/>" class="nav-link">FAQ</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value="/csc/tab/I"/>" class="nav-link">1:1 문의</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value="/csc/tab/A"/>" class="nav-link">정지 회원 이의신청</a>
					</li>
				</ul>
			</div>
			
			<div id="content">
				<c:forEach var="boards" items="${boardsList }">
					<dl class="${boards.boardNum }">
						<dt class="faq-list text-primary-emphasis" onclick="viewFAQ(this, ${boards.boardNum})">
							${boards.title }
						</dt>
					</dl>
					<c:if test="${sessionScope.user.grade eq 'A' }">
						<div id="btn_area">
							<button type="button" id="modBtn"
								onclick="modify(${boards.boardNum})" class="btn btn-primary">수정</button>
							<button type="button" id="delBtn"
								onclick="deleteFn(${boards.boardNum}, this)" class="btn btn-primary">삭제</button>
						</div>						
					</c:if>
				</c:forEach>
				
				<c:if test="${sessionScope.user.grade eq 'A'}">
					<button type="button" id="addBtn" class="btn btn-primary">FAQ등록</button>
				</c:if>
			</div>
		</section>

		
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>