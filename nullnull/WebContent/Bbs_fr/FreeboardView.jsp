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
    <title>자유게시판 게시글 뷰페이지</title>
    
   <script src="js/jquery-3.6.0.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="js/fr_js/view.js"></script>

<script>
      $(function(){ 
    	  var id = '${id}';
      	   $(".join1").click(function(){ //메인에서 회원가입버튼 클릭 시
    		   location.href="join.oky";
    	   });

      	   $(".join2").click(function(){ //로그인창에서 회원가입버튼 클릭 시
    		   location.href="join.oky";
    	   });

      	   $(".findidpw").click(function(){ //ID/PW찾기 클릭 시
    		   location.href="find.oky";
    	   });      	   
    	   $(".login").click(function(){//아이디 저장 기능
    	   var id = '${id}';
    	   if(id){
    		   $("#id").val(id);
    		   $("#remember").prop('checked',true);
    	   }
           });
    	   $("#contact").click(function(){ //1:1 문의 클릭시 아이디 없으면 안넘어가게하기
       		  if(!id){
       			  alert("로그인 후 이용해 주세요");
       			  return false;
       		  }
       	   });
      $("#loginaction").submit(function() {//자유게시판 뷰페이지에서 로그인 시도시
    	   if ($.trim($("#id").val()) =="") {
    		   
    		   alert("ID를 입력 하세요");
    		   $("#id").focus();
    		   return false;
    	   } 
    	   if ($.trim($("#pass").val()) =="") {
    		 
    		   alert("로그인시 비밀번호를 입력 하세요");
    		   $("#pass").focus();
    		   return false;
    	   }   	    	   
      });
      
      });

</script>   

    <style>
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
	background-color: #000000;
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

#myModal {
	display: none
}

#comment>table>tbody>tr>td:nth-child(2) {
	width: 60%
}

.CommentBox .comment_option .comment_title {
	float: left;
	margin-top: 3px;
	margin-right: 12px;
	font-size: 17px;
}

.CommentBox .comment_option .comment_tab .comment_tab_list {
	display: inline-block;
	margin-top: 4px;
	font-size: 13px;
	vertical-align: top;
}

.CommentBox .comment_option .comment_tab .comment_tab_item:first-child {
	margin-left: 0;
}

.CommentBox .comment_option .comment_tab .comment_tab_item {
	float: left;
	margin-left: 8px;
}

.CommentBox .comment_option .comment_tab .comment_tab_item .comment_tab_button[aria-selected=true]
	{
	color: #000000;
}

.comment_tab_button {
	color: #b7b7b7;
	font-weight: 700;
}

.CommentBox .comment_option .comment_tab .comment_refresh_button:before
	{
	content: "";
	border-radius: 50%;
	border: 1px solid transparent;
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
}

.CommentBox {
	margin-top: -17px;
	border-top: 1px solid #ebecef;
}

.CommentBox .comment_option {
	position: relative;
	padding-top: 16px;
	margin-bottom: 11px;
}

textarea.comment_inbox_text {
	max-height: 500px;
}

.CommentBox .comment_list .comment_nick_box, .CommentItem--reply {
	margin-bottom: 4px;
}

.CommentBox .comment_list .comment_area {
	position: relative;
	padding: 12px 23px 10px 0;
}

.CommentItem--reply.lev1 {
	margin-left: 46px;
}

.CommentItem--reply.lev2 {
	margin-left: 92px;
}

.CommentBox .comment_list .CommentItem {
	position: relative;
	border-top: 1px solid #f2f2f2;
}

.CommentBox .comment_list .comment_nick_box .comment_nickname {
	font-weight: 700;
}

.CommentBox a {
	color: inherit;
}

.CommentBox .comment_list .comment_info_box {
	margin-top: 7px;
	font-size: 12px;
	color: #979797;
}

.CommentBox .comment_list .comment_tool .comment_tool_button {
	display: block;
	width: 16px;
	height: 16px;
	text-align: right;
	cursor: pointer;
}

.CommentBox .comment_list .comment_tool {
	position: absolute;
	top: 12px;
	right: 0;
}

