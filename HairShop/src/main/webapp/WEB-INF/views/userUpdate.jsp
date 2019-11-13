<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>


/*모두작성이 되었는지 확인*/
	function userUpdateCheck(){
		
	if($('#name').val()==""||$('#birthDay').val()==""||$('#tel').val()==""||
	$('#sample6_postcode').val()==""||$('#sample6_address').val()==""||$('#sample6_detailAddress').val()==""||$('#email').val()==""){
		 alert('작성하지 않은 부분이 있는지 확인하세요.');
		 return false;
		 
	}else{
		alert("수정이 완료 되었습니다.");
		userUpdate.submit();
	}
}
	
</script>

<!-- 다음 주소검색 API -->
<script type="text/javascript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
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
                document.getElementById("sample6_detailAddress").focus();
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
								class="ion-ios-arrow-forward"></i></a></span> 
								<span><a href="userSelect?id=${sessionScope.sessionId}">회원정보 <i
								class="ion-ios-arrow-forward"></i></a></span>
								<span>회원정보 변경 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">회원정보 변경</h1>
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
			<h2 class="text-center">회원정보 변경</h2><br>
			
<form action="userUpdate2" method="post" name="userUpdate" onsubmit="return false" class="bg-light p-5 contact-form">

아이디 : <input type="text" id="id" value="${userSelect.id}" class="form-control"  style="width: 400px;" readonly><br>
이름 : <input type="text" name="name" id="name" value="${userSelect.name}" class="form-control"  style="width: 400px;"><br>
생년월일 : <input type="text" name="birthDay" id="birthDay" value="${userSelect.birthDay}" readonly><br><br>
<c:if test="${userSelect.gender=='남'}">
성별 :<br><label for="gender1">남자</label><input type="radio" id="gender1" name="gender" value="남" checked> &nbsp;&nbsp;&nbsp;
<label for="gender2">여자</label><input type="radio" id="gender2" name="gender" value="여"> <br> 
</c:if>
<c:if test="${userSelect.gender=='여'}">
성별 :<br><label for="gender1">남자</label><input type="radio" id="gender1" name="gender" value="남" > &nbsp;&nbsp;&nbsp;
<label for="gender1">여자</label><input type="radio" id="gender2" name="gender" value="여" checked> <br> 
</c:if><br>
<!-- 다음 주소 api -->
주소 : <input type="text" class="form-control"  style="width: 400px;" name="adrs_post_code" id="adrs_post_code" value="${userSelect.adrs_post_code}" id="sample6_postcode" placeholder="우편번호">
<input type="button"  onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary"><br><br>
<input type="text" class="form-control"  style="width: 700px;" name="adrs_street_1" id="adrs_street_1" value="${userSelect.adrs_street_1}" id="sample6_address" placeholder="주소"><br>
<input type="text" class="form-control"  style="width: 700px;" name="adrs_street_2" id="adrs_street_2" value="${userSelect.adrs_street_2}" id="sample6_detailAddress" placeholder="상세주소"><br>

전화번호 : <input type="text" class="form-control"  style="width: 400px;" name="tel" id="tel" value="${userSelect.tel}" placeholder=" '-' 없이 작성해주세요."><br>


이메일: <input type="email" class="form-control"  style="width: 500px;" name="email" id="email" value="${userSelect.email}"><br>
<input type="hidden" name="join_date" value="${userSelect.join_date}">
<input type="hidden" name="id" value="${sessionScope.sessionId}">
<input type="submit" value="수정하기" onclick="userUpdateCheck()" class="btn btn-primary">
<input type="submit" value="돌아가기" onclick="history.back()" class="btn btn-primary">
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