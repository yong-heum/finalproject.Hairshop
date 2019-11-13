<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
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
//     	 minDate: 0,
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
      
     
// // 	이전 날짜들은 선택막기
// 	   function noBefore(date){
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

function ticketing_DN_List(){
		  
		var str="";
		var disigner_id = $("#disigner_id").val();
		var work_Date = $("#datepicker1").val();
			$.ajax({
				type : "post", /* get인지 post인지 결정 */
				url : "ticketing_DN_List", /* 컨트롤러 주소 (목적지) */
				data : {
					"disigner_id" : disigner_id,
					"work_Date" : work_Date
				}, /* 내가 보내줄 데이터 *//* 처음 id는 내가정해주는 파라미터이름. 두번째 id는 위에 선언한 변수이름. */
				dataType : "json", /* 보내줄 데이터 타임  */
				success : function(data) { /* 통신이 성공했을때  */
					
					str +="<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'><tr class='table-info'>"
					str +="<td>예약 시간</td><td>고객 이름</td><td>고객 아이디</td><td>시술 이름</td><td>시술 현황</td><td>완료</td><td>취소</td></tr>"
				
					for(var i=0; i<data.length; i++){
						str += "<tr><td>"+data[i].work_Time+"</td>";
						str += "<td><a href='#1' onclick='javascript:user_info("+i+")' data-toggle='modal' data-target='#myModal1'>"+data[i].customer_name+"</a></td>";
						str += "<td>"+data[i].customer_id+"<input type='hidden' id='ListId"+i+"' value='"+data[i].customer_id+"'></td>";
						str += "<td>"+data[i].work+"</td>";
						str += "<td>"+data[i].complete+"</td>";
						if(data[i].complete=="시술 전"){
							
							var work_Time = "\""+data[i].work_Time+"\"";
							var work_Date = "\""+data[i].work_Date+"\"";
							var customer_id = "\""+data[i].customer_id+"\"";
							
							str += "<td><a href='#' onclick='work_completed("+work_Time+","+work_Date+","+customer_id+")'>확인</a></td>"
						}else{
							str += "<td></td>"
						}
						
						if(data[i].complete=="시술 전"){
							
							var work_Time = "\""+data[i].work_Time+"\"";
							var work_Date = "\""+data[i].work_Date+"\"";
							var customer_id = "\""+data[i].customer_id+"\"";
							
							str += "<td><a href='#' onclick='ticketing_cancel("+work_Time+","+work_Date+","+customer_id+")'>예약 취소</a></td></tr>"
							
						}else{
							str += "<td></td></tr>"
						}
					
					}
					str +="</table>"
					
					document.getElementById("ticketing_DN_List").innerHTML = str;

				},
				error : function() { /* 통신이 실패했을때 */
					alert("Overlap 함수 통신 실패!!");
				}
	  });
}

//시술 완료 클릭시 프롬프트 
	function work_completed(work_Time,work_Date,customer_id){
	
		var input = confirm('시술이 끝났습니까?'); 
		var disigner_id = $("#disigner_id").val();
		
		if(input){
			
			var inputString = prompt('시술 내용을 적으세요', '.');

			if(inputString){
			location.href="work_completed?work_Date="+encodeURI(work_Date)+"&work_Time="+encodeURI(work_Time)+"&disigner_id="+encodeURI(disigner_id)+"&work_Contents="+encodeURI(inputString)+"&customer_id="+encodeURI(customer_id);
			
			}else{
				
			}
		}
	}
	
//예약 취소 클릭시 확인후  예약취소
	function ticketing_cancel(work_Date,work_Time,customer_id){
	
		var input = confirm('예약을 취소 하시겠습니까?'); 
		var disigner_id = $("#disigner_id").val();
		if(input){
				
			location.href="ticketing_cancel?work_Date="+work_Date+"&work_Time="+work_Time+"&disigner_id="+disigner_id+"&customer_id="+customer_id;
			
			}
		}
	</script>
	
	<script>
/*모달창으로 고객 정보 불러오기  */
function user_info(i) {
		var customer_id = $("#ListId"+i).val();
	$.ajax({
		type : "post", /* get인지 post인지 결정 */
		url : "user_info", /* 컨트롤러 주소 (목적지) */
		data : {
			"customer_id" : customer_id
		}, /* 내가 보내줄 데이터 *//* 처음 id는 내가정해주는 파라미터이름. 두번째 id는 위에 선언한 변수이름. */
		dataType : "json", /* 보내줄 데이터 타임  */
		success : function(data) { /* 통신이 성공했을때  */

			str = "이름 : "+data.name+"<br> ";
			str += "성별 : "+data.gender+"<br> ";
			str += "전화번호 : "+data.tel+"<br> ";
			str += "생년월일 : "+data.birthDay+"<br> ";
			str += "주소 : "+data.adrs_street_1+"&nbsp;"+data.adrs_street_2+"<br>";
			str += "아이디 : "+data.id+"<br> ";
			str += "이메일 : "+data.email+"<br><br> ";
			str += "<button onclick='ticketHistory_DN()'data-toggle='modal' data-target='#myModal2' class='btn btn-outline-primary'>고객 예매정보 보기</button><br> ";
			str += "<input type='hidden' id='ticketHistory_id' value='"+data.id+"'>"
			document.getElementById("user_info").innerHTML = str;
		},
		error : function() { /* 통신이 실패했을때 */
			alert("Overlap 함수 통신 실패!!");
		}
	});
}



