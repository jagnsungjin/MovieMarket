<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
 <script src="js/jquery-3.6.0.min.js"></script>
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>공지사항 상세보기 페이지</title>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 <script src="js/fr_js/cookie.js"></script> 
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

/*추가된 주영님 로그인 CSS*/
.container {
  padding: 2rem 0rem;
}

.modal-header {
  .close {
    margin-top: -1.5rem;
  }
}

.form-title {
  margin: -2rem 0rem 2rem;
}

.btn-round {
  border-radius: 3rem;
}

.delimiter {
  padding: 1rem;  
}


.signup-section {
  padding: 0.3rem 0rem;
}
.modal-dialog-centered{
	width:330px;
	
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

/* 성진님 css */
span {
	color:red;
}
section.notice {
	padding: 80px 0;
}

.page-title {
	margin-bottom: 60px;
}

.page-title h3 {
	font-size: 28px;
	color: #333333;
	font-weight: 400;
	text-align: center;
}

#board-search .search-window {
	padding: 15px 0;
	background-color: #f9f7f9;
}

#board-search .search-window .search-wrap {
	position: relative;
	padding-right: 124px;
	margin: 0 auto;
	width: 80%;
	max-width: 564px;
}

#board-search .search-window .search-wrap input {
	height: 40px;
	width: 100%;
	font-size: 14px;
	padding: 7px 14px;
	border: 1px solid #ccc;
}

#board-search .search-window .search-wrap input:focus {
	border-color: #333;
	outline: 0;
	border-width: 1px;
}

#board-search .search-window .search-wrap .btn {
	position: absolute;
	right: 0;
	top: 0;
	bottom: 0;
	width: 108px;
	padding: 0;
	font-size: 16px;
}

.board-table {
	font-size: 15px;
	width: 100%;
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

.board-table a {
	color: #333;
	display: inline-block;
	line-height: 1.4;
	word-break: break-all;
	vertical-align: middle;
}

.board-table a:hover {
	text-decoration: underline;
}

.board-table th {
	text-align: center;
}

.board-table .th-num {
	width: 100px;
	text-align: center;
}

.board-table .th-date {
	width: 200px;
}

.board-table th, .board-table td {
	padding: 14px 0;
}

.board-table tbody td {
	border-top: 1px solid #e7e7e7;
	text-align: center;
}

.board-table tbody th {
	padding-left: 28px;
	padding-right: 14px;
	border-top: 1px solid #e7e7e7;
	text-align: left;
}

.btn {
	display: inline-block;
	padding: 0 30px;
	font-size: 15px;
	font-weight: 400;
	background: transparent;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	border: 1px solid transparent;
	text-transform: uppercase;
	-webkit-border-radius: 0;
	-moz-border-radius: 0;
	border-radius: 0;
	-webkit-transition: all 0.3s;
	-moz-transition: all 0.3s;
	-ms-transition: all 0.3s;
	-o-transition: all 0.3s;
	transition: all 0.3s;
}

.btn-dark {
	background: #555;
	color: #fff;
}

.btn-dark:hover, .btn-dark:focus {
	background: #373737;
	border-color: #373737;
	color: #fff;
}

.btn-dark {
	background: #555;
	color: #fff;
}

.btn-dark:hover, .btn-dark:focus {
	background: #373737;
	border-color: #373737;
	color: #fff;
}

/* reset */
* {
	list-style: none;
	text-decoration: none;
	padding: 0;
	margin: 0;
	box-sizing: border-box;
}

.clearfix:after {
	content: '';
	display: block;
	clear: both;
}

.container {
	width: 1100px;
	margin: 0 auto;
}

.blind {
	position: absolute;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	margin: -1px;
	width: 1px;
	height: 1px;
}
/* button */
.btn-wrap {
	margin: 10px 0 0 0;
	text-align: right
}

.btn {
	display: inline-block;
	padding: 12px 20px;
	background-color: #73a8d8;
	color: #fff;
	text-align: center;
	line-height: 1;
}

.btn btn light btn-sm {
	width: 800px;
}

h1 {
	margin-left: -0.8em;
	border: 5px solid currentColor;
	border-left-width: 20px;
	border-radius: 4px;
	padding: 0.4em 0.6em 0.4em 0.25em;
	color: #27517d;
	font-size: 38px;
	font-weight: 700;
	line-height: 1;
}

@import "https://fonts.googleapis.com/css?family=Open+Sans:300,400";

body {
	align-items: left;
}

#ddd {
	width: 500px
}

#tableheadera {
	background-color: #d5e0ea;
}

