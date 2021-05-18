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
		// 한글처리
		request.setCharacterEncoding("utf-8");
		
		// searchIdForm 페이지에서 form을 통해 넘어온 전달정보(파라미터 name, email)를 저장(자바빈객체 - 액션태그) 
		%>
		
		<jsp:useBean id="mb" class="com.camp.member.MemberBean"></jsp:useBean>
		
		<jsp:setProperty property="*" name="mb"/>
		
		<%
		// 자바빈에 email값과 name값이 전달됐음
		System.out.println("전달 정보 : " + mb);
		
		// DB이동 후 name, eamil 유무 판별 (일치하면 id값 찾아주기)
		MemberDAO bdao = new MemberDAO();
			
		// 해당 글 정보를 사용해서 회원 id 값 가져오기
		int check = bdao.seachId(mb);		
		
		
		System.out.println(mb.getId());
		System.out.println("check 값은 " + check);
		
		if(check == 0){
			session.setAttribute("fid", mb.getId());
			response.sendRedirect("/Portpolio_camp/member/IdCheck.jsp");
		}else{
			%>
			<script type="text/javascript">
				alert("아이디를 찾을 수 없습니다. 다시한번 확인해주세요.");
				history.back();
			</script>
			<%
		}
		
		// id 값을 가지고 페이지 이동
		
		
		
		%>
		
		
</body>
</html>