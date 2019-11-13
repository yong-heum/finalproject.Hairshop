<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	function noticeDelete(){
		var input = confirm('삭제 하시겠습니까?'); 
		
		if(input==true){
			location.href="noticeDelete?page=0&boardNum="+$('#boardNum').val();
		}else{
		}
	}
	
	
	function noticeUpdateJSP(){
		var input = confirm('수정 하시겠습니까?'); 
		
		if(input==true){
			location.href="noticeUpdateJSP?page="+${paging}+"&boardNum="+${noticeSelect.boardNum};
		}else{
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
	<br>
	
	
<div class="container">
<button onclick="location.href='noticeBoardJSP?page=${paging}'" class="btn btn-primary">목록으로</button><br><br>
<div class=”row“ >
	<table class='table table-bordered specialCollapse' style='text-align:center;'>
<tr class='table-info'>
<td>제목</td><td>작성자</td><td>작성날짜</td><td>조회수</td>
</tr>
<tr>
<td>${noticeSelect.title}</td><td>${noticeSelect.name}</td><td>${noticeSelect.notice_Date}</td><td>${noticeSelect.hit}</td>
</tr>
<tr>
<td  class='table-info'>내용</td><td colspan="3" style="text-align:left">${noticeSelect.contents}</td>
</tr>
</table>
<c:if test="${sessionScope.sessionId eq 'admin' }">
<input type="button" onclick="noticeUpdateJSP()" value="수정하기" class="btn btn-primary"> &nbsp;&nbsp;
<input type="button" onclick="noticeDelete()" value="삭제하기" class="btn btn-primary">
</c:if><br><br>
</div>
</div>

	<br>
	<br><br>
	<br>
	<br>
	
<%@include file="includeFooter.jsp"%>
</body>
</html>