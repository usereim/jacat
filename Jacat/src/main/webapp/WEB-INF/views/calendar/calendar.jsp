<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<style>
	section#content_area {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	section > h2 {
		margin-bottom: 40px;
	}
	
	#wrap {
		width: 100%;
		display: flex;
		justify-content: space-around;
	}
	
	#calendar_content {
		width: 40%;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 10px;
	}

	#date_area {
		width: 30%;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	#calendar_add_form {
		width: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	#calendar_add_form > h3 {
		margin: 30px 0;
	}
	
	.add_wrap {
	 	width: 100%;
		display: flex;
		justify-content: space-around;
		align-items: center;
	}
	
	.add_input {
		display:flex;
		justify-content: flex-start;
		align-items: center;
		gap: 20px;
	}
	
	.add_input > input {
		width: 200px;
	}
	
	#date_form {
		width: 40%;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}
	
	#content_form {
		width: 30%;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}
	
	#add_event_btn {
		height: 38px;
	}
	
	ul {
		margin: 20px 0;
	}
	
	li {
		list-style: none;
		margin: 10px 0;
	}
</style>

<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp" />

	<main>
		<section id="content_area">
			<h2 class="text-primary">캘린더</h2>
			<div id="wrap">
				<div id="calendar" style="width: 50%"></div>
	
				<div id="calendar_content">
					<h3 class="text-primary">일정</h3>
					<div id="date_area">
						<div id="selected_date"></div>
						<div id="selected_date_content">
					</div>
					</div>
				</div>
			</div>
			
			<div id="calendar_add_form">
				 	<h3 class="text-primary"> 일정 등록 </h3>
				 	<div class="add_wrap">
				 		<div id="date_form">
				 			<div class="add_input">
				 				<label for="start_date" class="text-primary">일정 시작일</label>
								<input type="text" id="start_date" name="start_date" class="form-control" readonly>
								<button type="button" id="start_date_btn" class="btn btn-primary">시작일 등록</button>
				 			</div>
				 			
							<div class="add_input">
								<label for="end_date" class="text-primary">일정 종료일</label>
								<input type="text" id="end_date" name="end_date" class="form-control" readonly>
								<button type="button" id="end_date_btn" class="btn btn-primary">종료일 등록</button>
							</div>
				 		</div>
				 		
						<div id="content_form">
							<div class="add_input">
								<label for="title" class="text-primary">일정 제목</label>
								<input type="text" name="title" id="title" class="form-control">
							</div>
							
							<div class="add_input">
								<label for="content" class="text-primary">일정 내용</label>
								<input type="text" name="content" id="content" class="form-control">
							</div>
						</div>
						
						<button type="button" id="add_event_btn" class="btn btn-primary">일정 등록</button> 
				 	</div>
					
			</div>
		</section>
		

		
	</main>

	<c:import url="/WEB-INF/views/includes/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js"></script>
	<script>
		$(function() {
			let calendarEl;
			let calendar;
			let selectedDay;
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
									let startDate = new Date(response[i].startDate);
									let startDateWithoutTime = startDate.toISOString().split('T')[0];
									let endDate = new Date(response[i].endDate);				
									endDate.setDate(endDate.getDate() + 1);
									let endDateWithoutTime = endDate.toISOString().split('T')[0];
									let event = {
										title : response[i].title,
										start : startDateWithoutTime,
										end : endDateWithoutTime,
										backgroundColor : '#87ceeb'
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
			
			function addLicenseEvent() {
				if (id != "") {
					$.ajax({
						url : "<c:url value='/calendar/test-date-list' />",
						type : "post",
						data : {
							"id" : id
						}, success : function(response) {
							for (let i = 0; i < response.length; ++i) {
								let dateList = response[i].dateList;
								let jmfldnm = response[i].jmfldnm;
								for (let j = 0; j < dateList.length; ++j) {
									let formattedDateString = dateList[j].docRegEndDt.substring(0, 4) + '-' +
										dateList[j].docRegEndDt.substring(4, 6) + '-' +
										dateList[j].docRegEndDt.substring(6, 8); 
									let date = new Date(formattedDateString);
									date.setDate(date.getDate() + 1);
									let date2 = date.toISOString().split('T')[0];
									let event = {
											title : jmfldnm + " " + dateList[j].description + " 필기시험 원서접수" ,
											start : dateList[j].docRegStartDt,
											end : date2,
											backgroundColor : '#ffb6c1'
									};									
									calendar.addEvent(event);
									
									formattedDateString = dateList[j].docExamEndDt.substring(0, 4) + '-' +
										dateList[j].docExamEndDt.substring(4, 6) + '-' +
										dateList[j].docExamEndDt.substring(6, 8); 
									date = new Date(formattedDateString);
									date.setDate(date.getDate() + 1);
									date2 = date.toISOString().split('T')[0];
									event = {
											title : jmfldnm + " " + dateList[j].description + " 필기시험" ,
											start : dateList[j].docExamStartDt,
											end : date2,
											backgroundColor : '#ffb6c1'
									}
									calendar.addEvent(event);
									
									formattedDateString = dateList[j].docPassDt.substring(0, 4) + '-' +
										dateList[j].docPassDt.substring(4, 6) + '-' +
										dateList[j].docPassDt.substring(6, 8); 
									date = new Date(formattedDateString);
									date.setDate(date.getDate() + 1);
									date2 = date.toISOString().split('T')[0];
									event = {
											title : jmfldnm + " " + dateList[j].description + " 필기시험 합격자 발표일" ,
											start : dateList[j].docPassDt,
											end : date2,
											backgroundColor : '#ffb6c1'
									}
									calendar.addEvent(event);
									
									formattedDateString = dateList[j].pracRegEndDt.substring(0, 4) + '-' +
										dateList[j].pracRegEndDt.substring(4, 6) + '-' +
										dateList[j].pracRegEndDt.substring(6, 8); 
									date = new Date(formattedDateString);
									date.setDate(date.getDate() + 1);
									date2 = date.toISOString().split('T')[0];
									event = {
											title : jmfldnm + " " + dateList[j].description + " 실기시험 원서접수" ,
											start : dateList[j].pracRegStartDt,
											end : date2,
											backgroundColor : '#ffb6c1'
									}
									calendar.addEvent(event);
									
									formattedDateString = dateList[j].pracExamEndDt.substring(0, 4) + '-' +
										dateList[j].pracExamEndDt.substring(4, 6) + '-' +
										dateList[j].pracExamEndDt.substring(6, 8); 
									date = new Date(formattedDateString);
									date.setDate(date.getDate() + 1);
									date2 = date.toISOString().split('T')[0];
									event = {
											title : jmfldnm + " " + dateList[j].description + " 실기시험" ,
											start : dateList[j].pracExamStartDt,
											end : date2,
											backgroundColor : '#ffb6c1'
									}
									calendar.addEvent(event);
									
									formattedDateString = dateList[j].pracPassDt.substring(0, 4) + '-' +
										dateList[j].pracPassDt.substring(4, 6) + '-' +
										dateList[j].pracPassDt.substring(6, 8); 
									date = new Date(formattedDateString);
									date.setDate(date.getDate() + 1);
									date2 = date.toISOString().split('T')[0];
									event = {
											title : jmfldnm + " " + dateList[j].description + " 실기시험 합격자 발표" ,
											start : dateList[j].pracPassDt,
											end : date2,
											backgroundColor : '#ffb6c1'
									}
									calendar.addEvent(event);
								}
								
							}
						}, error : function() {
							
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
					height : 400, // 캘린더 높이
					contentHeight : 'auto',
					selectable : true,
					selectMirror : true,
					dateClick : function(info) {
						/* selectedDay = info.dateStr; */
					},
					events : [

					],
					dayMaxEvents : 1
				});
				calendar.render();
				addEvent();
				addLicenseEvent();
				
				$("#fc-dom-1").addClass("text-primary");
				
				/* $(calendarEl).on('mousedown', '.fc-daygrid-day', function(event) {
					console.log($(this).data('date'));
				    $("#start-date").val($(this).data('date'));
				});
				*/
				$(calendarEl).on('mouseup', '.fc-daygrid-day', function(event) {
				    selectedDay = $(this).data('date'); 
				    
				    $("#selected_date").text(selectedDay + " 일의 일정");
				    
				    $.ajax({
				    	url : "<c:url value='/calendar/view' />",
				    	type : "post",
				    	data : {
				    		"selectedDay" : selectedDay
				    	}, success : function(response) {
				    		//dateContent(response);
				    		let target = $("#selected_date_content");
				    		target.children("ul").remove();
				    		target.children("button").remove();
				    		
				    		for (let i = 0; i < response.length; ++i) {
				    			let ul = $("<ul>");
				    			
				    			let title = $("<li>");
				    			title.text("일정 제목 : " + response[i].title);
				    			ul.append(title);
				    			
				    			let content = $("<li>");
				    			content.text("일정 내용 : " + response[i].content);
				    			ul.append(content);				    							
				    			target.append(ul);
				    			
				    			let modBtn = $("<button>");
				    			modBtn.attr("type", "button").text("일정 수정").attr("class", "btn btn-primary").css("margin-right", "5px")
				    			.on("click", {dateNum : response[i].dateNum}, function(event) {
				    				let target = $(".add_wrap");
				    				let h3 = target.children("h3").detach();
				    				target.children("#add_event_btn").remove();
				    				target.children(".btn").remove();
				    				
				    				h3.text("일정 수정");
				    				target.prepend(h3);
				    				
				    				$("#start_date").val(response[i].startDate);
				    				$("#end_date").val(response[i].endDate);
				    				$("input[name=title]").val(response[i].title);
				    				$("input[name=content]").val(response[i].content);
				    				
				    				let button = $("<button>").attr("type", "button").attr("id", "mod_btn").attr("class", "btn btn-primary").text("일정 수정")
				    				.on("click", {dateNum : response[i].dateNum}, function(event) {
				    					$.ajax({
				    						url : "<c:url value='/calendar/modify' />",
				    						type : "post",
				    						data : {
				    							"dateNum" : event.data.dateNum,
				    							"startDate" : $("#start_date").val(),
				    							"endDate" : $("#end_date").val(),
				    							"title" : $("input[name=title]").val(),
				    							"content" : $("input[name=content]").val(),
				    						}, success : function(response) {
				    							addCalendar();
				    							let target = $("#selected_date_content");
				    							target.children("ul").remove();
									    		target.children("button").remove();
									    		
									    		target = $(".add_wrap");
							    				target.children("h3").remove();					    
							    				target.children(".btn").remove();
							    				
							    				let h3 = $("<h3>");
							    				h3.text("일정 등록");
							    				target.prepend(h3);
							    				
							    				let addBtn = $("<button>").attr("type", "button").attr("id", "add_event_btn").attr("class", "btn btn-primary").text("일정 등록");
							    				target.append(addBtn);
							    				
						    					$("#start_date").val("");
							    				$("#end_date").val("");
							    				$("input[name=title]").val("");
							    				$("input[name=content]").val("");
				    						}, error : function() {
				    							
				    						}
				    					});
				    				});
				    				target.append(button);
				    				
				    				let cancleButton= $("<button>").attr("type", "button").attr("id", "mod_btn").attr("class", "btn btn-primary").text("수정 취소")
				    				.on("click", function() {		
				    					let target = $(".add_wrap");
					    				let h3 = target.children("h3").detach();					    
					    				target.children(".btn").remove();
					    								
					    				h3.text("일정 등록");
					    				target.prepend(h3);
					    				
					    				let addBtn = $("<button>").attr("type", "button").attr("id", "add_event_btn").attr("class", "btn btn-primary").text("일정 등록");
					    				target.append(addBtn);
					    				
				    					$("#start_date").val("");
					    				$("#end_date").val("");
					    				$("input[name=title]").val("");
					    				$("input[name=content]").val("");
				    				});
				    				target.append(cancleButton);
				    			});
				    			target.append(modBtn);
				    			
				    			let delBtn = $("<button>");
				    			delBtn.attr("type", "button").text("일정 삭제").attr("class", "btn btn-primary")
				    			.on("click", {dateNum : response[i].dateNum}, function(event) {
				    				$.ajax({
				    					url : "<c:url value='/calendar/delete' />",
				    					type : "post",
				    					data : {
				    						"dateNum" : event.data.dateNum
				    					}, success : function(response) {
				    						addCalendar();
				    						let target = $("#selected_date_content");
								    		target.children("ul").remove();
								    		target.children("button").remove();
				    					}, error : function() {
				    						
				    					}
				    				});
				    			});
				    			target.append(delBtn);
				    		}
				    	}, error : function() {
				    		
				    	}
				    });
				    
				}); 

			}

			addCalendar();

			/* $("#addBtn").click(function() {
				
			}); */
			
			$("#start_date_btn").click(function() {
				$("#start_date").val(selectedDay);
			});
			
			$("#end_date_btn").click(function() {
				$("#end_date").val(selectedDay);
			});

			$("#add_event_btn").click(function() {
				id = "${sessionScope.user.id}";

				if (id == '') {
					alert("로그인 후 사용가능합니다.");
					return false;
				}
				
				if ($("#start_date").val() == '' || $("#end_date").val() == '') {
					alert("일정을 등록할 날짜를 선택해 주세요.");
					return false;
				}
				
				let title = $("input[name=title]").val();
				let content = $("input[name=content]").val();
				let start_date = new Date($("#start_date").val());
				let end_date = new Date($("#end_date").val());
				
				if (start_date > end_date) {
					alert("일정 시작일이 종료일보다 뒤입니다. 다시 선택해 주세요.");
					$("#start_date").val("");
					$("#end_date").val("");
					return false;
				}
				
				start_date = $("#start_date").val();
				end_date = $("#end_date").val();

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
					},
					error : function() {

					}
				});
			});
		});
	</script>
</body>
</html>