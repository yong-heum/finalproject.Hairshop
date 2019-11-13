<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>

function ticketing_Block_Insert(){
	
	if($('input[name="work_Time"]:checked').val()==""){
		 alert("작성하지 않은 부분이 있는지 확인하세요.");
		 return false;

	}else{
		submit.submit();
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
								<span>예약하기 <i class="ion-ios-arrow-forward"></i></span>
							<span>예약 막기 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">예약 막기</h1>
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

<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" style="float:left; margin-left:30%;">메인가기</button>
<button onclick="history.back()" class="btn btn-primary" style="float:left; margin-left:1%;">뒤로가기</button><br><br>

<div class="container" style="width: 800px;">
<div class="bg-light p-5 contact-form text-center">
<h2 class="text-center">예약 막기</h2><br><br>

<div class="row block-9 justify-content-center mb-5" >
<form action="ticketing_Block_Insert" method="post" onsubmit="return false" name="submit" enctype="multipart/form-data">
	<input type="radio" name="work_Time" id="disigner_Text" value="" checked="checked" style="display: none;">
<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
<tr class='table-info'>
<td>예약 가능 여부/예약시간</td></tr>
	<c:if test="${sysDate==ticketing.work_Date}">
	<c:forEach var="ticketing_List" items="${ticketing_List}" varStatus="status">
<tr>

<!-- 현제시간 전으로는 예약불가 -->
<td style="margin:0; padding:0;">
	<c:if test="${sysDate_HH>=ticketing_List.rn }">
	<c:if test="${price.rn_Open<=ticketing_List.rn || price.rn_Closeds>=ticketing_List.rn}">
	 <a style="color:red;">예약불가</a>&nbsp;&nbsp;&nbsp;
			${ticketing_List.time}<br>
		</c:if>
	</c:if>
<!-- 예약 되어있는 시간은 예약 불가 -->
	<c:if test="${sysDate_HH<ticketing_List.rn }">
		<c:if test="${price.rn_Open<=ticketing_List.rn || price.rn_Closeds>=ticketing_List.rn}">
	
			<c:if test="${ticketing_List.time == ticketing_List.work_Time}"> <a style="color:red;">예약불가</a>&nbsp;&nbsp;&nbsp;
			${ticketing_List.time}<br>
			</c:if>
	
<!-- 예약 되어있지 않은 시간은 예약 가능 -->
		<c:if test="${ticketing_List.time != ticketing_List.work_Time}">
			<label for="disigner_Text${ticketing_List.rn}">예약가능 &nbsp;&nbsp;&nbsp;${ticketing_List.time}</label>
			<input type="radio" name="work_Time" id="disigner_Text${ticketing_List.rn}" value="${ticketing_List.time}"><br>
		</c:if>
	</c:if>
</c:if>
</td>
</tr>
</c:forEach>
</c:if>

<!-- 오픈시간 마감시간 이전 이후 처리 -->
<c:if test="${sysDate!=ticketing.work_Date}">
	<c:forEach var="ticketing_List" items="${ticketing_List}" varStatus="status">
		<c:if test="${price.rn_Open<=ticketing_List.rn && price.rn_Closeds>=ticketing_List.rn}">
<tr><td style="margin:0; padding:0;">
	
			<c:if test="${ticketing_List.time == ticketing_List.work_Time}"> <a style="color:red;">예약불가</a>&nbsp;&nbsp;&nbsp;
			${ticketing_List.time}<br>
			</c:if>
	
		<c:if test="${ticketing_List.time != ticketing_List.work_Time}">
			<label for="disigner_Text${ticketing_List.rn}">예약가능 &nbsp;&nbsp;&nbsp;${ticketing_List.time}</label>
			<input type="radio" name="work_Time" id="disigner_Text${ticketing_List.rn}" value="${ticketing_List.time}"><br>
		</c:if>
</td></tr>
	</c:if>
</c:forEach>
</c:if>
</table>
	<br><br>
	<input type="hidden" name="shopName" value="${ticketing.shopName}">
	<input type="hidden" name="disigner" value="${ticketing.disigner}">
	<input type="hidden" name="work_Date" value="${ticketing.work_Date}">
	
	
	<input type="submit" onclick="ticketing_Block_Insert();" value="예약 막기" class="btn btn-primary">
	</form>
	</div>
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