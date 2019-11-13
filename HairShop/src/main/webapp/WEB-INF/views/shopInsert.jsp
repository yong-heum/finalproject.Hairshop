<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	var nameCheck = 0;

	/* 매장이름 중복확인  */
	function shopName_Overlap() {

		var shopName = document.getElementById("shopName").value;
		var confirmShopName = document.getElementById("confirmShopName");

		/*ajax : Asynchronous JavaScript and XML(비동기 처리를 위한 자바스크립트)
		     ajax는 JSON 형식으로 데이터 전송
		        - JSON(JavaScript Object Notation) : 자바 스크립트 객체 표기법
		 */

		$.ajax({
			type : "post", /* get인지 post인지 결정 */
			url : "shopName_Overlap", /* 컨트롤러 주소 (목적지) */
			data : {
				"shopName" : shopName
			}, /* 내가 보내줄 데이터 *//* 처음 id는 내가정해주는 파라미터이름. 두번째 id는 위에 선언한 변수이름. */
			dataType : "text", /* 보내줄 데이터 타임  */
			success : function(data) { /* 통신이 성공했을때  */
				if (data == "OK") {
					confirmShopName.style.color = "#green";
					confirmShopName.innerHTML = "등록 가능한 매장입니다.";
					nameCheck = 1;
				} else {
					confirmShopName.style.color = "#ff0000";
					confirmShopName.innerHTML = "이미 등록 되어있는 매장입니다.";
					nameCheck = 0;
				}
			},
			error : function() { /* 통신이 실패했을때 */
				alert("Overlap 함수 통신 실패!!");
			}
		});
	}

	/*모두작성이 되었는지 & 아이디 인증 & 비밀번호가 일치 하는지 확인 */
	function ShopInsert() {

		if ($('#shopName').val() == "" || $('#introduce').val() == ""
				|| $('#openTime').val() == "" || $('#tel').val() == ""
				|| $('#openDate').val() == ""
				|| $('#sample6_postcode').val() == ""
				|| $('#sample6_address').val() == ""
				|| $('#sample6_detailAddress').val() == ""
				|| $('#closeTime').val() == "") {
			alert('작성하지 않은 부분이 있는지 확인하세요.');
			return false;
		} else if (nameCheck == '0') {
			alert('매장이름이 중복이 되는지 확인하세요.');
			return false;
		} else {
			alert("감사합니다. 게시물은 관리자의 인증후 등록됩니다.")
			shopInsert.submit();
		}
	}

	/* 파일추가하기 버튼 */
	
	var i = 2;
	
	$(document).ready(function() {
		$("#add").click(function() {
			$("#file" + i).show();
		i = i + 1;
		});
		$(document).ready(function() {
			$("#file2").hide();
			$("#file3").hide();
			$("#file4").hide();
			$("#file5").hide();
		});
	});

	
	
</script>

<!-- 다음 주소검색 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
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
						<span class="mr-2"><a href="mainJSP?id=${sessionScope.sessionId}">Home <i
								class="ion-ios-arrow-forward"></i></a></span> <span>매장 등록 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">매장 등록</h1>
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

<div class="row block-9 justify-content-center mb-5">
		<div class="col-md-8 mb-md-5">
			<h2 class="text-center">매장 등록</h2><br>
			
	<form action="shopInsert" method="post" onsubmit="return false" name="shopInsert" enctype="multipart/form-data" class="bg-light p-5 contact-form">
		매장이름 : <input type="text" name="shopName" id="shopName" placeholder="매장이름을 입력하세요." class="form-control"  style="width: 500px; ">
		<button onclick="shopName_Overlap()" class="btn btn-primary">중복 확인</button> <span id="confirmShopName"></span><br><br>
		
		매장소개글:<br>
		<textarea id="introduce" name="introduce" rows="10" cols="60" class="form-control"></textarea><br> 
		
		오픈시간 : <input type="text" name="openTime" id="openTime" placeholder="마감 시간을 입력하세요." class="form-control"  style="width: 300px; "><br> 
		마감시간 : <input type="text" name="closeTime" id="closeTime" placeholder="영업 시간을 입력하세요." class="form-control" style="width: 300px; "><br> 
		매장 전화 번호 : <input type="text" name="tel" id="tel" placeholder="매장번호를 입력하세요." class="form-control" style="width: 300px; "><br><br>
		오픈날짜 :<br>
		<input type="date" name="openDate" id="openDate"><br><br><br>

		<!-- 다음 주소 api -->
		매장주소 : <input type="text" name="adrs_post_code" id="sample6_postcode" placeholder="우편번호" class="form-control" style="width: 500px; "> 
		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary"><br><br>
		<input type="text" name="adrs_street_1" id="sample6_address" placeholder="주소" class="form-control" style="width: 700px; "><br> 
		<input type="text" name="adrs_street_2" id="sample6_detailAddress" placeholder="상세주소" class="form-control" style="width: 700px; "><br>
		<br>
		<br> 매장사진은 5장까지 올릴수 있습니다.<br> 
		매장사진 : <input type="file" name="shop_Photo_add1" class="btn btn-outline-primary"><br>
		<div id="file2"><input type="file" name="shop_Photo_add2" id="shop_Photo_add2" class="btn btn-outline-primary"><br></div>
		<div id="file3"><input type="file" name="shop_Photo_add3" id="shop_Photo_add3" class="btn btn-outline-primary"><br></div>
		<div id="file4"><input type="file" name="shop_Photo_add4" id="shop_Photo_add4" class="btn btn-outline-primary"><br></div>
		<div id="file5"><input type="file" name="shop_Photo_add5" id="shop_Photo_add5" class="btn btn-outline-primary"><br></div><br>
		<button id="add" class="btn btn-primary">사진추가</button><br><br><br><br>
		
		시술가격표 사진 등록 : <br><input type="file" name="menu_Photo_File" class="btn btn-outline-primary"><br><br>
		시술가격표 내용 : <br>
		<textarea name="menu_Contents" rows="30" cols="70" placeholder="가격표 사진이 없으면 글로 적으셔도 됩니다." class="form-control"></textarea><br> 

		<input type="hidden" name="shop_Manager" value="${sessionScope.sessionId}"> 
		<input type="hidden" name="pid_User" value="${sessionScope.sessionPid}"> 
		<br>
		<input type="submit"onclick="ShopInsert();" value="완료" class="btn btn-primary"> <input type="reset" value="초기화" class="btn btn-primary">
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