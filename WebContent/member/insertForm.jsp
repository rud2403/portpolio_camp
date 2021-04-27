<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

<style type="text/css">

html {

    position: relative;

    min-height: 100%;

    margin: 0; 
    
    }

body { min-height: 100%; }

h2 { text-align: center; padding: 50px; }


.footer {


    left: 0;

    bottom: 0;

    width: 100%;

	padding: 15px 0;

	text-align: center;

}

.contain { padding-left: 500px; padding-right: 500px; }






</style>

</head>
<body>

<!-- navbar 시작 -->
 <%@include file ="/navbar/navbar.jsp" %>



	<h2> 회원가입 </h2>
<div class="contain">	
 <form class="row g-3" action="insertPro.jsp" method="post">
 
   <!-- 아이디 --> 
   <div class="form-floating mb-3">
    <input type="text" class="form-control" id="floatingInput" placeholder="ID" name="id">
    <label for="floatingInput">ID</label>
   </div>
   
   
   <!-- 비밀번호 -->   
   <div class="form-floating">
    <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="pw">
    <label for="floatingPassword">Password</label>
   </div>
   <!-- 비밀번호 확인 -->
   <div class="form-floating">
    <input type="password" class="form-control" id="floatingPassword" placeholder="Password Confirm" name="pw2">
    <label for="floatingPassword">Password Confirm</label>
   </div>  
   
   
   <!-- 이름 -->
   <div class="form-floating mb-3">
    <input type="text" class="form-control" id="floatingInput" placeholder="Name" name="name">
    <label for="floatingInput">Name</label>
   </div>
   
   <!-- 전화번호 --> 
   <div class="form-floating mb-3">
    <input type="text" class="form-control" id="floatingInput" placeholder="PhoneNumber" name="PhoneNumber">
    <label for="floatingInput">PhoneNumber</label>
   </div>
   
   <!-- 이메일 -->
   <div class="form-floating mb-3">
    <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="email">
    <label for="floatingInput">Email address</label>
   </div>
   
   <!-- 성별 -->
   <h3>Gender</h3>
   <div class="form-check">
    <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" checked name="gender" value="남">
    <label class="form-check-label" for="flexRadioDefault1">
    Man
   </label>
   </div>
  <div class="form-check">
   <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" name="gender" value="여">
   <label class="form-check-label" for="flexRadioDefault2">
    Woman
   </label>
  </div>
   
  <div calss="button">
   <!-- 제출 버튼 -->
   <input class="btn btn-primary" id="button" type="submit" value="Submit">
  </div>

 </form>
</div>
	

<!-- footer -->
<%@include file ="/footer/footer.jsp" %>
	
</body>
</html>