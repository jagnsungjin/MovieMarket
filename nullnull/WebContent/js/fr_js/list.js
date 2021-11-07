function go(page) {
	var view = $("#view").val(); //최신순부터 값은 1~3
	var search = $("#search").val(); //검색어
	var setype = $("#searchType").val(); //검색어 타입
	
	console.log(search)
	console.log(setype)
	console.log(view)
	console.log(page)
	

	if (!$("#search").val()) {
	var data = "view=" + view + "&state=ajax&page=" + page;	
	} else {
	var data = "view=" + view + "&state=ajax&page=" + page + "&type=" + setype + "&search=" + search;	
	}
	
	console.log(data)
	ajax(data);
}


function setPaging(href, digit) {
	var output ="<li class=page-item>";
	gray="";
	if(href=="") {
		gray = " gray";
	}
	anchor = "<a class='page-link" + gray + "'" + href + ">" + digit + "</a></li>";
	output += anchor;
	return output;
}

function ajax(sdata) {
	var cate = $("#category").val(); //분류가 전체부터 값은 null~5
	console.log(cate)
	var add ="";
	if (cate ==1) {
		add = "FrList1.okybo"
	}
	else if (cate ==2) {
		add = "FrList2.okybo"
	}
	else if (cate ==3) {
		add = "FrList3.okybo"
	}
	else if (cate ==4) {
		add = "FrList4.okybo"
	}
	else if (cate ==5) {
		add = "FrList5.okybo"
	} else {
		add = "Freeboard.okybo"
	}
	console.log(add)
	console.log(sdata)
	output = "";
	$.ajax({
		type : "POST",
		data : sdata,
		url : add,
		dataType : "json",
		cache : false,
		success : function(data) {
			$("table").find("font").text("글 개수: " + data.listcount);
			
			if (data.listcount> 0) { //총 갯수가 0보다 큰 경우
				$("tbody").remove();
				var num = data.listcount - (data.page - 1) * data.limit;
				console.log(num)
				var output = "<tbody>";
				$(data.boardlist).each(
						function(index, item) {
						    output += '<tr><td>' + (num--) + '</td>'
						    blank_count = item.fr_re_lev * 2 + 1;
						    blank = '&nbsp;';
						    for (var i =0 ; i < blank_count; i++){
						    	blank += '&nbsp;&nbsp;';
						    }
						    if (item.fr_csfc == 1){
						    	output += '<td><div>잡담</div></td>'						    						    	
						    } else if (item.fr_csfc == 2){
						    	output += '<td><div>이벤트</div></td>'			
						    } else if (item.fr_csfc == 3){
						    	output += '<td><div>궁금해요</div></td>'			
						    } else if (item.fr_csfc == 4){
						    	output += '<td><div>정보</div></td>'			
						    } else if (item.fr_csfc == 5){
						    	output += '<td><div>기사</div></td>'			
						    }
						    output += "<td><div>" + blank 
						    output += ' <a href="FreeboardDetailAction.okybo?num=' + item.fr_no + '">'
						    output += item.fr_subject.replace(/</g,'&lt;').replace(/>/g,'&gt;')
						              + '</a></div></td>'
						    output += '<td><div>' + item.id + '</div></td>'
						    output += '<td><div>' + item.fr_date + '</div></td>'
						    output += '<td><div>' + item.fr_read + '</div></td>'
						})
				   output += "</tbody>"
				   $('table').append(output) //table 완성
				   
				   $(".pagination").empty(); //페이징 처리 영역 내용 제거
				   output = "";
				   
				   digit = '이전&nbsp;'
				   href="";
				   if (data.page > 1) {
					   href = 'href=javascript:go(' + (data.page - 1) + ')';
				   }
				   output += setPaging(href, digit);
				   
				   for (var i = data.startpage; i <= data.endpage; i ++) {
					   digit = i;
					   href= "";
					   if (i != data.page) {
						   href = 'href=javascript:go(' + i + ')';
					   }
					   output += setPaging( href, digit);
				   }
				   digit = '&nbsp;다음&nbsp;';
				   href="";
				   if (data.page < data.maxpage) {
					   href = 'href=javascript:go(' + (data.page + 1) + ')';
				   }
				   output += setPaging( href, digit);
				   $('.pagination').append(output)				
			}//if(data.listcount) end
			else { //카테고리에 글이 없는 경우
				$("tbody").remove();
				var output = "<tbody>";
				output += "<tr><td colspan=6><div>등록된 글이 없습니다.</div></td></tr>"
				 output += "</tbody>"
					   $('table').append(output)
				$(".pagination").empty();
			}
			
		}, //succes end
		error: function() {
			console.log('에러')
		}
	})// ajax end
}//function ajax end

$(function() {
	$("#view").change(function(){ //최신순, 등록순, 조회순 변경 시
		$("#search").val("");
		go(1); 
	}); 
		
	$("#write").click(function(){
	    	  location.href="FreeboardWrite.okybo";
	   });
	
	$("#searchbtn").click(function(){
		if (!$("#search").val()){
			return false
		} else {			
			go(1);
		}
	})
});   
