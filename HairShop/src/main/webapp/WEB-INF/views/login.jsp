<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>Insert title here</title>
<head>

    <title>Uptown - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Nunito+Sans:200,300,400,600,700,800,900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="resources/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/animate.css">
    
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css">

    <link rel="stylesheet" href="resources/css/aos.css">

    <link rel="stylesheet" href="resources/css/ionicons.min.css">

    <link rel="stylesheet" href="resources/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="resources/css/jquery.timepicker.css">

    
    <link rel="stylesheet" href="resources/css/flaticon.css">
    <link rel="stylesheet" href="resources/css/icomoon.css">
    <link rel="stylesheet" href="resources/css/style.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
    function caps_lock(e) {
            var keyCode = 0;
            var shiftKey = false;
            keyCode = e.keyCode;
            shiftKey = e.shiftKey;
            if (((keyCode >= 65 && keyCode <= 90) && !shiftKey)
                    || ((keyCode >= 97 && keyCode <= 122) && shiftKey)) {
                show_caps_lock();
                setTimeout("hide_caps_lock()", 2500);
            } else {
                hide_caps_lock();
            }
        }
 
    function show_caps_lock() {
         $("#capslock").show();
    }
 
    function hide_caps_lock() {
         $("#capslock").hide();
    }
</script>

</head>
<body>
  
	<%@include file="includeHeader.jsp"%>
    <!-- END nav -->
    
    <div class="hero-wrap ftco-degree-bg" style="background-image: url('resources/images/shop2.PNG');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text justify-content-center align-items-center">
<!--           <div class="col-lg-8 col-md-6 ftco-animate d-flex align-items-end"> -->
          	<div class="text text-center">
	            <h1 class="mb-4">LOGIN</h1>
<!-- 	            <p style="font-size: 18px;">A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts</p> -->
		        		<div class="row justify-content-center">
		        			<div class="col-lg-10 align-items-end">
		        				<div class="form-group">
		          				<div class="form-field">
	            <form action="userLogin" method="post">
		          				
		          				
<h3 class="mb-4">ID </h3> 
<input type="text" class="form-control" name="id"><br>
<h3 class="mb-4">PASSWORD </h3>
<input type="password" class="form-control" name="password"  onkeypress="caps_lock(event)">
<a id="capslock" style="position:relative; border:2px solid #003b83; width:300px; bottom:0px; display:none"> 
    &nbsp;<b>CapsLock</b> 키가 눌려있습니다.&nbsp;
</a><br>


<input type="submit"  class="btn btn-danger" value="로그인"><br><br>

<input type="button" onclick="location.href='NM_joinJSP'" class="btn btn-primary" value="일반회원 가입하기">
<input type="button" onclick="location.href='DN_joinJSP'" class="btn btn-primary" value="디자이너회원 가입하기" style="margin-top: 3px;"><br><br>
<a href="idFindJSP">아이디 찾기</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="passwordFindJSP">비밀번호 찾기</a>
</form>
<!--  <input type="text" class="form-control" placeholder="Search location"> -->
<!-- 				                <button><span class="ion-ios-search"></span></button> -->
				              </div>
			              </div>
		        			</div>
		        		</div>
            </div>
          </div>
        </div>
<!--       </div> -->
      <div class="mouse">
				<a href="#" class="mouse-icon">
					<div class="mouse-wheel"><span class="ion-ios-arrow-round-down"></span></div>
				</a>
			</div>
    </div>

    <section class="ftco-section ftco-no-pb">
      <div class="container">
      	<div class="row justify-content-center">
          <div class="col-md-12 heading-section text-center ftco-animate mb-5">
          	<span class="subheading">Our Services</span>
            <h2 class="mb-2">The smartest way to do hair</h2>
          </div>
        </div>
        <div class="row d-flex">
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services d-block text-center">
            	<div class="icon d-flex justify-content-center align-items-center"><span class="flaticon-piggy-bank"></span></div>
              <div class="media-body py-md-4">
                <h3>Use of Points</h3>
                <p>리뷰를 달면 포인트를 지급하고,<br> 포인트를 사용해 시술금액 할인이 가능합니다.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services d-block text-center">
            	<div class="icon d-flex justify-content-center align-items-center"><span class="flaticon-wallet"></span></div>
              <div class="media-body py-md-4">
                <h3>Easy Payment System</h3>
                <p>언제 어디서나 간편하게 예약시간 확인 후 결제를 편하게 할 수 있습니다.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services d-block text-center">
            	<div class="icon d-flex justify-content-center align-items-center"><span class="flaticon-file"></span></div>
              <div class="media-body py-md-4">
                <h3>Record Confirmation</h3>
                <p>시술내역이 기록이 되며, 언제, 어디서, 얼마에 어떤 시술을 받았는지 기록이 됩니다.</p>
              </div>
            </div>      
          </div>
          <div class="col-md-3 d-flex align-self-stretch ftco-animate">
            <div class="media block-6 services d-block text-center">
            	<div class="icon d-flex justify-content-center align-items-center"><span class="flaticon-locked"></span></div>
              <div class="media-body py-md-4">
                <h3>Privacy Protect</h3>
                <p>개인정보는 웹 사이트 사용 외에 다른곳에 사용 되지 않습니다.</p>
              </div>
            </div>      
          </div>
        </div>
      </div>
    </section>

    

    <footer class="ftco-footer ftco-section">
      <div class="container">
        <div class="row mb-5">
         
          <div class="col-md">
             <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">TEL</h2>
              <ul class="list-unstyled">
               <li><a href="#"><span class="icon icon-phone"></span><span class="text">+82 010 8744 2689</span></a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4 ml-md-4">
              <h2 class="ftco-heading-2">Questions</h2>
              <ul class="list-unstyled">
                <li><a href="#" onclick="loginBefor()"><span class="icon icon-envelope pr-4"></span><span class="text">chldyd2004@naver.com</span></a></li>
                <li><a href="#" onclick="loginBefor()"><span class="icon-long-arrow-right mr-2"></span>이메일 문의</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md">
            <div class="ftco-footer-widget mb-4">
            	<h2 class="ftco-heading-2">Address</h2>
            	<div class="block-23 mb-3">
	              <ul>
	                <li><span class="icon icon-map-marker"></span><span class="text">인천 남구 학익동 663-1 태승빌딩 5층 <br>(1층 홈플러스) </span></li>
	              </ul>
	            </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">
	
            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart color-danger" aria-hidden="true"></i> by <a href="#" target="_blank">Hair Shop</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer>
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="resources/js/jquery.min.js"></script>
  <script src="resources/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="resources/js/popper.min.js"></script>
  <script src="resources/js/bootstrap.min.js"></script>
  <script src="resources/js/jquery.easing.1.3.js"></script>
  <script src="resources/js/jquery.waypoints.min.js"></script>
  <script src="resources/js/jquery.stellar.min.js"></script>
  <script src="resources/js/owl.carousel.min.js"></script>
  <script src="resources/js/jquery.magnific-popup.min.js"></script>
  <script src="resources/js/aos.js"></script>
  <script src="resources/js/jquery.animateNumber.min.js"></script>
  <script src="resources/js/bootstrap-datepicker.js"></script>
  <script src="resources/js/jquery.timepicker.min.js"></script>
  <script src="resources/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="resources/js/google-map.js"></script>
  <script src="resources/js/main.js"></script>
    
  </body>
</html>