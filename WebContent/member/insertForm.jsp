<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<!-- 부트스트랩 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
<!-- 부트스트랩 끝-->

<!-- 파비콘 시작 -->
<link rel="shortcut icon" href="../favicon.ico">
<!-- 파비콘 끝 -->


<!-- jquery 준비 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- jquery 준비 끝 -->

</head>
<body>

<!-- 자바스크립트 시작 -->
<script type="text/javascript">
	// jquery 시작
	$(function() {
		// 아이디 중복체크 시작
		var num = 0;

		$('#id').keyup(function() {
			var id = $('#id').val();
			$.ajax({
				url : "memberIdChk.jsp",
				type : "post",
				data : {id:id},
				success:function(data){
					
					//아이디 값이 있을 때
					if(id.length > 0){
	  					if(data == 0){
	  			 			$('#idcheck2').html("");
	 						$('#idcheck1').html("사용가능한 아이디입니다.");
	  					}else if(data == -1){
	  			 			$('#idcheck1').html("");
	  						$('#idcheck2').html("중복되는 아이디가 있습니다.");
	  					}else if(data == -2){
	  			 			$('#idcheck1').html("");
	  						$('#idcheck2').html("admin은 사용할 수 없는 아이디 입니다.");	  						
	  					}else if(data == -3){
	  			 			$('#idcheck1').html("");
	  						$('#idcheck2').html("아이디 길이는 5~10입니다.");	  						
	  					}else if(data == -4){
	  			 			$('#idcheck1').html("");
	  						$('#idcheck2').html("아이디에 한글은 사용하실 수 없습니다.");	  						
	  					}else if(data == -5){
	  			 			$('#idcheck1').html("");
	  						$('#idcheck2').html("아이디에 공백 및 특수문자는 사용하실 수 없습니다.");	  						
	  					}
	  					
					//아이디 값이 없을 때	  					
					}else{
  			 			$('#idcheck1').html("");
  			 			$('#idcheck2').html("");
						
					}
				}
			});
		});
		// 아이디 중복체크 끝
		
		// 이메일 중복체크 시작
		
		$('#email').keyup(function() {
					var email = $('#email').val();
					$.ajax({
						url : "memberEmailChk.jsp",
						type : "post",
						data : {email:email},
						success:function(data){
					
					//아이디 값이 있을 때
					if(email.length > 0){
	  					if(data == 0){
	  			 			$('#emailcheck2').html("");
	 						$('#emailcheck1').html("사용가능한 이메일입니다.");
	  					}else if(data == -1){
	  			 			$('#emailcheck1').html("");
	  						$('#emailcheck2').html("중복되는 이메일이 있습니다.");
	  					}else if(data == -3){
	  			 			$('#emailcheck1').html("");
	  						$('#emailcheck2').html("이메일 양식이 맞지않습니다.");
	  					}else if(data == -4){
	  			 			$('#emailcheck1').html("");
	  						$('#emailcheck2').html("이메일 양식이 맞지않습니다.");
	  					}	  					
					//아이디 값이 없을 때	  					
					}else{
  			 			$('#emailcheck1').html("");
  			 			$('#emailcheck2').html("");
						
					}
				}
			});
		});
		// 아이디 중복체크 끝		
		
		// 이메일 중복체크 끝

		//비밀번호 일치 확인 시작1
		$('#pw').keyup(function() {

			var pw = $('#pw').val();
			var pw2 = $('#pw2').val();
			
			$.ajax({
				url : "memberPwChk.jsp",
				type : "post",
				data : {pw:pw,pw2:pw2},
				success:function(data){
					if(pw2.length > 0 && pw.length > 0){
	  					if(data == 0){
	  			 			$('#pwcheck2').html("");
	 						$('#pwcheck1').html("비밀번호가 일치합니다.");
	  					}else{
	  			 			$('#pwcheck1').html("");
	  						$('#pwcheck2').html("비밀번호가 다릅니다.");
	  					}
					}else{
  			 			$('#pwcheck1').html("");
  			 			$('#pwcheck2').html("");
					}
				}
			});
		});
		// 비밀번호 일치 확인 끝1		
		
		
		//비밀번호 일치 확인 시작2
		$('#pw2').keyup(function() {

			var pw = $('#pw').val();
			var pw2 = $('#pw2').val();
			
			$.ajax({
				url : "memberPwChk.jsp",
				type : "post",
				data : {pw:pw,pw2:pw2},
				success:function(data){
					if(pw2.length > 0 && pw.length > 0){
	  					if(data == 0){
	  			 			$('#pwcheck2').html("");
	 						$('#pwcheck1').html("비밀번호가 일치합니다.");
	  					}else{
	  			 			$('#pwcheck1').html("");
	  						$('#pwcheck2').html("비밀번호가 다릅니다.");
	  					}
					}else{
  			 			$('#pwcheck1').html("");
  			 			$('#pwcheck2').html("");					
					}
				}
			});
		});
		// 비밀번호 일치 확인 끝2					

	});
	// jquery 끝

	
	

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
 var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
 var nameRegExp = /^[가-힣]{2,4}$/;

    function isNumeric(s) { 
          for (i=0; i<s.length; i++) { 
            c = s.substr(i, 1); 
            if (c < "0" || c > "9") return false; 
          } 
          return true; 
    }
	
	
	
