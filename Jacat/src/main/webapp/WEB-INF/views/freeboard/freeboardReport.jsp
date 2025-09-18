<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  	<!-- 신고기능 -->
    	<form action="<c:url value='/freeboard/report' />" id="reportForm" method="post">
    	<input type="hidden" id="boardNum" name="boardNum"/>

    	<p>신고 사유 선택:</p>
    	<label><input type="radio" name="reportCategory" value="욕설/비방" required> 욕설/비방</label><br>
    	<label><input type="radio" name="reportCategory" value="스팸/광고"> 스팸/광고</label><br>
    	<label><input type="radio" name="reportCategory" value="음란물"> 음란물</label><br>
    	<label><input type="radio" name="reportCategory" value="기타"> 기타</label><br><br>

    	<textarea name="reportContent" placeholder="추가 내용 (선택)" rows="4" cols="40"></textarea><br><br>
    	
    	<input type="submit" value="신고 완료"/>
    	</form>
    	
</body>
</html>