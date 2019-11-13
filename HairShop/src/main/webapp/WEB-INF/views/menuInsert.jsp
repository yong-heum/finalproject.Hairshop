<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	$(document).ready(function() {
		$("#menuInsert").click(function() {
			alert("수정완료되었습니다.")
			menuInsert2.submit();
		});
	});
</script>
	
</head>
<body>
<a href="mainJSP?id=${sessionScope.sessionId}">메인가기</a><br>

	<form action="menuInsert2" method="post" onsubmit="return false" name="menuInsert2" enctype="multipart/form-data">
		시술가격 등록 : <input type="file" name="menu_Photo_File"><br>
		시술가격표 내용 : <br>
		<textarea name="menu_Contents" rows="30" cols="70" placeholder="가격표 사진이 없으면 글로 적으셔도 됩니다.">${shop_List.menu_Contents}</textarea>
		<br> <br> 
		<input type="hidden" name="pid" value="${shop_List.pid}">
		
		<input type="submit" id="menuInsert" value="확인"> 
		<input type="reset" value="초기화">
	</form>
</body>
</html>