.comment_tool_button div {
	transform: rotate(90deg);
	color: #979797
}

.CommentBox .comment_list+.CommentWriter {
	margin-top: 30px;
}

.CommentWriter {
	margin: 12px 0 29px;
	padding: 16px 10px 10px 18px;
	border: 2px solid rgba(0, 0, 0, 0.1);
	border-radius: 6px;
	box-sizing: border-box;
	background: #ffffff;
}

.CommentWriter .comment_inbox {
	position: relative;
	margin-bottom: 10px;
}

.CommentWriter .comment_inbox_text {
	overflow-x: hidden;
	overflow-y: auto;
	display: block;
	width: 100%;
	min-height: 17px;
	padding-right: 1px;
	border: 0;
	font-size: 13px;
	-webkit-appearance: none;
	resize: none;
	box-sizing: border-box;
	background: transparent;
	color: #000000;
	outline: 0;
}

button, textarea {
	font-family: Apple SD Gothic Neo, 맑은 고딕, Malgun Gothic, 돋움, dotum,
		sans-serif;
}

.CommentWriter .register_box .button {
	display: inline-block;
	min-width: 46px;
	height: 34px;
	line-height: 36px;
	font-size: 13px;
	color: #b7b7b7;
	border-radius: 6px;
	box-sizing: border-box;
	font-weight: 700;
	text-align: center;
	vertical-align: top;
}

.CommentBox .comment_list .comment_tool .LayerMore {
	left: auto;
	right: 0;
	margin-top: 7px;
}

.comment_tool_button:focus, .commnet_tool_button:visited {
	outline: none;
}

.btn_register, .btn_cancel, .reply {
	cursor: pointer;
	float: right;
}

.CommentItem .comment_area img {
	border-radius: 50%;
	border: 1px solid #ccc;
	float: left;
	margin-right: 20px;
}

.comment_inbox_text {
	overflow: hidden;
	overflow-wrap: break-word;
	height: 17px;
}

.comment_inbox_count {
	font-size: small;
	color: #b7b7b7;
	float: right
}

.comment_inbox_name {
	font-size: small;
}

.register_box {
	height: 20px;
}

.CommentWriter .register_box .btn_cancel {
	display: none;
}

img {
	vertical-align: middle;
}

a {
	text-decoration: none;
}

dl, ol, ul {
	list-style: none;
}

.blind {
	position: absolute;
	clip: rect(0, 0, 0, 0);
	width: 1px;
	height: 1px;
	margin: -1px;
	overflow: hidden;
}

.LayerMore {
	/*   overflow-y: auto; */
	position: absolute;
	top: auto;
	left: 0;
	z-index: 1;
	max-height: 416px;
	padding: 10px 0 10px 10px;
	border: 1px solid rgba(0, 0, 0, .06);
	border-radius: 6px;
	box-shadow: 0 1px 12px 0 rgb(0 0 0/ 6%);
	background-color: #fff;
	box-sizing: border-box;
	color: #000;
	width: 100px;
	/* height:36px; */
}

.LayerMore a {
	font-size: small;
	text-decoration: none;
}

.LayerMore {
	display: none;
}
.ctg {
  display: flex;
  justify-content: left;
  align-items: center;
  font-family: 'Open Sans', sans-serif;
  height: 100%;
  margin: 100;
  float:left;
  padding-left:200px;
  padding-top :170px
}

