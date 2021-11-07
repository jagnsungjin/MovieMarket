<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>ID/PW찾기</title>
    
   <script src="js/jquery-3.6.0.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/oky/okyjoin.css">   
<script>
$(document).ready(function () {   

   $(".findpw").click(function(){
	   $(".signupbtn").text('비밀번호 찾기');
	   $(".find").val("findpw");
   });	
   
   $(".findid").click(function(){
	   $(".signupbtn").text('아이디 찾기');
	   $(".find").val("findid");
   });	   
   
	$('.cancelbtn').click(function(){
		window.location ="index.jsp";
	})
   
   $("form").submit(function() {
	   if ($.trim($("#name").val()) =="") {
		   alert("이름을 입력 하세요");
		   $("#name").focus();
		   return false;
	   }
	   if ($.trim($("#birth").val()) =="") {
		   alert("생년월일을 입력 하세요");
		   $("#birth").focus();
		   return false;
	   }
	   if ($.trim($("#email").val()) =="") {
		   alert("이메일주소를 입력 하세요");
		   $("#email").focus();
		   return false;
	   }
  });
});  
   </script>
 
</head>
<body>
   <form name="findform" action="findProcess.oky" method="post">   
   <input type="hidden" class="find" id="find" value="findid" name="find"> <!-- 아이디, 비밀번호 찾기 버튼 클릭 시 value 값이 해당 값으로 변함 -->    
        <!-- header -->
        <div id="header">
            <img style="text-align: center; width: 200px; height: 200px;"  src="image/logo.png" id="logo">
        </div>

      <div class="wrap">
                 <button type="button" class="findid">아이디 찾기</button>&nbsp;&nbsp;&nbsp;&nbsp;
                 <button type="button" class="findpw">비밀번호 찾기</button><br>
      </div>
        <!-- wrapper -->
        <div id="wrapper">       
            <!-- content-->
            <div id="content">


                <!-- NAME -->
                <div>
                    <h3 class="join_title"><label for="name">이름</label></h3>
                    <span class="box int_name">
                        <input type="text" id="name" name="name" class="int" maxlength="20" placeholder="이름을 입력하세요">
                    </span>
                </div>

                <!-- BIRTH -->
                <div>
                    <h3 class="join_title"><label for="name">생년월일</label></h3>
                    <span class="box int_name">
                           <input type="text" placeholder="생년월일 앞 8자리를 입력하세요" name="birth"  id="birth" class="int">
                    </span>
                </div>                


                <!-- EMAIL -->
                     <div>
                    <h3 class="join_title"><label for="email">이메일</label></h3>
                    <span class="box int_name">
                           <input type="text" placeholder="이메일주소를 입력하세요" name="email"  id="email" class="int">
                    </span>
                    </div>
                <!-- JOIN BTN-->
                <div class="btn_area">
                    <button type="submit" id="btnJoin" class="signupbtn">
                        <span>아이디 찾기</span>
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
</body>
</html>