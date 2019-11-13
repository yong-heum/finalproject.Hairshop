<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
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
					<h1 class="mb-3 bread">리뷰 게시판</h1>
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
	<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" style="float:left; margin-left:6%;">메인가기</button><br><br><br><br>
	<div class="low"  style="text-align: -webkit-center;">
	<button class="btn btn-outline-primary" onclick="location.href='reviewInsertJSP?id=${sessionScope.sessionId}'"
style="float:right; margin-right:3%; margin-bottom:10px;">리뷰 작성</button>
<div class="row block-9 justify-content-center mb-5" style="width:95%;">
<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
<tr class='table-info'>
<th style="width:130px;">게시글번호 </th>
<th>제목 </th>
<th style="width:300px;">매장이름</th>
<th style="width:150px;">디자이너</th>
<th style="width:150px;">작성자</th>
<th style="width:230px;">작성날짜</th>
<th style="width:90px;">조회수</th>
</tr>
<c:forEach var="reviewList" items="${reviewList}" varStatus="status">
<tr>
<td>${reviewList.boardNum}</td>
<td><a href="reviewHitUp?page=${paging.page}&boardNum=${reviewList.boardNum}">${reviewList.title}&nbsp;&nbsp;(${reviewList.commentCount})</a></td>
<td>${reviewList.shopName}</td>
<td>${reviewList.disigner}</td>
<td>${reviewList.name}</td>
<td>${reviewList.review_Date}</td>
<td>${reviewList.hit}</td>
</tr>
</c:forEach>
</table>
</div>
</div>
<br>

<!-- 페이징 처리 기본-->
<div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
<c:if test="${paging.page<=1}">
<li><a href="#11">&lt;</a></li>
</c:if>
<c:if test="${paging.page>1}">
	<li><a href="reviewBoard?page=${paging.page-1}">&lt;</a></li>&nbsp;
</c:if>
<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
	<c:choose>
		<c:when test="${i eq paging.page}">
			<li class="active"><a href="#11">${i}</a></li>
		</c:when>
		<c:otherwise>
			<li><a href="reviewBoard?page=${i}">${i}</a></li>
		</c:otherwise>
	</c:choose>
</c:forEach>

<c:if test="${paging.page>=paging.maxPage}">
<li><a href="#11">&gt;</a></li>
</c:if>
<c:if test="${paging.page<paging.maxPage}">
<li><a href="reviewBoard?page=${paging.page+1}">&gt;</a></li>
</c:if>
</ul>
</div>
</div>
</div>
<br>

<br>
	<br>
	<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>

</body>
</html>