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
	
		// 로그아웃 => 세션정보를 초기화
		session.invalidate();
		
%>

	<script type="text/javascript">
		alert("로그아웃 됐습니다.");
		location.href="/Portpolio_camp/main/main.jsp";

	</script>

</body>
</html>