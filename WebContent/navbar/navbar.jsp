<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
</style>

</head>
<body>

<%
 String id = (String)session.getAttribute("id");
%>

<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #E9E9E9 ;">
  <div class="container-fluid">
    <a class="navbar-brand" href="/Portpolio_camp/main/main.jsp">CampMap</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      
      	<%
         if(session.getAttribute("id") == null){
        %>
        <li class="nav-item">
          <a class="nav-link" href="/Portpolio_camp/member/insertForm.jsp">회원가입</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/Portpolio_camp/member/loginForm.jsp">로그인</a>
        </li>
        <%
         }
        %> 
 
        
        <%
         if(session.getAttribute("id") != null){
        %>
        <li class="nav-item">
          <a class="nav-link" href="/Portpolio_camp/member/mypageForm.jsp">마이페이지</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/Portpolio_camp/member/logoutPro.jsp">로그아웃</a>
        </li>
        <%
         }
        %>
        
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">|</a>
        </li>        
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/Portpolio_camp/freecamp/freeForm.jsp">무료 캠핑장</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">유료 캠핑장</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/Portpolio_camp/board/commuForm.jsp">캠핑 장터</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">자유게시판</a>
        </li>        
      </ul>
      
	   
      <%
      if(session.getAttribute("id") != null){
      %>
      <span class="navbar-text">
        <%=id %>님 반갑습니다.
      </span>
      <%
      }
      %>
      
    </div>
  </div>
</nav>
</body>
</html>