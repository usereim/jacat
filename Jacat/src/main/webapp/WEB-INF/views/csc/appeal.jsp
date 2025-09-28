<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정지 회원 이의신청</title>
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
	
	#input_area {
		width: 60%;
		margin: 0 auto;
		display: flex;
		flex-direction: column;
		align-items: flex-start;
		gap: 20px;
	}
	
	#input_area > div {
		width: 80%;
		display: flex;
		flex-direction: column;
		gap: 10px;
		align-items: center;
		margin-left: 80px;
	}
	
	.input {
		width: 60%;
		display: flex;
		align-items: center;
		justify-content: start;
		gap: 10px;
	}
	
	#content {
		display: flex;
		flex-direction: column;
		gap: 20px;
		align-items: center;
	}
	
	table {
		width: 80%;
        border-collapse: collapse;
        font-size: 15px;
        table-layout: fixed;
    	margin: 0 auto;
    }

    td {
        border: 1px solid #222;
        padding: 10px 8px;
        line-height: 1.6;
        height: 40px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    td:nth-child(1) { width: 30%; text-align: left; }
    td:nth-child(2) { width: 70%; text-align: left; }

    /* 테이블 행 구분선과 배경 */
    table tr {
        border-bottom: 1px solid #ccc;
    }
    table tr:nth-child(even) {
        background-color: #f7f7f7;
    }

    /* 제목 링크 강조 */
    td:first-child a {
        font-weight: bold;
        color: #000;
    }
    td:first-child a:hover {
        text-decoration: underline;
    }
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
<script>
	function clickFn(boardNum) {
		location.href = "<c:url value='/csc/view/A/" + boardNum + "' />";
	}
	
	function addFn() {
		location.href = "<c:url value='/csc/write/A' />";
	}
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	<main>
		<section id="section_area">
			<h2 class="text-primary-emphasis">정지 회원 이의신청</h2>
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
				<c:if test="${not empty sessionScope.suspend}">
					<table>
						<tr>
							<c:forEach var="csc" items="${cscList}" varStatus="status">
								<td onclick="clickFn(${csc.boardNum})">
									${status.index + 1 }
								</td>
								<td onclick="clickFn(${csc.boardNum})">
									${csc.title }
								</td>
							</c:forEach>
						</tr>
						
					</table>
					<button type="button" id="add_btn" onclick="addFn()" class="btn btn-primary">이의 신청 하기</button>
				</c:if>
			</div>
	
			<!-- 세션의 이메일 인증 여부 확인하여 이메일 인증이 되었으면 화면에 안만듬 -->
			<c:if test="${empty sessionScope.suspend}">
				<div id="input_area">
					<div id="id_area">
						<div class="input">
							<label for="id" class="text-primary-emphasis">아이디</label>
							<input type="text" name="id" id="id">
						</div>
						<div id="id_message"></div>
					</div>
					
					<div id="email_area">
						<div class="input">
							<label for="email" class="text-primary-emphasis">이메일</label>
							<input type="text" name="email" id="email">
							<button type="button" id="emailBtn" class="btn btn-primary" disabled>인증번호 전송</button>
						</div>
						<div id="email_message"></div>
					</div>
					
					
					<div id="code_area">
						<div class="input">
							<label for="code" class="text-primary-emphasis">인증번호</label>
							<input type="text" name="code" id="code">
							<button type="button" id="codeBtn" class="btn btn-primary" disabled>인증</button> 
						</div>
						<div id="code_message"></div>
					</div>
				</div>
			</c:if>
		</section>
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			let id;
			let email;
			
			function sessionSuspend() {
				id = $("input[name=id]").val();
				
				$.ajax({
					url : "<c:url value='/csc/session-suspend' />",
					type : "post",
					data : {
						"id" : id
					}, success : function(response) {
						console.log(response);
					}, error : function() {
						
					}
				});
			}
			
			$("input[name=id]").keyup(function() {
				id = $("input[name=id]").val();
				
				$.ajax({
					url : "<c:url value='/user/id-suspend' />",
					type : "post",
					data : {
						"id" : id
					}, success : function(response) {
						if (response.code == 0) {
							$("#id_message").text("정지회원이 아닙니다.").css("color", "red");
							$("#emailBtn").prop("disabled", true);
						} else {
							$("#id_message").text("");
							$("#emailBtn").prop("disabled", false);
						}
					}, error : function() {
						
					}
				});
			});
			
			$("input[name=email]").keyup(function() {
				email = $("input[name=email]").val();
				id = $("input[name=id]").val();
				
				$.ajax({
					url : "<c:url value='/user/idmail-check' />",
					type : "post",
					data : {
						"id" : id,
						"email" : email
					}, success : function(response) {
						if (response.code == 1) {
							$("#email_message").text("정지회원이 아닙니다.").css("color", "red");
							$("#emailBtn").prop("disabled", true);
						} else {
							$("#email_message").text("");
							$("#emailBtn").prop("disabled", false);
						}
					}, error : function() {
						
					}
					
				});
			});
			
			$("#emailBtn").click(function() {
				email = $("input[name=email]").val();
				
				$.ajax({
					url : "<c:url value='/mail/send-mail' />",
					type : "post",
					data : {
						"email" : email
					}, success : function(response) {
						if (response == 'success') {
							$("#emailBtn").prop("disabled", true);
							$("#codeBtn").prop("disabled", false)
						} else {
							$("#codeBtn").prop("disabled", true);
						}
					}, error : function() {
						
					}
				});
			});
			
			$("#codeBtn").click(function() {
				let code = $("input[name=code]").val();
				
				$.ajax({
					url : "<c:url value='/mail/code-check' />",
					type : "post",
					data : {
						"code" : code
					}, success : function(response) {
						if (response == 'success') {
							// 세션에 이메일 인증 여부 저장
							sessionSuspend();
							location.href = "<c:url value='/csc/tab/A' />";
						} else if (response == 'fail') {
						}
					}, error : function() {
						
					}
				});
			});
		});
	</script>
</body>
</html>