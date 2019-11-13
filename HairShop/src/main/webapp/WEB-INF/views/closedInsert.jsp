<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet"href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>


<script>
// datePicket사용

var disabledDays = ${closeds_Date};

jQuery(function($){
	
    $("#datepicker1").datepicker({
//     	 showAnim: "slide",
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
      
     
//     // 이전 날짜들은 선택막기
//     function noBefore(date){
//         if (date < new Date()){
//             return [false];}
//         else{
//         return [true];}
//     }
     
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
</script>

<script>

	/*휴무 삭제   */
	function ClosedsInsert() {

			if($('#datepicker1').val()==""){
				 alert('날짜를 선택해 주세요.');
				 return false;
			}
			else{
				submit.submit();
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
								<span>디자이너 메뉴 <i class="ion-ios-arrow-forward"></i></span>
								<span>휴무 등록 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">휴무 등록</h1>
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
<h2 class="text-center">휴무 등록</h2><br><br>

 <form action="ClosedInsert" method="post" onsubmit="return false" name="submit">
 	<input type="hidden" name="disigner" id="disigner" value="${disigner}">
	<input type="hidden" name="disigner_id" id="disigner_id" value="${sessionScope.sessionId}">

 	휴무 등록 날짜: <input type="text" name="closeds_Date" id="datepicker1"> &nbsp;
 	<input type="submit" onclick="ClosedsInsert()" value="등록하기">
	<br><br>
	</form>
	</div>
	</div>
	
		<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>

</body>
</html>