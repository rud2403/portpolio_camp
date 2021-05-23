<%@page import="com.camp.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CampMap</title>

<!-- 부트스트랩 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
<!-- 부트스트랩 끝 -->

<!-- 파비콘 시작 -->
<link rel="shortcut icon" href="../favicon.ico">
<!-- 파비콘 끝 -->

</head>
<body class="pb-1" style="background-color: #F2F2F2;">

	<!-- 추천게시판 DB 연동 시작 -->
	<%
	// 디비에 저장된 글의 개수를 알기
	
	// BoardDAO 객체 생성
	BoardDAO bdao = new BoardDAO();

	// 즐겨찾기한 count 순으로 추천 캠핑장 보여주기
	ArrayList boardList = bdao.getRecommendList();

	// 캠핑장터 메인화면에 보여주기
	ArrayList marketList = bdao.getMainMarketList();
	
	// 자유게시판 메인화면에 보여주기
	ArrayList freeList = bdao.getFreeList();
	
	%>
	<!-- 추천게시판 DB 연동 끝 -->
	

<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
<!-- navbar 끝 -->

<!-- container 시작 -->
<div class="container pt-3 mb-5 "> 

<!-- 메인 텍스트 시작 -->
  <div class="col-md-12 text-center p-5 row">
   <a href="main.jsp" style="text-decoration-line: none; color: black;"> <h1>CampMap</h1> </a>
  </div>
<!-- 메인 텍스트 끝 -->  
  
<!-- 이미지 슬라이드 시작 -->  
	<div class="row">
		<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
		  <ol class="carousel-indicators">
		    <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active"></li>
		    <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"></li>
		    <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"></li>
		  </ol>
		  <div class="carousel-inner">
		  
		  	<%for(int i = 0; i < 3; i++){ 
				BoardBean bb = (BoardBean)boardList.get(i);
			
			if(i == 0){ %>  
		    <div class="carousel-item active">
		    <%}else{ %>
		    <div class="carousel-item">    
		    <%} %>
		    
			<%if(bb.getFilename().equals("null")){ %>
		      	<img src="https://allways.smotor.com/wp-content/uploads/2020/04/0429_%EC%BA%A0%ED%95%91_12.jpg" class="d-block w-100 rounded" alt="..." width="300" height="500" onclick="location.href='/Portpolio_camp/freecamp/content.jsp?num=<%=bb.getNum()%>'"  style='cursor:pointer;'>
		      <%}else{ %>	      
		      	<img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100 rounded" alt="..." width="300" height="500" onclick="location.href='/Portpolio_camp/freecamp/content.jsp?num=<%=bb.getNum()%>'"  style='cursor:pointer;'>
		      <%} %>    
		    
		      <div class="carousel-caption d-none d-md-block">
		      	<h1>추천 캠핑장 </h1>
		        <h5><%=bb.getName() %></h5>
		        <p><%=bb.getAddress() %> / 난이도 <%if(bb.getLevel().equals("상")){ %>
													★★★
											    <%}else if(bb.getLevel().equals("중")){ %>
											       	★★
											    <%}else{ %>
											     	  ★
											    <%} %></p>
		      </div>
		    </div>
		    
			<%} %>    
		    
		  </div>
		  <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </a>
		  <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </a>
		 </div>
		</div>
<!-- 이미지 슬라이드 끝 -->  
  
  
  
  
  
<!-- 테이블 row 시작 -->
	<div class="row mt-5">
		<div class="col">
			<div class="row text-center"><h5>캠핑 장터</h5></div>
			<div align="right">
				<a href="/Portpolio_camp/board/marketForm.jsp" style="text-decoration-line: none; color: black;">더보기</a>
			</div>
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">구분</th>
			      <th scope="col">제목</th>
			      <th scope="col">작성자</th>
			    </tr>
			  </thead>
			  <tbody>
			  <%
			  	for(int i = 0; i < 3; i++){ 
				BoardBean ml = (BoardBean)marketList.get(i);
			  %>
			    <tr>
			      <td>
					 <%if(ml.getKind().equals("팝니다")){ %>
			     	 <span class="badge bg-primary">팝니다</span>
			     	 <%}else{%>
			     	 <span class="badge bg-danger">삽니다</span>
			     	 <%} %>
				  </td>
			      <td>
			    	<a href="/Portpolio_camp/board/content.jsp?num=<%=ml.getNum()%>" style="text-decoration-line: none; color: black;"><%=ml.getName() %></a>		      	
			      </td>
			      <td><%=ml.getId() %></td>
			    </tr>
			    <%}%>
			  </tbody>
			</table>		
		</div>
		
		<div class="col">
			<div class="row text-center"><h5>자유 게시판</h5></div>
			<div align="right">
				<a href="/Portpolio_camp/freeboard/freeboardForm.jsp" style="text-decoration-line: none; color: black;">더보기</a>
			</div>
			<table class="table">
			  <thead>
			    <tr class="text-center">
			      <th scope="col">제목</th>
			      <th scope="col">작성자</th>
			    </tr>
			  </thead>
			  <tbody>
			  <%
			  	for(int i = 0; i < 3; i++){ 
				BoardBean fl = (BoardBean)freeList.get(i);
			  %>			  
			    <tr>
			      <td>
			      <%
				int wid = 0;
				if(fl.getRe_lev() > 0){
				wid = 10 * fl.getRe_lev(); 
				%>
				  <img alt="" src="../img/freeboard/level.gif" height="15" width="<%=wid%>">
	 			  ┕
				<%
				}
				%>
	      			<a  href="/Portpolio_camp/freeboard/content.jsp?num=<%=fl.getNum()%>&re_ref=<%=fl.getRe_ref() %>&re_lev=<%=fl.getRe_lev() %>&re_seq=<%=fl.getRe_seq() %>" style="text-decoration-line: none; color: black;"><%=fl.getName() %></a>		      	
			      </td>
			      <td class="text-center"><%=fl.getId() %></td>
			    </tr>
			    <%} %>
			  </tbody>
			</table>		
		</div>
	</div>
<!-- 테이블 row 끝 -->


</div>
<!-- container 끝 -->

</div>


<!-- footer 시작 -->
<div class="row">
 <jsp:include page="/footer/footer.jsp" />
</div>
<!-- footer 끝 -->

</body>
</html>