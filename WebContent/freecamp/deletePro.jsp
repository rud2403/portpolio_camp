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
	<h1>WebContent/board/deletePro.jsp</h1>

	<%
		// 전달 정보 저장 - pageNum
		String pageNum = request.getParameter("pageNum");
		// 전달 정보 저장 - 액션태그 (자바빈)-num,pass
	%>
	<jsp:useBean id="bb" class="com.camp.board.BoardBean" />
	<jsp:setProperty property="*" name="bb" />

	<%
		System.out.println("삭제할 정보 : " + bb);

		// DB 처리 객체 BoardDAO 생성

		BoardDAO bdao = new BoardDAO();

		// 해당 글 정보를 사용해서 글 내용 수정 

		int check = bdao.deleteBoard(bb);
		// 처리 결과에 따른 페이지 이동
		System.out.println("삭제 현황 : " + check);

		// 페이지 이동 (자바스크립트 이용)
		// check =>1, 0, -1

		// 1 (정상적으로 수정완료)
		if (check == 0) {
		%>
		<script type="text/javascript">
			alert("정보 삭제완료! ");
			location.href="/Portpolio_camp/freecamp/freeForm.jsp?pageNum=<%=pageNum%>";
		</script>
		<%
		} else {
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