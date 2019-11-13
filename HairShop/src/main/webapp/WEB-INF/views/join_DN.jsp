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
	var idcheck = 0;
	var pwdc = 0;
	var pwdcheck = 0;
	var idExpCheck = 0;

	/* 아이디 중복확인,정규식  */
	function idOverlap() {
		var idCheck1 = $("#id").val();

		/*ajax : Asynchronous JavaScript and XML(비동기 처리를 위한 자바스크립트)
		     ajax는 JSON 형식으로 데이터 전송
		        - JSON(JavaScript Object Notation) : 자바 스크립트 객체 표기법
		 */

		$.ajax({
			type : "post", /* get인지 post인지 결정 */
			url : "DN_idOverlap", /* 컨트롤러 주소 (목적지) */
			data : {
				"id" : idCheck1
			}, /* 내가 보내줄 데이터 *//* 처음 id는 내가정해주는 파라미터이름. 두번째 id는 위에 선언한 변수이름. */
			dataType : "text", /* 보내줄 데이터 타임  */
			success : function(data) { /* 통신이 성공했을때  */
				idCheck1 = document.getElementById('id');
				var idExp = /^[a-zA-Z0-9]{10,15}$/;
				var confirmId = document.getElementById('confirmId');

				if (data == "OK" && idCheck1.value.match(idExp)) {
					confirmId.style.color = "#black";
					confirmId.innerHTML = "사용가능한 아이디";
					idcheck = 1;
					idExpCheck = 1;
				} else if (data == "NO") {
					confirmId.style.color = "#ff0000";
					confirmId.innerHTML = "사용중인 아이디";
					idcheck = 0;
					idExpCheck = 0;
				} else {
					confirmId.style.color = "#ff0000";
					confirmId.innerHTML = "10글자 이상 작성 하세요 ";
					idcheck = 0;
					idExpCheck = 0;
				}
			},
			error : function() { /* 통신이 실패했을때 */
				alert("idOverlap 함수 통신 실패!!");
			}
		});
	}

	/* 	비밀번호 정규식 */
	function passwordExp() {
		//ㅂㅣ밀번호 검증을 위한 정규식 선언
		var exp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		var password = document.getElementById('password');
		var passwordExp = document.getElementById('passwordExp');
		if (password.value.match(exp)) {
			passwordExp.style.color = "black";
			passwordExp.innerHTML = "사용가능한 비밀번호형식입니다.";
			pwdc = 1;
		} else {
			passwordExp.style.color = "red";
			passwordExp.innerHTML = "형식에맞는 비밀번호를 입력하세요";
			pwdc = 0;
		}

	}

	/* 비밀번호확인 */
	function passwordcheck() {
		var pp = document.getElementById('p');

		if ($('#password').val() == $('#passwordconfirm').val()) {
			pp.innerHTML = "비밀번호가 일치 합니다.";
			pwdcheck = 1;
		} else {
			pp.innerHTML = "비밀번호가 일치하지않습니다.";
			pwdcheck = 0;
		}

	}

	/*모두작성이 되었는지 & 아이디 인증 & 비밀번호가 일치 하는지 확인 */
	function Join() {

		if (
				$('#id').val() == "" || $('#password').val() == ""
				|| $('#passwordconfirm').val() == "" || $('#name').val() == ""
				|| $('#birthDay').val() == "" || $('#tel').val() == ""
				|| $('#sample6_postcode').val() == ""
				|| $('#sample6_address').val() == ""
				|| $('#sample6_detailAddress').val() == ""
				|| $('#email').val() == "" || $('#profile_Photo').val() == "") {
			alert('작성하지 않은 부분이 있는지 확인하세요.');
			return false;
		} else if (idcheck == '0') {
			alert('아이디 중복이 되는지 확인하세요.');
			return false;
		} else if (pwdc == '0') {
			alert("비밀번호양식에 맞게 쓰세요.");
			return false;
		} else if (pwdcheck == '0') {
			alert("비밀번호가 일치하는지 확인하세요.");
			return false;
		} else if (idExpCheck == '0') {
			alert("아이디 형식이 맞는지 확인하세요.");
			return false;
		} else {
			join.submit();
		}
	}
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
	<!-- action 주소값은 memberJoin -->
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
						<span class="mr-2"><a href="loginJSP">Login <i
								class="ion-ios-arrow-forward"></i></a></span> <span>디자이너 고객 회원가입 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">Disigner Sing Up</h1>
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
			<h2 class="text-center">Disigner Sing Up</h2>
			<form action="DN_join" method="post" onsubmit="return false"
				name="join" enctype="multipart/form-data"
				class="bg-light p-5 contact-form">
				<div class="form-group">
					아이디 : <input type="text" name="id" id="id"
						placeholder="10글자이상 써주세요." onkeyup="idOverlap()"
						class="form-control" style="width: 300px; "><span
						id="confirmId"></span><br>
				</div>
				<div class="form-group">
					비밀번호 : <input type="password" id="password" name="password"
						placeholder="영어,숫자,특수문자  8~15글자" onkeyup="passwordExp()"
						class="form-control" style="width: 300px"> <span
						id="passwordExp"></span><br>
				</div>
				<div class="form-group">
					비밀번호 확인: <input type="password" id="passwordconfirm"
						placeholder="영어,숫자,특수문자  8~15글자" onkeyup="passwordcheck()"
						class="form-control" style="width: 300px"> <span id="p"></span><br>
				</div>
				<div class="form-group">
					이름 : <input type="text" name="name" id="name"
						placeholder="이름을 입력하세요." class="form-control" style="width: 300px"><br>
				</div>
				성별 :
				<div class="form-group">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <input type="radio"
							name="gender" id="gender1" autocomplete="off" value="남" checked>남자
						</label>
					</div>
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-primary active"> <input type="radio"
							name="gender" id="gender2" autocomplete="off" value="여">여자
						</label><br>
					</div>
				</div>
				<div class="form-group">
					생년월일 :<br> <input type="date" name="birthDay" id="birthDay"><br>
				</div>
				<div class="form-group">
					핸드폰 번호 : <input type="text" name="tel" id="tel"
						placeholder=" '-' 없이 작성해주세요." class="form-control"
						style="width: 300px"><br>
				</div>
				<!-- 다음 주소 api -->
				<div class="form-group">
					주소 : <input type="text" name="adrs_post_code" id="sample6_postcode"
						placeholder="우편번호" class="form-control" style="width: 500px">
					<input type="button" onclick="sample6_execDaumPostcode()"
						value="우편번호 찾기"><br>
					<br> <input type="text" name="adrs_street_1"
						id="sample6_address" placeholder="주소" class="form-control"><br>
					<input type="text" name="adrs_street_2" id="sample6_detailAddress"
						placeholder="상세주소" class="form-control"><br>
				</div>
				<div class="form-group">
					본인 소개 & 스펙 :<br>
					<textarea id="introduce" name="introduce" rows="10" cols="60"
						placeholder="가입 후 회원정보 수정으로 수정가능 합니다." class="form-control"></textarea>
					<br>
				</div>
				<div class="form-group">
					이메일: <input type="email" name="email" id="email"
						placeholder="가입후 인증이 필요합니다." class="form-control"
						style="width: 500px">
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp; 이메일 인증을 위해 정확히 적어주세요.<br> <br>
				<br>
				<div class="form-group">
					<input type="file" name="profile_Photo" id="profile_Photo"><br>
				</div>
				&nbsp;&nbsp;&nbsp;&nbsp; 디자이너는 프로필사진이 필수입니다.<br> <br> <input
					type="submit" onclick="Join();" value="join"
					class="btn btn-primary py-3 px-5"> <input type="reset"
					value="초기화" class="btn btn-primary py-3 px-5">
			</form>
		</div>
	</div>

	<br>
	<br>
	<br>
	<%@include file="includeFooter.jsp"%>
</body>
</html>