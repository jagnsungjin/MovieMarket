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
    <title>회원정보</title>
   <script src="js/jquery-3.6.0.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
body{
    margin-top:20px;
    color: #1a202c;
    text-align: left;
    background-color: #e2e8f0;    
}
.main-body {
    padding: 15px;
}
.card {
    box-shadow: 0 1px 3px 0 rgba(0,0,0,.1), 0 1px 2px 0 rgba(0,0,0,.06);
}

.card {
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 0 solid rgba(0,0,0,.125);
    border-radius: .25rem;
}

.card-body {
    flex: 1 1 auto;
    min-height: 1px;
    padding: 1rem;
}

.bg-gray-300 {
    background-color: #e2e8f0;
}
.h-100 {
    height: 100%!important;
}
.shadow-none {
    box-shadow: none!important;
}
.backbtn{
	background-color:lightblue;
}
</style>
</head>
<body>
<!-- 
 <div class="container">
   <table class="table table-bordered"> 
   <tr>
       <td>아이디</td>
       <td>${memberinfo.id}</td><%-- Member 클래스의 getId()메서드 호출 --%>
  </tr>
  <tr>
       <td>비밀번호</td>
       <td>${memberinfo.pass}</td>
   </tr>
   <tr>
       <td>이름</td>
       <td>${memberinfo.name}</td>
   </tr>
   <tr>
       <td>생년월일</td>
       <td>${memberinfo.birth}</td>
   </tr>
   <tr>
       <td>전화번호</td>
       <td>${memberinfo.phone}</td>
   </tr>
   <tr>
       <td>이메일주소</td>
       <td>${memberinfo.email}</td>
  </tr>
  <tr>
        <td colspan="2" >
        <a href="memberList.oky">리스트로 돌아가기</a></td>
  </tr>
</table>
</div>
-->
<div align="center">
  <a href="http://localhost:8088/nullnull/"><img style="text-align: center; height:85px; width:150px" src="image/logo.png" ></a>
</div>
<div class="container">
    <div class="main-body">
          <!-- /Breadcrumb -->
          <div class="row gutters-sm" style="float: none; margin:100 auto;">
            <div class="col-md-6 mb-3" style="float: none; margin:0 auto;">
              <div class="card">
                <div class="card-body">
                  <div class="d-flex flex-column align-items-center text-center">
                  	<c:if test="${empty memberinfo.memberfile}">
                  	<img  src="image/profile.png" alt="프로필 사진"  class="rounded-circle" width="150">
                    </c:if>
                    <c:set var="profile" value="${memberinfo.memberfile}"/>
                    <c:if test="${!empty memberinfo.memberfile}">
                    <img src="memberupload/${profile}" alt="프로필 사진"  class="rounded-circle" width="150">
                    </c:if>
                    <div class="mt-3">
                      <h4>${memberinfo.name}</h4>
                      <p class="text-muted font-size-sm">${memberinfo.email}</p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                    <h6 class="mb-0"><b>아이디</b></h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      ${memberinfo.id}
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                  <div class="col-sm-3">
                     <h6 class="mb-0"><b>이름</b></h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      ${memberinfo.name}
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <h6 class="mb-0"><b>비밀번호</b></h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      ${memberinfo.pass}
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <h6 class="mb-0"><b>생년월일</b></h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                     ${memberinfo.birth}
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <h6 class="mb-0"><b>전화번호</b></h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      ${memberinfo.phone}
                    </div>
                  </div>
                  <hr>
					<div class="row">
                    <div class="col-sm-3">
                      <h6 class="mb-0"><b>이메일주소</b></h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                    	${memberinfo.email}
                    </div>
                  </div>
                  
           		  <button type="button" class="backbtn" id="btnCancel"
           		  		  onclick="location.href='memberList.oky'">
           	   		<span>이전</span>
           		 </button>          
            	</div>
                </div>
              </div>
            </div>
     </div>  
  </div>
</body>
</html>