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
    <title>영화 예매</title>

   <script src="js/bk_js/jquery-3.6.0.min.js"></script>
   <script src="js/bk_js/Cal2.js"></script>
   <script src="js/bk_js/movie_select.js"></script>
   <script src="js/fr_js/cookie.js"></script>
   <link rel="stylesheet" href="css/ticket.css">
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
      $("form").submit(function() {
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
      });
      
      });

</script>   
    <style>
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

</script>
  </head>
  <body onload="build();">
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
	<div class="movie_form" style="height: 50px; border: none"><p style="font-size: 30pt;">예매하기</p></div>
    <div class="movie_form">
	    <div class="choice_movie">
	    	<div class="div_title">영화선택</div>
	    		<div class="movie_tab">
						<ul class="movie_tab_list">
						</ul><!--  -->
						
				</div>
				<hr>
				<!-- animation -->
				<div class="loading-container">
							    <div class="loading"></div>
							    <div id="loading-text">불러오는 중</div>
				</div>
				
				<div><!-- comment_option end -->
					<ul class="movie_list">
						<li class="movie_list_li"></li>
							
					</ul>
				</div>
	    </div>
	    
	    <div class="choice_place" id="writeTextarea">
	    	<div class="div_title">극장 선택</div>
	    	
	    	<!-- 아코디온 -->
	    	<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingOne">
			      <h4 class="panel-title1">
			        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
			         ☞ 서울(6)
			        </a>
			      </h4>
			    </div>
			    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
			      <div class=""><!-- panel-body -->
					<ul>
			         	<li style="background-color:gray;">강남구</li>
				         	<li class="mplace">CGV압구정</li>
				         	<li class="mplace">CGV강남</li>
				         	<li class="mplace">CGV청담씨네시티</li>
			         </ul>
			         <ul>
			         	<li style="background-color:gray;">강동구</li>
				         	<li class="mplace">CGV천호</li>
			         </ul>
			         <ul>
			         	<li style="background-color:gray;">강북구</li>
				         	<li class="mplace">CGV미아</li>
				         	<li class="mplace">CGV수유</li>
			         </ul>
			      </div>
			    </div>
			  </div>
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingTwo">
			      <h4 class="panel-title">
			        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			          ☞ 경기/인천(3)
			        </a>
			      </h4>
			    </div>
			    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
			      <div class="">
			      	<ul>
			         	<li style="background-color:gray;">고양시</li>
				         	<li class="mplace">CGV일산</li>
				         	<li class="mplace">CGV화정</li>
				         	<li class="mplace">CGV고양행신</li>
					</ul>
			      </div>
			    </div>
			  </div>
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingThree">
			      <h4 class="panel-title">
			        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
			          ☞ 부산/울산/경남(1)
			        </a>
			      </h4>
			    </div>
			    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
			      <div class="">
			      	 <ul>
			         	<li style="background-color:gray;">거제시</li>
				         	<li class="mplace">CGV거제</li>
			         </ul>
			      </div>
			    </div>
			  </div>
			</div>
	    <!-- <Accordion> end -->
	    </div>
	    <!-- 날짜선택 -->
	    <div class="choice_date">
	    <div class="div_title">날짜 선택</div>
			<table style="text-align: center;" id="calendar">
		<tr>
			<td>
			<a id="before" href="javascript:beforem()"><img src="image/leftArrow.png" width=20px;></a>
			</td>
			<td colspan="5" align="center">
			<div id="yearmonth"></div>
			</td>
			<td>
			<a id="next" href="javascript:nextm()"><img src="image/rightArrow.png" width=20px;></a>
			</td>
			<!-- <td>
			<a href="javascript:thisMonth()">오늘</a>
			</td> -->
		</tr>
		<tr>
			<td width="30px"><font color="#ed5353">일</font></td>
			<td width="30px"> 월 </td>
			<td width="30px"> 화 </td>
			<td width="30px"> 수 </td>
			<td width="30px"> 목 </td>
			<td width="30px"> 금 </td>
			<td width="30px"><font color="#009de0">토</font></td>
			
		</tr>
	</table>
	
	<div style="display: flex; margin-left: 30px; margin-top: 30px;">
		오늘날짜 
		<div style="background-color: #BCF1B1;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
		&nbsp;&nbsp;&nbsp;&nbsp;
		선택
		<div style="background-color: red;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
	</div>
	
	<div></div>
	    </div>
	    
	    <div class="choice_time">
	    	<div class="div_title">시간 선택</div>
	    	<ul class="times">
	    		<li id="time1" onclick="TimeSelect('time1')">4관 10 :00</li>
	    		<li id="time2" onclick="TimeSelect('time2')">5관 11 :00</li>
	    		<li id="time3" onclick="TimeSelect('time3')">7관 12 :00</li>
	    	</ul>
	    </div>
	      <div class="choice_peoples">
	    	<div class="div_title">인원 선택</div>
	    	<div style="display: flex;"><p class="btn1">성인</p>
	    	    	<button class="button1" value="1" >1</button>
	    	    	<button class="button1" value="2">2</button>
	    	    	<button class="button1" value="3">3</button>
	    	    	<button class="button1" value="4">4</button>
	    	    	<button class="button1" value="5">5</button>
	    	    	<button class="button1" value="6">6</button>
	    	</div>
			<hr style="margin-top: 15px;margin-bottom: 10px;">
			<p style="padding-top: 3px; margin-left: 10px;">※ 나이는 성인으로 통합합니다.</p>
	    </div>
	    <div class="choice_movieinfo">
	    	<div style="margin-top: 2px"><!-- 영화 이미지 -->
	    		<img style="margin: 9px 20px 5px 9px;" src="image/down.png" width="104px;" id="view">
	    	</div>
	    	<div style="margin-top: 2px">
	    	<ul class="movieinfos">
	    	<li>
	    		<span>영 &nbsp; 화</span>
	    		<span id="moviename"></span>
	    	</li>
	    	<li>
	    		<span>극 &nbsp; 장</span>
	    		<span id="movieplace"></span>
	    	</li>
	    	<li>
	    		<span>관람일</span>
	    		<span id="moviedate"></span>
	    	</li>
	    	<li>
	    		<span>시 &nbsp; 간</span>
	    		<span id="movietime"></span>
	    	</li>
	    	<li>
	    		<span>인 &nbsp; 원</span>
	    		<span id="moviepeoples"></span>
	    	</li>
	    	</ul>
	    	</div>
	    </div>
	    <div class="choice_submit">
	    	<!-- <div class="div_title">확인버튼</div> -->
	    	<div style="height: 93px;"><!-- 다음단계로 위 공간 -->
	    		<div style="font-size: 11pt;margin : 5px;">
	    			* 선택하신 영화정보를 꼭 확인해주세요 ! <br><br>
	    			* 영화선택에 로딩시간이 많이 걸릴 수 있습니다.
	    		</div>
	    	</div>
	    	<div style="display: none;" id="sessionid">${id}</div>
	    	<form action="movieseat.mo" method="post" name ="movieinfo">
	    		<input type="hidden" id="img" name="img" value="">
		    	<input type="hidden" id="name" name="name" value="">
		    	<input type="hidden" id="place" name="place" value="">
		    	<input type="hidden" id="date" name="date" value="">
		    	<input type="hidden" id="time" name="time" value="">
		    	<input type="hidden" id="count" name="count" value="">
	    	</form>
	    	<button id="buttonsub" class="btn btn-danger btn-block  buttonsub">다음 단계로</button>
	    </div>
    </div><!-- movie_form end -->

  <footer style="text-align: center; background: lightgray; height: 50px; padding-top:15px; margin-top: 30px;" class="footer">
      <div class="container"><p class="text-muted"style="margin: -20px;">중앙HTA 2104기 세미프로젝트 1조 nullnull</p>
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