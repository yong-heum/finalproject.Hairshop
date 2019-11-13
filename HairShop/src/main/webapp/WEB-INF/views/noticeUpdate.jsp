<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="resources/ckeditor/ckeditor.js"></script>

<script>
	function noticeUpdate(){
		if($('#title').val()==""||$('#contents').val()==""){
			alert("글을 모두 작성하세요.");
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
						<span class="mr-2"><a href="mainJSP?id=${sessionScope.sessionId}">Home 
						<i class="ion-ios-arrow-forward"></i></a></span> 
						<span><a href="noticeBoardJSP?page=0">공지사항</a>
						<i class="ion-ios-arrow-forward"></i></span> 
						<span>공지사항 수정 <i class="ion-ios-arrow-forward"></i></span>
					</p>
					<h1 class="mb-3 bread">공지사항 수정</h1>
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
	
	
	<div class="row block-9 justify-content-center mb-5">
		<div class="col-md-8 mb-md-5">
	<button onclick="location.href='noticeBoardJSP?page=${paging}'" class="btn btn-primary">목록으로</button>
	<button onclick="location.href='mainJSP?id=${sessionScope.sessionId}'" class="btn btn-primary" >메인가기</button>
	<br><br>
			<h2 class="text-center">공지사항 작성</h2>
			
<form action="noticeUpdate?page=0&boardNum=${noticeSelect.boardNum}" method="post" onsubmit="return false" name="submit"  class="bg-light p-5 contact-form">
        
        제목 : <input type="text" name="title" id="title" value="${noticeSelect.title}" class="form-control"><br>
        
        내용 : <br>
            <textarea name="contents" id="editor1"  class="form-control">${noticeSelect.contents} 
            </textarea><br>
            <script>
            CKEDITOR.replace( 'editor1', {
                filebrowserUploadUrl: 'imgUpload',
                width : '1150',
                height : '500'
            });
                </script>
                
      	<input type="hidden" name="boardNum" value="${noticeSelect.boardNum}" >
      	<input type="hidden" name="page" value="${paing}" >
      	
        <input type="submit" onclick="noticeUpdate()" value="완료" class="btn btn-primary">
        <input type="button" onclick="history.back()" value="취소" class="btn btn-primary">
        </form>
        </div>
        </div>
        
          
	<br>
	<br>
	<br>
	<%@include file="includeFooter.jsp"%>
    </body>
</body>
</html>