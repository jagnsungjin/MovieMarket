<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

<title>MVD 게시판</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="js/rv_js/modifyform.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>
<script>
	$(document).ready(function() {

		$(function() {

			var rating = $('.review .rating');

			rating.each(function() {
				var targetScore = $(this).attr('data-rate');
				console.log(targetScore)
				$(this).find('svg:nth-child(-n+' + targetScore + ')').css({
					color : 'red'
				});
			})
				$('.make_star svg:nth-child(-n+' + ${boarddata.RV_GRADE} + ')').css({
					color : 'red'
				});
			$('input[id=RV_GRADE]').attr('value', ${boarddata.RV_GRADE});

			var userScore = $('#RV_GRADEform');
			userScore.click(function() {
				userScoreNum = $(this).val();
				console.log(userScoreNum);

				var targetNum = 5
				$('.make_star svg').click(function() {
					targetNum = $(this).index() + 1;
					$('.make_star svg').css({
						color : '#000'
					});
					$('.make_star svg:nth-child(-n+' + targetNum + ')').css({
						color : 'red'
					});
					$('input[id=RV_GRADE]').attr('value', targetNum);
					$("#gradeCount").text(targetNum);
				})

			})

		})

	})
</script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
@import
	url('https://fonts.googleapis.com/css?family=Poppins:400,600&display=swap')
	;

html {
	background: #E0F2F1;
}

body, form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

body {
	padding: 32px 0px;
	padding-bottom: 128px;
}

body, h1, h2, h3, h4, p {
	margin: 0px;
}

form {
	padding-bottom: 16px;
	font-family: 'Poppins', sans-serif;
	background: white;
	border-radius: 8px;
	width: 100%;
	max-width: 600px;
	color: rgba(0, 0, 0, 0.9);
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02), 0 1px 2px rgba(0, 0, 0, 0.14);
}

.form__header {
	padding: 32px 0;
	width: 100%;
	text-align: center;
	border-bottom: 1px solid #eee;
}

.form__header h1 {
	font-size: 1.5rem;
	margin-bottom: 8px
}

.form__header p {
	font-size: 0.9rem;
	color: rgba(0, 0, 0, 0.5);
}

form h2 {
	margin-top: 24px;
	margin-bottom: 16px;
	width: 100%;
	font-size: 1.25rem;
	text-align: center;
}

form h3 {
	box-sizing: border-box;
	border-left: 3px solid transparent;
	margin-top: 24px;
	padding: 0px 32px;
	width: 100%;
	font-size: 1.10rem;
	text-align: left;
}

.form-group {
	box-sizing: border-box;
	width: 100%;
	padding: 24px 32px;
	border-left: 3px solid transparent;
	transition: 0.2s all;
}

.form-group:hover {
	border-left: 3px solid #64FFDA;
}

.form-date-group {
	display: flex;
	box-sizing: border-box;
	width: 100%;
	padding: 24px 32px;
	border-left: 3px solid transparent;
	transition: 0.2s all;
}

.form-date-group:hover {
	border-left: 3px solid #64FFDA;
}

.form-date-group .form-group {
	padding: 0px;
}

.form-date-group .form-group:hover {
	border-left: 3px solid transparent;
}

.form-group label {
	font-weight: bold;
	margin-bottom: 4px;
	font-size: 1rem;
	color: rgba(0, 0, 0, 0.7);
	display: block;
}

.form-group label span {
	color: red;
}

form .line-break {
	width: 100%;
	height: 1px;
	margin: 16px auto;
	border-bottom: 1px solid #eee;
}

input[type=text]::placeholder, input[type=password]::placeholder, input[type=date]::placeholder,
	textarea::placeholder {
	font-weight: 400;
	color: rgba(0, 0, 0, 0.4);
}

input[type=text], input[type=password], input[type=date], textarea {
	font-size: 1.05rem;
	font-weight: 600;
	font-family: inherit;
	box-sizing: border-box;
	padding: 8px 16px;
	border: 1px solid rgba(0, 0, 0, 0.1);
	border-radius: 4px;
	transition: 0.2s border;
	width: 100%;
	font-size: 1rem;
}

textarea {
	max-width: 533px;
	height: 150px;
}

input[type=text]:focus, input[type=password]:focus, input[type=date]:focus,
	textarea:focus {
	outline: none;
	border-color: #1DE9B6;
}

