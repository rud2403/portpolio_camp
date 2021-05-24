<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 찾기</title>
<!-- 부트스트랩 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
<!-- 부트스트랩 끝 -->

<!-- 파비콘 시작 -->
<link rel="shortcut icon" href="../favicon.ico">
<!-- 파비콘 끝 -->

<!-- jquery 준비 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- jquery 준비 끝 -->

<script type="text/javascript">
	$(function() {

	});

</script>



<!-- 버튼 기능 시작 -->
<script type="text/javascript">

</script>
<!-- 버튼 기능 끝 -->
</head>

<body>

	<%
	
	String fid = (String)session.getAttribute("fid");
	
	%>

<!-- navbar 시작 -->
<jsp:include page="/navbar/navbar.jsp" />
<!-- navbar 끝 -->

<!-- container 시작 -->
<div class="container-md">
 
 <!-- 이미지 row 시작 -->
 <div class="row mt-5">
 	<div class="col"></div>
 	<div class="col text-center"> 
 		<img alt="" src="../img/mypage/magnifier.png" style="width: 250px; height: 250px; ">
 	</div> 	
 	<div class="col"></div>
 </div>
 <!-- 이미지 row 끝 -->
 
 <!-- 텍스트 row 시작 -->
  <div class="row">
 	<h2 class="text-center p-5"> 아이디 찾기 </h2>
 	<div class="text-center"><h5>아이디는 <%=fid %> 입니다.</h5></div>
 	<%
		session.removeAttribute("fid");
	%>
 </div>
 <!-- 텍스트 row 끝 -->
 
 <!-- 이름, 이메일 input 시작 -->
 <div class="row">
  <form class="row g-3" action="/Portpolio_camp/member/searchIdPro.jsp" method="get" name="fr">
 
 <div class="col-3"></div>
  <div class="col-6"></div>
 <div class="col-3"></div>
 <!-- 이름, 이메일 input 끝 -->

  
  <div class="row text-center" >
  	<div class="col">
  	 &nbsp;&nbsp;&nbsp;<a href="/Portpolio_camp/member/loginForm.jsp" style="text-decoration-line: none; color: black;">로그인</a> /
  	 <a href="/Portpolio_camp/member/searchPwForm.jsp" style="text-decoration-line: none; color: black;">비밀번호 찾기</a>
  	</div>
  </div>

  </form>
 </div>
 
</div>	
<!-- container 끝 -->


<!-- footer -->
<jsp:include page="/footer/footer.jsp" />
	
</body>
</html>