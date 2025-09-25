<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시험장 정보</title>
<style>
	#content_area {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 30px;
		margin-top: 100px;
	}
	
	#content {
		width: 80%;
	}

	table {
        width: 100%;
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

    td:nth-child(1) { width: 20%; text-align: left; font-weight: bold;}
    td:nth-child(2) { width: 80%; text-align: left; }

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
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	
	<main>
		<section id="content_area">
			<h2 class="text-primary-emphasis">시험장 정보</h2>
			
			<div id="content">
				<table>
					<tr>
						<td>시험장 이름</td>
						<td>${center.examAreaNm }</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>${center.address }</td>
					</tr>
					<tr>
						<td>지사 명</td>
						<td>${center.brchNm}</td>
					</tr>
					<tr>
						<td>장소위치 안내</td>
						<td>${center.plceLoctGid }</td>
					</tr>
					<tr>
						<td>전화변호</td>
						<td>${center.telNo }</td>
					</tr>
				</table>
			</div>
			
			<button type="button" id="back_btn" class="btn btn-primary">뒤로가기</button>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
	
	<script>
		$(function() {
			$("#back_btn").click(function() {
				location.href = "<c:url value='/licenses/center/list' />";
			});
		});
	</script>
</body>
</html>