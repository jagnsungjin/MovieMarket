<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>영화 정보</title>

<script src="http://code.jquery.com/jquery-latest.js"></script>


<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function() {
		var x = "";
<%-- 좌석클릭시 색상바꾸기 --%>
	$("input").click(function() {
			$('input').removeClass("buttonactive");
			$(this).addClass("buttonactive");
			$('.aa').removeClass("aa");
			$(this).addClass("aa");

		})
<%-- 좌석 선택 클릭 (선택한 좌석 값 저장) --%>
	$("#seatcheck").click(function() {
		if($('.buttonactive').eq('0').val().length < 4){
			
		
			x += $('.buttonactive').eq('0').val() + " ";
			$('#span1').html(x);
			$("input").removeClass("buttonactive");
			$(".aa").addClass("buttonactive2");
			$('')
		}

		})
		<%-- 결제 버튼 클릭--%>
		$("#PayButton").click(function() {
			if(x== ""){
				alert("좌석을 선택하세요")
			}else{
			$('input[name=seatResult]').attr('value',x);
			location.href = "MoviePay.jsp?seat=" + "" +  x + "";
			}
		})
		
		<%-- 다시선택 클릭 --%>
		$("#CancelButton").click(function(){
			x= "";
			$("input").removeClass("buttonactive2");
			$('input[name=seatResult]').attr('value',"");
			$('#span1').html("");
			
		})
		
		
	})
</script>
<style>
.navbar .navbar-nav {
	display: inline-block;
	float: none;
}

.navbar .navbar-collapse {
	text-align: center;
}

.navc {
	width: 50px;
}

.row {
	display: flex;
	justify-content: center;
}
/* 여기는 body */
* {
	font-size: 11px;
}

.div_title {
	font-size: 25px;
	background-color: #535353;
	color: white;
	text-align: center;
	border-bottom: 1px solid black;
}

.movie_form {
	margin: 0px auto;
	position: relative;
	display: block;
	justify-content: center;
	height: 600px;
	width: 943px;
}

.info_movie {
	position: absolute;
	width: 220px;
	height: 400px;
	left: 10px;
	top: 10px;
	border: 1px solid black;
}

.seat_movie {
	position: absolute;
	width: 700px;
	height: 450px;
	left: 240px;
	top: 10px;
	border: 1px solid black;
}

li {
	list-style: none;
}

.seat-picker-label {
	background-color: #32a690;
	color: #ffffff;
	display: flex;
	justify-content: center;
	padding: 7px;
}

.buttonactive {
	background-color: blue;
}

.buttonactive2 {
	background-color: red;
}

.seat.selected {
	background: blue;
}

.seat.occupied {
	background: red;
}

.showcase {
	background: white;
	border-radius: 5px;
	padding: 5px 10px;
	list-style-type: none;
	display: flex;
}

.showcase li {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 10px;
}

.showcase li small {
	margin-left: 2px;
}

.seat {
	background: gray;
	height: 14px;
	width: 18px;
	margin: 4px;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	border-bottom-left-radius: 3px;
	border-bottom-right-radius: 3px;
}
</style>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
name은 ${name}
name은 <%=request.getParameter("name") %>
place은 ${place}
name은 <%=request.getParameter("place") %>
	<footer
		style="text-align: center; background: lightgray; height: 50px; padding-top: 15px; margin-top: 30px;"
		class="footer">
		<div class="container">
			<p class="text-muted">Place sticky footer content here.</p>
		</div>
	</footer>

</body>
</html>