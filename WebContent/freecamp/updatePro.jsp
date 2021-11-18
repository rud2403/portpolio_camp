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
		// 한글 처리
		request.setCharacterEncoding("utf-8");
	
		// 주소줄에 전달되는 pageNum값 저장
		String pageNum = request.getParameter("pageNum");
	%>
	 <jsp:useBean id="bb" class="com.camp.board.BoardBean" />
	 <jsp:setProperty property="*" name="bb"/>
	
	<%
	 System.out.println("수정할 정보 : " + bb);
	
	// DB 처리 객체 BoardDAO 생성
	BoardDAO bdao = new BoardDAO();
	
	// 해당 글 정보를 사용해서 글 내용 수정 
	
	int check = bdao.updateBoard(bb);
	
	// 페이지 이동 (자바스크립트 이용)
	// check =>1, 0, -1
	// 1 (정상적으로 수정완료)
	if(check == 0){
		%>
		<script type="text/javascript">
			alert("정보 수정완료! ");
			location.href="/Portpolio_camp/freecamp/freeForm.jsp?pageNum=<%=pageNum%>";
		</script>
		<%
	// -1 (없는글 접근 - 수정실패)
	}else{
		%>
		<script type="text/javascript">
			alert("해당 글 없음! ");
			history.back();
		</script>
	<%
	}
	%>

</body>
</html>