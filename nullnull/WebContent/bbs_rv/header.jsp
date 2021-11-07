<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> 
    <style>
.navbar .navbar-nav {
  display: inline-block;
  float: none;
}
.navbar .navbar-collapse {
  text-align: center;
}
.navc{
	width:50px;
}
.row{
	display: flex;
	justify-content: center;
}

</style>
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
          <ul class="nav navbar-nav" >
            <li class="active"><a href="bestmovie.mo">영화</a></li>
            <li style="width: 50px;">&nbsp;</li>
            <li><a href="movieticketing.mo">영화예매</a></li>
            <li style="width: 50px;">&nbsp;</li>
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop"
					data-toggle="dropdown">커뮤니티</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="Freeboard.okybo">자유게시판</a><br>
						<a class="dropdown-item" href="Bbs_bkList.bk">예매대행</a><br>
						<a class="dropdown-item" href="RvList.rv">영화후기</a>
					</div></li>
            <li style="width: 50px;">&nbsp;</li>
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop"
					data-toggle="dropdown">고객센터</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="NTList.bo">공지사항</a><br>
						<a class="dropdown-item" href="NTFAQ.bo" >자주 묻는 질문</a><br>
						<a class="dropdown-item" href="ContactUs.okycon" id="contact">1:1문의</a>
					</div></li>					
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
</body>
</html>