function ticketHistory_DN() {
	
	var customer_id = $("#ticketHistory_id").val();
	console.log(customer_id);
	$.ajax({
		type : "post", /* get인지 post인지 결정 */
		url : "ticketHistory_DN", /* 컨트롤러 주소 (목적지) */
		data : {
			"customer_id" : customer_id,
			"disigner_pid" : $('#disigner_pid').val()
		}, /* 내가 보내줄 데이터 *//* 처음 id는 내가정해주는 파라미터이름. 두번째 id는 위에 선언한 변수이름. */
		dataType : "json", /* 보내줄 데이터 타임  */
		success : function(data) { /* 통신이 성공했을때  */
			str = "<table class='table table-bordered table-hover specialCollapse' style='text-align:center; width:700px'><tr class='table-active'><th>날짜</th><th>예약자</th><th>예약시간</th><th>시술</th><th>결제금액</th><th>시술현황</th><th>시술내용</th></tr>";
			if(data!=null){
			for(var i=0; i<data.length; i++){
			str += "<tr><td>"+data[i].work_Date+"</td>";
			str += "<td>"+data[i].customer_name+"</td>";
			str += "<td>"+data[i].work_Time+"</td>";
			str += "<td>"+data[i].work+"</td>";
			str += "<td>"+data[i].price_After+"</td>";
			str += "<td>"+data[i].complete+"</td>";
			str += "<td>"+data[i].work_Contents+"</td></tr>";
			}}
			else{
				"<tr><td>정보가 없습니다.</td></tr>"
			}
			str += "</table>";
			
			document.getElementById("ticketHistory_DN").innerHTML = str;
		},
		error : function() { /* 통신이 실패했을때 */
			alert("Overlap 함수 통신 실패!!");
		}
	});
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
								<span>예약하기 <i class="ion-ios-arrow-forward"></i>
							</span><span>예약된 고객 목록 확인 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">예약된 고객 목록 확인</h1>
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
	
	<div class="container" style="width: 1000px;">
<div class="bg-light p-5 contact-form text-center">
<h2 class="text-center">예약된 고객 목록 확인</h2><br><br>
	<input type="hidden" name="disigner_id" id="disigner_id" value="${sessionScope.sessionId}">
	<input type="hidden" name="disigner_id" id="disigner_pid" value="${sessionScope.sessionPid}">

 	날짜 선택: <input type="text" name="date" id="datepicker1" onchange="ticketing_DN_List()"> &nbsp;
	<br><br>
	
	<div id="ticketing_DN_List" class="row block-9 justify-content-center mb-5" style="text-align:center;"></div>
	
	</div>
	</div>
	
<div class="nav-haed">
        <!-- Modal -->
        <div class="modal fade" id="myModal1" role="dialog" class="madal_fade">
            <!-- 사용자 지정 부분① : id명 -->
            <div class="nav2">
                <div class="modalDialog">
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modalContent">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <!-- <button type="button" class="close" data-dismiss="modal">×</button> -->
                                    <h4 class="modal-title">고객 정보</h4>
                                    <!-- 사용자 지정 부분② : 타이틀 -->
                                </div>
                                <div class="modal-body">

                                    <p>
                                       <span id="user_info"></span><!-- 자바스크립트에서 for문과 HTML.inner을 사용해 jsp에 띄우기  -->
                                    </p>
                                    <!-- 사용자 지정 부분③ : 텍스트 메시지 -->
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">-확인-</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



<!-- 고객의 시술정보-->
        <!-- Modal -->
        <div class="modal fade" id="myModal2" role="dialog" class="madal_fade">
            <!-- 사용자 지정 부분① : id명 -->
            <div class="nav2">
                <div class="modalDialog">
                    <div class="modal-dialog" style="margin-right: 450px; margin-left: 450px;">
                        <!-- Modal content-->
                        <div class="modalContent">
                            <div class="modal-content"  style="width: 1000px; align-items: center;">
                                <div class="modal-header">
                                    <!-- <button type="button" class="close" data-dismiss="modal">×</button> -->
                                    <h4 class="modal-title">고객 정보</h4>
                                    <!-- 사용자 지정 부분② : 타이틀 -->
                                </div>
                                <div class="modal-body">

                                    <p>
                                       <span id="ticketHistory_DN"></span><!-- 자바스크립트에서 for문과 HTML.inner을 사용해 jsp에 띄우기  -->
                                    </p>
                                    <!-- 사용자 지정 부분③ : 텍스트 메시지 -->
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">-확인-</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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