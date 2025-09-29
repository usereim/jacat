<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시글 신고하기</title>
		<link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.8/dist/cosmo/bootstrap.min.css" rel="stylesheet">
		<style>
			h2{
				margin:20px 0 40px;
			}
			section{
				padding:10px 20px;
				text-align:center;
			}
			form>div{
				display:flex;
				flex-direction:row;
				justify-content:space-around;
			}
			textarea[name=etcOrExplanation]{
				width:100%;
				resize:none;
			}
			#reportSubmitBtn{
				width:40%;
				height:40px;
			}
		</style>
	</head>
	<body>
		<section>
			<form action = "<c:url value='/licenses/lists/${jmcd}/${boardType }/${boardNum}/report'/>" method="post">
				<h2>신고 사유 선택</h2>
				<div>
					<p>
						<label for="Profanity">욕설/비방</label>
						<input type="radio" name="reportCategory" value="욕설/비방" id="Profanity" required>
					</p>
					<p>
						<label for="advertisement">스팸/광고</label>
						<input type="radio" name="reportCategory" value="스팸/광고" id="advertisement">
					</p>
					<p>
						<label for="pornography">음란물</label>
						<input type="radio" name="reportCategory" value="음란물" id="pornography">
					</p>
					<p>
						<label for="etc">기타</label>
						<input type="radio" name="reportCategory" value="기타" id="etc">
					</p>
				</div>
				<textarea name="etcOrExplanation" placeholder="기타 사유나 추가적인 설명을 적어주세요.(선택)" rows="3"></textarea>
				<br>
				<button type="submit" id="reportSubmitBtn" class="btn btn-primary">신고</button>
			</form>
		</section>
	</body>
</html>