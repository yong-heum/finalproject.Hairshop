<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
	
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
								<span>디자이너 메뉴 <i class="ion-ios-arrow-forward"></i></span>
							<span>소속매장 등록 신청 확인 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">소속매장 등록 신청 확인</h1>
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
	
<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" style="float:left; margin-left:18%;">메인가기</button><br><br>
<h2 class="text-center">소속매장 등록 신청 확인</h2><br><br>

<div class="container">
<div class=”row“ >

	<c:if test="${shop_Disigner_Apply.size()==0}">
	<div class="container" style="width: 800px;">
<div class="bg-light p-5 contact-form text-center">
<h2 class="text-center">"등록 정보가 없습니다."</h2>
	</div>
	</div>
	</c:if>

	<c:forEach var="shop_Disigner_Apply" items="${shop_Disigner_Apply}" varStatus="status">
	<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
<tr><td class='table-info'>디자이너 이름</td><td>${shop_Disigner_Apply.name}</td></tr>
<tr><td class='table-info'>디자이너 ID</td><td>${shop_Disigner_Apply.id}</td></tr>
<tr><td class='table-info'>전화번호</td><td>${shop_Disigner_Apply.tel}</td></tr>
<tr><td class='table-info'>성별</td><td>${shop_Disigner_Apply.gender}</td></tr>
<tr><td class='table-info'>주소</td><td>${shop_Disigner_Apply.adrs_post_code}&nbsp;${shop_Disigner_Apply.adrs_street_1}&nbsp;${shop_Disigner_Apply.adrs_street_2}</td></tr>
<tr><td class='table-info'>스팩&소개</td><td>${shop_Disigner_Apply.introduce}</td></tr>
<tr><td class='table-info'>등록된 사진 </td><td><img src="resources/profile_photo/${shop_Disigner_Apply.profile_Photo_Name}" style="width: 120px; height: 120px;"></td></tr>
</table>
	
	<button onclick="location.href='shop_Disigner_Apply?id=${shop_Disigner_Apply.id}&pid=${sessionScope.sessionId}'" 
	class="btn btn-primary" style="float:right; margin-right:1%;">승인하기</button>
	<button onclick="location.href='shop_Disigner_Apply_Delete?id=${shop_Disigner_Apply.id}&pid=${sessionScope.sessionId}&page=page'" 
	class="btn btn-primary" style="float:right; margin-right:1%;">삭제하기</button>

</c:forEach>
</div>
</div>



	<br>
	<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>
</body>
</html>