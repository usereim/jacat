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
				height:750px;
			}
			#licenseNavBox{
				display:flex;
				align-items:center;
			}
			#licenseNavBox li{
				width:20%;
				list-style:none;
				text-align:center;
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
						
						let delBtn = "<button type='button' onclick='delLicenseFn()'>관심자격증 제거</button>";
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
						
						let addBtn = "<button type='button' onclick='addLicenseFn()'>관심자격증 추가</button>";
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
							<button type="button" onclick="addLicenseFn()">관심자격증 추가</button>
						</c:when>
						<c:otherwise>
							<button type="button" onclick="delLicenseFn()">관심자격증 제거</button>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="licenseGeneralInfo">
					<h3>${lListOne.jmfldnm} 기본정보</h3>
					자격증 명 : ${lListOne.jmfldnm }<br>
					자격구분 : ${lListOne.qualgbnm }<br>
					계열 : ${lListOne.seriesnm }<br>
					대직무분야 : ${lListOne.obligfldnm }<br>
					중직무분야 : ${lListOne.mdobligfldnm }<br>
					시행 기관 : ${lListOne.licensingAutority }<br>
				</div>
				<!-- 
				<div id="licenseTestInfo">
					<h3>${lListOne.jmfldnm } 출제 과목</h3>
					<c:forEach var="lt" items="${lListOne.lTest }">
						<c:choose>
							<c:when test="${lTest.isEmpty() }">
								바부
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
						<c:choose>
							<c:when test = "${lTestDate.isEmpty() }">
								바보
							</c:when>
							<c:otherwise>
								<p>
								시행 년도 : ${ltdi.implYy }<br>
								회차 : ${ltdi.implSeq }<br>
								설명 : ${ltdi.description }<br>
								필기 원서접수일 : ${ltdi.docRegStartDt } ~ ${ltdi.docRegEndDt }<br>
								<c:if test="${ltdi.docRegStartDt != ltdi.docRegStartVacancyDt && ltdi.docRegEndDt != ltdi.docRegEndVacancyDt}">
									필기 빈자리접수일 : ${ltdi.docRegStartVacancyDt} ~ ${ltdi.docRegEndVacancyDt}<br>
								</c:if>
								필기 시험일 : ${ltdi.docExamStartDt } ~ ${ltdi.docExamEndDt }<br>
								필기 합격자 발표일 : ${ltdi.docPassDt }<br>
								실기 원서접수일 : ${ltdi.pracRegStartDt } ~ ${ltdi.pracRegEndDt }<br>
								<c:if test="${ltdi.pracRegStartDt != ltdi.pracRegStartVacancyDt && ltdi.pracRegEndDt != ltdi.pracRegVacancyEndDt }">
									실기 빈자리접수일 : ${ltdi.pracRegStartVacancyDt } ~ ${ltdi.pracRegVacancyEndDt }<br>
								</c:if>
								실기 시험일 : ${ltdi.pracExamStartDt } ~ ${ltdi.pracExamEndDt }<br>
								합격자 발표일 : ${ltdi.pracPassDt }<br>
								</p>
							</c:otherwise>
						</c:choose>
					
					</c:forEach>
				</div>
			</section>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>