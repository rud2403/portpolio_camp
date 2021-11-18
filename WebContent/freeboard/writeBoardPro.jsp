<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.camp.board.BoardDAO"%>
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
	%>
	
		<!-- 	자바빈객체 생성 -->
		<jsp:useBean id="bb" class="com.camp.board.BoardBean"></jsp:useBean>
		<jsp:setProperty property="*" name="bb"/>

	<%
		bb.setIp(request.getRemoteAddr());
	
		System.out.println("글쓰기 정보 : " +bb.toString());
		
		// DB에 대한 처리를 하는 객체를 생성
		BoardDAO bdao = new BoardDAO();
		
		// 글쓰기 기능 사용
		bdao.insertfreeBoard(bb);
		
		// 페이지 이동
		response.sendRedirect("/Portpolio_camp/freeboard/freeboardForm.jsp");
	%>
	
</body>
</html>