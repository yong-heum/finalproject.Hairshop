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
	/*모두작성이 되었는지 & 정규식이 맞는지 확인 &비밀번호가 일치 하는지 확인 */
	function passwordFind1() {

		if ($('#id').val() == "" || $('#email').val() == ""|| $('#birthDay').val() == ""|| $('#name').val() == "") {
			alert('작성하지 않은 부분이 있는지 확인하세요.');
			return false;
		}else{
			passwordFind.submit();
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
						<span class="mr-2"><a href="loginJSP">Login <i
								class="ion-ios-arrow-forward"></i></a></span> <span>아이디 찾기 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">비밀번호 찾기</h1>
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
		<div class="col-md-4 mb-md-5">
		<button onclick="history.back()" class="btn btn-primary" style="float:left; margin-left:1%;">뒤로가기</button><br><br>
			<h2 class="text-center">비밀번호 찾기</h2>
			
	<form action="passwordFind" method="post" onsubmit="return false" name="passwordFind" class="bg-light p-5 contact-form" style="width: 100%;">
		이름 : <input type="text" name="name" id="name"  class="form-control" style="width: 250px"><br>
		아이디 : <input type="text" name="id" id="id"  class="form-control" style="width: 300px"><br>
		이메일 : <input type="email" name="email" id="email"  class="form-control" style="width: 350px"><br>
		생일 : <input type="date" name="birthDay" id="birthDay"><br>
		<input type="submit" onclick="passwordFind1()" class="btn btn-primary py-3 px-5" style="float:right"><br><br>
	</form>
	</div>
	</div>
		
	<br>
	<br>
	<br>
	<%@include file="includeFooter.jsp"%>
	
</body>
</html>