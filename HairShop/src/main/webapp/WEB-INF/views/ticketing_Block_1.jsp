<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  // 특정 휴무 날짜들 배열
    var disabledDays = "";
  
  //디자이너의 휴무 정보를 가져옴 

  $(document).ready(function() {
  
	var disigner_id = $("#disigner_id").val();
		$.ajax({
			type : "post", /* get인지 post인지 결정 */
			url : "closeds_List", /* 컨트롤러 주소 (목적지) */
			data : {
				"disigner_id" : disigner_id
			}, /* 내가 보내줄 데이터 *//* 처음 id는 내가정해주는 파라미터이름. 두번째 id는 위에 선언한 변수이름. */
			dataType : "json", /* 보내줄 데이터 타임  */
			success : function(data) { /* 통신이 성공했을때  */
			
			disabledDays = data;
			console.log(disabledDays);
			},
			error : function() { /* 통신이 실패했을때 */
				alert("Overlap 함수 통신 실패!!");
			}
		});
  });
  

//매장이름과 디자이너 선택 후에만 날짜를 선택 
jQuery(function($){
	
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
});
// $("#datepicker1").datepicker().datepicker("show");
     

     
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
    function ticketing_Block_2_submit(){
		
    	if($('#datepicker1').val()==""){
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
							<span>예약 막기 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">예약 막기</h1>
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
	

<div class="container" style="width: 800px;">
<div class="bg-light p-5 contact-form text-center">
<h2 class="text-center">예약 막기</h2><br><br>
<form action="ticketing_Block_2" method="post" onsubmit="return false" name="submit">


     예약 날짜: <input type="text" name="work_Date" id="datepicker1"><br><br>
      	  <input type="hidden" name="disigner_id" id="disigner_id" value="${disigner_id}">
      	  <input type="hidden" name="shop_pid" id="shop_pid" value="${shop_pid}">
    <input type="submit" class="btn btn-primary" value="확인" onclick="ticketing_Block_2_submit()">
 </form>
   </div>
   </div>
        <br>
	<br>
	<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>
     
</body>
</html>