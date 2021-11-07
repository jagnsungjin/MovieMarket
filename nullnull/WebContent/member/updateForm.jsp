<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="new_main.css">
   
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>회원정보 수정페이지</title>
   <script src="js/jquery-3.6.0.min.js"></script>
<style>
html {
    height: 100%;
}

body {
    margin: 0;
    height: 100%;
    background: #f5f6f7;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}
#logo {
    width: 240px;
    height: 44px;
    cursor: pointer;
}

#header {
    padding-top: 62px;
    padding-bottom: 20px;
    text-align: center;
}
#wrapper {
    position: relative;
    height: 100%;
}

#content {
    position: absolute;
    left: 50%;
    transform: translate(-50%);
    width: 460px;
}
h4 {
  text-align: center;
}

h3 {
    margin: 19px 0 8px;
    font-size: 14px;
    font-weight: 700;
    text-align: left;
}


.box {
    display: block;
    width: 100%;
    height: 51px;
    border: solid 1px #dadada;
    padding: 10px 14px 10px 14px;
    box-sizing: border-box;
    background: #fff;
    position: relative;
}

.int {
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;
}
.btn_area {
    margin: 30px 0 91px;
}

#btnModify {
    width: 49%;
    padding: 19px 0 15px;
    border: 0;
    cursor: pointer;
    color: #fff;
    background-color: #08a600;
    font-size: 20px;
    font-weight: 400;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}

#btnCancel {
    width: 49%;
    padding: 19px 0 15px;
    border: 0;
    cursor: pointer;
    color: #fff;
    background-color: red;
    font-size: 20px;
    font-weight: 400;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
} 
input[type=file]{
  	display:none;
}

</style>
<script>
$(document).ready(function () {   
	
$("#phone").keyup(function () {
	if($("#phone").val().length == 11){
		pattern = /^[0][1][0][0-9]{8}$/;
		if(!pattern.test($("#phone").val())){
			alert("형식에 맞게 입력하세요");
			$("#phone").val('').focus();				
		}
	}
}); 
var check=0;
 $('form').submit(function () {

	  	  
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
	   
	   if ($("#birth").val().length !=8 || isNaN($.trim($("#birth").val())) ==true) {
		   alert("생년월일을 형식에 맞게 입력 하세요");
		   $("#birth").val('').focus();
		   return false;
	   }
	   
		if ($.trim($("#phone").val()) =="" ) {
			alert("휴대폰번호를 입력하세요");
			$("#phone").focus();
			return false;
		}
		
		if ($("#phone").val().length != 11) {
			alert("휴대폰번호를  다시 입력하세요");
			$("#phone").val('').focus();
			return false;
		}
		
		if ($.trim($("#email").val()) =="") {
			   alert("E-mail 주소를 입력하세요");
			   $("#email").focus();
			   return false;
		   }
	  
	  if (check == 0) {
		  value = $('#filename').text();
		  html = "<input type='text' value='" + value + "' name='check'>";
		  $(this).append(html);
	  }
	  
 }); //submit
 
 
 $('input[type=file]').change(function(event) {
	      check++;
	      var inputfile = $(this).val().split('\\');
	      var filename=inputfile[inputfile.length - 1];
	      var pattern = /(gif|jpg|jpeg|png)$/i; //플래그 i는 대소문자 구분 없는 검색
	      if (pattern.test(filename)) {
	    	  $('#filename').text(filename); //inputfile.length - 1 =2
	    	  
	    	  var reader = new FileReader(); //파일을 읽기 위한 객체 생성(FileReader는 자바스크립트 자체서 제공)
	    	//DataURL 형식으로 파일을 읽어옵니다.
	    	//읽어온 결과는 reader객체의 result 속성에 저장됩니다.
	    	//event.target.files[0] : 선택한 그림의 파일객체에서 첫번째 객체를 가져옵니다.
	    	   reader.readAsDataURL(event.target.files[0]);
	
	           reader.onload = function (event) { //읽기에 성공했을 때 실행되는 이벤트 핸들러
	        	   $('#showImage').html('<img width="20px" src="'
	        			                + event.target.result + '">');
	           };  
	      } else {
	    	  alert('확장자는 gif, jpg, jpeg, png가 가능합니다.');
	    	  check=0;
	      }
 })// $('input[type=file]').change() end
 
	$('.cancelbtn').click(function(){
		window.location ="index.jsp";
	})
 
});
</script>   
</head>
<body>

