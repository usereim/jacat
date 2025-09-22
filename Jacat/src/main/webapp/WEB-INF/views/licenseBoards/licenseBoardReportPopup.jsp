<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시글 신고하기</title>
	</head>
	<body>
		<section>
			<form action = "/licenses/lists/${jmcd}/QnA/${boardNum}/report" method="post">
				<p>신고 사유 선택</p>
				<label for="Profanity">욕설/비방</label>
				<input type="radio" name="reportCategory" value="욕설/비방" id="Profanity" required>
				<br>
				<label for="advertisement">스팸/광고</label>
				<input type="radio" name="reportCategory" value="스팸/광고" id="advertisement">
				<br>
				<label for="pornography">음란물</label>
				<input type="radio" name="reportCategory" value="음란물" id="pornography">
				<br>
				<label for="etc">기타</label>
				<input type="radio" name="reportCategory" value="기타" id="etc">
				<br>
				<input type="text" name="etcOrExplanation" placeholder="기타 사유나 추가적인 설명을 적어주세요.(선택)">
				<br>
				<button type="submit">신고</button>
			</form>
		</section>
	</body>
</html>