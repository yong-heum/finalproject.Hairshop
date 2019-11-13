<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="en">
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
function loginBefor(){
	alert("로그인 이후에 이용이 가능합니다.");
}
</script>
</head>
<body>
  <body>
    <c:if test="${sessionScope.sessionId!=null}">
	  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="mainJSP?id=${sessionScope.sessionId }">Hair Shop</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto ">
	        
	          <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	           <a href="mainJSP?id=${sessionScope.sessionId }"  class="nav-link">Home</a>
	           </div>
	           </li>
	           
	           <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown" >매장 둘러보기</a>
	          <div class="dropdown-menu">
                           <a class="dropdown-item" href="shopPaging?adrs_street_1=${sessionScope.adrs_street_1}&page=0" >매장 둘러보기</a>
                           <div class="dropdown-divider"></div>
                           
                           <c:if test="${sessionScope.sessionIdCheck=='DN'}">
                           <a class="dropdown-item" href="shopInsertJSP">매장등록</a>
                           <div class="dropdown-divider"></div>
                           </c:if>
                           
<%--                            <c:if test="${sessionScope.sessionId=='admin'}"> --%>
                           <a class="dropdown-item" href="shopApply1">매장 등록 신청 목록 보기(admin 관리자만사용)</a>
                           <div class="dropdown-divider"></div>
