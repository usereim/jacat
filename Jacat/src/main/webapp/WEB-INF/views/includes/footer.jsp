<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>jacatFooter</title>
		<style>
		#footerSection{
		overflow-wrap: break-word;
		background-color : rgb(84 165 255);
		}
		
		#footerCompanyInfoBox{
		height :50px;
		}
		
		#footerTeamInfo{
			text-align : center;
		}
		
		footer{
		height :80px;
	    width: 100%;
	    position: flexbox;
	    bottom: 0;
	    left: 0;
	    text-align: center;
	    line-height: 80px;
	    
		}
		
		p{
		margin-top: -20px;
	    margin-bottom: -20px;
		}
		</style>
	</head>
	<body>
		<footer>
			<div id="footerSection" class="bg-primary" data-bs-theme="dark">
					<p>&copy; 이젠 IT 아카데미 / A팀(자캣) 전북 전주시 덕진구 백제대로 572 5층</p>
					<p>김철호,김정준,정태양,조윤성</p>
			</div>
		</footer>
	</body>
</html>