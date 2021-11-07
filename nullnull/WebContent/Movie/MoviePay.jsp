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
	<%-- 게시판으로 클릭시 --%>
	$('#goto_bkwrite').click(function(){
		$('#movieinfoform').attr("action","Bbs_bkWrite.bk");
	/* $('#img').attr("value", $("#view").attr("src"));
	$('#name').attr("value", $("#moviename").text());
	$('#place').attr("value", $("#movieplace").text());
	$('#date').attr("value", $("#moviedate").text());
	$('#time').attr("value", $("#movietime").text());
	$('#count').attr("value", $("#moviepeoples").text());
	$('#seat').attr("value", $("#movieseat").text()); */
	var formbtn = document.movieinfo
	formbtn.submit();	
	})
	
$('#PayButton').click(function(){
		$('#movieinfoform').attr("action","paymentlist.mo");
		var formbtn = document.movieinfo
		formbtn.submit();
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
	width: 600px;
}

.info_movie {
	position: absolute;
	width: 220px;
	height: 450px;
	left: 10px;
	top: 10px;
	border: 1px solid black;
}

.seat_movie {
	position: absolute;
	width: 400px;
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
.buttonbtn{
	 margin-top: 150px;
	 margin-left: 50px;"
}
.btncustom{
	width: 300px;
	height: 50px;
}

/*추가된 네비 css*/
ul.main-nav li {
    display: inline-block;
}
ul.main-nav li a {
    font-family: 'Roboto', sans-serif;
    padding: 15px 35px;
    text-decoration: none;
    font-size: 16px;
    color:#918b76;
    display: block;
}
ul.main-nav li a:hover,ul.main-nav li a:focus, ul.main-nav li.active a {
    color:#607d8b;
    background: #e7e7e7;
}



li.drop-down {
    position: relative;
}
ul.sub-menu{
    position: absolute;
    top: 15px;
    left: 0;
    padding: 0;
    margin: 0;
    background: #9e9e9e08;
    text-align: left;
    min-width: 184px;
    opacity: 0;
    transition: all 500ms;
}

ul.sub-menu li a {
    line-height: 10px;
}

li.drop-down:hover ul.sub-menu{
    top:50px;
    opacity: 1;
    
}


</style>
</head>
<body>
	  	  	<!-- Static navbar -->
    <nav class="navbar navbar-default navbar-static-top">
            <!--     <a href="#">
              <button class="btn btn-danger" data-toggle="modal"
                      data-target="#myModal">삭제</button>
            </a> -->
      <c:if test="${empty id}">
    	<div align="right"><a class="login" data-toggle="modal" href="#login">로그인</a>&nbsp;&nbsp;&nbsp;<a class="join1" href="#">회원가입</a></div>
      </c:if>
      <c:if test="${!empty id&&id!='admin'}">
		<div align="right"><a class="logout" href="logout.oky">${id} 님(로그아웃)</a>&nbsp;&nbsp;&nbsp;<a class="nav-link" href="memberUpdate.oky">정보수정</a></div>			
      </c:if>
      <c:if test="${!empty id&&id=='admin'}">
		<div align="right"><a class="logout" href="logout.oky">${id} 님(로그아웃)</a>&nbsp;&nbsp;&nbsp;
		<a class="nav-link" href="memberUpdate.oky">정보수정</a>&nbsp;&nbsp;&nbsp;
		<a class="nav-link" href="memberList.oky">회원정보</a> </div>		
		</c:if>
   
    	    	<div align="center">
    	    	<a href="http://localhost:8088/nullnull/"><img style="text-align: center; width: 200px" src="image/logo.png" ></a></div>
      <div class="container">
        <div id="navbar" class="navbar-collapse collapse ">
           <div class="content-wrap">
                <nav>
                    <ul class="main-nav">
                        <li><a href="bestmovie.mo">영화</a></li>
                        <li><a href="movieticketing.mo">영화예매</a></li>
                        <li class="drop-down" >
                            <a href="#">커뮤니티<span class="down-arrow">&#709;</span></a>
                            <ul class="sub-menu">
                                <li><a href="Freeboard.okybo">자유게시판</a></li>
                                <li><a href="Bbs_bkList.bk">예매대행</a></li>
                                <li><a href="RvList.rv">영화후기</a></li>
                            </ul>
                        </li>
                        <li class="drop-down" >
                            <a href="#">고객센터<span class="down-arrow">&#709;</span></a>
                            <ul class="sub-menu">
                                <li><a href="NTList.bo">공지사항</a></li>
                                <li><a href="NTFAQ.bo" >자주 묻는 질문</a></li>
                                <li><a href="ContactUs.okycon" id="contact">1:1문의</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>         
        </div><!--/.nav-collapse -->
      </div>
    </nav>


	<!-- 영화 정보 -->
	<div class="container">
		<div class="movie_form" style="height: 50px; border: none">
			<p style="font-size: 30pt;">결제하기</p>
		</div>
		<div style="margin: 0 auto;"><!-- 전체폼 -->
		
		<div class="movie_form">
			<div class="info_movie">
				<div class="div_title">영화정보</div>
				<p style="text-align: center">
					<img style="text-align: center; width: 150px; height: 200px; margin-top: 20px;"
						src="${img}">

				</p>
				<div class="movieinfo">
					<ul>
						<li><span style="font-size: 15px">영화 이름 : </span> <span id="moviename">${name}</span></li>
						<li><span>영화 장소 : </span><span id="movieplace">${place}</span></li>
						<li><span>영화 날짜 : </span> <span id="moviedate">${date}</span></li>
						<li><span>시간 : </span> <span id="movietime">${time}</span></li>
						<li><span>인원 : </span> <span id="moviepeoples">${count}</span></li>
						<li><span>좌석 : </span> <span id="movieseat">${seat}</span></li>
					</ul>
				</div>
			</div><!-- Bbs_bkList.bk -->
				<form action="" method="post" name ="movieinfo" id="movieinfoform">
					<input type="hidden" id="user_id" name="user_id" value="${id}">
		    		<input type="hidden" id="img" name="img" value="${img}">
			    	<input type="hidden" id="name" name="name" value="${name}">
			    	<input type="hidden" id="place" name="place" value="${place}">
			    	<input type="hidden" id="date" name="date" value="${date}">
			    	<input type="hidden" id="time" name="time" value="${time}">
			    	<input type="hidden" id="count" name="count" value="${count}">
			    	<input type="hidden" id="seat" name= "seat" value="${seat}">
		    	</form>
			<div class="seat_movie">
				<div class="buttonbtn">
					<button style="margin-bottom: 15px;" type="submit" class="btn btn-success btncustom" id="goto_bkwrite">게시판으로</button>
					<br>
					<button style="margin-top: 15px;" type="submit" class="btn btn-danger btncustom" id="PayButton">결제하기</button>
				</div>
				
			</div>
		</div>

	</div>
	<!-- movie_form end -->
</div><!-- 전체폼 -->
	<footer
		style="text-align: center; background: lightgray; height: 50px; padding-top: 15px; margin-top: 30px;"
		class="footer">
		<div class="container">
			<p class="text-muted">중앙HTA 2104기 세미프로젝트 1조 nullnull</p>
		</div>
	</footer>
	
	
	<!-- 주영님이 수정한 로그인 모달 -->    
    
<div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom-0">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <div class="form-title text-center">
          <h3>Login</h3>
        </div>
      </div>
      <div class="modal-body">
          <form name="loginform" action="loginProcess.oky" method="post">
           <div class="form-group">
              <label for="id"><span class="glyphicon glyphicon-user"></span>아이디</label>
              <input type="text" class="form-control" name="id" id="id" placeholder="아이디 입력">
            </div>
            <div class="form-group">
              <label for="pass"><span class="glyphicon glyphicon-eye-open"></span>비밀번호</label>
              <input type="password" class="form-control" name="pass" id="pass" placeholder="비밀번호 입력">
            </div>
            <input type="checkbox" id="remember" name="remember" value="store">
            <span>아이디 저장</span><br>
            <button type="submit" class="btn btn-info btn-block btn-round btn-sm">Login</button><br>
              <a href="#" class="findidpw">ID/PW찾기</a>&nbsp;&nbsp;&nbsp;&nbsp;
              <a href="#" class="join2">회원가입</a>
          </form>
          
         
      </div>
    </div>
    
  </div>
</div> 
	
	

</body>
</html>


