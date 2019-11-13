<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->
<!-- <script type="text/javascript" src="resources/ckeditor/ckeditor.js"></script> -->
<script>
	
	
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
						} else {
							shopName_Text.innerHTML += "<input type='radio' name='shopName_Text' id='shopName_Text_id"+i+"' value='"+data[0]+"'><label for='shopName_Text_id"+i+"' checked='checked'>"
									+ data[0] + "</label><br>"

							for (var i = 1; i < Object.keys(data).length; i++) {
								shopName_Text.innerHTML += "<input type='radio' name='shopName_Text' id='shopName_Text_id"+i+"' value='"+data[i]+"'><label for='shopName_Text_id"+i+"'>"
										+ data[i] + "</label><br>"
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
	$(document).ready(
			function() {
				$("#shopName_Text_Check").click(
						function() {

							var shopName = $("#shopName"); // 매장이름 검색텍스트
							var shopName_Text_id = $(
									'input[name="shopName_Text"]:checked')
									.val();

							if (shopName_Text_id != null) {

								$('#shopName').val(shopName_Text_id).attr(
										'readonly', true);
								shopNameCheck = 1;

							} else {
							}
						});
					});
					
//모두 값이 있는지 홧인후 form태그 서브밋 실행
	function priceInsert(){
	$(document).ready(function() {
		
			if($('#shopName').val()==""||$('#rank').val()==""||$('#work_Open').val()==""||$('#work_Closeds').val()==""||$('#m_cut').val()==""||$('#m_purm').val()==""||$('#m_sc_purm').val()==""||$('#m_magic').val()==""||
					$('#m_b_magic').val()==""||$('#m_color').val()==""||$('#m_clinic').val()==""||$('#w_cut').val()==""||$('#w_purm').val()==""||
					$('#w_d_purm').val()==""||$('#w_magic').val()==""||$('#w_b_magic').val()==""||$('#w_setting').val()==""||$('#w_m_setting').val()==""||
					$('#w_color').val()==""||$('#w_clinic').val()==""||$('#work_Open').val()==""||$('#work_Closeds').val()==""||$('#rank').val()==""){
				
				alert("작성하지 않은 부분이 있는지 확인해 주세요.")
				return false;
			
			}else{
				priceInsert1.submit();
				return false;
				}
 			});
		}
		
//돌아가기 
	function back(){
		history.back();
		}
		
</script>

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
						<span class="mr-2"><a href="mainJSP?id=${sessionScope.sessionId}">Home 
						<i class="ion-ios-arrow-forward"></i></a></span> 
						<span>디자이너 메뉴
						<i class="ion-ios-arrow-forward"></i></span> 
						<span>소속매장등록(시술금액등록) <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">소속매장등록(시술금액등록)</h1>
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
										<span id="shopName_Text"></span>
										<!-- 자바스크립트에서 for문과 HTML.inner을 사용해 jsp에 띄우기  -->
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
	<div class="row block-9 justify-content-center mb-5">
		<div class="col-md-8 mb-md-5">
			<h2 class="text-center">소속매장을 등록을 하시기 위헤서는 시술 금액, 직급, 근무시간 등록이 필수 입니다 .</h2>
	<br><br> 
	
	<form action="priceInsert" method="post" onsubmit="return false" name="priceInsert1" enctype="multipart/form-data" class="bg-light p-5 contact-form">
	<input type="hidden" name="disigner_name" id="disigner" value="${user.name}">
	<input type="hidden" name="disigner_id" id="disigner" value="${user.id}">
	
	매장이름 :
	<input type="text" name="shopName" id="shopName"
		placeholder="매장 검색을 해주세요." class="form-control" style="width: 500px; ">
	<button type="button" data-toggle="modal" data-target="#myModal"
		onclick="shopName_Call()" class="btn btn-primary">검색</button>
	<br><br>
	
	직급 : <input type="text" name="rank" id="rank" class="form-control" style="width: 300px; "><br><br>
	근무 시작 시간 : <select name="ampm_Work_Open">
  				 <option value="오전">오전</option>
 				 <option value="오후">오후</option>
			 </select>
			 
			 <select name="work_Open" id="work_Open">
				 <c:forEach var="time_num" items="${time_num}" varStatus="status">
  					 <option value="${time_num}">${time_num}</option>
  				 </c:forEach>
			 </select>
	<br>
	근무 오픈 시간 : <select name="ampm_Work_Closeds">
  				 <option value="오후">오후</option>
 				 <option value="오전">오전</option>
			 </select>
 				 
			<select name="work_Closeds" id="work_Closeds">
				 <c:forEach var="time_num" items="${time_num}" varStatus="status">
  					 <option value="${time_num}">${time_num}</option>
  				 </c:forEach>
			 </select>
	<br><br>
	<h5>남자</h5><br>
	남자 컷 : <br><input type="text" name="m_cut" id="m_cut" placeholder="숫자만 입력하세요">원<br><br>
	남자 일반 펌 : <br><input type="text" name="m_purm" id="m_purm" placeholder="숫자만 입력하세요">원<br><br>
	남자 디자인 펌 : <br><input type="text" name="m_sc_purm" id="m_sc_purm" placeholder="숫자만 입력하세요">원<br><br>
	남자 매직 : <br><input type="text" name="m_magic" id="m_magic" placeholder="숫자만 입력하세요">원<br><br>
	남자 볼륨매직 : <br><input type="text" name="m_b_magic" id="m_b_magic" placeholder="숫자만 입력하세요">원<br><br>
	남자 컬러 : <br><input type="text" name="m_color" id="m_color" placeholder="숫자만 입력하세요">원<br><br>
	남자 크리닉 : <br><input type="text" name="m_clinic" id="m_clinic" placeholder="숫자만 입력하세요">원<br><br><br>
	
	<h5>여자</h5><br>
	여자 컷 : <br><input type="text" name="w_cut" id="w_cut" placeholder="숫자만 입력하세요">원<br><br>
	여자 일반 펌 : <br><input type="text" name="w_purm" id="w_purm" placeholder="숫자만 입력하세요">원<br><br>
	여자 디지털 펌 : <br><input type="text" name="w_d_purm" id="w_d_purm" placeholder="숫자만 입력하세요">원<br><br>
	여자 매직 : <br><input type="text" name="w_magic" id="w_magic" placeholder="숫자만 입력하세요">원<br><br>
	여자 볼륨매직 : <br><input type="text" name="w_b_magic" id="w_b_magic" placeholder="숫자만 입력하세요">원<br><br>
	여자 셋팅 : <br><input type="text" name="w_setting" id="w_setting" placeholder="숫자만 입력하세요">원<br><br>
	여자 매직셋팅 : <br><input type="text" name="w_m_setting" id="w_m_setting" placeholder="숫자만 입력하세요">원<br><br>
	여자 컬러 : <br><input type="text" name="w_color" id="w_color" placeholder="숫자만 입력하세요">원<br><br>
	여자 크리닉 : <br><input type="text" name="w_clinic" id="w_clinic" placeholder="숫자만 입력하세요">원
	<br><br>
	<input type="submit" onclick="priceInsert()" class="btn btn-primary" value="확인"> <input type="button" onclick="back()" class="btn btn-primary" value="돌아가기">
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