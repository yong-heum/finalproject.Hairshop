<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
								class="ion-ios-arrow-forward"></i></a></span> <span>리뷰 게시판 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">리뷰게시판</h1>
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
<button onclick="history.back()" class="btn btn-primary">돌아가기</button><br><br>
<div class=”row“ >

<table class='table table-bordered specialCollapse' style='text-align:center;'>
<tr class='table-info'><th style="width:350px;">매장이름</th><th  style="width:200px;">디자이너</th><th>평점</th><th style="width:170px;">작성자</th><th style="width:250px;">작성 날짜</th><th style="width:80px;">조회수</th></tr>
<tr><td>${reviewSelect.shopName}</td><td> ${reviewSelect.disigner}</td><td>${reviewSelect.grade}</td><td>${reviewSelect.id}</td><td>${reviewSelect.review_Date}</td><td>${reviewSelect.hit}</td></tr>
<tr class='table-info'><th colspan="6">제목</th></tr>
<tr><td colspan="6">${reviewSelect.title}</td></tr>
<tr class='table-info'><th colspan="6">내용</th></tr>
<tr><td colspan="6"  style="height:500px;">${reviewSelect.contents}</td>
</tr>
</table>
</div>
</div>
	<br>
	<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>
</body>
</html>