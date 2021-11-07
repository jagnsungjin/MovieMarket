 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>회원가입</title>
   <script src="js/jquery-3.6.0.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/oky/okyjoin.css">
<script src="js/fr_js/validate.js"></script> <!-- 회원가입 자바스크립트 폼 -->
<script>
$(function () {	
	$("#searchck").click(function(){
		$("#idck").val($("#id").val());
		$("#okuse").hide();
	});
	
	$("#search").click(function(){
        $.ajax({
      	  url : "idCheck.oky",
      	  data : {"idck" : $("#idck").val()},
      	  success : function(resp) {
      		  if (resp == -1) {//db에 해당 id가 없는 경우
      			  $("#message").css('color', 'green').html(
      					  "사용 가능한 아이디 입니다.");
      			$("#okuse").show();
      		  } else {//db에 해당 id가 있는 경우(0)
      		    $("#message").css('color','red').html(
      		    		"사용중인 아이디 입니다.");
      		  $("#okuse").hide();
      		  }
      	  }
       	  
        });//ajax end
	});	

	$("#okuse").click(function(){
		$("#id").val($("#idck").val());

	});
})
</script>

 </head>
    <body>
   <form name="joinform" action="joinProcess.oky" method="post">    
    
        <!-- header -->
        <div id="header">
            <img style="text-align: center; width: 200px; height: 200px;"  src="image/logo.png" id="logo">
        </div>


        <!-- wrapper -->
        <div id="wrapper">

            <!-- content-->
            <div id="content">
                <!-- ID -->
                <div>
                    <h3 class="join_title">
                        <label for="id">아이디</label>
                    </h3>
                    <span class="box int_id">
                        <input type="text" id="id" name="id" class="int" maxlength="20" placeholder="아이디를 입력하세요">
                        <span class="step"><a href="#" data-toggle="modal"  data-target="#idcheck" id="searchck">중복확인</a></span>
                    </span>
                </div>

                <!-- PW1 -->
                <div>
                    <h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
                    <span class="box int_pass">
                        <input type="password" id="pass" name="pass" class="int" maxlength="20" placeholder="비밀번호를 입력하세요" >
                    </span>
                </div>

                <!-- PW2 -->
                <div>
                    <h3 class="join_title"><label for="pswd2">비밀번호 재확인</label></h3>
                    <span class="box int_pass_check">
                        <input type="password" id="passck" name="passck" class="int" maxlength="20" placeholder="비밀번호를 다시 입력하세요">
                    </span>
                </div>

                <!-- NAME -->
                <div>
                    <h3 class="join_title"><label for="name">이름</label></h3>
                    <span class="box int_name">
                        <input type="text" id="name" name="name" class="int" maxlength="20" placeholder="이름을 입력하세요">
                    </span>
                </div>

                <!-- BIRTH -->
                <div>
                    <h3 class="join_title"><label for="yy">생년월일</label></h3>

                    <div id="bir_wrap">
                        <!-- BIRTH_YY -->
                        <div id="bir_yy">
                            <span class="box">
                                <input type="text" id="year" name="year" class="int" maxlength="4" placeholder="년(4자)">
                            </span>
                        </div>

                        <!-- BIRTH_MM -->
                        <div id="bir_mm">
                            <span class="box">
                                <select id="month" name="month" class="sel">
                                    <option value="월">월</option>
                                    <option value="01">01</option>
                                    <option value="02">02</option>
                                    <option value="03">03</option>
                                    <option value="04">04</option>
                                    <option value="05">05</option>
                                    <option value="06">06</option>
                                    <option value="07">07</option>
                                    <option value="08">08</option>
                                    <option value="09">09</option>                                    
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </span>
                        </div>

                        <!-- BIRTH_DD -->
                        <div id="bir_dd">
                            <span class="box">
                                <input type="text" id="date" name="date" class="int" maxlength="2" placeholder="일">
                            </span>
                        </div>

                    </div>    
                </div>


                <!-- EMAIL -->
                     <div>
                    <h3 class="join_title"><label for="email">이메일</label></h3>

                    <div id="email_wrap">
                    
                    <div id="email_id">
                    <span class="email">
                        <input type="text" id="email" name="email" class="int" maxlength="100" placeholder="아이디"><span class="step_url">@</span>
                    </span> 
                        </div>

                    <div id="email_add1">
                            <span class="box">
                                <input type="text" class="int" placeholder="주소를 입력하세요" name="domain" id="domain"> 
                            </span>
                    </div>
                   
                    <div id="email_add2">
                            <span class="box">
                                <select id="sel" name="sel" class="sel">
                                  <option value="">직접입력</option>
                                  <option value="naver.com">naver.com</option>
                                  <option value="daum.net">daum.net</option>
                                  <option value="nate.com">nate.com</option>
                                  <option value="gmail.com">gmail.com</option>
                                </select>
                            </span>
                     </div>
                    </div>    
                </div>               

                <!-- MOBILE -->
                <div>
                    <h3 class="join_title"><label for="phoneNo">휴대전화</label></h3>
                    <span class="box int_mobile">
                        <input type="text" id="phone" name="phone" class="int" maxlength="11" size="11" placeholder="01012345678">
                    </span>   
                </div>

     <br><label><b>자동가입방지문자</b></label><br>
     <input type="text" size=6  name="che" id="che" readOnly>
     <input type="button" value="문자생성 " id="code">
     <input type="text" size=6 maxLength="6" name="output" id="output">
     <input type="button" value="문자확인" id="ckcode">

    


                <!-- JOIN BTN-->
                <div class="btn_area">
                    <button type="submit" id="btnJoin" class="signupbtn">
                        <span>가입하기</span>
                    </button>
                    <button type="button" id="button" class="cancelbtn">
                        <span>취소</span>                        
                    </button>
                </div>
 
            <!-- content-->

        </div> 
        <!-- wrapper -->
        </div>
   </form>
   
   
  <div class="modal fade" id="idcheck" role="dialog"> <!-- 사용자 지정 부분① : id명 -->

    <div class="modal-dialog">
   
      <!-- Modal content-->

      <div class="modal-content">

        <div class="modal-header">

          <button type="button" class="close" data-dismiss="modal" >×</button>

          <h4 class="modal-title" align="center">아이디 중복 확인</h4> <!-- 사용자 지정 부분② : 타이틀 -->

        </div>

        <div class="modal-body">
                   <form id="my-form">
                   <input type ="text" name="idck" id="idck" placeholder="아이디 입력">            
                   <button type="button" id="search" class="searchid" >검색</button><br>
                   <span id="message"></span>
                   </form>
        </div>
      <!-- 사용자 지정 부분③ : 텍스트 메시지 -->

        </div>

        <div class="modal-footer">
        <button type="button"  id="okuse"  data-dismiss="modal">사용하기</button><br>

        </div>

      </div>

    </div>        
    </body>
</html>