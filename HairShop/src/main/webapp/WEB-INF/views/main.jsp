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
								class="ion-ios-arrow-forward"></i></a></span>
					</p>
					<h1 class="mb-3 bread">Home</h1>
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
	<section class="ftco-section">
    	<div class="container">
    	<div class="row">
	<h3 style="float:laft; margin-left:1%; position: absolute;">최근 등록된 매장</h3>
	<a href="reviewBoard?page=0" style="float:laft; margin-left:19%; margin-top: 20px; margin-bottom: 8px;">더보기+</a>
	</div> 
        <div class="row">
<c:forEach var="shopList" items="${shopList}" varStatus="status">
        	<div class="col-md-3">
        		<div class="property-wrap ftco-animate">
<a href="shopSelect?pid_Shop=${shopList.pid}&page=${paging.page}"><img src="resources/shop_photo/${shopList.shop_Photo_Name_add1}" style="width: 95%; height: 250px;"></a><br>
        			<div class="text">
        				<h3><a href="shopSelect?pid_Shop=${shopList.pid}&page=${paging.page}">${shopList.shopName}</a></h3>
        				<span class="location">${shopList.adrs_street_1}</span>
        				<a href="shopSelect?pid_Shop=${shopList.pid}&page=${paging.page}" class="d-flex align-items-center justify-content-center btn-custom">
        					<span class="ion-ios-link"></span>
        				</a>
        			</div>
        		</div>
        	</div>

</c:forEach>
</div>
</div>
</section>
	
	<div class="container">
	<div class="row">
	<h3 style="float:laft; margin-left:2%; position: absolute;">공지사항</h3>
	 <a href="noticeBoardJSP?page=0" style="float:laft; margin-left:42%; margin-top: 20px;">더보기+</a>
	<h3 style="float:laft; margin-left:40%; position: absolute;">최근 올라온 리뷰</h3>
	<a href="reviewBoard?page=0" style="float:laft; margin-left:45.5%; margin-top: 20px;">더보기+</a>
	</div> 
	<div class="row justify-content-center" >
	<table class='table table-bordered table-hover specialCollapse' style="width:45%;">
<tr class='table-info'>
<th>제목 </th>
<th style="width:190px;">작성날짜</th>
</tr>
<c:forEach var="noticeList" items="${noticeList}" varStatus="status">
<tr>
<td><a href="noticeHitUp?page=0&boardNum=${noticeList.boardNum}">${noticeList.title}</a></td>
<td>${noticeList.notice_Date}</td>
</tr>
</c:forEach>
</table>


	<table class='table table-bordered table-hover specialCollapse' style="width:45%; margin-left:5%;">
<tr class='table-info'>
<th>제목 </th>
<th style="width:190px;">작성날짜</th>
</tr>
<c:forEach var="reviewList" items="${reviewList}" varStatus="status">
<tr>
<td><a href="reviewHitUp?page=0&boardNum=${reviewList.boardNum}">${reviewList.title}</a></td><td>${reviewList.review_Date}</td>
</tr>
</c:forEach>
</table>
</div>
	</div>
	
	
	

    <section class="ftco-section ftco-no-pb">
      <div class="container">
      	<div class="row justify-content-center">
          <div class="col-md-12 heading-section text-center ftco-animate mb-5">
          	<span class="subheading">Our Services</span>
            <h2 class="mb-2">The smartest way to do hair</h2>
          </div>
        </div>
        <div class="row d-flex">
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services d-block text-center">
            	<div class="icon d-flex justify-content-center align-items-center"><span class="flaticon-piggy-bank"></span></div>
              <div class="media-body py-md-4">
                <h3>Use of Points</h3>
                <p>리뷰를 달면 포인트를 지급하고,<br> 포인트를 사용해 시술금액 할인이 가능합니다.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services d-block text-center">
            	<div class="icon d-flex justify-content-center align-items-center"><span class="flaticon-wallet"></span></div>
              <div class="media-body py-md-4">
                <h3>Easy Payment System</h3>
                <p>언제 어디서나 간편하게 예약시간 확인 후 결제를 편하게 할 수 있습니다.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services d-block text-center">
            	<div class="icon d-flex justify-content-center align-items-center"><span class="flaticon-file"></span></div>
              <div class="media-body py-md-4">
                <h3>Record Confirmation</h3>
                <p>시술내역이 기록이 되며, 언제, 어디서, 얼마에 어떤 시술을 받았는지 기록이 됩니다.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services d-block text-center">
            	<div class="icon d-flex justify-content-center align-items-center"><span class="flaticon-locked"></span></div>
              <div class="media-body py-md-4">
                <h3>Privacy Protect</h3>
                <p>개인정보는 웹 사이트 사용 외에 다른곳에 사용 되지 않습니다.</p>
              </div>
            </div>      
          </div>
        </div>
      </div>
    </section>
	
	<br>
	<br>
	<br><br>
	<br>
	<br>
	

<%@include file="includeFooter.jsp"%>
</body>
</html>