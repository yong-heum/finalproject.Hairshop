<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<!--    	<script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<!--   	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>



	
<script>
// 매장, 디자이너 검색

	var shopNameCheck=0;
	var disignerCheck=0;
	
/* 매장이름 불러오기  */
function shopName_Call() {
	
	var shopName = document.getElementById("shopName"); // 매장이름 검색텍스트
	var shopName_Search = document.getElementById("shopName_Search"); //검색 버튼
	
	/*ajax : Asynchronous JavaScript and XML(비동기 처리를 위한 자바스크립트)
	     ajax는 JSON 형식으로 데이터 전송
	        - JSON(JavaScript Object Notation) : 자바 스크립트 객체 표기법
	 */

	 
	$.ajax({
		type : "post", /* get인지 post인지 결정 */
		url : "shopName_Call", /* 컨트롤러 주소 (목적지) */
		data : {
			"shopName" : shopName.value
		}, /* 내가 보내줄 데이터 *//* 처음 id는 내가정해주는 파라미터이름. 두번째 id는 위에 선언한 변수이름. */
		dataType : "json", /* 보내줄 데이터 타임  */
		success : function(data) { /* 통신이 성공했을때  */
			
			if (data == '') {
				shopName_Text.innerHTML = "검색 결과가 없습니다. 다시 검색해 주세요.";
			}
			else {
				shopName_Text.innerHTML += "<input type='radio' name='shopName_Text' id='shopName_Text_id"+i+"' value='"+data[0]+"'><label for='shopName_Text_id"+i+"' checked='checked'>"+data[0]+"</label><br>"
				
				for(var i=1; i<Object.keys(data).length; i++ ){		
				shopName_Text.innerHTML += "<input type='radio' name='shopName_Text' id='shopName_Text_id"+i+"' value='"+data[i]+"'><label for='shopName_Text_id"+i+"'>"+data[i]+"</label><br>"
				}		
				}
		},
		error : function() { /* 통신이 실패했을때 */
			alert("Overlap 함수 통신 실패!!");
		}
	});
				shopName_Text.innerHTML = "";
	 
}


//모달창에서 선택한 값을 텍스트로 이동후 수정 못하게 함. 
$(document).ready(function() {
$("#shopName_Text_Check").click(function(){
	
	var shopName = $("#shopName"); // 매장이름 검색텍스트
	var shopName_Text_id = $('input[name="shopName_Text"]:checked').val();
	
	if(shopName_Text_id!=null){
		
	$('#shopName').val(shopName_Text_id).attr('readonly',true);
	shopNameCheck=1;
	
	}else{
	}
});
});
	
	
//모달창에서 가져온 매장이름 값으로 디자이너 정보,매장pid 불러옴
$(document).ready(function() {
	
$("#shopName_Text_Check").click(function(){
	
	var shopName = document.getElementById("shopName"); // 매장이름 검색텍스트
	var disigner_Text = document.getElementById("disigner_Text");
	
	if(shopNameCheck==1){
		
		$.ajax({
			type : "post", /* get인지 post인지 결정 */
			url : "shopDisigner_Call", /* 컨트롤러 주소 (목적지) */
			data : {
				"shopName" : shopName.value
			}, /* 내가 보내줄 데이터 *//* 처음 id는 내가정해주는 파라미터이름. 두번째 id는 위에 선언한 변수이름. */
			dataType : "json", /* 보내줄 데이터 타임  */
			success : function(data) { /* 통신이 성공했을때  */
				if (data == '') {
					disigner_Text.innerHTML = "이 매장은 디자이너가 없습니다.<br>";
					$('#shopName').attr('readonly',false);
				} else if (data != null) {
					disigner_Text.innerHTML +="<br>";
					for(var i=0; i<Object.keys(data).length; i++ ){		
						disigner_Text.innerHTML += "<input type='radio' name='disigner' id='disigner_Text"+i+"' onclick='closeds_List()' value='"+data[i].name+"'><label for='disigner_Text"+i+"'>"+data[i].name+"</label>&nbsp;&nbsp;&nbsp;&nbsp;"
					}
				}
			},
			error : function() { /* 통신이 실패했을때 */
				alert("Overlap 함수 통신 실패!!");
			}
		});
			disigner_Text.innerHTML = "";
	}	
	});
});

</script>


<script>
  // 특정 휴무 날짜들 배열
    var disabledDays = "";
  
  //디자이너의 휴무 정보를 가져옴 
  function closeds_List(){
  $(document).ready(function() {
  
	var shopName = $("#shopName").val();
	var disigner = $('input[name="disigner"]:checked').val();
		$.ajax({
			type : "post", /* get인지 post인지 결정 */
			url : "closeds_List", /* 컨트롤러 주소 (목적지) */
			data : {
				"shopName" : shopName,
				"disigner" : disigner
			}, /* 내가 보내줄 데이터 *//* 처음 id는 내가정해주는 파라미터이름. 두번째 id는 위에 선언한 변수이름. */
			dataType : "json", /* 보내줄 데이터 타임  */
			success : function(data) { /* 통신이 성공했을때  */
			
			disabledDays = data;
			disignerCheck=1;
			},
			error : function() { /* 통신이 실패했을때 */
				alert("Overlap 함수 통신 실패!!");
			}
		});
  });
  }

