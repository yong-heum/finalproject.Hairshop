<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
//승인하기 클릭시 confirm 
function pointApply(boardNum){

	var input = confirm('승인하시겠습니까?'); 
	var disigner_id=$("#sessionId").val();
	var customer_id=$("#id"+boardNum).val();
	if(input){
		location.href="pointApply?boardNum="+boardNum+"&disigner_id="+disigner_id+"&customer_id="+customer_id;
		}
	}

//포인트지급 목록에서 지우기 
function review_PointRS_UP(boardNum){
	
	var input = confirm('리뷰 게시판에서는 삭제 되지 않습니다. 목록에서 지우겠습니까?'); 
	var disigner_id=$("#sessionId").val();
	
	if(input){
		location.href="review_PointRS_UP?boardNum="+boardNum+"&disigner_id="+disigner_id;
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
								class="ion-ios-arrow-forward"></i></a></span> 
								<span>리뷰 확인 후 포인트 지급<i
							class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">리뷰 확인 후 포인트 지급</h1>
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
<div class="row block-9 justify-content-center mb-5" >
<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
<tr class='table-info'>
<td>게시글번호 </td>
<td>제목 </td>
<td>작성자</td>
<td>승인/삭제</td>

</tr>
<c:forEach var="reviewList" items="${reviewList}" varStatus="status">
<tr>
<td>${reviewList.boardNum}</td>
<td><a href="review_PointSelect?boardNum=${reviewList.boardNum}">${reviewList.title}</a></td>
<td>${reviewList.name}</td>
<td><button onclick="pointApply(${reviewList.boardNum})" class="btn btn-outline-primary" >승인하기</button>
<button onclick="review_PointRS_UP(${reviewList.boardNum})" class="btn btn-outline-primary" >포인트지급 목록에서 지우기</button>
<input type="hidden" id="id${reviewList.boardNum}" value="${reviewList.id}"></td>
</tr>
</c:forEach>
</table>
<c:if test="${reviewList=='[]'}">
<h2 class="text-center">등록정보가 없습니다.</h2>
</c:if>
</div>
</div>
<input type="hidden" id="sessionId" value="${sessionScope.sessionId}">
<input type="submit" value="돌아가기" onclick="history.back()" class="btn btn-primary" style="float:right; margin-right:18%;">
	<br>
	<br>
	<br>
	<br>
	<br>
	<%@include file="includeFooter.jsp"%>
	
</body>
</html>