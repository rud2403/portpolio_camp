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
</head>
<body>

	<%
		// 세션제어
		String id = (String)session.getAttribute("id");
		
		if(id == null){
			response.sendRedirect("loginForm.jsp");
		}
		
		// 아이디 비밀번호를 입력받아서 정보를 삭제처리하는 페이지로 전달
		
		// 아이디/비밀번호 입력 받아서 정보를 삭제처리하는 페이지로 전달
	%>

<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
<!-- navbar 끝 -->

<!-- container 시작 -->	
<div class="container-fluid">	
<div class="row">

	<!-- 왼쪽 열 시작 -->
	<div class="col-2 text-center mt-5"  style=" border-right: 1px solid black; height: 600px;">
	<!-- 페이지 목록 시작 -->
	 <jsp:include page="/pagelist/pagelistForm.jsp" />
	<!-- 페이지 목록 끝 -->
	</div>
	<!-- 왼쪽 열 끝 -->
	
	
	
	<!-- 오른쪽 열 시작 -->
	<div class="col-10 text-center mt-5">
		<h3>회원탈퇴</h3>
		
		<div class="row text-center my-5 pt-5">
		
		<h2>비밀번호 재확인</h2>
		
		
		</div>
		<!-- form태그 시작 -->
		<form action="withdrawalPro.jsp" method="get">
			<div class="row">
				<div class="col-4"></div>
					<div class="col-4 text-center">
						<div class="row">
						  <div class="col-auto">
						    <label for="inputPassword6" class="col-form-label">Password</label>
						  </div>
						  <div class="col-auto">
						  	<input type="hidden" name="id" value="<%=id%>">
						    <input type="password" id="inputPassword6" class="form-control" aria-describedby="passwordHelpInline" name="pw">
						    <input class="btn btn-primary mt-5" type="submit" value="회원탈퇴">
						  </div>
						  <div class="col-auto">
						    
						  </div>
						</div>
					 </div>
				  <div class="col-4"></div>
			</div>
		</form>
		<!-- form태그 끝 -->	
	</div>
	<!-- 오른쪽 열 끝 -->
	
</div>

</div>
<!-- container 끝 -->	

<!-- footer 시작 -->
<div class="row">
 <jsp:include page="/footer/footer.jsp" />
</div>
<!-- footer 끝 -->
</body>
</html>