.categories {
  margin: 0;
  padding: 0;
  text-transform: uppercase;
  border-left: 1px solid #aaa;
  display: inline-block;
  padding: 0 40px;
  position: absolute;
}
.categories:before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  display: inline-block;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 5px 0 5px 8px;
  border-color: transparent transparent transparent #aaa;
}
.categories__header {
  margin: 0 0 30px;
  font-weight: 400;
  color: #777777;
}
.categories__menu {
  padding: 0;
}
.categories__menu li {
  list-style-type: none;
  line-height: 34px;
  font-size: 15px;
  
}
.categories__menu li:before {
  content: '\00b7';
  font-size: 45px;
  line-height: 24px;
  vertical-align: text-bottom;
  margin-right: 20px;
  color: #aaa;
}
.categories__menu li a {
  color: #aaa;
  text-decoration: none;
}
.categories__menu li > .categories__menu__submenu {
  display: none;
  padding: 0;
}
.categories__menu li > .categories__menu__submenu li {
  list-style-type: none;
  position: relative;
}
.categories__menu li > .categories__menu__submenu li:before {
  content: "";
}
.categories__menu li > .categories__menu__submenu li a {
  margin-left: 50px;
  padding: 0 10px;
  background: white;
}
.categories__menu li > .categories__menu__submenu li a:hover {
  color: red;
}
.categories__menu li > .categories__menu__submenu li a:hover:before {
  content: "";
  position: absolute;
  width: 50%;
  height: 1px;
  background: #eaeaea;
  left: 0;
  top: 50%;
  z-index: -1;
}
.categories__menu li > .categories__menu__submenu li.active > a {
  color: red;
}
.categories__menu li > .categories__menu__submenu li.active > a:before {
  content: "";
  position: absolute;
  width: 50%;
  height: 1px;
  background: #eaeaea;
  left: 0;
  top: 50%;
  z-index: -1;
}
aside {
	float: left;

}
@media (max-width: 1800px) {
  .Index:first-of-type,
  .Index:last-of-type {
    display: none;
  }
}    
    
    
 
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

<!-- 상단 -->

<%-- 넘어온 id는 ${id} <br> --%>

<input type="hidden" id="loginid" value="${id}" name="loginid">
 <div class="container">
   <table class="table">
<!--      <thead><tr><th colspan="4">MVC 게시판-view페이지</th></tr></thead> -->
     <tr>      
         <td><div>분류:
          	    <c:if test="${boarddata.fr_csfc ==1 }">
	                        잡담
		        </c:if>
	            <c:if test="${boarddata.fr_csfc ==2 }">
	                        이벤트
		        </c:if>
	            <c:if test="${boarddata.fr_csfc ==3 }">
	                        궁금해요
		        </c:if>		
	            <c:if test="${boarddata.fr_csfc ==4 }">
	                         정보
		        </c:if>
	             <c:if test="${boarddata.fr_csfc ==5 }">
	                         기사
		         </c:if>	             
          </div></td>
          
         <td><div>날짜 : ${boarddata.fr_date}</div> </td>
         
         <td><div>조회수 : ${boarddata.fr_read}</div>
         
      </tr>
     <tr>
         <td colspan="4"><div>글쓴이: ${boarddata.id}</div></td>
     </tr>
     <tr>
         <td colspan="4"><div>제목: <c:out value="${boarddata.fr_subject}" /></div></td>
     </tr>     
     <tr>
         <td colspan="4" style="padding-right:0px"><textarea class="form-control" rows="15" id="TXT" style="resize: none;"
               readOnly>${boarddata.fr_content}</textarea></td>
     </tr>     
     