//매장이름과 디자이너 선택 후에만 날짜를 선택 
jQuery(function($){
	$("#datepicker1").click(function(){
	if(disignerCheck==0){
		alert("매장과 디자이너를 먼저 선택해 주세요.");
	}else{
// datePicket사용

    $("#datepicker1").datepicker({
    	 minDate: 0,
        changeMonth:true,
        changeYear:true,
        showOn:"both",
        buttonImage:"resources/menu_photo/캡처.PNG",
        buttonImageOnly:true,
        yearSuffix: '년',
        dateFormat: 'yy-mm-dd',
        showOtherMonths: true,
        selectOtherMonths: true,
        showMonthAfterYear: true,
        dayNamesMin: ['일','월', '화', '수', '목', '금', '토'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
        nextText: '다음 달',
        prevText: '이전 달',
        beforeShowDay: disableAllTheseDays
    });
$("#datepicker1").datepicker().datepicker("show");
     
	}
	});
});
     
    // 이전 날짜들은 선택막기
    function noBefore(date){
        if (date < new Date()){
            return [false];}
        else{
        return [true];}
    }
     
    // 특정일 선택막기
    function disableAllTheseDays(date) { 
        var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
        for (i = 0; i < disabledDays.length; i++) {
            if($.inArray(y + '-' +(m+1) + '-' + d,disabledDays) != -1) {
                return [false];
            }
        }
        return [true];
    }

// submit버튼 눌럿을때 확인후 데이터 보내기
    function ticketingJSP_2_submit(){
		
    	if($('#shopName').val()==""||$('#datepicker1').val()==""||$('input[name="disigner"]:checked').val()==''){
    		 alert('작성하지 않은 부분이 있는지 확인하세요.');
    		 return false;
    	}
    	else{
    		submit.submit();
    		return false;
    	}
    }
  
    
</script>


<style>
.ui-datepicker{ font-size: 16px; width: 300px;}
.ui-datepicker select.ui-datepicker-month{ width:30%; font-size: 14px; }
.ui-datepicker select.ui-datepicker-year{ width:40%; font-size: 14px; }
</style>

</head>
<body>





<%@include file="includeHeader.jsp"%>


	<section class="hero-wrap hero-wrap-2 ftco-degree-bg js-fullheight"
		style="background-image: url('resources/images/shop2.PNG');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div
				class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate pb-5 text-center">
					<p class="breadcrumbs">
						<span class="mr-2"><a href="mainJSP?id=${sessionScope.sessionId}">Home <i
								class="ion-ios-arrow-forward"></i></a></span> 
								<span>예약하기 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">예약 하기</h1>
				</div>
			</div>
		</div>

		<div class="mouse">
			<div class="mouse-icon">
				<div class="mouse-wheel">
					<span class="ion-ios-arrow-round-down"></span>
				</div>
			</div>
		</div>
	</section>


	<br>
	<br>
	<br>
	<br>
	<br>
	
<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" style="float:left; margin-left:30%;">메인가기</button>
<button onclick="history.back()" class="btn btn-primary" style="float:left; margin-left:1%;">뒤로가기</button><br><br>

<div class="container" style="width: 800px;">
<div class="bg-light p-5 contact-form text-center">
<h2 class="text-center">예약 하기</h2><br><br>

<form action="ticketingJSP_2" method="post" onsubmit="return false" name="submit">

	<c:if test="${shopName==''}">
    매장이름 : <input type="text" name="shopName" id="shopName" placeholder="매장 검색을 해주세요."> 
			 <button type="button" data-toggle="modal" data-target="#myModal" onclick="shopName_Call()">검색
   		 </button><br><br>
   	</c:if>
	<c:if test="${shopName!=''}">
	    매장이름 : <input type="text" name="shopName" id="shopName" value="${shopName}" placeholder="매장 검색을 해주세요."> 
			 <button type="button" data-toggle="modal" data-target="#myModal" onclick="shopName_Call()">검색
   		 </button><br>
   		 
   	</c:if>
      	  <br>
    디자이너 이름 : <span id="disigner_Text">
    <input type="radio" name="disigner" id="disigner_Text" value="" checked="checked" style="display: none;">
   <br><strong>"매장을 선택하면 디자이너목록이 나타 납니다."</strong>
    </span><br><br><br>
    
     예약 날짜:<br> <input type="text" name="work_Date" id="datepicker1" ><br>
    
    <input type="hidden" name="customer_id" id="customer_id" value="${sessionScope.sessionId}" >
    
    <br><br>
    <input type="submit" value="확인" onclick="ticketingJSP_2_submit()">
 </form>
 </div>
 </div>
    
<div class="nav-haed">
        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog" class="madal_fade">
            <!-- 사용자 지정 부분① : id명 -->
            <div class="nav2">
                <div class="modalDialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modalContent">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <!-- <button type="button" class="close" data-dismiss="modal">×</button> -->
                                    <h4 class="modal-title">매장 검색하기</h4>
                                    <!-- 사용자 지정 부분② : 타이틀 -->
                                </div>
                                <div class="modal-body">

                                    <p>
                                       <span id="shopName_Text"></span><!-- 자바스크립트에서 for문과 HTML.inner을 사용해 jsp에 띄우기  -->
                                    </p>
                                    <!-- 사용자 지정 부분③ : 텍스트 메시지 -->
                                </div>
                                <div class="modal-footer">
                               		<button type="button" class="btn btn-default" data-dismiss="modal" id="shopName_Text_Check">-확인-</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">-취소-</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    	<br>
	<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>
</body>
</html>