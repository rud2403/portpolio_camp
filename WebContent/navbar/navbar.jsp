<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- jquery 준비 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- jquery 준비 끝 -->

<script type="text/javascript">
	$(function (){
		$('#sub_1').hide();
		
		$('#menu_1').mouseover(function(){
			$('#sub_1').slideDown('fast');
		});
		
		$('#menu_2').mouseleave(function(){
			$('#sub_1').hide();
		});

	});

</script>



</head>
<body>

<%
 String id = (String)session.getAttribute("id");
%>

<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #E9E9E9;">
  <div class="container-fluid">
    <a class="navbar-brand" href="/Portpolio_camp/main/main.jsp">CampMap</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
    
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 pb-3" style="height:40px;">      
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
        
        
        
        <li class="nav-item" id="menu_2">
          <a class="nav-link active" id="menu_1" aria-current="page" href="/Portpolio_camp/board/marketForm.jsp">캠핑 장터</a>
	    	<ul class="px-3 py-1" id="sub_1" style="list-style:none; background-color: #E9E9E9;">
				<li><a href="/Portpolio_camp/board/BuyForm.jsp" style="text-decoration-line: none; color: black;">삽니다</a></li>
				<li><a href="/Portpolio_camp/board/SellForm.jsp" style="text-decoration-line: none; color: black;">팝니다</a></li>
			</ul>
        </li>
        
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/Portpolio_camp/board/freeboardForm.jsp">자유게시판</a>
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