<%--    <c:if test="${boarddata.fr_re_lev==0}">원문글인 경우에만 첨부파일을 추가 할 수 있습니다.
    <tr>
      <td colspan="4"><div>첨부파일
     <c:if test="${!empty boarddata.fr_file}">파일첨부한 경우
      <img src="image/down.png" width="10px">
          <a href="FreeboardFileDown.okybo?filename=${boarddata.fr_file}">
            ${boarddata.fr_file}</a>
      </c:if>
      </div></td>
      <c:if test= "${empty boarddata.fr_file}">파일첨부하지 않은 경우
          <td></td>
      </c:if>
      </tr>
   </c:if>
     
     <tr>
         <td colspan="4" class="center">
           <a href="FreeboardReplyView.okybo?num=${boarddata.fr_no}">
              <c:if test="${!empty id}">
             <button class="btn btn-primary">답변</button>
             </c:if>
           </a>
           
           <c:if test="${boarddata.id == id || id == 'admin' }">
            <a href="FreeboardModifyView.okybo?num=${boarddata.fr_no}">
              <button class="btn btn-info">수정</button>
            </a>
            href의 주소를 #으로 설정합니다.
            <a href="#">
              <button class="btn btn-danger" data-toggle="modal"
                      data-target="#myModal">삭제</button>
            </a>
           </c:if>
           
           <a href="Freeboard.okybo">
              <button class="btn btn-secondary">목록</button>
           </a>
           </td>
           </tr>     --%>          
   </table>
   
    <c:if test="${boarddata.fr_re_lev==0}"><%--원문글인 경우에만 첨부파일을 추가 할 수 있습니다. --%>
     <div>첨부파일
     <c:if test="${!empty boarddata.fr_file}"><%-- 파일첨부한 경우 --%>
      <img src="image/down.png" width="10px">
          <a href="FreeboardFileDown.okybo?filename=${boarddata.fr_file}">
            ${boarddata.fr_file}</a>
      </c:if>
      </div>
      <c:if test= "${empty boarddata.fr_file}"><%-- 파일첨부하지 않은 경우 --%>
      </c:if>
      </c:if>
				<div class="btn-wrap">     
           <a href="FreeboardReplyView.okybo?num=${boarddata.fr_no}">
              <c:if test="${!empty id}">
             <button class="btn ">답변</button>
             </c:if>
           </a>
           
           <c:if test="${boarddata.id == id || id == 'admin' }">
            <a href="FreeboardModifyView.okybo?num=${boarddata.fr_no}">
              <button class="btn ">수정</button>
            </a>
            <%-- href의 주소를 #으로 설정합니다. --%>
            <a href="#">
              <button class="btn " data-toggle="modal"
                      data-target="#myModal">삭제</button>
            </a>
           </c:if>
           
           <a href="Freeboard.okybo">
              <button class="btn ">목록</button>
           </a>
 </div>    
   
   
   
   
<%-- 게시판 view end --%>

             <%-- modal 시작 --%>
             <div class="modal" id="myModal">
              <div class="modal-dialog">
               <div class="modal-content">
                 <%-- Modal body --%>
                 <div class="modal-body">
                  <form name="deleteForm" action="FreeboardDeleteAction.okybo" method="post">
                    <%-- http://localhost:8888/6Board/BoardDetailAction.bo?num=22
                                                 주소를 보면 num을 파라미터로 넘기고 있습니다.
                                                 이 값을 가져와서 ${param.num}를 사용
                                                 또는 ${boarddata.board_num}
                     --%>
                     <input type="hidden" name="num" value="${param.num}"
                         id="comment_board_num">
                     <div class="form-group">
                        <label for="pwd">비밀번호</label>
                        <input type="password"
                               class="form-control" placeholder="Enter password"
                               name="board_pass" id="board_pass">
                     </div>
                     <button type="submit" class="btn btn-primary">삭제</button>
                     <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                  </form>
                 </div><!-- class="modal-body" -->
               </div><!-- class="modal-content" -->
              </div><!-- class="modal-dialog" -->
             </div>
             <!-- class="modal" -->
             
             
             <!-- 댓글 작성 영역 -->
             <div class="CommentBox">
                 <div class="comment_option">
                    <h3 class="comment_title">
                                             댓글 <sup id="count"></sup> 
                    </h3>
                    <div class="comment_tab">
                        <ul class="comment_tab_list">
                        </ul>
                    </div>
                 </div><!-- coment option end -->
                 <ul class="comment_list">
                 </ul>
                 <div class="CommentWriter">
                     <div class="comment_inbox">
                         <b class="comment_inbox_name">${id}</b> <span                       
                              class="comment_inbox_count">0/200</span>
                         <textarea placeholder="댓글을 남겨보세요" rows="1"
                             class="comment_inbox_text" style="width:400px; height:80px; resize: none;" maxLength="200" ></textarea>
                             
                    </div>
                    <div class="register_box">
                        <div class="button btn_cancel">취소</div>
                         <div class="button btn_register">등록</div>                      
                    </div>
                 </div><!-- CommentWriter end -->
             </div><!-- CommentBox end -->
          </div><!-- container end -->
          
          
 <!-- 해드 로그인 부분 -->         
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