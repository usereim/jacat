<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
	#lListNavBox ul li {
		width:20%;
		text-align:center;
	}
	
	#sub_tab ul li {
		width:15%;
		text-align:center;
	}
	
	#content_area {
		margin-top: 60px;
	}
	
	#content {
		width: 100%;
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

    th, td {
        border: 1px solid #222;
        padding: 10px 8px;
        line-height: 1.6;
        height: 40px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

	.user_info_tb > td:nth-child(1) { width: 30%; text-align: left; }
	.user_info_tb > td:nth-child(2) { width: 70%; text-align: left; }


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
	<c:import url="/WEB-INF/views/includes/header.jsp"/>
	
	<main>
		<hr>
		<div id="lListNavBox">
			<ul class="nav nav-underline">
				<li class="nav-item">
					<div class="nav-link" id="user_info_tab">회원 정보 조회</div>
				</li>
				<li class="nav-item">
					<div class="nav-link" id="user_board_tab">
						회원 게시글 조회
					</div>
				</li>
				<li class="nav-item">
					<div class="nav-link" id="user_favorite_license_tab">
						회원 관심자격증 조회
					</div>
				</li>
			</ul>
		</div>
		<hr>
		
		<section id="content_area">
			<div id="content">
			
			</div>
		</section>
	</main>
	
	<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	
	<script>
		$(function() {
			function userInfoTab() {
				let target = $("#lListNavBox");
				target.next("#sub_tab").remove();
				
				$.ajax({
					url : "<c:url value='/mypage/view-user' />",
					type : "post",
					success : function(response) {
						target = $("#content_area");
						target.children("div").remove();
						
						let content = $("<div>").attr("id", "content");
						
						let table = $("<table>").attr("class", "user_info_tb");
						let tr = $("<tr>");
						
						let td = $("<td>");
						td.text("아이디");
						tr.append(td);
						
						td = $("<td>");
						td.text(response.id);
						tr.append(td);
						table.append(tr);
						
						tr = $("<tr>");
						td = $("<td>");
						td.text("닉네임");
						tr.append(td);
						
						td = $("<td>");
						td.text(response.nick);
						tr.append(td);
						table.append(tr);
						
						tr = $("<tr>");
						td = $("<td>");
						td.text("이메일");
						tr.append(td);
						
						td = $("<td>");
						td.text(response.email);
						tr.append(td);
						table.append(tr);

						tr = $("<tr>");
						td = $("<td>");
						td.text("프로필 이미지");
						tr.append(td);
						
						if (response.realFileName != null) {	
							td = $("<td>");
							
							let img = $("<img>");
							img.attr("width", "300px")
							.attr("alt", "프로필 이미지")
							.attr("src", "<c:url value='/uploads/profile/" + response.id + "/" + response.fileName + "' />");
							
							td.append(img);
							tr.append(td);
						} else {
							td = $("<td>");
							td.text("등록된 프로필 이미지가 없습니다.");
							tr.append(td);
						}
						table.append(tr);
						content.append(table);
						
						let button = $("<button>");
						button.attr("type", "button").attr("id", "user_mod_btn").attr("class", "btn btn-primary").text("회원정보 수정")
						.css("width", "150px")
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
							let div = $("<div>").attr("class", "license_board");
							
							let p = $("<p>").text("작성된 게시글이 없습니다.");
							div.append(p);
							
							content.append(div);
						} else {
							let table = $("<table>").attr("class", "free_board_tb");
							let tr = $("<tr>");
							let th = $("<th>");
							th.text("번호");
							tr.append(th);
							
							th = $("<th>").text("제목");
							tr.append(th);
							
							th = $("<th>").text("작성일");
							tr.append(th);
							
							th = $("<th>").text("조회수");
							tr.append(th);
							
							table.append(tr);
						
							for (let i = 0; i < response.boardList.length; ++i) {
								let board = response.boardList[i];		
								
								tr = $("<tr>");
								tr.attr("class", "free_board")
								.on("click", {boardNum : board.boardNum}, function(event) {
									location.href = "<c:url value='/freeboard/boards/" + event.data.boardNum + "' />";
								});
												
								let td = $("<td>").text(i + 1);
								tr.append(td);
								
								td = $("<td>").text(board.title);
								tr.append(td);
								
								td = $("<td>").text(board.wDate);
								tr.append(td);
								
								td = $("<td>").text(board.visit);
								tr.append(td);
								
								table.append(tr);	
							}	
							content.append(table);
						}
						target.append(content);
					}, error : function() {
						
					}
				});	
			}
			
			function licenseBoardQnATab() {
				let target = $("#content_area");
				target.children("div").remove();
				
				let content = $("<div>").attr("class", "content");
				
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
							let div = $("<div>").attr("class", "license_board");
							
							let p = $("<p>").text("작성된 게시글이 없습니다.");
							div.append(p);
							
							content.append(div);
						} else {
							let table = $("<table>").attr("class", "license_board_qna_tb");
							let tr = $("<tr>");
							let th = $("<th>");
							th.text("번호");
							tr.append(th);
							
							th = $("<th>").text("제목");
							tr.append(th);
							
							th = $("<th>").text("작성일");
							tr.append(th);
							
							th = $("<th>").text("조회수");
							tr.append(th);
							
							th = $("<th>").text("자격증");
							tr.append(th);
							
							table.append(tr);
							
							for (let i = 0; i < response.boardList.length; ++i) {
								let board = response.boardList[i];
								
								tr = $("<tr>");
								tr.attr("class", "license_board")
								.on("click", {jmcd : board.licenseListJmcd, boardNum : board.boardNum}, function(event) {
									location.href = "<c:url value='/licenses/lists/" + event.data.jmcd + "/QnA/" + event.data.boardNum + "' />";
								});
								
								let td = $("<td>").text(i + 1);
								tr.append(td);
								
								td = $("<td>").text(board.title);
								tr.append(td);
								
								td = $("<td>").text(board.wDate);
								tr.append(td);
												
								td = $("<td>").text(board.visitCount);
								tr.append(td);	
								
								td = $("<td>").text(board.licenseName);
								tr.append(td);	
								
								table.append(tr);
							}
							content.append(table);
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
							let table = $("<table>").attr("class", "license_board_data_tb");
							let tr = $("<tr>");
							let th = $("<th>");
							th.text("번호");
							tr.append(th);
							
							th = $("<th>").text("제목");
							tr.append(th);
							
							th = $("<th>").text("작성일");
							tr.append(th);
							
							th = $("<th>").text("조회수");
							tr.append(th);
							
							th = $("<th>").text("자격증");
							tr.append(th);
							
							table.append(tr);
							for (let i = 0; i < response.boardList.length; ++i) {
								let board = response.boardList[i];

								tr = $("<tr>");
								tr.attr("class", "license_board")
								.on("click", {jmcd : board.licenseListJmcd, boardNum : board.boardNum}, function(event) {
									location.href = "<c:url value='/licenses/lists/" + event.data.jmcd + "/QnA/" + event.data.boardNum + "' />";
								});
								
								let td = $("<td>").text(i + 1);
								tr.append(td);
								
								td = $("<td>").text(board.title);
								tr.append(td);
								
								td = $("<td>").text(board.wDate);
								tr.append(td);
												
								td = $("<td>").text(board.visitCount);
								tr.append(td);	
								
								td = $("<td>").text(board.licenseName);
								tr.append(td);	
								
								table.append(tr);						
							}
							content.append(table);
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
							let div = $("<div>").attr("class", "license_board");
							
							let p = $("<p>").text("작성된 게시글이 없습니다.");
							div.append(p);
							
							content.append(div);
						} else {
							let table = $("<table>").attr("class", "inquiry_board_tb");
							let tr = $("<tr>");
							let th = $("<th>");
							th.text("번호");
							tr.append(th);
							
							th = $("<th>").text("제목");
							tr.append(th);
							
							th = $("<th>").text("작성일");
							tr.append(th);
							
							table.append(tr);
							for (let i = 0; i < response.boardList.length; ++i) {
								let board = response.boardList[i];
								
								tr = $("<tr>");
								tr.attr("class", "inquiry_board")
								.on("click", {boardNum : board.boardNum}, function(event) {
									location.href = "<c:url value='/csc/view/I/" + event.data.boardNum + "' />";
								});
								
								let td = $("<td>").text(i + 1);
								tr.append(td);
								
								td = $("<td>").text(board.title);
								tr.append(td);
								
								td = $("<td>").text(board.wDate);
								tr.append(td);	
								
								table.append(tr);							
							}
							content.append(table);
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
				
				let content = $("<div>").attr("id", "content");
				
				$.ajax({
					url : "<c:url value='/mypage/board-report' />",
					type : "post",
					success : function(response) {
						for (let i = 0; i < response.length; ++i) {
							let reportList = response[i].boardList;
							
							if (i == 0) {
								if (reportList.length == 0) {
									let div = $("<div>").attr("class", "license_board").text("작성된 신고글이 없습니다.");
									let h3 = $("<h3>").text("자유 게시판 신고글").attr("class", "text-primary-emphasis");
									
									content.append(h3);
									content.append(div);
								} else {
									let h3 = $("<h3>").text("자유 게시판 신고글").attr("class", "text-primary-emphasis");									
									content.append(h3);
									
									let table = $("<table>").attr("class", "board_report");
									let tr = $("<tr>");
									let th = $("<th>");
									th.text("번호");
									tr.append(th);
									
									th = $("<th>").text("신고자");
									tr.append(th);
									
									th = $("<th>").text("신고 게시글 번호");
									tr.append(th);
									
									th = $("<th>").text("신고 내용");
									tr.append(th);
									
									table.append(tr);
									
									for (let j = 0; j < reportList.length; ++j) {
										let report = reportList[j];
										
										tr = $("<tr>");
										tr.attr("class", "inquiry_board");
										
										let td = $("<td>").text(j + 1);
										tr.append(td);
										
										td = $("<td>").text(report.usersId);
										tr.append(td);
										
										td = $("<td>").text(report.boardsBoardNum);
										tr.append(td);
										
										td = $("<td>").text(report.reportContent);
										tr.append(td);	
										
										table.append(tr);
									}	
									content.append(table);
								}
								target.append(content);
							} else if (i == 1) {
								if (reportList.length == 0) {
									let div = $("<div>").attr("class", "license_board").text("작성된 신고글이 없습니다.");
									
									let h3 = $("<h3>").text("자격증 게시판 신고글").attr("class", "text-primary-emphasis");									

									content.append(h3);
									content.append(div);
								} else {
									let h3 = $("<h3>").text("자격증 게시판 신고글").attr("class", "text-primary-emphasis");
									content.append(h3);
									
									let table = $("<table>").attr("class", "board_report");
									let tr = $("<tr>");
									let th = $("<th>");
									th.text("번호");
									tr.append(th);
									
									th = $("<th>").text("신고자");
									tr.append(th);
									
									th = $("<th>").text("신고 게시글 번호");
									tr.append(th);
									
									th = $("<th>").text("신고 내용");
									tr.append(th);
									
									table.append(tr);
									
									for (let j = 0; j < reportList.length; ++j) {
										let report = reportList[j];
										
										tr = $("<tr>");
										tr.attr("class", "inquiry_board");
										
										let td = $("<td>").text(j + 1);
										tr.append(td);
										
										td = $("<td>").text(report.usersId);
										tr.append(td);
										
										td = $("<td>").text(report.boardsBoardNum);
										tr.append(td);
										
										td = $("<td>").text(report.reportContent);
										tr.append(td);	
										
										table.append(tr);
									}
									content.append(table);
								}
								target.append(content);
							}
						}
						
					}, error : function() {
						
					}
				});
			}
			
			function userBoardTab() {
				let target = $("#content_area");
				target.children("div").remove();
				
				target = $("#lListNavBox");
				let subTab = $("<div>").attr("id", "sub_tab");
				let ul = $("<ul>").attr("class", "nav nav-underline");
				
				let li = $("<li>").attr("class", "nav-item");
				let tab = $("<div>").text("자유게시판").attr("class", "user_board_tab nav-link").attr("id", "free_board_tab")
				.on("click", function() {
					freeBoardTab();
				});
				li.append(tab);
				ul.append(li);
				
				li = $("<li>").attr("class", "nav-item");
				tab = $("<div>").text("자격증 QnA").attr("class", "user_board_tab nav-link").attr("id", "qna_board_tab")
				.on("click", function() {
					licenseBoardQnATab();
				});
				li.append(tab);
				ul.append(li);
				
				li = $("<li>").attr("class", "nav-item");
				tab = $("<div>").text("자격증 자료실").attr("class", "user_board_tab nav-link").attr("id", "data_board_tab")
				.on("click", function() {
					licenseBoardDataTab();
				});
				li.append(tab);
				ul.append(li);
				
				li = $("<li>").attr("class", "nav-item");
				tab = $("<div>").text("1:1문의").attr("class", "user_board_tab nav-link").attr("id", "inquiry_board_tab")
				.on("click", function() {
					inquiryBoardTab();
				});
				li.append(tab);
				ul.append(li);
				
				li = $("<li>").attr("class", "nav-item");
				tab  = $("<div>").text("신고글").attr("class", "user_board_tab nav-link").attr("id", "board_report_tab")
				.on("click", function() {
					boardReportTab();
				});
				li.append(tab);
				ul.append(li);
				
				subTab.append(ul);
				target.after(subTab);
			}
			
			function userFavoriteLicenseTab() {
				let target = $("#lListNavBox");
				target.next("#sub_tab").remove();
				
				target = $("#content_area");
				target.children("div").remove();
				
				let content = $("<div>").attr("id", "content");
				
				$.ajax({
					url : "<c:url value='/mypage/favorite-license' />",
					type : "post",
					success : function(response) {
						let h3 = $("<h3>").text("관심자격증").attr("class", "text-primary-emphasis");									
						content.append(h3);
						
						let table = $("<table>").attr("class", "board_report");
						let tr = $("<tr>");
						let th = $("<th>");
						th.text("번호");
						tr.append(th);
						
						th = $("<th>").text("종목번호");
						tr.append(th);
						
						th = $("<th>").text("자격증 명");
						tr.append(th);
						
						th = $("<th>").text("관심자격증 해제");
						tr.append(th);
						
						table.append(tr);
						
						for (let i = 0; i < response.length; ++i) {
							let fav = response[i];
							
							tr = $("<tr>");
							tr.attr("class", "favorite_license")
							.on("click", {jmcd : fav.licenseListJmcd}, function(event) {
								location.href = "<c:url value='/licenses/lists/" + event.data.jmcd + "' />";
							});
							
							let td = $("<td>").text(i + 1);
							tr.append(td);
														
							td = $("<td>").text(fav.licenseListJmcd);
							tr.append(td);
							
							td = $("<td>").text(fav.jmfldnm);
							tr.append(td);
							
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
							td = $("<td>");
							td.append(button);
							tr.append(td);	
							
							table.append(tr);
						}
						content.append(table);
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