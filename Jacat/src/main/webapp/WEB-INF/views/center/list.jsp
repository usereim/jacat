<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시험장 조회</title>
<style>
	#lListNavBox ul li{
		width:20%;
		text-align:center;
	}
	
	#section_area {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 20px;
	}
	
	#search_area {
		width: 50%;
		display: flex;
		justify-content: center;
		align-items : center;
		gap: 15px;
		margin-bottom: 40px;
	}
	
	#keyword {
		width: 300px;
	}
	
	#content {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	table {
        width: 80%;
        border-collapse: collapse;
        font-size: 15px;
        table-layout: fixed;
    }

    th, td {
        border: 1px solid #222;
        padding: 10px 8px;
        line-height: 1.6;
        height: 40px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    th:nth-child(1), td:nth-child(1) { width: 10%; text-align: left; }
    th:nth-child(2), td:nth-child(2) { width: 45%; text-align: left; }
    th:nth-child(3), td:nth-child(3) { width: 45%; text-align: left; }

    /* 헤더 강조 */
    th {
    background-color: #2780e3; /* btn-primary 색상 */
    color: #ffffff; /* 흰색 글씨로 대비 */
    font-size: 15px;
    border-bottom: 2px solid #222;
	}

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
		<hr>
		<div id="lListNavBox">
			<ul class="nav nav-underline">
				<li class="nav-item">
					<a href="<c:url value='/licenses/lists'/>" class="nav-link">자격증 목록</a>
				</li>
				<li class="nav-item">
					<a href="<c:url value='/licenses/center/list'/>" class="nav-link">시험장 정보</a>
				</li>
			</ul>
		</div>
		<hr>
		
		<section id="section_area">
			<h2 class="text-primary-emphasis">시험장 검색</h2>
			<section id="search_area">
				<label for="keyword">검색어</label>
				<input type="text" id="keyword" name="keyword" id="keyword" class="form-control"> <br>
				<button type="button" id="search_btn" class="btn btn-primary">시험장 검색</button>
			</section>
			
			<section id="content_area">
				<div id="content">
					<table id="table">
						<tr id="t_head">
							<th>번호</th>
							<th>시험장 이름</th>
							<th>시험장 주소</th>
						</tr>
					</table>
				</div>
			</section>
		</section>
		
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
	
	<script>
		$(function() {
			$("#search_btn").on("click", function() {
				let target = $("#table");
				target.find(".t_body").remove();
				
				$("#content").children(".center").remove();
				
				let keyword = $("#keyword").val();
				if (keyword != '') {
					$.ajax({
						url : "<c:url value='/licenses/center/search' />",
						type : "post",
						data : {
							"keyword" : keyword
						}, success : function(response) {
							if (response.length == 0) {
								let div = $("<div>").attr("class", "center");
								
								let p = $("<p>").text("해당 검색어에 해당하는 시험장이 존재하지 않습니다.").css("color", "red").css("fontSize", "24px");
								div.append(p);
								
								$("#content").append(div);
							} else {
								for (let i = 0; i < response.length; ++i) {
									let center = response[i];
									
									let tr = $("<tr>").attr("class", "t_body")
									.on("click", {addno : center.addno}, function(event) {
										location.href = "<c:url value='/licenses/center/view/" + event.data.addno + "' />";
									});
									
									let td = $("<td>").text(i + 1);
									tr.append(td);
									
									td = $("<td>").text(center.examAreaNm);
									tr.append(td);
									
									td = $("<td>").text(center.address);
									tr.append(td);
									
									target.append(tr);
								}
							} 
						}, error : function() {
						}
					});
				} else {
					alert("검색어를 입력해 주세요");
				}
			});
		});
	</script>
</body>
</html>