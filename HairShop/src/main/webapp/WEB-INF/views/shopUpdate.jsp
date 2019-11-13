<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script>

	/*모두작성이 되었는지 & 아이디 인증 & 비밀번호가 일치 하는지 확인 */
	function shopUpdate1() {

		if ($('#shopName').val() == "" || $('#introduce').val() == ""
				|| $('#openTime').val() == "" || $('#tel').val() == ""
				|| $('#openDate').val() == ""
				|| $('#sample6_postcode').val() == ""
				|| $('#sample6_address').val() == ""
				|| $('#sample6_detailAddress').val() == ""
				|| $('#closeTime').val() == "") {
			alert('작성하지 않은 부분이 있는지 확인하세요.');
			return false;
		} else {
			alert("감사합니다. 수정되었습니다.")
			shopUpdate.submit();
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
								class="ion-ios-arrow-forward"></i></a></span> <span>매장 둘러보기<i
							class="ion-ios-arrow-forward"></i></span>
							<span>매장 정보 수정<i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">매장 정보 수정</h1>
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
			
	<form action="shopUpdate2?page=${paging}" method="post" onsubmit="return false" name="shopUpdate" enctype="multipart/form-data" class="bg-light p-5 contact-form">
		매장이름 : <input type="text" name="shopName" id="shopName" value="${shop_List.shopName}" readonly="readonly"  class="form-control"  style="width: 500px; ">
		<br> 
		
		매장소개글:<br>
		<textarea id="introduce" name="introduce" rows="10" cols="60" class="form-control">${shop_List.shopName}</textarea><br> 
		
		오픈시간 : <input type="text" name="openTime" id="openTime" placeholder="마감 시간을 입력하세요." value="${shop_List.openTime}"  class="form-control"  style="width: 300px; "><br> 
		마감시간 : <input type="text" name="closeTime" id="closeTime" placeholder="영업 시간을 입력하세요." value="${shop_List.closeTime}"  class="form-control"  style="width: 300px; "><br> 
		매장 전화 번호 : <input type="text" name="tel" id="tel" placeholder="매장번호를 입력하세요." value="${shop_List.tel}"  class="form-control"  style="width: 300px; "><br>
		오픈날짜 : <input type="date" name="openDate" id="openDate" value="${shop_List.openDate}"><br>

		<!-- 다음 주소 api -->
		매장주소 : <input type="text" name="adrs_post_code" id="sample6_postcode" placeholder="우편번호" value="${shop_List.adrs_post_code}" class="form-control" style="width: 500px;"> 
		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary"><br><br>
		<input type="text" name="adrs_street_1" id="sample6_address" placeholder="주소" value="${shop_List.adrs_street_1}"  class="form-control" style="width: 700px;"><br> 
		<input type="text" name="adrs_street_2" id="sample6_detailAddress" placeholder="상세주소" value="${shop_List.adrs_street_2}" class="form-control" style="width: 700px;"><br>
		<br>
		<br> 매장사진은 5장까지 올릴수 있습니다.(이미지 파일 수정,삭제,추가는 이미지로먼저 보여주고 AJAX를 통해 수정,삭체,추가하기 시간남으면!)<br> 
		매장사진 : <input type="file" name="shop_Photo_add1" class="btn btn-outline-primary"><br>
		<div id="file2"><input type="file" name="shop_Photo_add2" id="shop_Photo_add2" class="btn btn-outline-primary"><br></div>
		<div id="file3"><input type="file" name="shop_Photo_add3" id="shop_Photo_add3" class="btn btn-outline-primary"><br></div>
		<div id="file4"><input type="file" name="shop_Photo_add4" id="shop_Photo_add4" class="btn btn-outline-primary"><br></div>
		<div id="file5"><input type="file" name="shop_Photo_add5" id="shop_Photo_add5" class="btn btn-outline-primary"><br></div>
		<button id="add"  class="btn btn-primary">사진추가</button><br><br><br><br>
		
		시술가격표 사진 등록 : <input type="file" name="menu_Photo_File" class="btn btn-outline-primary"><br>
		시술가격표 내용 : <br>
		<textarea name="menu_Contents" rows="30" cols="70" placeholder="가격표 사진이 없으면 글로 적으셔도 됩니다."  class="form-control">${shop_List.menu_Contents}</textarea><br> 

		<input type="hidden" name="pid" value="${shop_List.pid}"> 
		<input type="hidden" name="shop_Manager" value="${sessionScope.sessionId}"> 
		<input type="hidden" name="pid_User" value="${sessionScope.sessionPid}"> 
		<br>
		<input type="submit"onclick="shopUpdate1();" value="수정완료"  class="btn btn-primary"> <input type="reset" value="초기화" class="btn btn-primary">
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