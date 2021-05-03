<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
</head>
<body>
<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
 
<!-- navbar 끝 -->

<!-- container 시작 -->	
<div class="container-fluid">

<!-- row 시작 -->
<div class="row text-center pt-5">
	<h3>마이 페이지</h3>
</div>
<!-- row 종료 -->

<!-- row 시작 -->	
<div class="row pt-5">
	<div class="col-3">
		<!-- 카드 시작 -->		
		<div class="card container" style="width: 20rem; height: 500px;">
		  <img src="/Portpolio_camp/img/mypage/user.png" class="card-img-top my-5" alt="..." height="130px">
		  <div class="card-body text-center my-5">
		    <h5 class="card-title">내정보</h5>
		    <p class="card-text">가입 시 입력한 회원정보를 조회 합니다.</p>
		    <a href="/Portpolio_camp/member/myinfoForm.jsp" class="btn btn-primary">이동하기</a>
		  </div>
		</div>
		<!-- 카드 종료 -->		
			
	</div>
	<div class="col-3">	
		<!-- 카드 시작 -->		
		<div class="card container" style="width: 20rem; height: 500px;">
		  <img src="/Portpolio_camp/img/mypage/user.png" class="card-img-top my-5" alt="..." height="130px">
		  <div class="card-body text-center my-5">
		    <h5 class="card-title">내정보 관리</h5>
		    <p class="card-text">가입 시 입력한 회원정보를 수정 합니다.</p>
		    <a href="/Portpolio_camp/member/manageForm.jsp" class="btn btn-primary">이동하기</a>
		  </div>
		</div>
		<!-- 카드 종료 -->	
	</div>
	<div class="col-3">	
		<!-- 카드 시작 -->		
		<div class="card container" style="width: 20rem; height: 500px;"> 
		  <img src="/Portpolio_camp/img/mypage/user.png" class="card-img-top my-5" alt="..." height="130px">
		  <div class="card-body text-center my-5">
		    <h5 class="card-title">캠핑장 즐겨찾기</h5>
		    <p class="card-text">즐겨찾기로 등록한 캠핑장을 확인합니다.</p>
		    <a href="/Portpolio_camp/member/myfavoritesForm.jsp" class="btn btn-primary">이동하기</a>
		  </div>
		</div>
		<!-- 카드 종료 -->	
	</div>
	<div class="col-3">	
		<!-- 카드 시작 -->		
		<div class="card container" style="width: 20rem; height: 500px;">
		  <img src="/Portpolio_camp/img/mypage/user.png" class="card-img-top my-5" alt="..." height="130px">
		  <div class="card-body text-center my-5">
		    <h5 class="card-title">회원탈퇴</h5>
		    <p class="card-text">회원정보를 삭제 합니다. 개인의 정보가 삭제됩니다.</p>
		    <a href="/Portpolio_camp/member/withdrawalForm.jsp" class="btn btn-primary">이동하기</a>
		  </div>
		</div>
		<!-- 카드 종료 -->	
	</div>
</div>
<!-- row 종료 -->	

</div>
<!-- container 끝 -->	

<!-- footer 시작 -->
<div class="row">
 <jsp:include page="/footer/footer.jsp" />
</div>
<!-- footer 끝 -->
</body>
</html>