<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
		// 세션 제어
		String id = (String) session.getAttribute("id");
		if (id == null) {
			response.sendRedirect("loginForm.jsp");
		}

		// 한글 처리
		request.setCharacterEncoding("utf-8");

		// 전달되는 정보 저장
	%>

	<jsp:useBean id="mb" class="com.camp.member.MemberBean"></jsp:useBean>

	<jsp:setProperty property="*" name="mb" />

	<%
		// update 처리 로직을 참고하여 회원정보 삭제기능 구현

		System.out.println("삭제할 정보 : " + mb);

			MemberDAO bdao = new MemberDAO();
			
		// 해당 글 정보를 사용해서 회원 정보 삭제
		
			int check = bdao.deleteMember(mb);
			
			// 제대로 삭제가 되면 check에 1이 반환되기 때문에 성립하여 회원삭제 완료.
			if(check > 0 ){
				
				//남은 세션 정보 초기화 하기
				session.invalidate();
				
				//페이지 이동
				response.sendRedirect("/Portpolio_camp/member/withdrawalconForm.jsp");
				
				} else {	// 비밀번호 다름 => 오류 (페이지 뒤로 이동)
	%>
				<script type="text/javascript">
					alert(" 비밀번호가 다릅니다. ");
					history.back();
				</script>

	<%
				
			}

	%>
</body>
</html>