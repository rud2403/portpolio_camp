<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(function() {
			$("#fr").submit();
		})
	</script>

	<script type="text/javascript">
		<%
		String id = (String)session.getAttribute("id");
		String pw = (String)session.getAttribute("pw");
		
		
		if (id == null) {
			//로그인 x
			System.out.println("[info.jsp] : 아이디 없음 -> 로그인페이지 이동");
			response.sendRedirect("/Portpolio_camp/member/loginForm.jsp");
		}
		
		%>
	</script>




</head>
<body>
	
	<!-- camp/파일업로드 프로 -->
	<%
	// 파일 업로드 전 준비
	
	// 0) 해당 라이브러리 설치(cos.jar)
	// 1) 파일이 저장될 위치 지정
	String path = request.getRealPath("/upload");

	System.out.println("파일이 저장되는 실제 경로 : " + path);
	
	// 2) 파일의 크기를 지정 -> 10mb
	int maxSize = 10 * 1024 * 1024;
	
	// 파일 업로드 => Multipart 객체를 생성
	MultipartRequest multi = new MultipartRequest(
			request,
			path,
			maxSize,
			"UTF-8",
			new DefaultFileRenamePolicy()
			);
	
	System.out.println("파일이 업로드 됐습니다.");
	
	// 이전 페이지에서 전달해 준 정보를 출력s

	String name = multi.getParameter("name");
	String coment = multi.getParameter("coment");
	int num = Integer.parseInt(multi.getParameter("num"));
	String pageNum = multi.getParameter("pageNum");	
	
	//String filename = multi.getParameter("filename");
	
	// 서버에 올라가는 파일의 이름(중복처리)
	String filename = multi.getFilesystemName("filename");
	String filename2 = multi.getFilesystemName("filename2");
	String filename3 = multi.getFilesystemName("filename3");
	
	// 서버에 올라가는 파일이름 X 파일자체의 이름
	String oFileName = multi.getOriginalFileName("filename");
	String oFileName2 = multi.getOriginalFileName("filename2");
	String oFileName3 = multi.getOriginalFileName("filename3");
	
	%>

	<hr>
	
	<form id="fr" name="fr" action="/Portpolio_camp/freeboard/updatePro.jsp" method="post">
		<input type="hidden" name="name" value="<%=name %>">
		<input type="hidden" name="id" value="<%=id %>">
		<input type="hidden" name="pw" value="<%=pw %>">
		<input type="hidden" name="coment" value="<%=coment %>">
		<input type="hidden" name="filename" value="<%=filename %>">
		<input type="hidden" name="filename2" value="<%=filename2 %>">
		<input type="hidden" name="filename3" value="<%=filename3 %>">	
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">			
		
	</form>

	<!-- <a href="javascript:fr.submit();">DB 저장하기</a> -->
	
</body>
</html>