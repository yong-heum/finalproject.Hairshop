<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
//모두 값이 있는지 홧인후 form태그 서브밋 실행
	function priceUpdate(){
		
			if($('#rank').val()==""||$('#work_Open').val()==""||$('#work_Closeds').val()==""||$('#m_cut').val()==""||$('#m_purm').val()==""||$('#m_sc_purm').val()==""||$('#m_magic').val()==""||
					$('#m_b_magic').val()==""||$('#m_color').val()==""||$('#m_clinic').val()==""||$('#w_cut').val()==""||$('#w_purm').val()==""||
					$('#w_d_purm').val()==""||$('#w_magic').val()==""||$('#w_b_magic').val()==""||$('#w_setting').val()==""||$('#w_m_setting').val()==""||
					$('#w_color').val()==""||$('#w_clinic').val()==""||$('#work_Open').val()==""||$('#work_Closeds').val()==""||$('#rank').val()==""){
				
				alert("작성하지 않은 부분이 있는지 확인해 주세요.")
				return false;
			
			}else{
				priceUpdate1.submit();
				return false;
				}
		}
		
//돌아가기 
	function back(){
		history.back();
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
						<span class="mr-2"><a href="mainJSP?id=${sessionScope.sessionId}">Home 
						<i class="ion-ios-arrow-forward"></i></a></span> 
						<span>디자이너 메뉴
						<i class="ion-ios-arrow-forward"></i></span> 
						<span>나의 시술금액 보기 <i class="ion-ios-arrow-forward"></i></span>
						<span>직급, 시술금액, 근무시간 변경 . <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">직급, 시술금액, 근무시간 변경 .</h1>
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
	
<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" style="float:left; margin-left:25%;">메인가기</button>
<button onclick="history.back()" class="btn btn-primary" style="float:left; margin-left:1%;">뒤로가기</button><br><br>

<br>
	<div class="row block-9 justify-content-center mb-5">
		<div class="col-md-8 mb-md-5">
			<h2 class="text-center">직급, 시술금액, 근무시간 변경 .</h2>
	<br><br> 
	<form action="priceUpdate" method="post" onsubmit="return false" name="priceUpdate1" class="bg-light p-5 contact-form">
	<input type="hidden" name="disigner_name" id="disigner" value="${price.disigner_name}">
	<input type="hidden" name="disigner_id" id="disigner" value="${price.disigner_id}">
	
	직급 : <input type="text" name="rank" id="rank" value="${price.rank}"  class="form-control" style="width: 300px; "><br><br>
	근무 시작 시간 : <select name="ampm_Work_Open">
  				 <option value="오전">오전</option>
 				 <option value="오후">오후</option>
			 </select>
			 
			 <select name="work_Open" id="work_Open">
				 <c:forEach var="time_num" items="${time_num}" varStatus="status">
  					 <option value="${time_num}">${time_num}</option>
  				 </c:forEach>
			 </select>
	<br>
	근무 오픈 시간 : <select name="ampm_Work_Closeds">
  				 <option value="오후">오후</option>
 				 <option value="오전">오전</option>
			 </select>
 				 
			<select name="work_Closeds" id="work_Closeds">
				 <c:forEach var="time_num" items="${time_num}" varStatus="status">
  					 <option value="${time_num}">${time_num}</option>
  				 </c:forEach>
			 </select>
	<br><br><br>
	<h5>남자</h5><br>
	남자 컷 : <br><input type="text" name="m_cut" id="m_cut" value="${price.m_cut}" placeholder="숫자만 입력하세요">원<br><br>
	남자 일반 펌 : <br><input type="text" name="m_purm" id="m_purm" value="${price.m_purm}" placeholder="숫자만 입력하세요">원<br><br>
	남자 디자인 펌 : <br><input type="text" name="m_sc_purm" id="m_sc_purm" value="${price.m_sc_purm}" placeholder="숫자만 입력하세요">원<br><br>
	남자 매직 : <br><input type="text" name="m_magic" id="m_magic" value="${price.m_magic}" placeholder="숫자만 입력하세요">원<br><br>
	남자 볼륨매직 : <br><input type="text" name="m_b_magic" id="m_b_magic" value="${price.m_b_magic}" placeholder="숫자만 입력하세요">원<br><br>
	남자 컬러 : <br><input type="text" name="m_color" id="m_color" value="${price.m_color}" placeholder="숫자만 입력하세요">원<br><br>
	남자 크리닉 : <br><input type="text" name="m_clinic" id="m_clinic" value="${price.m_clinic}" placeholder="숫자만 입력하세요">원<br><br>
	
	<h5>여자</h5><br>
	여자 컷 : <br><input type="text" name="w_cut" id="w_cut" value="${price.w_cut}" placeholder="숫자만 입력하세요">원<br><br>
	여자 일반 펌 : <br><input type="text" name="w_purm" id="w_purm" value="${price.w_purm}" placeholder="숫자만 입력하세요">원<br><br>
	여자 디지털 펌 : <br><input type="text" name="w_d_purm" id="w_d_purm" value="${price.w_d_purm}" placeholder="숫자만 입력하세요">원<br><br>
	여자 매직 : <br><input type="text" name="w_magic" id="w_magic" value="${price.w_magic}" placeholder="숫자만 입력하세요">원<br><br>
	여자 볼륨매직 : <br><input type="text" name="w_b_magic" id="w_b_magic" value="${price.w_b_magic}" placeholder="숫자만 입력하세요">원<br><br>
	여자 셋팅 : <br><input type="text" name="w_setting" id="w_setting" value="${price.w_setting}" placeholder="숫자만 입력하세요">원<br><br>
	여자 매직셋팅 : <br><input type="text" name="w_m_setting" id="w_m_setting" value="${price.w_m_setting}" placeholder="숫자만 입력하세요">원<br><br>
	여자 컬러 : <br><input type="text" name="w_color" id="w_color" value="${price.w_color}" placeholder="숫자만 입력하세요">원<br><br>
	여자 크리닉 : <br><input type="text" name="w_clinic" id="w_clinic" value="${price.w_clinic}" placeholder="숫자만 입력하세요">원
	<br><br>
	<input type="submit" onclick="priceUpdate()" value="확인"  class="btn btn-primary"> 
	<input type="button" onclick="back()" value="돌아가기"  class="btn btn-primary">
	</form>
	</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<%@include file="includeFooter.jsp"%>

</body>
</html>