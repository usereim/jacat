<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시험장 조회</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />

	<main>
		<section id="search_area">
			검색어 입력 : <input type="text" name="keyword" id="keyword"> <br>
			<button type="button" id="search_btn">시험장 검색</button>
		</section>
		
		<section id="content_area">
			<div id="content"></div>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
	
	<script>
		$(function() {
			$("#search_btn").on("click", function() {
				let target = $("#content_area");
				target.children("div").remove();
				
				let content = $("<div>").attr("id", "content");
				
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
								
								let p = $("<p>").text("해당 검색어에 해당하는 시험장이 존재하지 않습니다.");
								div.append(p);
								
								content.append(div);
							} else {
								for (let i = 0; i < response.length; ++i) {
									let center = response[i];
									
									let div = $("<div>").attr("class", "center")
									.on("click", {addno : center.addno}, function(event) {
										location.href = "<c:url value='/licenses/center/view/" + event.data.addno + "' />";
									});
									
									let p = $("<p>").text("시험장 이름 : " + center.examAreaNm);
									div.append(p);
									
									p = $("<p>").text("주소 : " + center.address);
									div.append(p);
									
									content.append(div);
								}
							}
							target.append(content);
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