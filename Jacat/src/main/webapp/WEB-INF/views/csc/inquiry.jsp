<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
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
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 40px;
	}
	
	table {
        width: 60%;
        border-collapse: collapse;
        font-size: 15px;
        table-layout: fixed;
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

    td:nth-child(1) {width: 30%; text-align: left; font-weight: bold; }
	td:nth-child(2) {width: 70%; text-align: left; }
	
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
		$(function() {
			$("#addBtn").click(function() {
				location.href = "<c:url value='/csc/write/I' />";
			});
			
			
		});
		
		function viewFn(boardsNum) {
			location.href = "<c:url value='/csc/view/I/" + boardsNum + "' />";
		}
		
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	<main>
		<section id="section_area">
			<h2 class="text-primary-emphasis">1:1 문의</h2>
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
				<table>
					<c:forEach var="boards" items="${boardsList }" varStatus="status">
						<tr onclick="viewFn(${boards.boardNum})">
							<td>
								${status.index + 1 }
							</td>
							<td>
								${boards.title }
							</td>
						</tr>
					</c:forEach>
				</table>
	
				<c:if test="${sessionScope.user.id != null and sessionScope.user.grade == 'G'}">
					<button type="button" id="addBtn" class="btn btn-primary">문의 작성하기</button>
				</c:if>
			</div>
		</section>
	</main>
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>