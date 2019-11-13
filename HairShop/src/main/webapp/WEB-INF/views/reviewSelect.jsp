<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="resources/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script>

var check=0;
var pp= document.getElementById('UDcheck');

//수정,삭제, 비밀번호수정 버튼 눌렀을때 비밀번호칸 생성, 수정인지 삭제인지 확인 값 인풋에 value 주기
	$(document).ready(function() {
		$("#reviewUpdate").click(function() {
			$("#passwordCheck").show();
			$("#DU_CheckSubmit").show();
			check = 1;
			UDcheck.innerHTML ="<input type='hidden' name='check' value='"+check+"'>";
		});
		$("#reviewDelete").click(function() {
			$("#passwordCheck").show();
			$("#DU_CheckSubmit").show();
			check = 2;
			UDcheck.innerHTML ="<input type='hidden' name='check' value='"+check+"'>";
		});
		$(document).ready(function() {
			$("#passwordCheck").hide();
			$("#DU_CheckSubmit").hide();
		});
	});
	
	
	
	
	
//리뷰 수정,삭제 컨트롤러 넘어 가기
	$(document).ready(function() {
		$("#DU_CheckSubmit").click(function() {
			if(check==1){
				DU_CheckSubmit1.submit();
				return false
			}else if(check==2){
				alert('삭제되었습니다.');
				DU_CheckSubmit1.submit();
				return false
			}
		});
	});
	
	
	
//댓글 달기 입력 되어있을때만 댓글 달기
	$(document).ready(function() {
		$("#commentSubmit").click(function() {
			if($("#contents").val()!=''){
				comemnt.submit();
				return false
			}else{
				alert("글을 작성 하세요.");
				return false
			}
		});
	});
	
	
	
	
//댓글 삭제 눌렀을때 프롬프트
	function comment_Delete(commentNum){
	$(document).ready(function() {
			var input = confirm('삭제 하시겠습니까?'); 
			
			if(input==true){
				location.href="commentDelete?commentNum="+commentNum+"&page=${paging}&boardNum=${reviewSelect.boardNum}"
			}else{
				
			}
		});
	}
	
	
	
// 댓글의 답글 텍스트 숨기기
		$(document).ready(function() {
			var commentList_size="${commentList.size()}";
			
			if(commentList_size==''){
				
			}else{
		for(var i=1; i<=commentList_size; i++){
				$("#comment_Second_Show"+i).hide();
			}
			}
		});
	
		
		
// 답글 택스트 보이기
	function comment_Second_Fun(value){
		$(document).ready(function() {
			$("#comment_Second_Show"+value).show();
		});
	}
		
		
// 답글의 댓글 쓰기 컨트롤러로 넘기기
	function comment_Second_Submit(value){
			if($("#contents_Scond"+value).val()==''){
				alert("댓글을 작성해주세요.");
			}else{
				location.href="reviewComment_Second?"+
						"page=${paging}"+
						"&id="+$('#id_Scond'+value).val()+
						"&contents="+$('#contents_Scond'+value).val()+
						"&pid="+$('#pid_Scond'+value).val()+
						"&boardNum="+$('#boardNum_Scond'+value).val()+
						"&commentNum="+$('#commentNum_Scond'+value).val()
			}
	};
		
	
//댓글의 답글 삭제 눌렀을때 프롬프트
	function comment_Scond_Delete(commentNum_Second){
	$(document).ready(function() {
			var input = confirm('삭제 하시겠습니까?'); 
			
			if(input==true){
				location.href="comment_SecondDelete?commentNum_Second="+commentNum_Second+"&page=${paging}&boardNum=${reviewSelect.boardNum}"
			}else{
				
			}
		});
	}
	</script>
	
	
	<script>
