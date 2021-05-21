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
	
	// 비밀번호 유효성 검사
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
	}
	
	// 이름 유효성 검사
	function nmcheck() {
		
		if($("#name").val() == ""){
			alert("이름을 입력해주세요.");
			$("#name").focus();
			return false;
		}
	}
	
	// 전화번호 유효성 검사
	function phcheck() {
		
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
	}
	
	// 이메일 유효성 검사
	function echeck(){
		
		if($("#email").val() == ""){
			alert("이메일을 입력해주세요.");
			$("#email").focus();
			return false;
			}
		
		// 에이잭스 넣기
		// 중복된 이메일 있으면 막기

	}	
	
	
	
</script>


</head>
<body>

<%
		// 로그인한 사람의 정보를 DB에서 조회해서
		// jsp화면에 출력
	
		// 로그인 세션 처리
		String id = (String)session.getAttribute("id");
	
		if (id == null) {
			//로그인 x
			System.out.println("[info.jsp] : 아이디 없음 -> 로그인페이지 이동");
			response.sendRedirect("loginForm.jsp");
		}
	
		// 디비 연결 후 필요한 데이터 조회 -> 출력
		
		final String DRIVER = "com.mysql.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/portpolio_camp";
		final String DBID = "root";
		final String DBPW = "1234";
		
		// 1 드라이버 로드
		Class.forName(DRIVER);
		
		// 2 디비 연결
		Connection conn = DriverManager.getConnection(DBURL, DBID, DBPW);
		
		// 3 쿼리 작성(select) & pstmt 작성
		String sql = "select * from camp_member where id = ?";
	
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		// 4 sql 객체 실행 -> rs에 저장
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		
		// 5 데이터 처리
		MemberBean mb = null;

		if(rs.next()) { 
			// rs에 저장된 정보를 꺼내서 화면에 출력
			mb = new MemberBean();

			mb.setId(rs.getString("id"));
			mb.setPw(rs.getString("pw"));
			mb.setName(rs.getString("name"));
			mb.setPhone(rs.getString("phone"));			
			mb.setEmail(rs.getString("email"));
			mb.setRegdate(rs.getTimestamp("regdate"));
			
			System.out.println("sql 구문 실행 완료");
			System.out.println("저장된 회원 정보" + mb);
		}
		
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
				      	<%=mb.getId() %>
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
					     	<input type="hidden" name="id" value="<%=mb.getId() %>">
					      	<div id="i2" style="display: none;">
					      		<div>현재 비밀번호 &nbsp;&nbsp;&nbsp;<input type="password" name="pw" id="pw"></div><br>
					      		<div>새 비밀번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="pw1" id="pw1"></div><br>
					      		<div>새 비밀번호 확인&nbsp;<input type="password" name="pw2" id="pw2"></div><br>
					      		
					   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
					      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func1();">	
					      		
					      	</div>
    							<%
    								String pw="";
    								for(int i= 0 ; i<mb.getPw().length();i++)
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
				      	<input type="hidden" name="id" value="<%=mb.getId() %>">
				      		<div id="i4" style="display: none;">
					      		<div><input type="text" name="name" id="name"></div><br>
					      		
						   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
						      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func2();">	
						      		
						     </div>
					      	
					      	<div id="i3"><%=mb.getName() %></div>
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
					     	<input type="hidden" name="id" value="<%=mb.getId() %>">
					      		<div id="i6" style="display: none;">
						      		<div><input type="text" name="phone" id="phone"></div><br>
						      		
							   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
							      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func3();">	
							      		
							     </div>
						      	
						      	<div id="i5"><%=mb.getPhone() %></div>
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
					     	<input type="hidden" name="id" value="<%=mb.getId() %>">
					      		<div id="i8" style="display: none;">
						      		<div><input type="email" name="email" id="email"></div><br>
						      		
							   		<input type="submit" class="btn btn-outline-primary btn-sm" value="확인">
							      	<input type="button" class="btn btn-outline-primary btn-sm" value="취소" onclick="func4();">	
							      		
							     </div>
						      	
						      	<div id="i7"><%=mb.getEmail() %></div>
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