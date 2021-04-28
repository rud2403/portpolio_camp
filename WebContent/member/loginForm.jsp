<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
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

.contain { padding-left: 400px; padding-right: 400px; }

</style>

</head>
<body>

<!-- navbar 시작 -->
<jsp:include page="/navbar/navbar.jsp" />



 <h2 class="text-center p-5"> 로그인 </h2>
 
 <div class="contain">
  <form class="row g-3" action="loginPro.jsp" method="post" name="fr">
 
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




  <!-- 제출 버튼 -->   
  <div class="col-sm30 p-5" style="text-align:center;">
   <input class="btn btn-primary btn-block" type="submit" value="로그인">
   <input class="btn btn-primary btn-block" type="button" value="회원가입" onclick="location.href='insertForm.jsp'">
  </div>

 </form>
</div>
	

<!-- footer -->
<jsp:include page="/footer/footer.jsp" />
	
</body>
</html>