input[type=button] {
	background: gray;
	padding: 8px 16px;
	color: white;
	font-weight: bold;
	font-family: inherit;
	letter-spacing: 0.3px;
	border-radius: 4px;
	border: none;
	cursor: pointer;
	outline: none;
	transition: 0.2s all;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.00), 0 1px 2px rgba(0, 0, 0, 0.00);
}

input[type=submit] {
	background: #1DE9B6;
	padding: 8px 16px;
	color: white;
	font-weight: bold;
	font-family: inherit;
	letter-spacing: 0.3px;
	border-radius: 4px;
	border: none;
	cursor: pointer;
	outline: none;
	transition: 0.2s all;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.00), 0 1px 2px rgba(0, 0, 0, 0.00);
}

input[type=submit]:hover {
	margin-top: -1px;
	margin-bottom: 1px;
	background: gray;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02), 0 1px 2px rgba(0, 0, 0, 0.14);
}

input[type=button]:hover {
	margin-top: -1px;
	margin-bottom: 1px;
	background: black;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02), 0 1px 2px rgba(0, 0, 0, 0.14);
}

input[type=submit]:active {
	background: #00bfa5;
	margin-top: 0px;
	margin-bottom: 0px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.00), 0 1px 2px rgba(0, 0, 0, 0.00);
}

select {
	width: 250px;
	height: 40px
}

#upfile {
	display: none
}

img {
	width: 20px;
}

#RV_CSFC {
	height: 45px;
}
</style>
<!-- 글 수정 VIEW -->
</head>
<body>
	<%-- 게시판 수정 --%>

	<form action="RvModifyAction.rv" method="post" name="modifyform"
		enctype="multipart/form-data">
		<input type="hidden" name="RV_NO" value="${boarddata.RV_NO}">
		<div class="form__header">
			<h1>게시글 수정</h1>
			<p>영화후기 게시판</p>
		</div>
		<h2>Edit Post</h2>
		<div class="form-group">
			<label for="RV_CSFC">영화제목</label> <input type="text"
				class="form-control" value="${boarddata.RV_CSFC}" readOnly>
		</div>
		<div class="form-group">
			<div class="make_star">
				<label>평점</label><br>

				<div class="rating" data-rate="3" id="RV_GRADEform">

					<i class="fas fa-star"></i> <i class="fas fa-star"></i> <i
						class="fas fa-star"></i> <i class="fas fa-star"></i> <i
						class="fas fa-star"></i> <i class="fas fa-star"></i> <i
						class="fas fa-star"></i> <i class="fas fa-star"></i> <i
						class="fas fa-star"></i> <i class="fas fa-star"></i> <span
						id="gradeCount"></span>
				</div>
				<input type="hidden" name="RV_GRADE" id="RV_GRADE">

			</div>
		</div>
		<div class="form-group">
			<label for="USER_ID">글쓴이</label> <input type="text"
				class="form-control" value="${boarddata.USER_ID}" readOnly>
		</div>


		<div class="form-group">
			<label for="RV_SUBJECT">제목</label>
			<textarea name="RV_SUBJECT" id="RV_SUBJECT" rows="1"
				class="form-control" maxlength="100">${boarddata.RV_SUBJECT}</textarea>
		</div>

		<div class="form-group">
			<label for="RV_CONTENT">내용</label>
			<textarea name="RV_CONTENT" id="RV_CONTENT" class="form-control"
				rows="15">${boarddata.RV_CONTENT}</textarea>
		</div>
		<%--원문글인 경우에만 파일 첨부 수정 가능합니다. --%>
		<c:if test="${boarddata.RV_RE_LEV==0}">
			<div class="form-group read">
				<label for="RV_FILE">파일첨부</label> <label for="upfile"> <img
					src="image/attach.png" alt="파일첨부" width="20px">
				</label> <input type="file" id="upfile" name="RV_FILE"> <span
					id="filevalue">${boarddata.RV_FILE}</span> <img
					src="image/remove.png" alt="파일삭제" width="10px" class="remove">
			</div>
		</c:if>

		<div class="form-group">
			<label for="RV_PASS">비밀번호<span>*</span></label> <input name="RV_PASS"
				id="RV_PASS" type="password" size="10" maxlength="30"
				class="form-control" placeholder="Enter board_pass" value="">
		</div>

		<input type="submit" value="확인" id="create-resume">




	</form>
	<br>
	<input type="button" value="뒤로가기" id="create-resume"
		onClick="history.go(-1)">



</body>
</html>