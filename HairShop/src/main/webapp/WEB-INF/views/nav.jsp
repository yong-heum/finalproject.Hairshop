<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>${sessionScope.sessionId}님 환영 합니다.</h1>
<!-- 회원정보 -->
<a href="userSelect?id=${sessionScope.sessionId}">회원정보보기</a><br>
<a href="logOut">로그아웃</a><br><br>

<!-- 매장확인 -->
<a href="shopInsertJSP">매장등록</a><br>
<a href="shopPaging?adrs_street_1=${userLogin.adrs_street_1}&page=0">매장 둘러보기</a><br>
<a href="shopApply1">매장 등록 신청 목록 보기(admin 관리자만사용)</a><br><br>

<!-- 리뷰게시판 -->
<a href="reviewInsertJSP?id=${sessionScope.sessionId}">리뷰작성</a><br>
<a href="reviewBoard?page=0">리뷰 게시판 보기</a><br>
<a href="review_PointJSP?id=${sessionScope.sessionId}&name=${userLogin.name}">시술 완료된 고객의 리뷰 확인 후 포인트 지급(디자이너만)</a><br><br>

<!-- 디자이너 메뉴 111-->
<a href="priceJSP?id=${sessionScope.sessionId}&name=${userLogin.name}">소속매장등록(시술금액등록)(디자이너만 가능하게)</a><br>
<a href="priceSelect?disigner_id=${sessionScope.sessionId}&check=1">나의 시술금액 보기(디자이너 회원정보 안에 있을거임)</a><br>
<a href="shop_Disigner_ApplyJSP?id=${sessionScope.sessionId}">소속매장등록 신청 보기 (매장 관리자만 가능)</a><br><br>

<!-- 휴무 관리 111-->
<a href="closedInsertJSP?id=${userLogin.id}">휴무 등록 하기(디자이너만 가능하게)</a><br>
<a href="closedDeleteJSP?id=${userLogin.id}">휴무 취소 하기(디자이너만 가능하게)</a><br><br>

<!-- 예약 하기 -->
<a href="ticketingJSP_1?shopName=">예약하기</a><br>
<a href="ticketing_DN_ListJSP?id=${sessionScope.sessionId}">(디자이너)본인의 예약 목록 보기</a><br>
<a href="ticketHistoryJSP?id=${sessionScope.sessionId}">(고객)본인의 예약 내역 보기</a><br>
<a href="ticketing_Block_1?id=${sessionScope.sessionId}">(디자이너)고객이 예약 못하게 예약 막기</a><br><br>

<!-- 매출보기 -->
<a href="sales_Chart">매출 보기</a><br><br>

<!-- 이메일 문의 -->
<a href="EmailInquiryJSP">이메일문의</a><br><br>

<!-- 공지사항 -->
<a href="noticeBoardJSP?page=0">공지사항</a><br><br>
</body>
</html>