<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
function send(){
	
	if($('#title').val()==""||$('#contents').val()==""){
		 alert('작성하지 않은 부분이 있는지 확인하세요.');
		 return false;
	}else{
		send1.submit();
		 return false;
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
								class="ion-ios-arrow-forward"></i></a></span> <span>E-mail 문의 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">E-mail 문의</h1>
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
			<h2 class="text-center">E-mail 문의</h2>

	<form action="EmailInquiry" method="post" onsubmit="return false" name="send1" class="bg-light p-5 contact-form" >
	제목 : <input type="text" name="title" id="title" class="form-control"><br>
	내용 : <br><textarea name="contents" id="contents" rows="30" cols="70" placeholder="문의사항/신고 내용을 적어주세요." class="form-control"></textarea>
		<input type="hidden" name="id" id="id" value="${sessionScope.sessionId}"><br>
		<input type="submit" onclick="send()" value="보내기" class="btn btn-primary">
	</form>
	
	</div>
	</div>
	
	
	<br>
	<br>
	<br>
	<br>
	<%@include file="includeFooter.jsp"%>
</body>
</html>