// 	datepicket

  // 특정 휴무 날짜들 배열
    var disabledDays = "";
  
  //디자이너의 휴무 정보를 가져옴 , 숨긴div 보여줌.
  function datepicker_Show(){
	  
	  
		var shopName = $("#shopName").val();
		var disigner = $("#disigner").val();
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
				$("#disigner_Ticketing_Text").attr('style','dispaly:block');
			
		  
				},
				error : function() { /* 통신이 실패했을때 */
					alert("Overlap 함수 통신 실패!!");
				}
			});
	  }

     
  jQuery(function($){
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
    function disigner_Ticketing_submit(){
		
    	if($('#datepicker1').val()==""){
    		 alert('날짜를 선택해 주세요.');
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
								class="ion-ios-arrow-forward"></i></a></span> <span>리뷰 게시판 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">리뷰게시판</h1>
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
	



<div class="container">
<button onclick="location.href='reviewBoard?page=0'" class="btn btn-primary">목록으로</button><br><br>
<div class=”row“ >

<table class='table table-bordered specialCollapse' style='text-align:center;'>
<tr class='table-info'><th style="width:350px;">매장이름</th><th  style="width:200px;">디자이너</th><th>평점</th><th style="width:170px;">작성자</th><th style="width:250px;">작성 날짜</th><th style="width:80px;">조회수</th></tr>
<tr><td>${reviewSelect.shopName}</td><td> ${reviewSelect.disigner}</td><td>${reviewSelect.grade}/5</td><td>${reviewSelect.id}</td><td>${reviewSelect.review_Date}</td><td>${reviewSelect.hit}</td></tr>
<tr class='table-info'><th colspan="6">제목</th></tr>
<tr><td colspan="6">${reviewSelect.title}</td></tr>
<tr class='table-info'><th colspan="6">내용</th></tr>
<tr><td colspan="6"  style="height:500px;">${reviewSelect.contents}</td>
</tr>
</table>
</div>
<c:if test="${sessionScope.sessionId eq reviewSelect.id || sessionScope.sessionId eq 'admin'}">
<div class="row">
	<div class="col-sm-12">
		<input type="button" id="reviewUpdate" value="수정하기" class="btn btn-outline-primary"> 
		<input type="button" id="reviewDelete" value="삭제하기 " class="btn btn-outline-primary">
		<button id="disigner_Ticketing" onclick="datepicker_Show()" class="btn btn-danger py-3 px-5" style="float:right;">${reviewSelect.disigner}디자이너에게 예매하기</button>
	</div>
</div>
<form action="DU_Check?page=${paging}" method="post" onsubmit="return false" name="DU_CheckSubmit1">
<span id="UDcheck"></span>
<input type="hidden" name="boardNum" id="boardNum" value="${reviewSelect.boardNum}">
<input type="hidden" name="id" id="id" value="${sessionScope.sessionId}">
<input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호를 입력 하세요.">
<input type="submit" name="DU_CheckSubmit" id="DU_CheckSubmit" value="확인" class="btn btn-danger">
</form>
</c:if>
</div>
<br>
<form action="ticketingJSP_2" method="post" onsubmit="return false" name="submit">
			
<div id="disigner_Ticketing_Text" style="display: none;">
<div class="row">
<div class="col-sm-12" >
<div style="float:right;">
     예약 날짜 선택: <input type="text" name="work_Date" id="datepicker1">&nbsp;&nbsp;&nbsp;
  </div>
  <input type="hidden" name="shop_pid" value="${reviewSelect.shopName}">
    <input type="hidden" name="shopName" id="shopName" value="${reviewSelect.shopName}"> 
    <input type="hidden" name="disigner" id="disigner" value="${reviewSelect.disigner}">
    <input type="hidden" name="customer_id" id="customer_id" value="${sessionScope.sessionId}" >
 </div>
</div>

    <input type="submit" value="확인" onclick="disigner_Ticketing_submit()" class="btn btn-outline-danger"
    style="float:right; margin-right:4%; margin-top:5px;">
 </div>
 </form>
 <br><br>
<!-- 댓글쓰기 -->
<br><br><br><br><br>
<div class="container">
	<div class="row">
		<div class="col-sm-12 center">
			<form action="reviewComment?page=${paging}" method="post" onsubmit="return false" name="comemnt">
			<textarea id="contents" name="contents" rows="3" style="width:100%;" class="form-control"></textarea>
			<input type="hidden" name="id" value="${sessionScope.sessionId}">
			<input type="hidden" name="pid" value="${sessionScope.sessionPid}">
			<input type="hidden" name="boardNum" value="${reviewSelect.boardNum}">
			<input type="submit" id="commentSubmit" value="댓글 쓰기" style="float:right; margin-top:10px;" class="btn btn-primary">
			</form>
		</div>
	</div>
</div>

<!-- 댓글 보기 -->
<br>
<div class="container">
	<div class="row">
<div class="col-sm-12 center" style="float:center;">
<hr style="border: 0;
    height: 1px;
    background: #ccc;">
<c:forEach var="commentList" items="${commentList}" varStatus="status">
<strong>작성자 : ${commentList.hideId}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 작성날짜 : ${commentList.comment_Date}<br><br>
${commentList.contents}</strong><br>
<c:if test="${sessionScope.sessionId==commentList.id || sessionScope.sessionId==reviewSelect.id || sessionScope.sessionId eq 'admin'}"><br>
<a href="#aa" onclick="comment_Delete(${commentList.commentNum})">삭제</a>
</c:if> &nbsp;&nbsp;&nbsp; 

<a href="#aa" id="comment_Second${commentList.rn}" onclick="comment_Second_Fun(${commentList.rn})">답글보기(${comment_ScondCount[status.index].count}개)</a><br>
<!-- 답글 -->
<div id="comment_Second_Show${commentList.rn}">

<!-- 답글 정보 -->
<hr>
<c:forEach var="comment_ScondList" items="${comment_ScondList}" varStatus="status">
<c:if test="${comment_ScondList.commentNum==commentList.commentNum}">
<p style="font-size: 14px;">└>작성자 : ${comment_ScondList.hideId}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 작성날짜 : ${comment_ScondList.comment_Date}
<c:if test="${comment_ScondList.id==sessionScope.sessionId || sessionScope.sessionId=='qweqweqweqwe2'}">
<a href="#aa" onclick="comment_Scond_Delete(${comment_ScondList.commentNum_Second})" style="font-size: 14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;삭제</a><br>
</c:if><br>
${comment_ScondList.contents}</p>
<hr>
</c:if>
</c:forEach>

<!-- 답글쓰기 -->
<textarea id="contents_Scond${commentList.rn}" rows="1" style="width:40%;" class="form-control"></textarea>
<input type="hidden" id="id_Scond${commentList.rn}" value="${sessionScope.sessionId}">
<input type="hidden" id="pid_Scond${commentList.rn}" value="${sessionScope.sessionPid}">
<input type="hidden" id="boardNum_Scond${commentList.rn}" value="${reviewSelect.boardNum}">
<input type="hidden" id="commentNum_Scond${commentList.rn}" value="${commentList.commentNum}">
<input type="button" value="답글 쓰기" onclick="comment_Second_Submit(${commentList.rn})" class="btn btn-primary" style="margin-bottom:25px;">
</div>

<hr style="border: 0;
    height: 1px;
    background: #ccc;">
</c:forEach>
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
