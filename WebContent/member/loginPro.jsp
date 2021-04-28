<%@page import="com.camp.member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// 한글처리
		request.setCharacterEncoding("utf-8");
		
		// 전달정보를 저장(자바빈객체 - 액션태그) id, pw
		%>
		<jsp:useBean id="mb" class="com.camp.member.MemberBean"></jsp:useBean>
		
		<jsp:setProperty property="*" name="mb"/>
		
		<%
		
			System.out.println("전달 정보 : " + mb);
		///////////////////////////////////////////////////
		// DB이동 후 로그인 상태 판별
		
		final String DRIVER = "com.mysql.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/portpolio_camp";
		final String DBID = "root";
	 	final String DBPW = "1234";
	 	
	 	// 1. 드라이버 로드
	 	
	 	Class.forName(DRIVER);
	 	
	 	Connection conn = DriverManager.getConnection(DBURL, DBID, DBPW);
	 	
	 	String sql ="select pw from camp_member where id = ?";
	 	
	 	
	 	PreparedStatement pstmt = conn.prepareStatement(sql);

	
		pstmt.setString(1, mb.getId());
		
		ResultSet rs = pstmt.executeQuery();
		
		//sql 구문의 결과가 있을 때
		if(rs.next()){
			// 회원이다
			// 비밀번호를 사용해서 본인 확인
			if(mb.getPw().equals(rs.getString("pw")) ){
				// 비밀번호가 같다 ( + 회원이다 ) => 본인 => 로그인성공
						
				// 로그인 성공의 의미로 회원 ID정보를 session내장 객체에 저장
				session.setAttribute("id", mb.getId());
				// main.jsp 페이지 이동
				response.sendRedirect("/Portpolio_camp/main/main.jsp");
				System.out.println("로그인성공");
				
			}else{
				// 비밀번호 다름. ( + 회원이다.)
				%>
				<script type="text/javascript">
					alert("비밀번호 오류");
					history.back();
				</script>
				
				<%
				
				
			}
		}else{ // 비회원이다.
			%>
			<script type="text/javascript">
				 var con = confirm("비회원입니다. 회원가입 하시겠습니까?");
				 if(con == true){
					 location.href="insertForm.jsp";
				 }else{
					 history.back();
				 }
				 
				// Y - 회원가입 페이지 이동, N - 페이지 뒤로가기
				//alert("비회원입니다.");
				
			</script>
			
			<%
		}
	%>
</body>
</html>