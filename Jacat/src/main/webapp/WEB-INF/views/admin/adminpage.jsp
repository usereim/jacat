<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<style>
	main {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	section#content_area {
		width: 80%;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 20px;
		margin-top: 200px;
	}
	
	section > h2 {
		margin-bottom: 60px;
	}
	
	div#btn_area {
		width: 70%;
		display: flex;
		gap: 20px;
	}
</style>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />
	
	<main>
		<section id="content_area">
			<h2 class="text-primary">자격증 정보 API 업데이트</h2>
			
			<div id="btn_area">
				<button type="button" id="license_list_btn" class="btn btn-primary">자격증 목록 정보 업데이트</button>
				<button type="button" id="license_eligibility_btn" class="btn btn-primary">자격증 응시자격 정보 업데이트</button>
				<button type="button" id="license_test_center_btn" class="btn btn-primary">시험장 정보 업데이트</button>
				<button type="button" id="license_test_date_btn" class="btn btn-primary">자격증 시험일정 업데이트</button>
			</div>
		</section>
		
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp" />
	
	<script>
		$(function() {
			$("#license_list_btn").click(function() {
				$.ajax({
					url : "<c:url value='/api/license-list' />",
					type : "post",
					success : function(response) {
						console.log(response);
					}, error : function() {
						
					}
				});
			});
			
			$("#license_eligibility_btn").click(function() {
				$.ajax({
					url : "<c:url value='/api/license-eligibility' />",
					type : "post",
					success : function(response) {
						console.log(response);
					}, error : function() {
						
					}
				});
			});
			
			$("#license_test_center_btn").click(function() {
				$.ajax({
					url : "<c:url value='/api/license-test-center' />",
					type : "post",
					success : function(response) {
						console.log(response);
					}, error : function() {
						
					}
				});
			});
			
			$("#license_test_date_btn").click(function() {
				$.ajax({
					url : "<c:url value='/api/license-test-date' />",
					type: "post",
					success : function(response) {
						console.log(response);
					}, error : function() {
						
					}
				});
			});
		});
	</script>
</body>
</html>