<form name="joinform" action="updateProcess.oky" method="post"
      enctype="multipart/form-data">
<div id="header"> 
 <a href="http://localhost:8088/nullnull/"><img style="text-align: center; height:80px; width:150px" src="image/logo.png" ></a>
<h4 class="mb-3">회원 정보 수정</h4>
	<div id="wrapper">
    	<div id="content"><br>
    		<div>
			<h3>
			  <label for="id">아이디</label>
			</h3>
			<span class="box">
			  <input type="text" id="id" name="id" class="int"
			   		 value="${memberinfo.id}" maxlength="20" readOnly>
			</span>
			</div>
			
			<div>
			<h3>
			  <label for="pass">비밀번호</label>
			</h3>
			<span class="box">
			  <input type="password" id="pass" name="pass" class="int"
			   		 value="${memberinfo.pass}" maxlength="20" readOnly>
			</span>
			</div>
			
			<div>
			<h3>
			  <label for="name">이름</label>
			</h3>
			<span class="box">
			  <input type="text" id="name" name="name" class="int" placeholder="이름을 입력하세요"
			   		 value="${memberinfo.name}" maxlength="20" required>
			</span>
			</div>
			
			<div>
			<h3>
			  <label for="birth">생년월일</label>
			</h3>
			<span class="box">
			  <input type="text" id="birth" name="birth" class="int" placeholder="생년월일 8자를 입력하세요"
			   		 value="${memberinfo.birth}" maxlength="20">
			</span>
			</div>
			
			<div>
			<h3>
			  <label for="phone">휴대폰 번호</label>
			</h3>
			<span class="box">
			  <input type="text" id="phone" name="phone" class="int" placeholder="01012345678"
			   		 value="${memberinfo.phone}" maxlength="20">
			</span>
			</div>
			 
			<div>
			<h3>
			  <label for="email">이메일</label>
			</h3>
			<span class="box">
			  <input type="text" id="email" name="email" class="int" placeholder="이메일을 입력하세요"
			   		 value="${memberinfo.email}" maxlength="20" required>
			</span>
			</div>
			
		 <h3>프로필 사진</h3>
      	 <label>
          <img src="image/attach.png" width="20px" align="left">
          <span id="filename">${memberinfo.memberfile}</span>
          <%-- memberinfo.memberfile의 값이 없으면 기본 사진을 보여줍니다.
                              값이 존재하면 memberupload 폴더에 존재하는 파일명으로 경로를 설정합니다. --%>
          <span id="showImage">
            <c:if test='${empty memberinfo.memberfile}'>
             <c:set var='src' value='image/profile.png'/>
            </c:if>
           <c:if test='${!empty memberinfo.memberfile}'>
             <c:set var='src' value='${"memberupload/"}${memberinfo.memberfile}'/>
            </c:if>
            <%-- 위에서 memberinfo.memberfile의 값이 있는 경우와 없는 경우에 따라 src 속성값이 달라집니다. --%>
            <img src="${src}" width="30px" alt="profile" align="left">
          </span>
          <input type="file" name="memberfile" accept="image/*">
      	 </label><br>

         <div class="btn_area">
           <button type="submit" id="btnModify">
               <span>수정</span>
           </button>
           <button type="button" class="cancelbtn" id="btnCancel">
           	   <span>취소</span>
           </button>           
         </div> 
        </div>
    </div>
</div>
</form>
</body>
</html>
