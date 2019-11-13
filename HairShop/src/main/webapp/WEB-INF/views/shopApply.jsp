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
								<span>매장 둘러 보기 <i class="ion-ios-arrow-forward"></i></span>
							<span>매장 등록 신청 내역 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">매장 등록 신청 내역</h1>
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
	
<button class="btn btn-primary" onclick="location.href='mainJSP?id=${sessionScope.sessionId}'"
style="float:left; margin-left:18%;">메인가기</button><br><br>


	<c:if test="${shopApply.size()==0}">
	<h2 class="mb-3 bread" style="text-align: center;">"등록 정보가 없습니다."</h2>
	</c:if>

	<c:forEach var="shopApply" items="${shopApply}" varStatus="status">
	<div class="container">
	<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
	
<tr>
<td class='table-info'>이름</td> <td>${shopApply.shopName}</td>
</tr>
<tr>
<td class='table-info'>매장 전화번호</td> <td>${shopApply.tel}</td>
</tr>
<tr>
<td class='table-info'>매장 주소</td> <td>${shopApply.adrs_post_code}&nbsp;${shopApply.adrs_street_1}&nbsp;${shopApply.adrs_street_2}</td>
</tr>
<tr>
<td class='table-info'>매장 관리자</td> <td>${shopApply.shop_Manager}</td>
</tr>
<tr>
<td class='table-info'>매장 소개</td> <td>${shopApply.introduce}</td>
</tr>
<tr>
<td class='table-info'>등록된 사진</td> <td>
	<c:if test="${shopApply.shop_Photo_Name_add1 == null}">
매장 사진이 없습니다.
</c:if>
	<c:choose>
	<c:when test="${shopApply.shop_Photo_Name_add5 != null}"> 
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add2}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add3}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add4}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add5}" style="width: 300px; height: 300px;">
	</c:when>
	<c:when test="${shopApply.shop_Photo_Name_add4 != null}">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add2}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add3}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add4}" style="width: 300px; height: 300px;">
	</c:when>
	<c:when test="${shopApply.shop_Photo_Name_add3 != null}">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add2}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add3}" style="width: 300px; height: 300px;">
	</c:when>
	<c:when test="${shopApply.shop_Photo_Name_add2 != null}">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add2}" style="width: 300px; height: 300px;">
	</c:when>
	<c:when  test="${shopApply.shop_Photo_Name_add1 != null}">
		<img src="resources/shop_photo/${shopApply.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
	</c:when>
	</c:choose>
	</td>
	</tr>
	<tr>
<td class='table-info'>시술 가격표</td> <td>	<c:if test="${shopApply.menu_Photo_Name!=null}">
	<img src="resources/menu_photo/${shopApply.menu_Photo_Name}" style="width: 60%; height: 400px;">
	<c:if test="${shopApply.menu_Contents!=null}">
 	${shopApply.menu_Contents}
 	</c:if>
</c:if>
	<c:if test="${shopApply.menu_Photo_Name==null&&shopApply.menu_Contents==null}">
	시술 가격표 정보가 없습니다.
</c:if></td>
</tr>
</table>
	<button class="btn btn-primary" onclick="location.href='shopApply2?pid_shop=${shopApply.pid}&pid_User=${sessionScope.sessionId}'"
		style="float:right; margin-right:1%;">승인하기</button>
	<button class="btn btn-primary" onclick="location.href='shopApplyDelete?pid_shop=${shopApply.pid}'"
	style="float:right; margin-right:1%;">삭제하기</button>
	
	<br><br><br><br>
	</div>
</c:forEach>

	<br>
	<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>
</body>
</html>