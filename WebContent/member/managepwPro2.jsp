<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.camp.member.MemberBean"%>
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
		// 로그인 세션
		String id = (String)session.getAttribute("id");
	
		if(id == null){
			System.out.println("[updatePro.jsp] : 아이디없음 -> 로그인페이지 이동");
			response.sendRedirect("loginForm.jsp");
		}
		
		// 한글 처리
		request.setCharacterEncoding("utf-8");
		
		// 전달되는 정보(파라미터)를 저장 => 액션태그 사용 자바빈객체 저장
				
		String pw = request.getParameter("pw");
		String pw1 = request.getParameter("pw1");
		String pw2 = request.getParameter("pw2");
		%>
		
		<jsp:useBean id="mb" class="com.camp.member.MemberBean" />
		
		<jsp:setProperty property="*" name="mb" />
		
		<%
		
 	
		
		System.out.println("전달된 수정할 정보 : " +mb);
		
		

		// DB접속 후
		final String DRIVER = "com.mysql.jdbc.Driver";
		final String DBURL = "jdbc:mysql://localhost:3306/portpolio_camp";
		final String DBID = "root";
	 	final String DBPW = "1234";
	 	
	 	// 1. 드라이버 로드
	 	
	 	Class.forName(DRIVER);
	 	
	 	// 2. 디비연결
	 	Connection conn = DriverManager.getConnection(DBURL, DBID, DBPW);
		
	 	// 3. sql작성 & pstmt 객체생성
	 	String sql = "select pw from camp_member where id = ? ";

	 	PreparedStatement pstmt = conn.prepareStatement(sql);
	 	
	 	// ? 채우기
	 	pstmt.setString(1, mb.getId());
	 	
	 	// 4. sql 실행
	 	ResultSet rs = pstmt.executeQuery();
	 	

	 	// 5. 데이터 처리
		 	if(rs.next()){
		 		// 아이디가 있는 경우
		 		
		 		
		 		if(mb.getPw().equals(rs.getString("pw"))){
		 			// 비밀번호 같음
		 			
		 			
		 			// 새 비밀번호 일치 확인
		 			if(pw1.equals(pw2)){
		 				
		 			// sql 구문 작성 & pstmt 객체
		 			sql = "update camp_member set pw = ? where id = ? ";
		 			
		 			pstmt = conn.prepareStatement(sql);
		 				// sql문 하나당 pstmt하나 따라와야함
		 			
		 			// ? 채우기
		 			pstmt.setString(1, pw1);
		 			pstmt.setString(2, mb.getId());
		
		 			// sql 실행
		 			
		 			pstmt.executeUpdate();
		 			
		 			//페이지 이동
		 			//response.sendRedirect("/Portpolio_camp/member/manageForm.jsp");
		 			
			 		%>
			 		<script type="text/javascript">
		 			alert(" 비밀번호 변경완료 ");
		 			location.href="/Portpolio_camp/member/manageForm.jsp?id=<%=id%>";
		 			</script>
			 		
			 		<%
		 			
		 			}else{
				 		%>
				 		
				 		<script type="text/javascript">
				 			alert("새 비밀번호가 다릅니다.");
				 			history.back();
				 		</script>
				 		
				 		<%
		 			}
			 	}else{
			 		// 비밀번호 다름 => 오류 (페이지 뒤로 이동)
			 		%>
			 		
			 		<script type="text/javascript">
			 			alert("현재 비밀번호가 다릅니다.");
			 			history.back();
			 		</script>
			 		
			 		<%
			 	}
		 		
		 	}else{
		 		// 아이디가 없는 경우 => 오류 (페이지 뒤로 이동)
		 			%>
		 		<script type="text/javascript">
	 			alert(" 아이디 없음 ! ");
	 			history.back();
	 			</script>
		 		
		 		<%
		 	}
		 	%>


	 	
	

</body>
</html>