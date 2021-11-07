function getList(state){
	option=state; // 1 =등록순 2=아트박스
	$('.movie_list').html("");
	$('.movie_tab_button').css("pointer-events",'none');
	$('.loading-container').show();
	$.ajax({
		type:"post",
		url:"moivelist.mo",
		data : {state : state},
		dataType: "json",
		success:function(rdata){
			$('.loading-container').hide();
			var red1='red';		var red2='red';
			if(option==1){  //등록순인 경우 등록순이 'red', 최신순이 'gray'로 글자색을 나타냅니다.
				red2='gray';
			}else if(option==2){ //최신순인 경우 등록순이 'gray', 최신순이 'red'로 글자색을 나타냅니다.
				red1='gray';
			}//else if ind
			var output="";
			var output2="";
			 if(rdata.movielist.length>0){
				   output += '<li class="movie_tab_item" >'
                        + '   <a style="color : ' +  red1 + '; text-decoration: none;" href="javascript:getList(1)" class="movie_tab_button">예매순 </a>'
                        + '</li>'
                        + '<li>&nbsp;&nbsp;&nbsp;</li>'
                        + '<li class="movie_tab_item ' +  red2 + '" >'
                        + '   <a style="color : ' +  red2 + '; text-decoration: none;" href="javascript:getList(2)" class="movie_tab_button">아트하우스</a>'
                        + '</li>';
                   $('.movie_tab_list').html(output);//댓글 수 등록순 최신순 출력
                   output2='';
                   output='';
                   var num=100;
                   $(rdata.movielist).each(function(){          	   
                	  num++;
                	output+='<li class="movie_list_li" id="'+num+'" value="'+this.name+'">'+this.name+'</li>';
                	output+='<li class="fakeli" id="f'+num+'"></li>';
                    output2=this.src;	

                   })//each end
                   $('.movie_list').html(output);
                   
                   var num=100;
                   $(rdata.movielist).each(function(){          	   
                	num++;
                	output2=this.src;
                	$('#f'+num).text(output2);
                   })//each end
                   

			 }// if(rdata.boardlist.length>0){ end
		}//success end
		
	});//ajax end
	
}
function movieSelect(data, src){
	$('#'+data).addClass('movienames')
	$('.movienames').css('background','');
	$('#'+data).css('background','red');
	var name = $('#'+data).text();
	changename(name);
	$("#view").attr("src",src);
}

function changename(data){
	$('#moviename').text(data);
}

function changeplace(data){
	$('#movieplace').text(data);
}

function DateSelect(data){//onclick 부분 id값 받아옴
    var only = today.getFullYear()+""+(today.getMonth()+1)+"" //년도와 월
	var num = $('#'+data).text();	//선택한 id의 값가져오기 (일)
    if(num<10){
    	num = "0"+num;
    }
    var nonly =parseInt(only+num);	//숫자변환  => 년도 월 일 (선택한 년도)
    
    var d = new Date();
    var year	= d.getFullYear(); //연도
    var month	= d.getMonth()+1;	//월
    var date	= d.getDate();
    if(date<10){
    	date = "0"+date;
    }
    var dstring = year+""+month+""+date;
    var nnum =parseInt(dstring); //오늘 날짜 숫자로
    if(nonly>=nnum){
    	changedate(num);
    	$('.times').show();
    	$('.cal').css('background','');
    	$('#'+data).css('background','red');
    }
	
}
function changedate(data){
	YYNN = today.getFullYear() + "-"+ (today.getMonth() + 1) + "-";
	$('#moviedate').text(YYNN + data);	

}


function TimeSelect(data){

	$('#'+data).addClass('timess')
	$('.timess').css('background','');
	$('#'+data).css('background','red');
	name = $('#'+data).text().substring(2);
	$('#movietime').text(name);
}

$(function() {
	$('.times').hide();
	//fakeli
	$(document).on("click",".movie_list_li",function(event){
		var data = $(this).text();
		var dataid = $(this).attr('id');
		$('#moviename').text(data);
		$('.movie_list_li').css('background','');
		$(this).css('background','red');
		var fsrc = $('#f'+dataid).text();
		$("#view").attr("src",fsrc);
	})
	
	
	$('.button1').click(function(){
		var data = $(this).text();
		$('#moviepeoples').text(data+"명");
		$('.button1').css('background','');
		$(this).css('background','red');
	})
	$('.mplace').click(function(){
		var data = $(this).text();
		$('.mplace').css('background','');
		$(this).css('background','red');
		$('#movieplace').text(data);
	})

	$('#buttonsub').click(function(){
		
		$('#img').attr("value", $("#view").attr("src"));
		$('#name').attr("value", $("#moviename").text());
		$('#place').attr("value", $("#movieplace").text());
		$('#date').attr("value", $("#moviedate").text());
		$('#time').attr("value", $("#movietime").text());
		$('#count').attr("value", $("#moviepeoples").text());
		var formbtn = document.movieinfo
		
		if($('#sessionid').text() ==""){
			alert('아이디를 입력하세요');
			return false;
		}
		if($.trim($("input").eq(1).val()) == ""){
			alert("영화를 선택하세요");
			return false;
		}
		if($.trim($("input").eq(2).val()) == ""){
			alert("극장을 선택하세요");
			return false;
		}
		if($.trim($("input").eq(3).val()) == ""){
			alert("날짜를 선택하세요");
			return false;
		}
		if($.trim($("input").eq(4).val()) == ""){
			alert("시간대를 선택하세요");
			return false;
		}
		if($.trim($("input").eq(5).val()) == ""){
			alert("사람수를 선택하세요");
			return false;
		}
		formbtn.submit();
	})
$(document).ready(function(){
	option =1;
	getList(option);
	
	
	
})
})


