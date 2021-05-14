<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>


<script type="text/javascript">

function check1(){
	//id의 정보가 입력이 돼있는지 아닌지 판단.
	//alert("아이디의 값 : @" + document.fr.id.value+"@");
	//console.log(document.fr.id);
	//"" - 공백문자(문자데이터가 없음)
	
	//if(document.fr.id.value == "")
		
	//아이디가 입력된 후에 비밀번호 입력 여부 체크
	// -> 입력정보가 없을 경우 입력을 유도하는 동작
	
	// 사용자의 아이디가 "admin"인 경우 사용불가
	// 사용자의 아이디가 5~10자리 내외로만 사용 가능
	
	if(document.fr.id.value.length < 1){
		alert("아이디를 입력하세요.")
		document.fr.id.focus();
		return false;
		// 아이디 공백 차단
	} // if
	
	if(document.fr.id.value == "admin"){
		alert("사용할 수 없는 ID입니다.")
		document.fr.id.value="";
		document.fr.id.focus();
		return false;
		// 'admin' id 차단
	} // if
	
	var idlen = document.fr.id.value.length;
	if(!(5 <= idlen && idlen <= 10)){
		alert("아이디의 길이는 5 ~ 10 입니다.")
		return false;
		// 아이디 길이가 5보다 작거나 10보다 클 경우 차단
	} // if
	
	if(document.fr.pw.value == ""){
		alert("비밀번호를 입력하세요.")
		document.fr.pw.focus();
		return false;
		// 비밀번호 공백 시 차단
	} // if
	
	if(document.fr.pw2.value == ""){
		alert("비밀번호 확인을 입력하세요.")
		document.fr.pw2.focus();
		return false;
		// 비밀번호확인 공백 시 차단
	} // if
	
	if(document.fr.pw2.value != document.fr.pw.value){
		alert("비밀번호가 다릅니다.");
		document.fr.pw.value="";
		document.fr.pw2.value="";
		document.fr.pw.focus();
		return false;
	} // if
	
	if(document.fr.name.value == ""){
		alert("이름을 입력하세요.");
		document.fr.name.focus();
		return false;
	} // if
	
	if(document.fr.phone.value == ""){
		alert("전화번호 입력하세요.");
		document.fr.phone.focus();
		return false;
	} // if
	
	if(document.fr.phone.value.length != 11){
		alert("잘못된 전화번호 입니다.");
		document.fr.phone.value="";
		document.fr.phone.focus();
		return false;
	} // if
	
	if(document.fr.email.value == ""){
		alert("이메일을 입력하세요.");
		document.fr.email.focus();
		return false;
	} // if	
	
	
}
</script>
</head>
<body>

<!-- navbar 시작 -->
<jsp:include page="/navbar/navbar.jsp" />



 <h2 class="text-center p-5"> 회원가입 </h2>
 
 <!-- 컨테이너 시작 -->
 <div class="container-md">
  <form class="row g-3" action="insertPro.jsp" method="post" name="fr">
 
   <!-- 아이디 --> 
   <div class="form-floating mb-3">
    <input type="text" class="form-control" id="floatingInput" placeholder="ID" name="id">
    <label for="floatingInput">ID</label>
    <span id="idcheck">사용가능한 아이디입니다.</span>
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
    <span id="idcheck">비밀번호가 일치합니다.</span>
   </div>  
   
   
   <!-- 이름 -->
   <div class="form-floating mb-3">
    <input type="text" class="form-control" id="floatingInput" placeholder="Name" name="name">
    <label for="floatingInput">Name</label>
   </div>
   
   <!-- 전화번호 --> 
   <div class="form-floating mb-3">
    <input type="tel" class="form-control" id="floatingInput" placeholder="PhoneNumber" name="phone">
    <label for="floatingInput">Phone ('-' 제외)</label>
   </div>
   
   <!-- 이메일 -->
   <div class="form-floating mb-3">
    <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="email">
    <label for="floatingInput">Email address</label>
   </div>


  <!-- 제출 버튼 -->   
  <div class="col-sm30 p-5" style="text-align:center;">
   <input class="btn btn-primary btn-block" type="submit" value="가입하기" onclick="return check1()">
  </div>

 </form>
</div>
 <!-- 컨테이너 종료 -->

	

<!-- footer 시작 -->
<jsp:include page="/footer/footer.jsp" />
<!-- footer 끝 -->
	
</body>
</html>