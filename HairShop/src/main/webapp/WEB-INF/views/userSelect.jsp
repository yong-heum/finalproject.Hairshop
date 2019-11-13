<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>

<script>
	var passwordCheck = 0;

	//수정,삭제, 비밀번호수정 버튼 눌렀을때 비밀번호칸 생성
	$(document).ready(function() {
		$("#userUpdate").click(function() {
			$("#updatePassword1").show();
			passwordCheck = 1;
		});
		$("#userDelete").click(function() {
			$("#updatePassword1").show();
			passwordCheck = 2;
		});
		$("#userPasswordUpdate").click(function() {
			$("#updatePassword1").show();
			passwordCheck = 3;
		});
		$(document).ready(function() {
			$("#updatePassword1").hide();
		});
	});

	$(document).ready(
			function() {
				$("#updatePassword2").click(
						function() {
							var password = $("#password1").val();
							location.href = "updatePassword?pid=${sessionScope.sessionPid}"
									+ "&password=" + password
									+ "&passwordCheck=" + passwordCheck
									+ "&id=${userSelect.id}&name=${userSelect.name}&gender=${userSelect.gender}&birthDay=${userSelect.birthDay}&tel=${userSelect.tel}&adrs_post_code=${userSelect.adrs_post_code}&adrs_street_1=${userSelect.adrs_street_1}&userSelect=${userSelect.adrs_street_2}&userSelect=${userSelect.email}&userSelect=${userSelect.join_date}"
						});
			});
</script>

<script>
    function caps_lock(e) {
            var keyCode = 0;
            var shiftKey = false;
            keyCode = e.keyCode;
            shiftKey = e.shiftKey;
            if (((keyCode >= 65 && keyCode <= 90) && !shiftKey)
                    || ((keyCode >= 97 && keyCode <= 122) && shiftKey)) {
                show_caps_lock();
                setTimeout("hide_caps_lock()", 2500);
            } else {
                hide_caps_lock();
            }
        }
 
    function show_caps_lock() {
         $("#capslock").show();
    }
 
    function hide_caps_lock() {
         $("#capslock").hide();
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
								class="ion-ios-arrow-forward"></i></a></span> <span>회원정보 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">회원정보</h1>
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

<c:if test="${sessionScope.sessionIdCheck=='DN'}">
<button class="btn btn-outline-primary" onclick="location.href='priceSelect?disigner_id=${userSelect.id}&check=1'" style="float:right; margin-right:18%;">나의 시술금액 확인/수정</button><br>
<br></c:if>
<div class="container">
<div class="row" >
	<table class="table table-striped" style="text-align:center;" >
	<tr>
	<th>아이디</th> <th>이름</th> <th>생년월일</th> <th>성별</th> <th>이메일</th> <th>전화번호</th> <th>주소</th> <th>보유 포인트</th>
	</tr>
	<tr>
	<td>${userSelect.id}</td>
	<td>${userSelect.name}</td>
	<td>${userSelect.birthDay}</td>
	<td>${userSelect.gender}</td>
	<td>${userSelect.email}</td>
	<td>${userSelect.tel}</td>
	<td>${userSelect.adrs_street_1} ${userSelect.adrs_street_2}</td>
	<td>${point}</td></tr>
	</table>
	</div>
	</div>
	<br>
	<br>

	<!-- <input type="button" value="목록보기" onclick='#'> -->
	<div style="float:right; margin-right:18%;">
	<button id="userUpdate" class="btn btn-primary">회원정보 수정</button>
	<button id="userDelete" class="btn btn-primary">회원정보 삭제</button>
	<button id="userPasswordUpdate" class="btn btn-primary">비밀번호 변경</button>


	<div id="updatePassword1" > 
		<input type="hidden" name="pid" id="pid" value="${sessionScope.sessionPid}"> 
		<input type="password"class="form-control" name="password" id="password1" placeholder="비밀번호를 입력하세요." style="width: 300px;" onkeypress="caps_lock(event)">
<a id="capslock" style="position:relative; border:2px solid #003b83; width:300px; bottom:0px; display:none"> 
    &nbsp;<b>CapsLock</b> 키가 눌려있습니다.&nbsp;
</a><br>
		<input type="button" id="updatePassword2" class="btn btn-primary" value="확인"><br>
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