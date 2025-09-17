<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${lListOne.jmfldnm } 상세정보</title>
		<script src="<c:url value='/resources/js/jquery-3.7.1.min.js'/>"></script>
		<script>
			function addLicenseFn(){
				let id = "${sessionScope.user.id}";
				let jmcd = "${jmcd}";
				$.ajax({
					
					url : "",
					type : "post",
					data : {
						"usersId" : id,
						"licenseListJmcd" : jmcd 
					},
					success : function(){
						
					},
					error : function(){
						
					}
					
				});
			}
		</script>
	</head>
	<body>
		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		<main>
			<div id="licenseSubtitleBox">
				<h2>${lListOne.jmfldnm } 상세정보</h2>
				<ul id="licenseNavBox">
					<li>
						<a href="<c:url value='/licenses/lists' />">자격증 목록으로</a>
					</li>
					<li>
						<a href="<c:url value='/licenses/lists/${lListOne.jmcd }/QnA' />">${lListOne.jmfldnm } QnA 게시판</a>
					</li>
					<li>
						<a href="<c:url value='/licenses/lists/${lListOne.jmcd }/dataroom' />">${lListOne.jmfldnm } 자료실</a>
					</li>
				</ul>
			</div>
			<div id="licenseInfosBox">
				<button type="button" onclick="addLicenseFn()">관심자격증 추가</button>
				<div id="licenseGeneralInfo">
					<h3>${lListOne.jmfldnm} 기본정보</h3>
					자격증 명 : ${lListOne.jmfldnm }<br>
					자격구분 : ${lListOne.qualgbnm }<br>
					계열 : ${lListOne.seriesnm }<br>
					대직무분야 : ${lListOne.obligfldnm }<br>
					중직무분야 : ${lListOne.mdobligfldnm }<br>
					시행 기관 : ${lListOne.licensingAutority }<br>
				</div>
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
								필기 시험일 : ${ltdi.docExamStartDt } ~ ${ltdi.docExamEndDt }<br>
								필기 합격자 발표일 : ${ltdi.docPassDt }<br>
								실기 원서접수일 : ${ltdi.pracRegStartDt } ~ ${ltdi.pracRegEndDt }<br>
								실기 시험일 : ${ltdi.pracExamStartDt } ~ ${ltdi.pracExamEndDt }<br>
								합격자 발표일 : ${ltdi.pracPassDt }<br>
								</p>
							</c:otherwise>
						</c:choose>
					
					</c:forEach>
				</div>
			</div>
		</main>
		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</body>
</html>