// 아이디 유효성 검사 시작 (공백과 'admin'이 올 수없으며, 길이가 5~10인 영어와 숫자조합의 아이디만 가능하다.)
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
	
	for (var i = 0; i < document.fr.id.value.length; i++) {
        chm = document.fr.id.value.charAt(i)
        if (!(chm >= '0' && chm <= '9') && !(chm >= 'a' && chm <= 'z')&&!(chm >= 'A' && chm <= 'Z')) {
            alert("아이디는 영문 대소문자, 숫자만 입력가능합니다.")
			document.fr.id.value="";
			document.fr.id.focus();
            return false;
        }
    }	
// 아이디 유효성 검사 끝		

	
// 비밀번호 유효성 검사 시작 (공백이 올 수 없으며, 아이디와 다르고, 비밀번호 확인과 일치해야한다.)
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
	
	
    if (document.fr.pw.value == document.fr.id.value) {
        alert("아이디와 비밀번호가 같습니다.")
		document.fr.pw.focus();
        return false;
    }	
// 비밀번호 유효성 검사 시작	

// 이름 유효성 검사 시작 (공백이 올 수 없으며, 2글자이상의 한글이어야 한다.)
	if(document.fr.name.value == ""){
		alert("이름을 입력하세요.");
		document.fr.name.focus();
		return false;
	} // if
	
    if(document.fr.name.value.length < 2){
        alert("이름을 2자 이상 입력해주십시오.")
		document.fr.name.focus();
        return false;
    }
	
    
    if (!nameRegExp.test(document.fr.name.value)) {
        alert("이름이 올바르지 않습니다.");
		document.fr.name.focus();
        return false;
    }

	
// 이름 유효성 검사 끝

	
// 전화번호 유효성 검사 시작 (공백x, 010으로 시작하는 숫자로 된 11자리 번호)
	if(document.fr.phone.value == ""){
		alert("전화번호 입력하세요.");
		document.fr.phone.focus();
		return false;
	} // if

    // 숫자가 아닌 것을 입력한 경우
    if (!isNumeric(document.fr.phone.value.substr(0,11))) {
        alert("전화번호는 숫자로 입력하세요.");
		document.fr.phone.value="";
		document.fr.phone.focus();
        return false;
    }		
	
	if(document.fr.phone.value.length != 11){
		alert("잘못된 전화번호 형식 입니다.");
		document.fr.phone.value="";
		document.fr.phone.focus();
		return false;
	} // if	
	
	if(document.fr.phone.value.substr(0,3) != '010'){
		alert("010 으로 시작하는 휴대전화 번호를 입력해주세요.");
		document.fr.phone.value="";
		document.fr.phone.focus();
		return false;		
	}
	
// 전화번호 유효성 검사 끝	
	

