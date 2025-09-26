<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="<c:url value="/resources/js/jquery-3.7.1.min.js" />"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	
	<main>
		<section id="tab_area">
			<div id="user_info_tab">
				회원 정보 조회
			</div>
			
			<div id="user_board_tab">
				회원 게시글 조회
			</div>
			
			<div id="user_favorite_license_tab">
				회원 관심자격증 조회
			</div>
		</section>
		
		<section id="content_area">
			<div id="content">
			
			</div>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			function userInfoTab() {
				$("#tab_area").children("div").css("backgroundColor", "white");
				$("#user_info_tab").css("backgroundColor", "#6495ed");
				
				let target = $("#user_board_tab");
				target.children(".user_board_tab").remove();
				
				$.ajax({
					url : "<c:url value='/mypage/view-user' />",
					type : "post",
					success : function(response) {
						target = $("#content_area");
						target.children("div").remove();
						
						let content = $("<div>");
						
						let div = $("<div>");
						div.text("아이디 : " + response.id);
						content.append(div);
						
						div = $("<div>");
						div.text("닉네임 : " + response.nick);
						content.append(div);
						
						div = $("<div>");
						div.text("이메일 : " + response.email);
						content.append(div);
						
						div = $("<div>");
						div.text("프로필 이미지 : ");
						if (response.realFileName != null) {									
							let img = $("<img>");
							img.attr("width", "300px")
							.attr("alt", "프로필 이미지")
							.attr("src", "<c:url value='/uploads/profile/" + response.id + "/" + response.fileName + "' />");
							
							div.append(img);
							target.append(div);
						}
						
						let button = $("<button>");
						button.attr("type", "button").attr("id", "user_mod_btn").attr("class", "btn btn-primary").text("회원정보 수정")
						.on("click", function() {
							location.href = "<c:url value='/mypage/modify-user' />";
						});
						content.append(button);
						
						target.append(content);
						
					}, error : function(request, status, error) {
						console.log("code: " + request.status)
				        console.log("message: " + request.responseText)
				        console.log("error: " + error);
					}
				});
			}
			
			userInfoTab();
			
			function freeBoardTab() {
				let target = $("#content_area");
				target.children("div").remove();
				
				let content = $("<div>").attr("id", "content");
				
				$.ajax({
					url : "<c:url value='/mypage/free-board' />",
					type : "post",
					success : function(response) {
						if (response == null) {
							alert("로그인 하셈");
							location.href = "<c:url value='/' />";
						} else if (response.boardList.length == 0) {
							alert("작성 게시글 없음");
						} else {
							for (let i = 0; i < response.boardList.length; ++i) {
								let board = response.boardList[i];													
								
								let div = $("<div>").attr("class", "free_board")
								.on("click", {boardNum : board.boardNum}, function(event) {
									location.href = "<c:url value='/freeboard/boards/" + event.data.boardNum + "' />";
								});
								
								let p = $("<p>").text(board.title);
								div.append(p);
								
								p = $("<p>").text(board.boardNum);
								div.append(p);
								
								p = $("<p>").text(board.visit);
								div.append(p);
								
								content.append(div);	
							}	
						}
						target.append(content);
					}, error : function() {
						
					}
				});	
			}
			
			function licenseBoardQnATab() {
				let target = $("#content_area");
				target.children("div").remove();
				
				let content = $("<div>");
				
				$.ajax({
					url : "<c:url value='/mypage/license-board '/>",
					type : "post",
					data : {
						"type" : "Q"
					}, success : function(response) {
						if (response == null) {
							alert("로그인 하셈");
							location.href = "<c:url value='/' />";
						} else if (response.boardList.length == 0) {
							alert("작성 게시글 없음");
						} else {
							for (let i = 0; i < response.boardList.length; ++i) {
								let board = response.boardList[i];
								
								let div = $("<div>").attr("class", "license_board")
								.on("click", {jmcd : board.licenseListJmcd, boardNum : board.boardNum}, function(event) {
									location.href = "<c:url value='/licenses/lists/" + event.data.jmcd + "/QnA/" + event.data.boardNum + "' />";
								});
								
								let p = $("<p>").text(board.title);
								div.append(p);
								
								p = $("<p>").text(board.boardNum);
								div.append(p);
								
								p = $("<p>").text(board.visitCount);
								div.append(p);	
								
								p = $("<p>").text(board.licenseName);
								div.append(p);
								
								content.append(div);						
							}
						}
						target.append(content);
					}, error : function() {
						
					}
				});								
			}
			
			function licenseBoardDataTab() {
				let target = $("#content_area");
				target.children("div").remove();
				
				let content = $("<div>");
				
				$.ajax({
					url : "<c:url value='/mypage/license-board '/>",
					type : "post",
					data : {
						"type" : "D"
					}, success : function(response) {
						if (response == null) {
							alert("로그인 하셈");
							location.href = "<c:url value='/' />";
						} else if (response.boardList.length == 0) {
							let div = $("<div>").attr("class", "license_board");
							
							let p = $("<p>").text("작성된 게시글이 없습니다.");
							div.append(p);
							
							content.append(div);
						} else {
							for (let i = 0; i < response.boardList.length; ++i) {
								let board = response.boardList[i];

								let div = $("<div>").attr("class", "license_board");
								
								let p = $("<p>").text(board.title);
								div.append(p);
								
								p = $("<p>").text(board.boardNum);
								div.append(p);
								
								p = $("<p>").text(board.visit);
								div.append(p);
								
								content.append(div);							
							}
						}
						target.append(content);
					}, error : function() {
						
					}
				});
				
				target.append(content);
			}
			
			function inquiryBoardTab() {
				let target = $("#content_area");
				target.children("div").remove();
				
				let content = $("<div>");
				
				$.ajax({
					url : "<c:url value='/mypage/inquiry-board' />",
					type : "post",
					data : {
						"type" : "I"
					}, success : function(response) {
						if (response == null) {
							alert("로그인 하셈");
							location.href = "<c:url value='/' />";
						} else if (response.boardList.length == 0) {
							alert("작성 게시글 없음");
						} else {
							for (let i = 0; i < response.boardList.length; ++i) {
								let board = response.boardList[i];

								let div = $("<div>").attr("class", "license_board")
								.on("click", {boardNum : board.boardNum}, function(event) {
									location.href = "<c:url value='/csc/view/I/" + event.data.boardNum + "' />";
								});
								
								let p = $("<p>").text(board.title);
								div.append(p);
								
								p = $("<p>").text(board.boardNum);
								div.append(p);
								
								p = $("<p>").text(board.usersId);
								div.append(p);
								
								content.append(div);							
							}
						}
						target.append(content);
					}, error : function() {
						
					}
				});
				
				target.append(content);
			}
			
			function boardReportTab() {
				let target = $("#content_area");
				target.children("div").remove();
				
				let content = $("<div>");
				
				$.ajax({
					url : "<c:url value='/mypage/board-report' />",
					type : "post",
					success : function(response) {
						for (let i = 0; i < response.length; ++i) {
							let reportList = response[i].boardList;
							
							if (i == 0) {
								let div = $("<div>").attr("class", "board_report");
								let h3 = $("<h3>").text("자유 게시판 신고글");									
								div.append(h3);
								
								for (let j = 0; j < reportList.length; ++j) {
									let report = reportList[j];
									
									
									
									let p = $("<p>").text(report.usersId);
									div.append(p);
									
									p = $("<p>").text(report.boardsBoardNum);
									div.append(p);
									
									p = $("<p>").text(report.reportContent);
									div.append(p);
									
									content.append(div);
								}								
							} else if (i == 1) {
								let div = $("<div>").attr("class", "license_board_report");
								let h3 = $("<h3>").text("자격증 게시판 신고글");									
								div.append(h3);
								for (let j = 0; j < reportList.length; ++j) {
									let report = reportList[j];
									
									let p = $("<p>").text(report.usersId);
									div.append(p);
									
									p = $("<p>").text(report.licenseBoardsBoardNum);
									div.append(p);
									
									p = $("<p>").text(report.reportContent);
									div.append(p);
									
									content.append(div);
								}
							}
						}
						target.append(content);
					}, error : function() {
						
					}
				});
			}
			
			function userBoardTab() {
				$("#tab_area").children("div").css("backgroundColor", "white");
				$("#user_board_tab").css("backgroundColor", "#6495ed");
				
				let target = $("#content_area");
				target.children("div").remove();
				
				target = $("#user_board_tab");
				target.children("div").remove();
				
				let tab = $("<div>").text("자유게시판").attr("class", "user_board_tab").attr("id", "free_board_tab").css("backgroundColor", "#00bfff")
				.on("click", function() {
					freeBoardTab();
				});
				target.append(tab);
				
				tab = $("<div>").text("자격증 QnA").attr("class", "user_board_tab").attr("id", "qna_board_tab").css("backgroundColor", "#00bfff")
				.on("click", function() {
					licenseBoardQnATab();
				});
				target.append(tab);
				
				tab = $("<div>").text("자격증 자료실").attr("class", "user_board_tab").attr("id", "data_board_tab").css("backgroundColor", "#00bfff")
				.on("click", function() {
					licenseBoardDataTab();
				});
				target.append(tab);
				
				tab = $("<div>").text("1:1문의").attr("class", "user_board_tab").attr("id", "inquiry_board_tab").css("backgroundColor", "#00bfff")
				.on("click", function() {
					inquiryBoardTab();
				});
				target.append(tab);
				
				tab  = $("<div>").text("신고글").attr("class", "user_board_tab").attr("id", "board_report_tab").css("backgroundColor", "#00bfff")
				.on("click", function() {
					boardReportTab();
				});
				target.append(tab);
				
		
			}
			
			function userFavoriteLicenseTab() {
				$("#tab_area").children("div").css("backgroundColor", "white");
				$("#user_favorite_license_tab").css("backgroundColor", "#6495ed");
				
				let target = $("#user_board_tab");
				target.children(".user_board_tab").remove();
				
				target = $("#content_area");
				target.children("div").remove();
				
				let content = $("<div>");
				
				$.ajax({
					url : "<c:url value='/mypage/favorite-license' />",
					type : "post",
					success : function(response) {
						for (let i = 0; i < response.length; ++i) {
							let fav = response[i];
							
							let div = $("<div>").attr("class", "user_fav")
							.on("click", {jmcd : fav.licenseListJmcd}, function(event) {
								location.href = "<c:url value='/licenses/lists/" + event.data.jmcd + "' />";
							});
							
							p = $("<p>").text(fav.jmfldnm);
							div.append(p);
							
							let button = $("<button>").attr("type", "button").text("관심자격증 해제")
							.on("click", {jmcd : fav.licenseListJmcd}, function(event) {
								event.stopPropagation();
								$.ajax({
									url : "<c:url value='/mypage/cancle-favorite' />",
									type : "post",
									data : {
										"licenseListJmcd" : event.data.jmcd
									}, success: function(response) {
										if (response == "success") {
											userFavoriteLicenseTab();
										} else if (response == "fail") {
											alert("관심자격증 해제에 실패하였습니다.");
										}
									}, error : function() {
										
									}
								});
							});
							div.append(button);
							
							content.append(div);
						}
						
						target.append(content);
					}, error : function() {
						
					}
				});											
			}
			
			$("#user_info_tab").click(function() {
				userInfoTab();
			});
			
			$("#user_board_tab").click(function() {
				userBoardTab();
			});
			
			$("#user_favorite_license_tab").click(function() {
				userFavoriteLicenseTab();
			});
		});
	</script>
</body>
</html>