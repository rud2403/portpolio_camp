<%@page import="com.camp.member.MemberDAO"%>
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
		// 회원가입 정보를 전달 받아서 저장 -> DB저장 (회원)
		request.setCharacterEncoding("utf-8");
	%>	
	
	<jsp:useBean id="mb" class="com.camp.member.MemberBean" />

	<jsp:setProperty property="*" name="mb"/>
	
	<%
		System.out.println("회원 정보 : " + mb.toString());	

		// DB에 대한 처리를 하는 객체를 생성
		MemberDAO bdao = new MemberDAO();
		
		// 회원가입 기능 사용
		bdao.insertMember(mb);

		
// 		<script type="text/javascript">
			
// 			alert("회원가입이 완료되었습니다.");
// 			location.href="/Portpolio_camp/main/main.jsp";
			
// 		</script>

		
		// 페이지 이동
		response.sendRedirect("/Portpolio_camp/member/insertconfirmForm.jsp");
		
		%>


</body>
</html>