// 이메일 유효성 검사 시작 (공백x, 영어와 숫자조합으로 xxx@xxx.xxx 형식을 맞춰야한다.)
	if(document.fr.email.value == ""){
		alert("이메일을 입력하세요.");
		document.fr.email.focus();
		return false;
	} // if	
	
	if (regex.test(document.fr.email.value) === false) {
        alert("잘못된 이메일 형식입니다.");
        document.fr.email.value="";
		document.fr.email.focus();
        return false;
    }
	
	for (var i = 0; i < document.fr.email.value.length; i++) {
        chm = document.fr.email.value.charAt(i)
        if (!(chm >= '0' && chm <= '9') && !(chm >= 'a' && chm <= 'z') && !(chm >= 'A' && chm <= 'Z') && !(chm ='@')) {
            alert("이메일은 영문 대소문자, 숫자만 입력가능합니다.")
	        document.fr.email.value="";
			document.fr.email.focus();
            return false;
        }
    }	
// 이메일 유효성 검사 끝

	
// 아이디, 이메일 중복시 회원가입 막기 시작		
		var id = $('#id').val();
		var pw = $('#pw').val();
		var name = $('#name').val();
		var phone = $('#phone').val();
		var email = $('#email').val();
			
		$.ajax({
			url : "insertAjax.jsp",
			type : "post",
			data : {id:id,pw:pw,name:name,phone:phone,email:email},
			success:function(data){
 					if(data == 0){
 						alert('회원가입이 완료됐습니다.')
 						location.href="/Portpolio_camp/main/main.jsp";
 					}else if(data == -1){
 						alert('중복된 아이디입니다.');
 						$('#id').focus()
 					}else{
 						alert('중복된 이메일입니다.');
 						$('#email').focus()						
 					}
			}
		});
// 아이디, 이메일 중복시 회원가입 막기 끝

	
}	
	</script>
<!-- 자바스크립트 끝 -->



<!-- navbar 시작 -->
<jsp:include page="/navbar/navbar.jsp" />



 <h2 class="text-center p-5"> 회원가입 </h2>
 
 <!-- 컨테이너 시작 -->
 <div class="container-md">
  <form class="row g-3" action="" method="post" name="fr" id="fr">
 
   <!-- 아이디 --> 
   <div class="form-floating mb-3">
    <input type="text" class="form-control" id="id" placeholder="ID" name="id">
    <label for="floatingInput">ID</label>
    <span id="idcheck1" style="color: green;"></span>
    <span id="idcheck2" style="color: red;"></span>    
   </div>
   
   
   <!-- 비밀번호 -->   
   <div class="form-floating">
    <input type="password" class="form-control" id="pw" placeholder="Password" name="pw">
    <label for="floatingPassword">Password</label>
   </div>
   <!-- 비밀번호 확인 -->
   <div class="form-floating">
    <input type="password" class="form-control" id="pw2" placeholder="Password Confirm" name="pw2">
    <label for="floatingPassword">Password Confirm</label>
    <span id="pwcheck1" style="color: green;"></span>
    <span id="pwcheck2" style="color: red;"></span>    
   </div>  
   
   
   <!-- 이름 -->
   <div class="form-floating mb-3">
    <input type="text" class="form-control" id="name" placeholder="Name" name="name">
    <label for="floatingInput">Name</label>
   </div>
   
   <!-- 전화번호 --> 
   <div class="form-floating mb-3">
    <input type="tel" class="form-control" id="phone" placeholder="PhoneNumber" name="phone">
    <label for="floatingInput">Phone [ '-' 제외 ]</label>
   </div>
   
   <!-- 이메일 -->
   <div class="form-floating mb-3">
    <input type="email" class="form-control" id="email" placeholder="name@example.com" name="email">
    <label for="floatingInput">Email address</label>
    <span id="emailcheck1" style="color: green;"></span>
    <span id="emailcheck2" style="color: red;"></span>      
   </div>


  <!-- 제출 버튼 -->   
  <div class="col-sm30 p-5" style="text-align:center;">
   <input class="btn btn-primary btn-block" type="button" value="가입하기" onclick="return check1()" id="submit">
  </div>

 </form>
</div>
 <!-- 컨테이너 종료 -->

	
<!-- footer 시작 -->
<jsp:include page="/footer/footer.jsp" />
<!-- footer 끝 -->


	
</body>
</html>