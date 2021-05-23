<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원탈퇴</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

<!-- 파비콘 시작 -->
<link rel="shortcut icon" href="../favicon.ico">
<!-- 파비콘 끝 -->

</head>
<body>

<!-- navbar 시작 -->
<jsp:include page="/navbar/navbar.jsp" />
<!-- navbar 끝 -->

<!-- container 시작 -->
<div class="container pt-3" > 

	<div class="row text-center mt-5">
		<h3>회원탈퇴가 완료되었습니다.</h3>
	</div>
	<div class="row">
		  <!-- 제출 버튼 -->   
		   <div class="col-sm30 p-5" style="text-align:center;">
		    <input class="btn btn-primary btn-block" type="submit" value="메인으로" onclick="location.href='/Portpolio_camp/main/main.jsp'">
		    <input class="btn btn-primary btn-block" type="button" value="회원가입" onclick="location.href='insertForm.jsp'">
		   </div>
		  <!-- 버튼 끝 -->
	</div>


</div>


</body>
</html>