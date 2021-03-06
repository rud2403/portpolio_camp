<%@page import="com.camp.member.MemberDAO"%>
<%@page import="com.camp.member.MemberBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내정보 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

<!-- 파비콘 시작 -->
<link rel="shortcut icon" href="../favicon.ico">
<!-- 파비콘 끝 -->

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
	
	// 비밀번호 유효성 검사 시작
	function pwcheck() {
		if($("#pw").val() == ""){
			alert("현재 비밀번호를 입력해주세요.");
			$("#pw").focus();
			return false;
			}		
		if($("#pw1").val() == ""){
			alert("새 비밀번호를 입력해주세요.");
			$("#pw1").focus();
			return false;
			}
		if($("#pw2").val() == ""){
			alert("새 비밀번호 확인을 입력해주세요.");
			$("#pw2").focus();
			return false;
			}
		
	    if ($("#pw1").val() == '<%=session.getAttribute("id") %>') {
	        alert("아이디와 비밀번호가 같습니다.")
			$("#pw1").focus();
	        return false;
	    }		
		
	}
	// 비밀번호 유효성 검사 끝

	
	// 이름 유효성 검사 시작
	function nmcheck() {
		
		if($("#name").val() == ""){
			alert("이름을 입력해주세요.");
			$("#name").focus();
			return false;
		}
		
	    if($("#name").val().length < 2){
	        alert("이름을 2자 이상 입력해주십시오.")
			$("#name").focus();
	        return false;
	    }
	    
	    var nameRegExp = /^[가-힣]{2,4}$/;
	    if (!nameRegExp.test($("#name").val())) {
	        alert("이름이 올바르지 않습니다.");
	        $("#name").focus();
	        return false;
	    }	    
		
	}
	// 이름 유효성 검사 끝
	
	// 전화번호 유효성 검사 시작
	function phcheck() {
		
	    function isNumeric(s) { 
	          for (i=0; i<s.length; i++) { 
	            c = s.substr(i, 1); 
	            if (c < "0" || c > "9") return false; 
	          } 
	          return true; 
	    }
		
		if($("#phone").val() == ""){
			alert("전화번호를 입력해주세요.");
			$("#phone").focus();
			return false;
			}
		
		if($("#phone").val().length != 11){
			alert("잘못된 전화번호 입니다.");
			$("#phone").val("");
			$("#phone").focus();
			return false;
		}
		
	    if (!isNumeric($("#phone").val().substr(0,11))) {
	        alert("전화번호는 숫자로 입력하세요.");
			$("#phone").val("");
			$("#phone").focus();
	        return false;
	    }
	    
		if($("#phone").val().substr(0,3) != '010'){
			alert("010 으로 시작하는 휴대전화 번호를 입력해주세요.");
			$("#phone").val("");
			$("#phone").focus();
			return false;		
		}	    
	}
	// 전화번호 유효성 검사 끝
	
	// 이메일 유효성 검사 시작
	function echeck(){
		var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

		if($("#email").val() == ""){
			alert("이메일을 입력해주세요.");
			$("#email").focus();
			return false;
		}
		
		if (regex.test($("#email").val()) === false) {
	        alert("잘못된 이메일 형식입니다.");
			$("#email").focus();
	        return false;
	    }		
	}	
	// 이메일 유효성 검사 시작
	
	
	
</script>


</head>
<body>
<%
	String id = (String)session.getAttribute("id");

	if (id == null) {
		//로그인 x
		System.out.println("[info.jsp] : 아이디 없음 -> 로그인페이지 이동");
		response.sendRedirect("loginForm.jsp");
	}
%>
	<jsp:useBean id="mb" class="com.camp.member.MemberBean" />
	<jsp:setProperty property="*" name="mb"/>

<%	
	
	System.out.println("확인 할 정보 @@@@@@@@@@@@@@@@@@@@ : " + mb);


	MemberDAO bdao = new MemberDAO();

	MemberBean mb2 = bdao.manageMemeber(mb);
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
<!-- 왼쪽 열 종료 -->	

<!-- 오른쪽 열 시작 -->	
	<div class="col-10 text-center mt-5">
		<h3>내정보 관리</h3>
		
		<!-- 행 시작 -->
		<div class="row mt-5">
		
			<div class="col-1"></div>
			
			<div class="col-10">
				<!-- 테이블 시작 -->
				<table class="table text-center">
				  <tbody>
				    <tr>
				      <th scope="row">아이디</th>
				      
				      <!-- 가운데 부분 시작 -->
				      
				      <td>
				      	<%=mb2.getId() %>
				      </td>
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
					      <form action="/Portpolio_camp/member/managepwPro2.jsp" method="post" onsubmit="return pwcheck()">
					     	<input type="hidden" name="id" value="<%=mb2.getId() %>">
					     	
					      	<div id="i2" style="display: none;">
					      		<div>현재 비밀번호 &nbsp;&nbsp;&nbsp;<input type="password" name="pw" id="pw"></div><br>
					      		<div>새 비밀번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="pw1" id="pw1"></div><br>
					      		<div>새 비밀번호 확인&nbsp;<input type="password" name="pw2" id="pw2"></div><br>
					      		
						   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
						      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func1();">	
					      		
					      	</div>
    							<%
    								String pw="";
    								for(int i= 0 ; i<mb2.getPw().length();i++)
    								{
    									pw+="*";
    								}
    							%>
					      	<div id="i1"><%=pw %></div>
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
				      <form action="/Portpolio_camp/member/managenamePro.jsp" method="post" onsubmit="return nmcheck()">
				      	<input type="hidden" name="id" value="<%=mb2.getId() %>">
				      		<div id="i4" style="display: none;">
					      		<div><input type="text" name="name" id="name"></div><br>
					      		
						   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
						      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func2();">	
						      		
						     </div>
					      	
					      	<div id="i3"><%=mb2.getName() %></div>
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
				      
					     <form action="/Portpolio_camp/member/managephonePro.jsp" method="post" onsubmit="return phcheck()">
					     	<input type="hidden" name="id" value="<%=mb2.getId() %>">
					      		<div id="i6" style="display: none;">
						      		<div><input type="text" name="phone" id="phone"></div><br>
						      		
							   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
							      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func3();">	
							      		
							     </div>
						      	
						      	<div id="i5"><%=mb2.getPhone() %></div>
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
				      
					     <form action="/Portpolio_camp/member/manageemailPro.jsp" method="post" onsubmit="return echeck()">
					     	<input type="hidden" name="id" value="<%=mb2.getId() %>">
					      		<div id="i8" style="display: none;">
						      		<div><input type="email" name="email" id="email"></div><br>
						      		
							   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
							      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func4();">	
							      		
							     </div>
						      	
						      	<div id="i7"><%=mb2.getEmail() %></div>
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