<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>영화 예매게시판</title>

   <script src="js/jquery-3.6.0.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 <script src="js/bk_js/list.js"></script>
 <script src="js/fr_js/cookie.js"></script>
 <link rel="stylesheet" href="css/rv_css/list.css">
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
      	   
      	   $("#contact").click(function(){ //1:1 문의 클릭시 아이디 없으면 안넘어가게하기
      		  if(!id){
      			  alert("로그인 후 이용해 주세요");
      			  return false;
      		  }
      	   });
      	   
      	   
      	   
    	   $(".login").click(function(){//아이디 저장 기능
    	   if(id){
    		   $("#id").val(id);
    		   $("#remember").prop('checked',true);
    	   }
       })
       
       $('#searchbtn').click(function(){
			var formbtn = document.searchbtn
			formbtn.submit();	
		})
	
		
		$('#loginform').click(function(){
			if ($.trim($("#id").val()) =="") {
	    		   
	    		   alert("ID를 입력 하세요");
	    		   $("#id").focus();
	    		   return false;
	    	   } 
	    	   if ($.trim($("#pass").val()) =="") {
	    		 
	    		   alert("비밀번호를 입력 하세요");
	    		   $("#pass").focus();
	    		   return false;
	    	   }   	    	   
			var formbtn = document.loginform
			formbtn.submit();	
		})
      
    
      
      });

</script>   
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


</style>
<script>
$(function(){

    $("#rec").click(function(){
       location.href="Bbs_bkList.bk";
    })
 })
$(function(){

    $("#enr").click(function(){
       location.href="Bbs_bkListEnr.bk";
    })
 })
$(function(){

    $("#rea").click(function(){
       location.href="Bbs_bkListRea.bk";
    })
 })
