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
    <title>1:1문의</title>
    
<script src="js/jquery-3.6.0.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/oky/mail.css">
<script src="js/fr_js/cookie.js"></script>
<script>
      $(function(){ 
   	        	   
      	   $("#contact").click(function(){ //1:1 문의 클릭시 아이디 없으면 안넘어가게하기
      		  if(!id){
      			  alert("로그인 후 이용해 주세요");
      			  return false;
      		  }
      	   });
      	   
      	   
      	   
    	   $("#send").click(function(){//아이디 저장 기능
    	   if($.trim($("#subject").val()) == ""){
    		   alert("제목을 입력하세요");
    		   $("#subject").focus();
    		   return false
    		   }
    		   
    		 if($.trim($("#content").val()) == ""){
        		   alert("내용을 입력하세요");
        		   $("#content").focus();
        		   return false
	          }
       });
   	$('.cancelbtn').click(function(){
		window.location ="index.jsp";
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

<%-- 회원 ID: ${id} <br>
회원 이름: ${memberinfo.name} <br>
회원 email: ${memberinfo.email} <br>
회원 전화번호: ${memberinfo.phone} --%>

<header>1:1문의</header>

<form action="Bbs_con/mailSend.jsp" method="post" id="form" class="topBefore">
<input type="hidden" name="userid"  value= "${id}" readOnly>
<input type="hidden" name="name" value= "${memberinfo.name}" readOnly>
<input type="hidden" name="email" value= "${memberinfo.email}" readOnly>
<input type="hidden" name="phone" value= "${memberinfo.phone}" readOnly>
<input type="hidden" name="sender" value= "okycontactus@gmail.com" readOnly>


  <input type="text" name="receiver"value= "okycontactus@gmail.com" readOnly>
  <input type="text" name="subject" id="subject" placeholder="제목">
  <textarea name="content" id="content"  placeholder="내용"></textarea>
  <input id="send" type="submit" value="보내기">
  <input type="button" id="cancelbtn" class="cancelbtn" value="취소">


</form>

  <footer style="text-align: center; background: lightgray; height: 50px; padding-top:15px; margin-top: 30px;" class="footer">
      <div class="container">
        <p class="text-muted">중앙HTA 2104기 세미프로젝트 1조 nullnull</p>
      </div>
    </footer>
</body>
</html>