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
		MemberDAO bdao = new MemberDAO();
			
		// 해당 글 정보를 사용해서 회원 정보 삭제
		int check = bdao.loginMember(mb);
		
		
		
		//sql 구문의 결과가 있을 때
		if(check > 0){

			session.setAttribute("id", mb.getId());
			session.setAttribute("pw", mb.getPw());

			// main.jsp 페이지 이동
			response.sendRedirect("/Portpolio_camp/main/main.jsp");
			System.out.println("로그인성공");
				
			}else if(check == 0){
				// 비밀번호 다름. ( + 회원이다.)
				%>
				<script type="text/javascript">
					alert("비밀번호가 틀립니다.");
					history.back();
				</script>
				
				<%
				
		
		}else{ // 비회원이다.
			%>
			<script type="text/javascript">
				 var con = confirm("비회원입니다. 회원가입 하시겠습니까?");
				 if(con == true){
					 location.href="insertForm.jsp";
				 }else{
					 history.back();
				 }
		<%		 
		}
		%>
				// Y - 회원가입 페이지 이동, N - 페이지 뒤로가기
				//alert("비회원입니다.");
				
			</script>

</body>
</html>