</script>
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
    
    
    
  <section class="notice">
      <aside class="Index">
         <div class="ctg">
            <div class="categories">
               <h2 class="categories__header">
                  <b>게시판 목록</b>
               </h2>
               <ul class="categories__menu">
                  <li><a href="Freeboard.okybo">자유게시판</a></li>
                  <li><a href="NTList.bo">공지사항</a></li>
                  <li><a href="RvList.rv">영화후기</a></li>
                  <li><a href="Bbs_bkList.bk"><b>예매대행</b></a></li>

               </ul>

            </div>
         </div>
      </aside>



      <div class="page-title">
      

         <div class="container">
         
            <h1>예매 대행 게시판</h1>
         </div>
         <div class="container">
          <hr style="border: solid 10px black;">
          <h4><b>※제목을 누르면 상세페이지로 이동합니다.</b></h4>
         </div>
      </div>
      

      <!-- board seach area -->
      <div id="board-search">

         <div class="container">
            <button type="button" class="btn btn-light btn-sm" id="rec"
               name="rec">최신순</button>
            <button type="button" class="btn btn-light btn-sm" id="enr"
               name="enr">정확순</button>
            <button type="button" class="btn btn-light btn-sm" id="rea"
               name="rea">조회순</button>
            <div class="search-window">
               <form  method="get" action="Bbs_bkList.bk" name="search" id="searchform">
                  <div class="search-wrap">

                     <c:if test="${search==''}">
                        <input id="search" type="search" name="search"
                           placeholder="검색어를 입력해주세요." value="">
                     </c:if>
                     <c:if test="${search !='' }">
                        <input type="search" placeholder="검색어를 입력해주세요." name="search"
                           id="search" value="${search}">
                     </c:if>
                     <br> <select name="searchType" id="searchType">
							<option value="subAcon"${(searchType =="subAcon")? "selected" : ""}>제목+내용</option>
							<option value="subject"${(searchType =="subject")? "selected" : ""}>제목</option>
							<option value="content"${(searchType =="content")? "selected" : ""}>내용</option>
							<option value="writer"${(searchType =="writer")? "selected" : ""}>글쓴이</option>
					</select>
                     <div class="btn-wrap">
                        <input type="submit" id="searchbtn" class="btn" value="검색">
                     </div>
                  </div>
               </form>
            </div>
         </div>
      </div>

      <!-- board list area -->
      <div id="board-list">

         <div class="container">
            <table class="board-table">
               <thead>
                  <tr>
                     <th scope="col" class="th-num">번호</th>
                     <th scope="col" class="th-title">분류</th>
                     <th scope="col" class="th-date">제목</th>
                     <th scope="col" class="th-date">글쓴이</th>
                     <th scope="col" class="th-date">날짜</th>
                     <th scope="col" class="th-date">조회수</th>
                  </tr>
               </thead>
               <tbody>
                  <c:set var="num" value="${listcount-(page-1)*limit}" />
                  <c:forEach var="b" items="${boardlist}">
                     <tr>
                        <td>
                           <%--번호 --%> <c:out value="${num}" /> <%-- num 출력 --%> <c:set
                              var="num" value="${num-1}" /> <%-- num=num-1; 의미--%>
                        </td>
                        <td><b>${b.BK_CSFC}</b></td>
                        <th>
                           
                           <%--제목 --%>
                           <div>

                              <c:if test="${b.BK_RE_LEV != 0}">
                                 <!--  답글인 경우 -->
                                 <c:forEach var="a" begin="0" end="${b.BK_RE_LEV*2}" step="1">
                                    &nbsp;    
                              </c:forEach>
                                 <img src='image/line.gif'>
                              </c:if>

                              <c:if test="${b.BK_RE_LEV == 0}">
                                 <%-- 원문인 경우 --%>
                                 &nbsp;  
                              </c:if>

                              <a href="Bbs_bkDetail.bk?num=${b.BK_NO}"> <c:out
                                    value="${b.BK_SUBJECT}" /> <%-- ${b.board_subject} --%> <%-- escapeXml="true" : HTML 태그를 화면에 그대로 보여줍니다. --%>
                              </a>
                           </div>
                        </th>


                        
                        <td>
                           <div>${b.USER_ID}</div>
                        </td>
                        <td><div>${b.BK_DATE}</div></td>
                        <td><div>${b.BK_READ}</div></td>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>
            <div class="center-block">
               <ul class="pagination justify-content-center">
                  <c:if test="${page <= 1 }">
                     <li class="page-item"><a class="page-link gray">이전&nbsp;</a></li>
                  </c:if>
                  <c:if test="${page > 1 }">
                     <li class="page-item"><a href="Bbs_bkListEnr.bk?page=${page-1}"
                        class="page-link">이전&nbsp;</a></li>
                  </c:if>

                  <c:forEach var="a" begin="${startpage}" end="${endpage}">
                     <c:if test="${a == page }">
                        <li class="page-item "><a class="page-link gray">${a}</a></li>
                     </c:if>
                     <c:if test="${a != page }">
                        <li class="page-item"><a href="Bbs_bkListEnr.bk?page=${a}"
                           class="page-link">${a}</a></li>
                     </c:if>
                  </c:forEach>

                  <c:if test="${page >= maxpage }">
                     <li class="page-item"><a class="page-link gray">&nbsp;다음</a></li>
                  </c:if>
                  <c:if test="${page < maxpage }">
                     <li class="page-item"><a href="Bbs_bkListEnr.bk?page=${page+1}"
                        class="page-link">&nbsp;다음</a></li>
                  </c:if>
               </ul>
            </div>
            <div class="btn-wrap">
               <c:if test="${!empty id}">
            <input type="button" id="writeform" class="btn" value="글쓰기">					
			</c:if>
            </div>
         </div>
      </div>

   </section>
   
   
   
   
  <footer style="text-align: center; background: lightgray; height: 50px; padding-top:15px; margin-top: 30px;" class="footer">
      <div class="container">
        <p class="text-muted"style="margin: -20px;">중앙HTA 2104기 세미프로젝트 1조 nullnull</p>
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
          <form name="loginform" action="loginProcess.oky" method="post" id="loginform">
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