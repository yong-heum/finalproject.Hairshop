<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>

$(document).ready(function() {
		$("#menuDelete").click(function() {
			alert("삭제되었습니다.");
			location.href="menuDelete?pid_Shop=${shop_List.pid}"+"&page=${paging}";			
	});
		$("#menuInsert").click(function() {
			location.href="menuInsert1?pid_Shop=${shop_List.pid}"+"&page=${paging}";			
	});
		$("#shopUpdate").click(function() {
			location.href="shopUpdate1?pid=${shop_List.pid}"+"&page=${paging}";			
	});
		$("#shopDelete").click(function() {
			alert("삭제되었습니다.");
			location.href="shopDelete?pid=${shop_List.pid}"+"&page=${paging}"+"&pid_user=${sessionScope.sessionPid}";			
	});
});
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
								class="ion-ios-arrow-forward"></i></a></span> <span>매장 둘러보기 <i
							class="ion-ios-arrow-forward"></i></span><span>매장 정보 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">매장 정보</h1>
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
<br><br>
<div class="container">
<button onclick="location.href='shopPaging?adrs_street_1=${sessionScope.adrs_street_1}&page=${paging}'"
class="btn btn-primary" style="float:left; margin-right:3px;" >목록으로</button>
<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" 
class="btn btn-primary" style="float:left" >메인가기</button>
</div>
<br><br>
<c:if test="${sessionScope.sessionId eq shopList.manager }">
<div class="container">
<button id="shopUpdate" style="float:right" class="btn btn-outline-primary">매장 수정</button>
<button id="shopDelete" style="float:right; margin-right:3px;" class="btn btn-outline-primary">매장 삭제</button>
</div>
</c:if>
<br><br>
<div class="container">
<div class="row" >
	<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
<!-- 매장 정보 소개 -->
	<tr>
	<th class='table-info'>매장 이름 </th><td> ${shop_List.shopName}</td></tr>
	<tr><th class='table-info'>매장 주소 </th><td>${shop_List.adrs_street_1} &nbsp;
	${shop_List.adrs_street_2}</td></tr>
	<tr><th class='table-info'>매장 전화번호 </th><td>${shop_List.tel}</td></tr>
	<tr><th class='table-info'>매장 오픈시간 </th><td>${shop_List.openTime}</td></tr>
	<tr><th class='table-info'>매장 마감시간 </th><td>${shop_List.closeTime}</td><tr>
	<tr><th class='table-info'>매장 오픈 날짜 </th><td>${shop_List.openDate}</td></tr>
	<tr><th class='table-info'>매장 책임자 </th><td>${shop_List.shop_Manager}</td></tr>
	<tr><th colspan='2' class='table-info'>매장 소개글 </th></tr>
	<tr><td colspan='2'>${shop_List.introduce}</td></tr>
	</table>
	</div>
	</div>
	<br><br><br>
	<div class="container">
<div class="row" >
	<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
<tr><th class='table-info'>매장 사진</th>	
	</tr>
	<tr>
	<td>
	<c:if test="${shop_List.shop_Photo_Name_add1==null}">
매장 사진이 없습니다.
</c:if>
<c:choose>
	<c:when test="${shop_List.shop_Photo_Name_add5 ne null}"> 
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add2}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add3}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add4}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add5}" style="width: 300px; height: 300px;">
	</c:when>
	<c:when test="${shop_List.shop_Photo_Name_add4!=null}">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add2}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add3}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add4}" style="width: 300px; height: 300px;">
	</c:when>
	<c:when test="${shop_List.shop_Photo_Name_add3!=null}">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add2}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add3}" style="width: 300px; height: 300px;">
	</c:when>
	<c:when test="${shop_List.shop_Photo_Name_add2!=null}">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add2}" style="width: 300px; height: 300px;">
	</c:when>
	<c:when  test="${shop_List.shop_Photo_Name_add1!=null}">
		<img src="resources/shop_photo/${shop_List.shop_Photo_Name_add1}" style="width: 300px; height: 300px;">
	</c:when>
	</c:choose>
	</td>
	</tr>
	</table>
	</div>
	</div>
	<br><br><br><br><br>
	
	
<!-- 디자이너 정보 소개 -->
<div class="container">
<div class="row"  style="text-align:center;">
<h1 class="col-md-12 mb-md-5"> 디자이너 정보</h1>
	<c:forEach var="shop_DN" items="${shop_DN}" varStatus="status">
	
	<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
	<tr><th class='table-info' style="width: 30%;">디자이너 사진 </th><td><img src="resources/profile_photo/${shop_DN.profile_Photo_Name}" style="width: 120px; height: 120px;"></td></tr>
	<tr><th class='table-info' style="width: 30%;">디자이너 이름 </th><td>${shop_DN.name}</td></tr>
	<tr><th class='table-info' style="width: 30%;">디자이너 직급 </th><td>${rank[status.index]}</td></tr>
	<tr><th class='table-info' style="width: 30%;">디자이너 소개 </th><td>${shop_DN.introduce}</td></tr>
</table>

<c:if test="${sessionScope.sessionId eq shop_List.shop_Manager}">
	<button onclick="location.href='shop_Disigner_Apply_Delete?belong_Shop=${shop_DN.belong_Shop}&id=${shop_DN.id}&pid=${sessionScope.sessionId}&page=0'"
	style="float:right; margin-bottom:50px;" class="btn btn-outline-primary">디자이너 방출하기</button><br>
	</c:if>
	
	</c:forEach>
</div>
</div>

<br><br><br>
<!-- 시술 가격표 등록,수정-->
<div class="container">
<div class="row"  style="text-align:center; justify-content: center;">
	<c:if test="${shop_List.menu_Photo_Name!=null}">
	<div class="col-md-6 mb-md-5"  style="text-align:center;">
<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
<tr><th class='table-info' style="width: 30%;">시술 가격표 </th></tr>
	<tr><td><img src="resources/menu_photo/${shop_List.menu_Photo_Name}" style="width: 100%; height: 500px;"></td></tr>
	</table>
	<c:if test="${shop_List.menu_Contents!=null}">
 	<br>${shop_List.menu_Contents}
 	</c:if>
 	</div>
</c:if>
</div>
	<c:if test="${shop_List.menu_Photo_Name==null&&shop_List.menu_Contents==null}">
	<br>시술 가격표 정보가 없습니다.
</c:if>
<br><br>

<button onclick="location.href='ticketingJSP_1?shopName=${shop_List.shopName}'" 
 style="float:right" class="btn btn-danger py-3 px-5">${shop_List.shopName}매장 예매하기</button>
</div>
	<br>
	<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>

</body>
</html>