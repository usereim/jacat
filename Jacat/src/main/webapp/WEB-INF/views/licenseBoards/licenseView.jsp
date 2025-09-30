<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${lListOne.jmfldnm } 상세정보</title>
		<style>
			main{
				/* height:750px; */
				/* margin:0 auto; */
			}
			#licenseInfosBox{
				width:80%;
				margin:0 auto;
				
			}
			
			#licenseNavBox{
				display:flex;
				align-items:center;
				justify-content:space-around;
			}
			#licenseNavBox li{
				width:20%;
				list-style:none;
				text-align:center;
			}
			#licenseGeneralInfo{
				margin-top:30px;
			}
			#licenseTestDateInfo{
				margin-top:30px;
			}
		    table {
		        width: 100%;
		        border-collapse: collapse;
		        font-size: 15px;
		        table-layout: fixed;
		        margin-top:20px;
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
		    td:nth-child(1) { width: 30%; text-align: right; }
		    td:nth-child(2) { width: 10%; text-align: center; }
		    td:nth-child(3) { width: 60%; text-align: left; }
		    
		    table tr {
		        border-bottom: 1px solid #ccc;
		    }
		    table tr:nth-child(even) {
		        background-color: #f7f7f7;
		    }
		    .implSeqLine{
		    	margin-bottom:20px;
		    }
		    .implSeqLine:last-child{
		    	display:none;
		    }
		</style>
		<script src="<c:url value='/resources/js/jquery-3.7.1.min.js'/>"></script>
		<script>
			const id = "${sessionScope.user.id}";
			const jmcd = "${jmcd}";
			
			function addLicenseFn(){
				
				$.ajax({
					
					url : "<c:url value='/licenses/lists/add-license'/>",
					type : "post",
					data : {
						"usersId" : id,
						"licenseListJmcd" : jmcd 
					},
					success : function(result){
						alert("관심자격증 등록이 완료되었습니다.");
						
						let delBtn = "<button type='button' onclick='delLicenseFn()' class='btn btn-primary'>관심자격증 제거</button>";
						let favoBtnBox = $("#licenseFavoBtnBox");
						
						favoBtnBox.html("");
						favoBtnBox.html(delBtn);
						
					},
					error : function(result){
						alert("관심자격증 등록에 실패하였습니다.");
					}
					
				});
			}
			
			function delLicenseFn(){
				$.ajax({
					
					url : "<c:url value='/licenses/lists/del-license'/>",
					type : "post",
					data : {
						"usersId" : id,
						"licenseListJmcd" : jmcd 
					},
					success : function(result){
						alert("관심자격증 해제가 완료되었습니다.");
						
						let addBtn = "<button type='button' onclick='addLicenseFn()' class='btn btn-primary'>관심자격증 추가</button>";
						let favoBtnBox = $("#licenseFavoBtnBox");
						
						favoBtnBox.html("");
						favoBtnBox.html(addBtn);
						
					},
					error : function(result){
						alert("관심자격증 해제에 실패하였습니다.");
					}
				});
			}
		</script>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<section id="licenseSubtitleBox">
				<h2>${lListOne.jmfldnm } 상세정보</h2>
				<hr>
				<ul id="licenseNavBox" class="nav nav-underline">
					<li class="nav-item">
						<a href="<c:url value='/licenses/lists' />" class="nav-link">자격증 목록으로</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value='/licenses/lists/${lListOne.jmcd }' />" class="nav-link">${lListOne.jmfldnm } 상세정보</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value='/licenses/lists/${lListOne.jmcd }/QnA' />" class="nav-link">${lListOne.jmfldnm } QnA 게시판</a>
					</li>
					<li class="nav-item">
						<a href="<c:url value='/licenses/lists/${lListOne.jmcd }/dataroom' />" class="nav-link">${lListOne.jmfldnm } 자료실</a>
					</li>
				</ul>
				<hr>
			</section>
			<section id="licenseInfosBox">
				<div id="licenseFavoBtnBox">
					<c:choose>
						<c:when test="${empty sessionScope }">
						
						</c:when>
						<c:when test="${favoLi == 'N' }">
							<button type="button" onclick="addLicenseFn()" class="btn btn-primary">관심자격증 추가</button>
						</c:when>
						<c:otherwise>
							<button type="button" onclick="delLicenseFn()" class="btn btn-primary">관심자격증 제거</button>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="licenseGeneralInfo">
				<h3>${lListOne.jmfldnm} 기본정보</h3>
					<table>
						<tr>
							<td>자격증 명</td>
							<td> : </td>
							<td>${lListOne.jmfldnm }</td>
						</tr>
						<tr>
							<td>자격구분</td>
							<td> : </td>
							<td>${lListOne.qualgbnm }</td>
						</tr>
						<tr>
							<td>계열</td>
							<td> : </td>
							<td>${lListOne.seriesnm }</td>
						</tr>
						<tr>
							<td>대직무분야</td>
							<td> : </td>
							<td>${lListOne.obligfldnm }</td>
						</tr>
						<tr>
							<td>중직무분야</td>
							<td> : </td>
							<td>${lListOne.mdobligfldnm }</td>
						</tr>
						<tr>
							<td>시행 기관</td>
							<td> : </td>
							<td>${lListOne.licensingAutority }</td>
						</tr>
					</table>
				</div>
				
				<!-- 
				<div id="licenseTestInfo">
					<h3>${lListOne.jmfldnm } 출제 과목</h3>
					<c:forEach var="lt" items="${lListOne.lTest }">
						<c:choose>
							<c:when test="${lTest.isEmpty() }">
								
							</c:when>
							<c:otherwise>
								과목명 : ${lListOne.lTest }<br>
								문제형식 : ${lListOne.lTest }<br>
								문항 수 : ${lListOne.lTest }<br>
								필기/실기 여부 : ${lListOne.lTest }<br>
								시험 시간 : ${lListOne.lTest }<br>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				
				 -->
				<div id="licenseTestDateInfo">
					<h3>${lListOne.jmfldnm } 시험 일정</h3>
					<c:forEach var="ltdi" items="${lListOne.lTestDate }">
						<table>
							<c:choose>
								<c:when test = "${lTestDate.isEmpty() }">
									
								</c:when>
								<c:otherwise>
									<tr>
										<td>시행 년도</td>
										<td> : </td>
										<td>${ltdi.implYy }</td>
									</tr>
									<tr>
										<td>회차</td>
										<td> : </td>
										<td>${ltdi.implSeq }</td>
									</tr>
									<tr>
										<td>설명</td>
										<td> : </td>
										<td>${ltdi.description }</td>
									</tr>
									<tr>
										<td>필기 원서접수일</td>
										<td> : </td>
										<td>${ltdi.docRegStartDt } ~ ${ltdi.docRegEndDt }</td>
									</tr>
									<c:if test="${ltdi.docRegStartVacancyDt != null && ltdi.docRegEndVacancyDt != null && ltdi.docRegStartDt != ltdi.docRegStartVacancyDt && ltdi.docRegEndDt != ltdi.docRegEndVacancyDt}">
										<tr>
											<td>필기 빈자리접수일</td>
											<td> : </td>
											<td>${ltdi.docRegStartVacancyDt} ~ ${ltdi.docRegEndVacancyDt}</td>
										</tr>
									</c:if>
									<tr>
										<td>필기 시험일</td>
										<td> : </td>
										<td>${ltdi.docExamStartDt } ~ ${ltdi.docExamEndDt }</td>
									</tr>
									<tr>
										<td>필기 합격자 발표일</td>
										<td> : </td>
										<td>${ltdi.docPassDt }</td>
									</tr>
									<c:if test="${not empty ltdi.pracRegStartDt }">
										<tr>
											<td>실기 원서접수일</td>
											<td> : </td>
											<td>${ltdi.pracRegStartDt } ~ ${ltdi.pracRegEndDt }</td>
										</tr>
										<c:if test="${ltdi.pracRegStartDt != ltdi.pracRegStartVacancyDt && ltdi.pracRegEndDt != ltdi.pracRegVacancyEndDt }">
											<tr>
												<td>실기 빈자리접수일</td>
												<td> : </td>
												<td>${ltdi.pracRegStartVacancyDt } ~ ${ltdi.pracRegVacancyEndDt }</td>
											</tr>
										</c:if>
									</c:if>
									<c:if test="${not empty ltdi.pracExamStartDt }">
										<tr>
											<td>실기 시험일</td>
											<td> : </td>
											<td>${ltdi.pracExamStartDt } ~ ${ltdi.pracExamEndDt }</td>
										</tr>
									</c:if>
									<c:if test="${not empty ltdi.pracPassDt }">
										<tr>
											<td>합격자 발표일</td>
											<td> : </td>
											<td>${ltdi.pracPassDt }</td>
										</tr>
									</c:if>
								</c:otherwise>
							</c:choose>
						</table>
						<hr class="implSeqLine">
					</c:forEach>
				</div>
			</section>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>