<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="en">
    <head>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<!-- 	모달 창  -->
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<!--    	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<!--   	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->
<!--   	ck에디터불러오기 -->
  	<script type="text/javascript" src="resources/ckeditor/ckeditor.js"></script>
<script>

	
	var shopNameCheck=0;
	
/*모달창으로 매장이름 불러오기  */
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
					
					disigner_Text.innerHTML += "<br><input type='radio' name='disigner' id='disigner_Text"+i+"' value='"+data[0].name+"' checked='checked'><label for='disigner_Text"+i+"'>"+data[0].name+"</label>&nbsp;&nbsp;&nbsp;&nbsp;"
					
					for(var i=1; i<Object.keys(data).length; i++ ){		
						disigner_Text.innerHTML += "<input type='radio' name='disigner' id='disigner_Text"+i+"' value='"+data[i].name+"'><label for='disigner_Text"+i+"'>"+data[i].name+"</label>&nbsp;&nbsp;&nbsp;&nbsp;"
					}
					disigner_Text.innerHTML +="<br><input type='hidden' name='pid_Shop' id='pid_Shop' value='"+data[0].belong_Shop+"'><br>"
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


//모두 값이 있는지 홧인후 form태그 서브밋 실행
$(document).ready(function() {
	
$("#submit1").click(function(){
	
	if($('#title').val()==""||$('#contents').val()==""||$('#grade').val()==""||$('#shopName').val()==""||$('#id').val()==""||$('#pid').val()==""||
			$('#name').val()==""||$('#pid_Shop').val()==""){
		alert("작성하지 않은 부분이 있는지 확인해 주세요.")
		return false;
	}
	else if($('input[name="disigner"]:checked').val()==null){
		alert("디자이너가 존재하지 않습니다.")
		return false;
	
	}else{
		alert("리뷰를 달아주셔서 감사합니다. 포인트는 디자이너가 확인후 지급됩니다.");
		reviewInsert1.submit();
		return false;
		
	}
	
	});
});

</script>

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
						<span class="mr-2"><a href="mainJSP?id=${sessionScope.sessionId}">Home 
						<i class="ion-ios-arrow-forward"></i></a></span> 
						<span><a href="reviewBoard?page=0">리뷰 게시판 
						<i class="ion-ios-arrow-forward"></i></a></span> 
						<span>리뷰 작성 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">리뷰 작성</h1>
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
    
    
    	<div class="row block-9 justify-content-center mb-5">
		<div class="col-md-8 mb-md-5">
			<h2 class="text-center">리뷰 작성</h2>
   <form action="reviewInsert?page=0" method="post" onsubmit="return false" name="reviewInsert1" class="bg-light p-5 contact-form">
        
        제목 : <input type="text" name="title" id="title" class="form-control"><br>
        
        
        내용 : <br>
            <textarea name="contents" id="editor1" class="form-control">
            </textarea><br>
            <script>
            CKEDITOR.replace( 'editor1', {
                filebrowserUploadUrl: 'imgUpload',
                width : '1150',
                height : '500'
            });
                </script>
         
         
        평점 :  1<input type="radio" name="grade" id="grade1" value="1"><label for="grade1"></label>&nbsp;&nbsp;
          2<input type="radio" name="grade" id="grade2" value="2"><label for="grade2"></label>&nbsp;&nbsp;
          3<input type="radio" name="grade" id="grade3" value="3"><label for="grade3"></label>&nbsp;&nbsp;
          4<input type="radio" name="grade" id="grade4" value="4"><label for="grade4"></label>&nbsp;&nbsp;
          5<input type="radio" name="grade" id="grade5" value="5"checked="checked"><label for="grade5"></label>&nbsp;&nbsp;<br><br>
          
      매장이름 : <input type="text" name="shopName" id="shopName" placeholder="매장 검색을 해주세요."class="form-control" style="width: 500px;">
			 <button type="button" data-toggle="modal" data-target="#myModal" onclick="shopName_Call()" class="btn btn-primary">검색
   		 </button><br>
      	  
      	  <span id="disigner_Text"></span>
      
        <br>
        <input type="hidden" name="id" id="id" value="${userSelect.id}">
        <input type="hidden" name="pid" id="pid" value="${userSelect.pid}">
        <input type="hidden" name="name" id="name" value="${userSelect.name}">
        <input type="submit" value="완료" id="submit1" class="btn btn-primary" style="float:right; margin-right:18%;">
        <br>
        <br>
        </form>
        
        </div>
        </div>
        
        	<br>
	<br>
	<br>
	<br>
	<br>
	<%@include file="includeFooter.jsp"%>
    </body>
    
    
</html>