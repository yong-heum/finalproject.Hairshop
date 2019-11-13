<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<script>
 var pwdc = 0;
 var pwdcheck = 0;

/* 	비밀번호 정규식 */
 	function passwordExp(){
	    //ㅂㅣ밀번호 검증을 위한 정규식 선언
	    var exp =/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	    var password = document.getElementById('password');
	    var passwordExp = document.getElementById('passwordExp');
	    if(password.value.match(exp)){
	        passwordExp.style.color ="black";
	        passwordExp.innerHTML ="사용가능한 비밀번호형식입니다.";
	        pwdc = 1;
	    }else {
	        passwordExp.style.color="red";
	        passwordExp.innerHTML="형식에맞는 비밀번호를 입력하세요";
	        pwdc = 0;
	    }

	} 

/* 비밀번호확인 */
	function passwordcheck(){
	    var pp= document.getElementById('pp');

	    if($('#password').val()== $('#passwordconfirm').val()){
	        pp.innerHTML="비밀번호가 일치 합니다.";
	        pwdcheck = 1;
	    }else{
	        pp.innerHTML="비밀번호가 일치하지않습니다.";
	        pwdcheck = 0;
	    }

	}
	
/*모두작성이 되었는지 & 정규식이 맞는지 확인 &비밀번호가 일치 하는지 확인 */
	function userPasswordUpdate1(){
		
	if($('#password').val()==""||$('#passwordconfirm').val()==""){
		 alert('작성하지 않은 부분이 있는지 확인하세요.');
		 return false;
	}
	else if(pwdc == '0'){
		alert("비밀번호양식에 맞게 쓰세요.");
	      return false;
	}
	else if(pwdcheck == '0'){
		alert("비밀번호가 일치하는지 확인하세요.");
	      return false;
	}
	else{
		userPasswordUpdate.submit();
	}
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
								<span>비밀번호 변경 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">비밀번호 변경</h1>
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
	<div class="row block-9 justify-content-center mb-5">
<form action="userPasswordUpdate" method="post" onsubmit="return false" name="userPasswordUpdate" class="bg-light p-5 contact-form" style="width: 600px;">
			<h2 class="text-center">비밀번호 변경</h2><br>
<input type="hidden" name="pid" value="${sessionScope.sessionPid}">
변경할 비밀번호 : <input type="password" name="password" id="password" onkeyup="passwordExp()" class="form-control"  style="width: 400px;" ><span id="passwordExp"></span><br>
변경할 비밀번호 확인 : <input type="password" name="passwordconfirm" id="passwordconfirm" onkeyup="passwordcheck()" class="form-control"  style="width: 400px;" ><span id="pp"></span><br>
<input type="submit" value="확인" onclick="userPasswordUpdate1()" class="btn btn-primary">
<input type="submit" value="취소" onclick="history.back()" class="btn btn-primary">
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