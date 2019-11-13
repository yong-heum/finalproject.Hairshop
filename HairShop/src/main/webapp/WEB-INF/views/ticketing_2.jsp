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
/*모두작성이 되었는지 & 아이디 인증 & 비밀번호가 일치 하는지 확인 */
function ticketing(){
	
	if($('input[name="work"]:checked').val()==""||$('input[name="work_Time"]:checked').val()==""){
		 alert("작성하지 않은 부분이 있는지 확인하세요.");
		 return false;
	}
	else if($('#point_Use').val()==""){
		alert("사용할 포인트를 적어주세요. 포인트를 사용하지 않는다면 '0'을 입력해주세요");
		return false;
	}else if($("#point_Use").val()>${point}){
		alert("보유포인트보다 많은 포인트를 사용 할 수 없습니다.");
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
							<span>예약 하기 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">예약 하기</h1>
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
	
	
<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" style="float:left; margin-left:30%;">메인가기</button>
<button onclick="history.back()" class="btn btn-primary" style="float:left; margin-left:1%;">뒤로가기</button><br><br>

<h2 class="text-center">예약 하기</h2><br><br>

<form action="ticketing" method="post" onsubmit="return false" name="submit" enctype="multipart/form-data" >

<div class="bg-light p-5 contact-form text-center" style="width: 800px; height: 1820px; float:left; margin-left:30%; position:absolute ">
<div class="container">

	<div style="float:left; margin-left:1%; margin:0;">
	<input type="radio" name="work_Time" id="disigner_Text" value="" checked="checked" style="display: none;">
	<table class='table table-bordered table-hover specialCollapse' style='text-align:center;'>
<tr class='table-info'>
<th>예약 가능 여부/예약시간</th></tr>
	<c:if test="${sysDate==ticketing.work_Date}">
	<c:forEach var="ticketing_List" items="${ticketing_List}" varStatus="status">
	
	<tr><td style="margin:0; padding:0;">
<!-- 현제시간 전으로는 예약불가 -->
	<c:if test="${sysDate_HH>=ticketing_List.rn }">
	<c:if test="${price.rn_Open<=ticketing_List.rn && price.rn_Closeds>=ticketing_List.rn}">
	 <a style="color:red;">예약불가</a>&nbsp;&nbsp;&nbsp;
			${ticketing_List.time}<br>
		</c:if>
	</c:if>
	
<!-- 예약 되어있는 시간은 예약 불가 -->
	<c:if test="${sysDate_HH<ticketing_List.rn }">
		<c:if test="${price.rn_Open<=ticketing_List.rn && price.rn_Closeds>=ticketing_List.rn}">
	
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
</div>
</div>

<div style="float:left; margin-left:25%;">
<table class='table table-bordered specialCollapse' style='text-align:center;'>
<tr class='table-info'>
<th>남자</th>
	<tr>
	<td style="text-align:left; padding:35px;">
	<input type="radio" name="work" id="work" value="" checked="checked" style="display: none;">
	
	<input type="radio" name="work" id="work1" value="남자 컷.${price.m_cut}">
	<label for="work1">남자 컷 : ${price.m_cut}원 </label><br>
	
	<input type="radio" name="work" id="work2" value="남자 일반 펌.${price.m_purm}">
	<label for="work2">남자 일반 펌 : ${price.m_purm}원 </label><br>
	
	<input type="radio" name="work" id="work3" value="남자 디자인 펌.${price.m_sc_purm}">
	<label for="work3">남자 디자인 펌 : ${price.m_sc_purm}원 </label><br>
	
	<input type="radio" name="work" id="work4" value="남자 매직.${price.m_magic}">
	<label for="work4">남자 매직 : ${price.m_magic}원 </label><br>
	
	<input type="radio" name="work" id="work5" value="남자 볼륨매직.${price.m_b_magic}">
	<label for="work5">남자 볼륨매직 : ${price.m_b_magic}원 </label><br>
	
	<input type="radio" name="work" id="work6" value="남자 컬러.${price.m_color}">
	<label for="work6">남자 컬러 : ${price.m_color}원 </label><br>
	
	<input type="radio" name="work" id="work7" value="남자 크리닉.${price.m_clinic}">
	<label for="work7">남자 크리닉 : ${price.m_clinic}원 </label><br>
	</td>
	</tr>
	</table>
	<br>
	
	<table class='table table-bordered specialCollapse' style='text-align:center;'>
<tr class='table-info'>
<th>여자</th>
	<tr>
	<td style="text-align:left; padding:35px;">
	<input type="radio" name="work" id="work8" value="여자 컷.${price.w_cut}">
	<label for="work8">여자 컷 : ${price.w_cut}원 </label><br>
	
	<input type="radio" name="work" id="work9" value="여자 일반 펌.${price.w_purm}">
	<label for="work9">여자 일반 펌 : ${price.w_purm}원 </label><br>
	
	<input type="radio" name="work" id="work10" value="여자 디지털 펌.${price.w_d_purm}">
	<label for="work10">여자 디지털 펌 : ${price.w_d_purm}원 </label><br>
	
	<input type="radio" name="work" id="work11" value="여자 매직.${price.w_magic}">
	<label for="work11">여자 매직 : ${price.w_magic}원</label><br>
	
	<input type="radio" name="work" id="work12" value="여자 볼륨매직.${price.w_b_magic}">
	<label for="work12">여자 볼륨매직 : ${price.w_b_magic}원</label><br>
	
	<input type="radio" name="work" id="work13" value="여자 셋팅.${price.w_setting}">
	<label for="work13">여자 셋팅 : ${price.w_setting}원</label><br>
	
	<input type="radio" name="work" id="work14" value="여자 매직셋팅.${price.w_m_setting}">
	<label for="work14">여여자 매직셋팅 : ${price.w_m_setting}원</label><br>
	
	<input type="radio" name="work" id="work15" value="여자 컬러.${price.w_color}">
	<label for="work15">여자 컬러 : ${price.w_color}원</label><br>
	
	<input type="radio" name="work" id="work15" value="여자 크리닉.${price.w_clinic}">
	<label for="work15">여자 크리닉 : ${price.w_clinic}원</label><br>
</td>
	</tr>
	</table>
		<br><br>
	<h4>포인트 사용</h4>  <input type="number" name="point_Use" id="point_Use" value="0" class="form-control" style="width: 300px;"><br>
	<h5>(사용가능한 포인트 : ${point})</h5>
	<br><br>
	<input type="hidden" name="point" value="${point}">
	<input type="hidden" name="shopName" value="${ticketing.shopName}">
	<input type="hidden" name="customer_id" value="${ticketing.customer_id}">
	<input type="hidden" name="disigner" value="${ticketing.disigner}">
	<input type="hidden" name="work_Date" value="${ticketing.work_Date}">
	
	<input type="submit" onclick="ticketing();" value="예약 하기" class="btn btn-primary  py-3 px-5" style="float:right; margin-right:1%;">
	</div>
	</div>
	
	</form>
	
	       <br>
	<br>
	<br><br>
	<br>
	<br>
	<div style="margin-top:1800px;">
<%@include file="includeFooter.jsp"%>
     </div>
</body>
</html>