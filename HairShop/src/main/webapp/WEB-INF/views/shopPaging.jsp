<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
/*모두작성이 되었는지 & 정규식이 맞는지 확인 &비밀번호가 일치 하는지 확인 */
	function search1() {
		var searchContents=$('#searchContents').val();
	
		if ($('#searchContents').val() == ""){
			alert('검색어를 적어주세요.');
			return false;
		}else{
			location.href="search?page=0&searchContents="+searchContents;
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
								class="ion-ios-arrow-forward"></i></a></span> <span>매장 둘러보기 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">매장 둘러보기</h1>
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
<div class="row" >
<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" style="padding:14px;">메인가기</button>
</div>
</div>
<br><br>
<div class="container">
<input type="button" onclick="search1()" value="확인" style="float:right; padding:15px;" class="btn btn-primary">
<input type="text" name="searchContents" id="searchContents" placeholder="매장이름,동네이름 검색" style="float:right; width:20%;" class="form-control">
</div>

<br>
<br>

<section class="ftco-section">
    	<div class="container">
<c:if test="${sessionScope.sessionIdCheck eq DN || sessionScope.sessionId eq admin}">
<div class="row" >
<button onclick="location.href='shopInsertJSP'"  class="btn btn-outline-primary" style="margin-left:2%;">매장등록</button> <br>
</div>
</c:if><br>
        <div class="row">
<c:forEach var="shopList" items="${shopList}" varStatus="status">
        	<div class="col-md-4">
        		<div class="property-wrap ftco-animate">
<a href="shopSelect?pid_Shop=${shopList.pid}&page=${paging.page}">
<img src="resources/shop_photo/${shopList.shop_Photo_Name_add1}" style="width: 95%; height: 300px;"></a><br>
        			<div class="text">
        				<h3><a href="shopSelect?pid_Shop=${shopList.pid}&page=${paging.page}">${shopList.shopName}</a></h3>
        				<span class="location">${shopList.adrs_street_1}</span>
        				<a href="shopSelect?pid_Shop=${shopList.pid}&page=${paging.page}" class="d-flex align-items-center justify-content-center btn-custom">
        					<span class="ion-ios-link"></span>
        				</a>
        			</div>
        		</div>
        	</div>

<c:if test="${empty shopList}"> 
조회결과가 없습니다.<br>
</c:if>

</c:forEach>
</div>
</div>
</section>

<!-- 페이징 처리 기본-->
<div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
<c:if test="${paging.NPorSP_Page==0}">
<c:if test="${paging.page<=1}">
	<li><a href="#11">&lt;</a></li>
</c:if>
<c:if test="${paging.page>1}">
	<li><a href="shopPaging?page=${paging.page-1}&adrs_street_1=${paging.adrs_street_1}">&lt;</a></li>&nbsp;
</c:if>
<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
	<c:choose>
		<c:when test="${i eq paging.page}">
			<li class="active"><a href="#11">${i}</a></li>
		</c:when>
		<c:otherwise>
			<li><a href="shopPaging?page=${i}&adrs_street_1=${paging.adrs_street_1}">${i}</a></li>
		</c:otherwise>
	</c:choose>
</c:forEach>

<c:if test="${paging.page>=paging.maxPage}">
<li><a href="#11">&gt;</a></li>
</c:if>
<c:if test="${paging.page<paging.maxPage}">
<li><a href="shopPaging?page=${paging.page+1}&adrs_street_1=${paging.adrs_street_1}">&gt;</a></li>
</c:if>
</c:if>

<!-- 페이징 처리 검색 -->
<c:if test="${paging.NPorSP_Page==1}">
<c:if test="${paging.page<=1}">
	<li><a href="#11">&nbsp;</a></li>
</c:if>
<c:if test="${paging.page>1}">
	<li><a href="search?page=${paging.page-1}&searchContents=${paging.searchContents}">&nbsp;</a></li>&nbsp;
</c:if>
<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
	<c:choose>
		<c:when test="${i eq paging.page}">
			<li class="active"><a href="#11">${i}</a></li>
		</c:when>
		<c:otherwise>
			<li><a href="search?page=${i}&searchContents=${paging.searchContents}">${i}</a></li>
		</c:otherwise>
	</c:choose>
</c:forEach>

<c:if test="${paging.page>=paging.maxPage}">
<li><a href="#11">&gt;</a></li>
</c:if>
<c:if test="${paging.page<paging.maxPage}">
<li><a href="search?page=${paging.page+1}&searchContents=${paging.searchContents}">&gt;</a></li>
</c:if>
</c:if>
</ul>
</div>
</div>
</div>


	<br>
	<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>

</body>
</html>