<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<style>
#wrap {
	width: 100%;
	display: flex;
	justify-content: space-around;
}

#calendar-content {
	border: 1px solid red;
	width: 40%;
}
</style>

<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />

	<main>
		<h2>캘린더</h2>
		<div id="wrap">
			<div id="calendar" style="width: 50%"></div>

			<div id="calendar-content">
				<h3>일정</h3>
				<div></div>
				<div></div>

			</div>
		</div>
		<div>
			<button type="button" id="addBtn">일정 추가</button>
		</div>
		<div id="calendar-add-form">
   <!-- <div>
		 	<h3> 일정 등록 </h3>
			<p>일정 시작일</p> 
			<input type="text" id="start-date" name="start_date" readonly>
			<p>일정 종료일</p>
			<input type="text" id="end-date" name="end_date" readonly>
			
			<p>일정 제목</p>
			<input type="text" name="title">
			
			<p>일정 내용</p>
			<input type="text" name="content">
			
			<button type="button" id="addEventBtn">일정 등록</button>
		</div> -->
		</div>
	</main>

	<c:import url="/WEB-INF/views/includes/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script>
	<script>
		$(function() {
			let calendarEl;
			let calendar;
			let selectedDay;
			let selectCount = 0;
			let id = "${sessionScope.user.id}";

			function addEvent() {
				if (id != "") {
					$.ajax({
						url : "<c:url value='/calendar/list' />",
						type : "post",
						data : {
							"id" : id
						},
						success : function(response) {
							if (response.length != 0) {
								for (let i = 0; i < response.length; ++i) {
									let event = {
										title : response[i].title,
										start : response[i].startDate,
										end : response[i].endDate,
										backgroundColor : 'blue'
									};
									calendar.addEvent(event);
								}
							}
						},
						error : function() {

						}
					});
				} else {

				}
			}

			function addCalendar() {
				calendarEl = document.getElementById("calendar");
				calendar = new FullCalendar.Calendar(calendarEl, {
					initialView : 'dayGridMonth', // 월 기준 달력
					locale : 'ko', // 한글로 설정
					timeZone : 'UTC', // 브라우저마다 동일 시간 사용
					height : 500, // 캘린더 높이
					contentHeight : 'auto',
					selectable : true,
					selectMirror : true,
					dateClick : function(info) {
						selectedDay = info.dateStr;
					},
					events : [

					],
					dayMaxEvents : 1
				});
				calendar.render();
				addEvent();

				/* $(calendarEl).on('mousedown', '.fc-daygrid-day', function(event) {
					console.log($(this).data('date'));
				    $("#start-date").val($(this).data('date'));
				});
				
				$(calendarEl).on('mouseup', '.fc-daygrid-day', function(event) {
					console.log($(this).data('date'));
				    $("#end-date").val($(this).data('date')); 
				
				}); */

			}

			addCalendar();

			$("#addBtn").click(function() {
				let addForm = $("#calendar-add-form");
			});

			$("#addEventBtn").click(function() {
				id = "${sessionScope.user.id}";

				if (id == '') {
					alert("로그인 후 사용가능합니다.");
					return false;
				}

				let title = $("input[name=title]").val();
				let content = $("input[name=content]").val();
				let start_date = $("#start-date").val();
				let end_date = $("#end-date").val();

				$.ajax({
					url : "<c:url value='/calendar/add-event' />",
					type : "post",
					data : {
						"usersId" : id,
						"title" : title,
						"content" : content,
						"startDate" : start_date,
						"endDate" : end_date
					},
					success : function(response) {
						console.log(response);
						addCalendar();
						$("#calendar-add-form").children("div").remove();
					},
					error : function() {

					}
				});
			});
		});
	</script>
</body>
</html>