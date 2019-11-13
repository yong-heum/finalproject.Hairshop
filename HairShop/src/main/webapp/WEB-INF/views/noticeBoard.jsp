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
								class="ion-ios-arrow-forward"></i></a></span> <span>공지사항 <i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">공지사항</h1>
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
	
	
<div class="container">
<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" >메인가기</button><br><br><br>
<div class=”row“ >
	<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
<tr class='table-info'>
<th style="width:130px;">게시글번호 </th>
<th>제목 </th>
<th style="width:150px;">작성자</th>
<th style="width:230px;">작성날짜</th>
<th style="width:90px;">조회수</th>
</tr>
<c:forEach var="noticeList" items="${noticeList}" varStatus="status">
<tr>
<td>${noticeList.boardNum}</td>
<td><a href="noticeHitUp?page=${paging.page}&boardNum=${noticeList.boardNum}">${noticeList.title}</a></td>
<td>${noticeList.name}</td>
<td>${noticeList.notice_Date}</td>
<td>${noticeList.hit}</td>
</tr>
</c:forEach>
</table>
</div>
</div>

<!-- 페이징 처리 기본-->
<div class="row mt-5">
          <div class="col text-center">
            <div class="block-27">
              <ul>
<c:if test="${paging.page<=1}">
	<li><a href="#11">&lt;</a></li>
</c:if>
<c:if test="${paging.page>1}">
	<li><a href="noticeBoard?page=${paging.page-1}">&lt;</a></li>&nbsp;
</c:if>
<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
	<c:choose>
		<c:when test="${i eq paging.page}">
			<li class="active"><a href="#11">${i}</a></li>
		</c:when>
		<c:otherwise>
			<li><a href="noticeBoard?page=${i}">${i}</a></li>
		</c:otherwise>
	</c:choose>
</c:forEach>

<c:if test="${paging.page>=paging.maxPage}">
<li><a href="#11">&gt;</a></li>
</c:if>
<c:if test="${paging.page<paging.maxPage}">
<li><a href="noticBoard?page=${paging.page+1}">&gt;</a></li>
</c:if>
</ul>
</div>
</div>
</div>

<br>
<%-- <c:if test="${sessionScope.sessionId eq 'admin'}"> --%>
<button onclick="location.href='noticeInsertJSP'" class="btn btn-primary" style="float:right; margin-right:18%;">공지사항 작성</button>
<%-- </c:if> --%>
<br>
	<br>
	<br><br>
	<br>
	<br>
	

<%@include file="includeFooter.jsp"%>
</body>
</html>