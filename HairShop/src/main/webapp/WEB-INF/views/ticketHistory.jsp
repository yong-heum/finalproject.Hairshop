<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			<div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate pb-5 text-center">
					<p class="breadcrumbs">
						<span class="mr-2"><a href="mainJSP?id=${sessionScope.sessionId}">Home <i
								class="ion-ios-arrow-forward"></i></a></span> 
								<span>예약하기 <i class="ion-ios-arrow-forward"></i></span>
							<span>예약 내역 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">예약 내역</h1>
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
	
<div class="container">
<div class="bg-light p-5 contact-form text-center">
<h2 class="text-center">예약 내역</h2><br><br>

	<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
	<tr class='table-info'>
	<th>날짜</th>
	<th>예약자</th>
	<th>미용실</th>
	<th>디자이너</th>
	<th>예약시간</th>
	<th>시술</th>
	<th>시술금액</th>
	<th>사용한 포인트</th>
	<th>결제 금액</th>
	<th>시술 현황</th>
		<c:forEach var="ticketing" items="${ticketing}" varStatus="status">
		<tr>
			<td>${ticketing.work_Date}</td>
			<td>${ticketing.customer_name}</td>
			<td>${ticketing.shopName}</td>
			<td>${ticketing.disigner}</td>
			<td>${ticketing.work_Time}</td>
			<td>${ticketing.work}</td>
			<td>${ticketing.price_Original}</td>
			<td>${ticketing.point_Use}</td>
			<td>${ticketing.price_After}</td>
			<td>${ticketing.complete}</td>
			</tr>
		</c:forEach>
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