<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="https://www.gstatic.com/charts/loader.js"></script>
	
	<link rel="stylesheet"href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script>
	$(document).ready(function() {	
	$('#sales_confirm').click(function(){
		
		if($("#date").val()==""||$("#sales_Select").val()==""){
			alert("선택하지 않은 항목이 있는지 확인 하세요");
		}else{
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawVisualization);
		}
	});
	});
		function drawVisualization() { 
			
			var date = $("#datepicker1").val();
			var sales_Select = $("#sales_Select").val();
			var id = $("#id").val();
			
			
			$.ajax({
				type : "post",             /* get인지 post인지 결정 */
				url : "sales_Chart_Select",         /* 컨트롤러 주소 (목적지) */
				data : {"id" : id,
						"date" : date,
						"sales_Select" : sales_Select 
						},
				dataType : "json",         /* 보내줄 데이터 타임  */
				success : function(data){           /* 통신이 성공했을때  */
			var sales_Chart_data = google.visualization.arrayToDataTable(
					[
					['날짜', '매출',{role:'annotation'}, "그래프"],
					[data.dateArray[0],  data.salesArray[0],  data.salesArray[0],  data.salesArray[0]],
					[data.dateArray[1],  data.salesArray[1],  data.salesArray[1],  data.salesArray[1]],
					[data.dateArray[2],  data.salesArray[2],  data.salesArray[2],  data.salesArray[2]],
					[data.dateArray[3],  data.salesArray[3],  data.salesArray[3],  data.salesArray[3]],
					[data.dateArray[4],  data.salesArray[4],  data.salesArray[4],  data.salesArray[4]]
				]);
			var options = {
					title : '매출',
// 					vAxis: {title: 'Cups'},
// 					hAxis: {title: 'Month'}, 
					seriesType: 'bars',
					series: {1: {type: 'line'}
					},
				};
			
			var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
			chart.draw(sales_Chart_data, options);
			
				},
				error : function(){                  /* 통신이 실패했을때 */
					alert("idOverlap 함수 통신 실패!!");	
				}	
			});
		}
		
		</script>
		


	<script>
		// datePicket사용
		jQuery(function($){
		     
		    $("#datepicker1").datepicker({
//		     	 showAnim: "slide",
// 				minDate : 0,
		    	maxDate : 0,
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
// 		        beforeShowDay:noBefore
		    });
		     
		});
		
		
		 // 이전 날짜들만 선택할수있게
	    function noBefore(date){
	        if (date > new Date()){
	            return [false];}
	        else{
	        return [true];}
	    }
	</script>
	
	<style>
	#chart_div div div div svg rect {
    fill: #d5f7d7;
}

#chart_div div div div svg g g g rect {
    fill: #50b182;
}
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
								<span>매장 매출 확인 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">매장 매출 확인</h1>
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
	
<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" style="float:left; margin-left:25%;">메인가기</button>
<button onclick="history.back()" class="btn btn-primary" style="float:left; margin-left:1%;">뒤로가기</button><br><br>

<div class="container" style="width: 1020px;">
<div class="bg-light p-5 contact-form text-center">
<h2 class="text-center">매장 매출 확인</h2><br><br>
	날짜 선택 : <input type="text" name="date" id="datepicker1"><br><br>

	매출 선택 : <select name="sales_Select" id="sales_Select">
				 <option value="3">매장 하루 매출(날짜 전 5일간 매출)</option>
 				 <option value="4">매장 일주일 매출(날짜 전 5주간 매출, 선택 날짜로부터 7일 기준)</option>
 				 <option value="5">매장 달 매출(선택 날짜부터 5달간 매출)</option>
			 </select>
			 
			 <input type="button" name="sales_confirm" id="sales_confirm" value="확인"><br><br>
			 
	<div id="chart_div" style="width:900px; height: 500px;"></div>
	
	<input type="hidden" name="id" id="id" value="${sessionScope.sessionId }">
	</div>
	</div>
	
			<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>
	
</body>
</html>