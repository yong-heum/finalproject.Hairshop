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
								class="ion-ios-arrow-forward"></i></a></span> <span><a href="userSelect?id=${sessionScope.sessionId}">회원정보 <i
							class="ion-ios-arrow-forward"></i></a></span> <span>시술 금액 확인 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">시술 금액 확인</h1>
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
	
	
<button class="btn btn-outline-primary" onclick="location.href='priceSelect?disigner_id=${sessionScope.sessionId}&check=2'"
style="float:right; margin-right:18%;">직급,시술금액,근무시간 수정하기</button><br><br>

<div class="container">
<div class=”row“ >
<table class="table table-striped"  style="text-align:center;" >
<tr>
<th><h5>남자</h5></th><th><h5>여자</h5></th></tr>
<tr>
<td>
	남자 컷 : ${price.m_cut}원<br>
	남자 일반 펌 : ${price.m_purm}원<br>
	남자 디자인 펌 : ${price.m_sc_purm}원<br>
	남자 매직 : ${price.m_magic}원<br>
	남자 볼륨매직 : ${price.m_b_magic}원<br>
	남자 컬러 : ${price.m_color}원<br>
	남자 크리닉 : ${price.m_clinic}원<br><br>
	</td>
<td>
	여자 컷 : ${price.w_cut}원<br>
	여자 일반 펌 : ${price.w_purm}원<br>
	여자 디지털 펌 : ${price.w_d_purm}원<br>
	여자 매직 : ${price.w_magic}원<br>
	여자 볼륨매직 : ${price.w_b_magic}원<br>
	여자 셋팅 : ${price.w_setting}원<br>
	여자 매직셋팅 : ${price.w_m_setting}원<br>
	여자 컬러 : ${price.w_color}원<br>
	여자 크리닉 : ${price.w_clinic}원
	</td>
	</tr>
</table>
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