<%@page import="com.camp.member.MemberDAO"%>
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
		
		MemberDAO bdao = new MemberDAO();
		
		int check = bdao.updateEmail(mb);
		
		System.out.println("비밀번호 수정 현황 : " + check);
		
		
 		if(check == 0){			
	 	
		 			
			//페이지 이동
			//response.sendRedirect("/Portpolio_camp/member/manageForm.jsp");
			
 		%>
 		<script type="text/javascript">
			alert(" 비밀번호 변경완료 ");
			location.href="/Portpolio_camp/member/manageForm.jsp";
			</script>
 		
 		<%
			
			}else if(check == -1){
	 		%>
	 		
	 		<script type="text/javascript">
	 			alert("새 비밀번호가 다릅니다.");
	 			history.back();
	 		</script>
	 		
	 		<%
			 	}else if(check == -2){
			 		// 비밀번호 다름 => 오류 (페이지 뒤로 이동)
			 		%>
			 		
			 		<script type="text/javascript">
			 			alert("현재 비밀번호가 다릅니다.");
			 			history.back();
			 		</script>
			 		
			 		<%
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