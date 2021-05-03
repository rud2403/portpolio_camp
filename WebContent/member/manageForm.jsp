<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내정보 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

<script type="text/javascript">
	function func1() {
		var con = document.getElementById("i1");
		con.style.display = (con.style.display != 'none') ? "none" : "block";
		var con = document.getElementById("i2");
		con.style.display = (con.style.display != 'none') ? "none" : "block";
	}
	
	function func2() {
		var con = document.getElementById("i3");
		con.style.display = (con.style.display != 'none') ? "none" : "block";
		var con = document.getElementById("i4");
		con.style.display = (con.style.display != 'none') ? "none" : "block";
	}
	
	function func3() {
		var con = document.getElementById("i5");
		con.style.display = (con.style.display != 'none') ? "none" : "block";
		var con = document.getElementById("i6");
		con.style.display = (con.style.display != 'none') ? "none" : "block";
	}
	
	function func4() {
		var con = document.getElementById("i7");
		con.style.display = (con.style.display != 'none') ? "none" : "block";
		var con = document.getElementById("i8");
		con.style.display = (con.style.display != 'none') ? "none" : "block";
	}


</script>


</head>
<body>
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
<!-- 왼쪽 열 종료 -->	

<!-- 오른쪽 열 시작 -->	
	<div class="col-10 text-center mt-5">
		<h3>내정보 관리</h3>
		
		<!-- 행 시작 -->
		<div class="row mt-5">
		
			<div class="col-1"></div>
			
			<div class="col-10">
				<!-- 테이블 시작 -->
				<table class="table">
				  <tbody>
				    <tr>
				      <th scope="row">아이디</th>
				      
				      <!-- 가운데 부분 시작 -->
				      
				      <td>rud2403</td>
				      <!-- 가운데 부분 끝 -->
				      
				      <td>
				      	<div style="display: none;"><button type="button" class="btn btn-light"></button></div>
				      </td>
				    </tr>
				    
				    <!-- 비밀번호 행 시작 -->
				    <tr>
				      <th scope="row">비밀번호</th>
				      
				      <!-- 가운데 부분 시작 -->
				      <td>
					      <form action="/Portpolio_camp/member/managepwPro.jsp" method="post">
					      	<div id="i2" style="display: none;">
					      		<div>현재 비밀번호 &nbsp;&nbsp;&nbsp;<input type="text" name=""></div><br>
					      		<div>새 비밀번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name=""></div><br>
					      		<div>새 비밀번호 확인&nbsp;<input type="text" name=""></div><br>
					      		
					   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
					      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func1();">	
					      		
					      	</div>
	    		
					      	<div id="i1">********</div>
					      </form>
				      </td>
				      <!-- 가운데 부분 끝 -->
				      
				      <td><button type="button" class="btn btn-outline-primary" onclick="func1();">변경하기</button></td>
				      
				    </tr>
				   <!-- 비밀번호 행 끝 -->
				    
				    <!-- 이름 행 시작 -->
				    <tr>
				      <th scope="row">이름</th>
				      
				      <!-- 가운데 부분 시작 -->
				      <td>
				      <form action="/Portpolio_camp/main/main.jsp" method="post">
				      		<div id="i4" style="display: none;">
					      		<div><input type="text" name=""></div><br>
					      		
						   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
						      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func2();">	
						      		
						     </div>
					      	
					      	<div id="i3">박경민</div>
				      	</form>
					  </td>
				      <!-- 가운데 부분 끝 -->
				      <td><button type="button" class="btn btn-outline-primary" onclick="func2();">변경하기</button></td>
				    </tr>
   				    <!-- 이름 행 끝 -->
				    
				    <!-- 전화번호 행 시작 -->
				    <tr>
				      <th scope="row">전화번호</th>
				      
				      <!-- 가운데 부분 시작 -->
				      <td>
				      
					     <form action="/Portpolio_camp/main/main.jsp" method="post">
					      		<div id="i6" style="display: none;">
						      		<div><input type="text" name=""></div><br>
						      		
							   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
							      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func3();">	
							      		
							     </div>
						      	
						      	<div id="i5">01020592403</div>
					      </form>
				      </td>
				     <!-- 가운데 부분 끝 -->
				      
				      
				      <td><button type="button" class="btn btn-outline-primary" onclick="func3();">변경하기</button></td>
				    </tr>
   				    <!-- 전화번호 행 끝 -->
				    
				    <!-- 이메일 행 시작 -->
				    <tr>
				      <th scope="row">이메일</th>
				      
				      
				      <td>
				      
					     <form action="/Portpolio_camp/main/main.jsp" method="post">
					      		<div id="i8" style="display: none;">
						      		<div><input type="text" name=""></div><br>
						      		
							   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
							      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func4();">	
							      		
							     </div>
						      	
						      	<div id="i7">rud2403@naver.com</div>
					      </form>
				      </td>
				      
				      
				      <td><button type="button" class="btn btn-outline-primary" onclick="func4();">변경하기</button></td>
				    </tr>
				    <!-- 이메일 행 끝 -->
				    
				    				    				    
				  </tbody>
				</table>
				<!-- 테이블 종료 -->
			</div>
			<div class="col-1"></div>
			
		</div>
		
	</div>
<!-- 오른쪽 열 종료 -->	
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