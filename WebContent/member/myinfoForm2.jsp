<%@page import="com.camp.member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.camp.member.MemberBean"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내정보</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
</head>
<body>

 	<!--  myinfoForm DAO를 위한 임시 페이지  -->

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
		
		
		
		%>	
		<jsp:useBean id="mb" class="com.camp.member.MemberBean" />
		<jsp:setProperty property="*" name="mb"/>
		<%
		
		System.out.println("확인 할 정보 @@@@@@@@@@@@@@@@@@@@ : " + mb);

		// 디비 연결 후 필요한 데이터 조회 -> 출력
		
		MemberDAO bdao = new MemberDAO();

		MemberBean mb2 = bdao.infoMember(mb);
		
		
		
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
		<h3>내정보</h3>
		
		<div class="row mt-5">
			<div class="col-1"></div>
			<div class="col-10">
				<!-- 테이블 시작 -->
				<table class="table">
				  <tbody>
				    <tr>
				      <th scope="row">아이디</th>
				      <td><%=mb2.getId() %></td>
				    </tr>
				    <tr>
				      <th scope="row">비밀번호</th>
				      <td><%=mb2.getPw() %></td>
				    </tr>
				    <tr>
				      <th scope="row">이름</th>
				      <td><%=mb2.getName() %></td>
				    </tr>
				    <tr>
				      <th scope="row">전화번호</th>
				      <td><%=mb2.getPhone() %></td>
				    </tr>
				    <tr>
				      <th scope="row">이메일</th>
				      <td><%=mb2.getEmail() %></td>
				    </tr>	
				    <tr>
				      <th scope="row">가입일자</th>
				      <td><%=mb2.getRegdate() %></td>
				    </tr>				    			    				    
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