td {
	align: left;
	border-bottom: 1px solid black;
}

#Ttextarea {
	align: left;
	valign: top
}

textarea {
	background-color: white;
	height: 50px
}

textarea.form-control {
	resize: none
}

textarea {
	font-weight: 400;
}

#TXT {
	font-size: 1em;
	height: 400px;
	font-weight:bold
	
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
  	<!-- Static navbar -->

<!-- 성진님 board -->
	<section class="notice">
		<div class="page-title">

			<div class="container">
				<h1>공지사항 게시판</h1>
			</div>
			<div class="container">
				<hr style="border: solid 6px #4f7094;">
			</div>
		</div>

		<!-- 성진님 board list area -->
<div id="board-list">
  <div class="container">
	<hr>
	<h4>
	  <b>작성일 :  &nbsp;${boarddata.nt_date}</b><br>
	</h4>
	<hr>
	<input type="hidden" value="${id}" id="loginid" name="loginid">
	<table class="board-table">
	  <thead>
		<tr id="tableheadera">
		  <td scope="col" class="th-num" colspan=2><b>제목</b>&nbsp;
		  <c:out value="${boarddata.nt_subject}" /></td>
		  <td scope="col" class="th-title" id="ddd"></td>
		  <td scope="col" class="th-date"><b>작성자</b>
				&nbsp;${boarddata.user_id}</td>
		</tr>
		<tr id="tableheader">
		  <td scope="col" class="th-num" colspan=2><b>첨부파일</b>
		  &nbsp;
		  <c:if test="${!empty boarddata.nt_file}">
									<%--파일첨부한 경우 --%>
		   <img src="image/down.png" width="10px">
		   <a href="NTFileDown.bo?filename=${boarddata.nt_file}">
		   ${boarddata.nt_file}</a>
		  </c:if> 
		 <c:if test="${empty boarddata.nt_file}">
									<%--파일 첨부하지 않은경우 --%>
		  &nbsp;
		  </c:if>
		  </td>
		  <td scope="col" class="th-title" id="ddd"></td>
		  <td scope="col" class="th-date"><b>조회수</b> &nbsp;
		  ${boarddata.nt_read}</td>
	    </tr>
		<tr id="Ttextarea">
		   <td style="padding-right: 0px" colspan=4><textarea
			   class="form-control" rows="15" readOnly id="TXT">
			   ${boarddata.nt_content}</textarea></td>
			<td></td>
		</tr>
		<tr>
				<td colspan="3" class="center">
				  <c:if test="${id =='admin'}">
				   <a href="NTModifyView.bo?num=${boarddata.nt_no}">
				   	  <button class="btn btn-info" >수정</button>
				   </a>
				   <a href="#">
				   	  <button class="btn btn-danger" data-toggle="modal"
				   	  		  data-target="#myModal">삭제</button>
				   </a>
				   </c:if>
				   
				   <a href="NTList.bo">
				   	 <button class="btn btn-secondary">목록</button>
				   </a>
				 </td>
			</tr>
		</thead>
  </table>
			

</div>
</div>
</section>



<!-- 기존 게시판view 시작 -->

	
		<%--modal 시작--%>
		<div class="modal" id="myModal">
		  <div class="modal-dialog">
			<div class="modal-content">
				<%--Modal body --%>
				<div class="modal-body">
				 <form name="deleteForm" action="NTDeleteAction.bo" method="post">
				 	<%--http://localhost:8088/Board/BoardDetailAction.bo?num=22 
				 		주소를 보면 num을 파라미터로 넘기고 있습니다.
				 		이 값을 가져와서 ${param.num}를 사용
				 		또는 ${boarddata.board_num}
				 	--%>
				 	<input type="hidden" name="num" value="${param.num}" id="comment_board_num">
				 	<div class="form-group">
				 		<label for ="pwd">비밀번호</label>
				 		<input type="password"
				 				class="form-control" placeholder="Enter password"
				 				name="nt_pass" id="nt_pass">
				 	</div>
				 	<button type="submit" class="btn btn-primary">전송</button>
				 	<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				 </form>
				</div><!-- class="modal-body" -->
			</div><!-- class="modal-content -->
		</div><!-- class="modal-dialog" -->
		</div><!-- class="modal" end -->
<!-- class="container" -->

  <footer style="text-align: center; background: lightgray; height: 50px; padding-top:15px; margin-top: 30px;" class="footer">
      <div class="container">
        <p class="text-muted"style="margin: -20px;">중앙HTA 2104기 세미프로젝트 1조 nullnull</p>
      </div>
    </footer>

  </body>
</html>