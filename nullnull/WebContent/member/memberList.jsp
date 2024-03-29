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
<title>회원관리 시스템 관리자모드(회원 목록 보기)</title>

   <script src="js/jquery-3.6.0.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/rv_css/list.css">

<%--
1. 검색어를 입락한 후 다시 memberList.net으로 온 경우 검색 필드와 검색어가 나타나도록 합니다.

2. 검색 필드를 변경하면 검색어 입력창에 placeholder 나타나도록 합니다.
   예로 아이디를 선택하면 placeholder로 "아이디 입력하세요"라고 나타나납니다.
   예로 이름을 선택하면 placeholder로 "이름 입력하세요"라고 나타나납니다.
   예로 나이를 선택하면 placeholder로 "나이 입력하세요"라고 나타나납니다.  
   예로 성별을 선택하면 placeholder로 "여 또는 남 입력하세요"라고 나타나납니다.
   
3. 검색 버튼 클릭시 다음을 체크합니다.
   1) 검색어를 입력하지 않은 경우 "검색어를 입력하세요" 라고 대화상자가 나타나게 합니다.
   2) 나이는 두 자리 숫자가 아닌 경우 "나이는 형식에 맞게 입력하세요 (두자리 숫자)" 라고 대화상자가 나타나게 합니다.
   3) 성별은 "남" 또는 "여"가 아닌 경우 "남 또는 여를 입력하세요" 라고 대화상자가 나타나게 합니다.
   
4. 회원 목록의 삭제를 클릭한 경우
   confirm("정말 삭제하시겠습니까?")를 실행해서 취소를 클릭하면 "memberDelete.net"로 이동하지 않습니다.   
 --%>
<script>
 $(function() {
	 //검색 클릭 후 응답화면에는 검색시 선택한 필드가 선택되도록 합니다.
	 var selectedValue = '${search_field}'
	 if(selectedValue != '-1')
		 $("#viewcount").val(selectedValue);
	 
	 //검색 버튼 클릭한 경우
	 $("button").click(function(){
     //검색어 공백 유효성 검사합니다.
       if($("input").val()==''){
    	   alert("검색어를 입력하세요");
    	   $("input").focus();
    	   return false;
       }
	 });//button click end
	 
	 //검색어 입력창에 placeholder 나타나도록 합니다.
	 $("#viewcount").change(function(){
		 selectedValue = $(this).val();
		 $("input").val('');
		 message=["아이디", "이름", "나이", "여 또는 남"]
		 $("input").attr("placeholder",message[selectedValue] + " 입력하세요");
	 })//$("#viewcount").change end
	 
	 
	 //회원 목록의 삭제를 클릭한 경우
	 $("tr > td:nth-child(3) > a").click(function (event){
		 var answer = confirm("정말 삭제하시겠습니까?");
		 console.log(answer); //취소를 클릭한 경우- false
		 if(!answer) {//취소를 클릭한 경우
			 event.preventDefault(); //이동하지 않습니다.
		 }
	 })//삭제 클릭 end
 })
</script>
<style>
.center-block{
text-align: center;
}
</style>
</head>
<body>
<div align="right"><a class="logout" href="logout.oky">${id} 님(로그아웃)</a>&nbsp;&nbsp;&nbsp;
<a class="nav-link" href="memberUpdate.oky">정보수정</a>&nbsp;&nbsp;&nbsp;
<a class="nav-link" href="http://localhost:8088/nullnull/">메인으로</a> </div>		

 <div class="page-title">
      

         <div class="container">
         
            <h1>회원 정보 게시판</h1>
         </div>
         <div class="container">
          <hr style="border: solid 6px black;">
         </div>
      </div>
  <div id="board-search">
        <form action="memberList.oky" method="post">
         <div class="container">
            <div class="search-window">
                  <div class="search-wrap">
                     <input name="search_word" type="text" class="form-control"
               			placeholder="아이디 입력하세요" value="${search_word}" >
                     <br> <select id="viewcount" name="search_field">
       						<option value="0" selected>아이디</option>
        					<option value="1" >이름</option>
        					<option value="2" >생년월일</option>
      						<option value="3" >휴대폰번호</option>
       					  </select> 
                     <div class="btn-wrap">
                        <input type="submit" id="searchbtn" class="btn" value="검색">
                     </div>
                  </div>
            </div>
         </div>
         </form>
      </div>

      <!-- board list area -->
      <div id="board-list">
         <div class="container">
         <c:if test="${listcount > 0}"> <%-- 회원이 있는 경우 --%>
            <table class="board-table">
               <thead>
               <tr>
        		<th  colspan="2">회원 정보 리스트</th>
        		<th>
            	<font size=3>회원 수 : ${listcount}</font>
       		    </th>
      			</tr>
                  <tr>
                    <th>아이디</th><th>이름</th><th>이메일</th><th>삭제</th>
                  </tr>
               </thead>
               <tbody>
                   <c:forEach var="m" items="${totallist}">
             <tr>
             <td>
               <a href="memberInfo.oky?id=${m.id}">${m.id}</a>
           </td>
          <td>${m.name}</td>
          <td>${m.email}
          <td><a href="memberDelete.oky?id=${m.id}">삭제</a></td>
          </tr>
         </c:forEach>   
           </tbody>
         </table>
</c:if>
<div class="center-block">
      <ul class="pagination justify-content-center">
        <c:if test="${page <= 1 }">
            <li class="page-item">
              <a class="page-link current" href="#">이전&nbsp;</a>
            </li>
        </c:if>
        <c:if test="${page > 1 }">
             <li class="page-item">
<a href="memberList.net?page=${page-1}&search_field=${search_field}&search_word=${search_word}"
               class="page-link">이전</a>&nbsp;
          </li>
       </c:if>
       
       <c:forEach var="a" begin="${startpage}" end="${endpage}">
           <c:if test="${a == page }">
               <li class="page-item">
                   <a class="page-link current" href="#" >${a}</a>
               </li>
           </c:if>
           <c:if test="${a != page }">
               <li class="page-item">
        <a href="memberList.net?page=${a}&search_field=${search_field}&search_word=${search_word}"
               class="page-link">${a}</a>       
              </li>
           </c:if>
       </c:forEach>        
       
      <c:if test="${page >= maxpage }">
          <li class="page-item">
              <a class="page-link current" href="#">&nbsp;다음</a>
          </li>
      </c:if>
      <c:if test ="${page < maxpage}">
         <li class="page-item">    
        <a href="memberList.net?page=${page+1}&search_field=${search_field}&search_word=${search_word}"
               class="page-link">&nbsp;다음</a>    
        </li>
       </c:if>  
      </ul>
     </div>
</div>
</div>
<%-- 회원이 없는 경우 --%>
 <c:if test="${listcount == 0 && empty search_word}">
   <h1> 회원이 없습니다.</h1>
 </c:if>
 
 <c:if test="${listcount == 0 && !empty search_word}">
   <h1> 검색결과가 없습니다.</h1>
 </c:if>
</body>
</html>