<%--                            </c:if> --%>
                  </div>
	          	</div>
	          </li>
	          
	           <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">리뷰 게시판</a>
	          <div class="dropdown-menu">
	           	   	 	   <a class="dropdown-item" href="reviewBoard?page=0">리뷰 게시판 보기</a>
	           	   	 	   <div class="dropdown-divider"></div>
	           	   	 	   
                           <a class="dropdown-item" href="reviewInsertJSP?id=${sessionScope.sessionId}">리뷰작성</a>
                           <div class="dropdown-divider"></div>
                           
                           <c:if test="${sessionScope.sessionIdCheck=='DN'}">
                           <a class="dropdown-item" href="review_PointJSP?id=${sessionScope.sessionId}&name=${sessionScope.name}">시술 완료된 고객의 리뷰 확인 후 포인트 지급(디자이너만)</a>
                  		   <div class="dropdown-divider"></div>
                  		   </c:if>
                  </div>
	          	</div>
	          </li>
	          
	            <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">예약하기</a>
	          <div class="dropdown-menu">
	         			   <a class="dropdown-item" href="ticketingJSP_1?shopName=">예약하기</a>
	         			   <div class="dropdown-divider"></div>
	         			   
                           <a class="dropdown-item" href="ticketHistoryJSP?id=${sessionScope.sessionId}">예약 내역 보기</a>
                           <div class="dropdown-divider"></div>
                           
                           <c:if test="${sessionScope.sessionIdCheck=='DN'}">
	           	   	 	   <a class="dropdown-item" href="ticketing_DN_ListJSP?id=${sessionScope.sessionId}">(디자이너)본인에게 예약 된 고객 목록 보기</a>
	           	   	 	   <div class="dropdown-divider"></div>
	           	   	 	   </c:if>
	           	   	 	   
	           	   	 	   <c:if test="${sessionScope.sessionIdCheck=='DN'}">
                           <a class="dropdown-item" href="ticketing_Block_1?id=${sessionScope.sessionId}">(디자이너)고객이 예약 못하게 예약 막기</a>
                           <div class="dropdown-divider"></div>
                           </c:if>
                  </div>
	          	</div>
	          </li>
	          
	          <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">이메일문의</a>
	          <div class="dropdown-menu">
                           <a class="dropdown-item" href="EmailInquiryJSP">이메일문의</a>
                           <div class="dropdown-divider"></div>
                  </div>
	          	</div>
	          </li>
	          
	           <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">공지사항</a>
	          <div class="dropdown-menu">
                           <a class="dropdown-item" href="noticeBoardJSP?page=0">공지사항</a>
                           <div class="dropdown-divider"></div>
                  </div>
	          	</div>
	          </li>
	         
	         <c:if test="${sessionScope.sessionIdCheck=='DN'}">
	          <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	           <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">디자이너 메뉴</a>
                  <div class="dropdown-menu">
                           <a class="dropdown-item" href="priceJSP?id=${sessionScope.sessionId}&name=${sessionScope.name}">소속매장등록(시술금액등록)(디자이너만 가능하게)</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="priceSelect?disigner_id=${sessionScope.sessionId}&check=1">나의 시술금액 보기(디자이너 회원정보 안에 있을거임)</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="shop_Disigner_ApplyJSP?id=${sessionScope.sessionId}">소속매장등록 신청 보기 (매장 관리자만 가능)</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="closedInsertJSP?id=${sessionScope.sessionId}">휴무 등록 하기(디자이너만 가능)</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="closedDeleteJSP?id=${sessionScope.sessionId}">휴무 취소 하기(디자이너만 가능)</a>
						   <div class="dropdown-divider"></div>
                           <a class="dropdown-item" href="ticketing_Block_1?id=${sessionScope.sessionId}">고객이 예약 못하게 예약 막기(디자이너만 가능)</a>
                           <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="sales_Chart_DN">개인 매출 보기</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="sales_Chart_SHOP?id=${sessionScope.sessionId}">매장 매출 보기</a>
						   <div class="dropdown-divider"></div>
                           
                  </div>
         		</div>
         	  </li>
         	  </c:if>
         	  
	        </ul>
	      </div>
	    </div>
	    <ul  class="navbar-nav ml-auto">
	    <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <button  class="dropdown-toggle btn btn-outline-danger"  data-toggle="dropdown">회원 정보</button>
	          <div class="dropdown-menu">
                           <a class="dropdown-item" href="userSelect?id=${sessionScope.sessionId}">회원정보</a>
                           <div class="dropdown-divider"></div>
                           <a class="dropdown-item" href="logOut">로그아웃</a>
                           <div class="dropdown-divider"></div>
	    </div>
	    </div>
	    </li>
	    </ul>
	    
	  </nav>
	  
	  
	  </c:if>
	  
	  
	  <c:if test="${sessionScope.sessionId==null}">
	   <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="#" onclick="loginBefor()">Hair Shop</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto ">
	        
	          <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	           <a href="#" onclick="loginBefor()" class="nav-link">Home</a>
	           </div>
	           </li>
	           
	           <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown" >매장 둘러보기</a>
	          <div class="dropdown-menu">
                           <a class="dropdown-item" href="#" onclick="loginBefor()">매장 둘러보기</a>
                           <div class="dropdown-divider"></div>
                           
                           <c:if test="${sessionScope.sessionIdCheck=='DN'}">
                           <a class="dropdown-item" href="#"  onclick="loginBefor()">매장등록</a>
                           <div class="dropdown-divider"></div>
                           </c:if>
                           
                           <c:if test="${sessionScope.sessionId=='admin'}">
                           <a class="dropdown-item" href="#"  onclick="loginBefor()">매장 등록 신청 목록 보기(admin 관리자만사용)</a>
                           <div class="dropdown-divider"></div>
                           </c:if>
                  </div>
	          	</div>
	          </li>
	          
	           <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">리뷰 게시판</a>
	          <div class="dropdown-menu">
	           	   	 	   <a class="dropdown-item" href="#"  onclick="loginBefor()">리뷰 게시판 보기</a>
	           	   	 	   <div class="dropdown-divider"></div>
	           	   	 	   
                           <a class="dropdown-item" href="#"  onclick="loginBefor()">리뷰작성</a>
                           <div class="dropdown-divider"></div>
                           
                           <c:if test="${sessionScope.sessionIdCheck=='DN'}">
                           <a class="dropdown-item" href="#"  onclick="loginBefor()">시술 완료된 고객의 리뷰 확인 후 포인트 지급(디자이너만)</a>
                  		   <div class="dropdown-divider"></div>
                  		   </c:if>
                  </div>
	          	</div>
	          </li>
	          
	            <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">예약하기</a>
	          <div class="dropdown-menu">
	         			   <a class="dropdown-item" href="#"  onclick="loginBefor()">예약하기</a>
	         			   <div class="dropdown-divider"></div>
	         			   
                           <a class="dropdown-item" href="#"  onclick="loginBefor()">본인의 예약 내역 보기</a>
                           <div class="dropdown-divider"></div>
                           
                           <c:if test="${sessionScope.sessionIdCheck=='DN'}">
	           	   	 	   <a class="dropdown-item" href="#"  onclick="loginBefor()">(디자이너)본인에게 예약 된 고객 목록 보기</a>
	           	   	 	   <div class="dropdown-divider"></div>
	           	   	 	   </c:if>
	           	   	 	   
	           	   	 	   <c:if test="${sessionScope.sessionIdCheck=='DN'}">
                           <a class="dropdown-item" href="#"  onclick="loginBefor()">(디자이너)고객이 예약 못하게 예약 막기</a>
                           <div class="dropdown-divider"></div>
                           </c:if>
                  </div>
	          	</div>
	          </li>
	          
	          <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">이메일문의</a>
	          <div class="dropdown-menu">
                           <a class="dropdown-item" href="#"  onclick="loginBefor()">이메일문의</a>
                           <div class="dropdown-divider"></div>
                  </div>
	          	</div>
	          </li>
	          
	           <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">공지사항</a>
	          <div class="dropdown-menu">
                           <a class="dropdown-item" href="#"  onclick="loginBefor()">공지사항</a>
                           <div class="dropdown-divider"></div>
                  </div>
	          	</div>
	          </li>
	         
	         <c:if test="${sessionScope.sessionIdCheck=='DN'}">
	          <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	           <a href="#" class="dropdown-toggle nav-link"  data-toggle="dropdown">디자이너 메뉴</a>
                  <div class="dropdown-menu">
                           <a class="dropdown-item" href="priceJSP?id=${sessionScope.sessionId}&name=${sessionScope.name}">소속매장등록(시술금액등록)(디자이너만 가능하게)</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="priceSelect?disigner_id=${sessionScope.sessionId}&check=1">나의 시술금액 보기(디자이너 회원정보 안에 있을거임)</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="shop_Disigner_ApplyJSP?id=${sessionScope.sessionId}">소속매장등록 신청 보기 (매장 관리자만 가능)</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="closedInsertJSP?id=${sessionScope.sessionId}">휴무 등록 하기(디자이너만 가능하게)</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="closedDeleteJSP?id=${sessionScope.sessionId}">휴무 취소 하기(디자이너만 가능하게)</a>
						   <div class="dropdown-divider"></div>
						   <a class="dropdown-item" href="sales_Chart">매출 보기</a>
						   <div class="dropdown-divider"></div>
                  </div>
         		</div>
         	  </li>
         	  </c:if>
         	  
	        </ul>
	      </div>
	    </div>
	         <ul  class="navbar-nav ml-auto">
	    <li class="nav-item">
	           <div class="nav-link dropdown" style="padding-top : 5px;">
	          <button  class="dropdown-toggle  btn btn-outline-danger"  data-toggle="dropdown">회원 정보</button>
	          <div class="dropdown-menu">
                           <a class="dropdown-item" href="loginJSP">로그인</a>
                           <div class="dropdown-divider"></div>
                           </div>
                           </div>
                           </li>
                           </ul>
	  </nav>
	  </c:if>
</body>
</html>