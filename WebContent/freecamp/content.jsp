<%@page import="com.camp.board.BoardBean"%>
<%@page import="com.camp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>content</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
</head>
<body>

<%
		// 페이지 이동 시 전달정보가 있으면 항상 먼저 저장
		// num, pageNum
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		// BoardDAO 객체 생성
		
		BoardDAO bdao = new BoardDAO();
		
		
		
		// 글 조회수 1증가 (DB 처리)
 		bdao.updateReadcount(num);
		
		
 		//DB에서 글 번호(null)에 해당하는 글 정보를 모두 가져와서 출력
 		BoardBean bb = bdao.getBoard(num);
	
	%>

	<!-- id 값 받아오기 시작 -->
	<script type="text/javascript">
		<%
		String id = (String)session.getAttribute("id");
		%>
	</script>
	<!-- id 값 받아오기 끝 -->

<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
 
<!-- navbar 끝 -->

<!-- container 시작 -->	
<div class="container-fluid p-5">

	<!-- 캠핑지 이름 줄 시작 -->	
	<div class="row pt-3">
		<div class="col-4 text-center">
		</div>
		<div class="col-4 text-center">
			<h2><%=bb.getName() %></h2>
		</div>
		<div class="col-4 text-center">
		</div>
	</div>
	<!-- 캠핑지 이름 줄 끝 -->	
	
	<!-- 조회수 및 수정 삭제 줄 시작 -->	
	<div class="row">
		<%if(id.equals("admin")){ %>
		<div class="col-1 text-center">
			<button class="btn btn-light btn-sm" type="button">수정</button> / <button class="btn btn-light btn-sm" type="button">삭제</button>
		</div>
		<%} %>
		<div class="col-10 text-center">
		</div>
		<div class="col-1 text-center">
			조회수 <%=bb.getReadcount() %>
		</div>
	</div>
	<!-- 조회수 및 수정 삭제 줄 끝 -->	
	
	<hr>
	
	<!-- 위치 및 난이도 줄 시작 -->
	<div class="row">
		<!-- 위치 칼럼 시작 -->
		<div class="col-4 px-3">
			<div class="row">
				<div class="px-4 m-2"><%=bb.getAddress() %></div>
			</div>
			<div class="row m-1">
				<div class="col-3"><span class="badge rounded-pill bg-primary">경도</span> <%=bb.getLat() %> </div>
				<div class="col-9"><span class="badge rounded-pill bg-danger">위도</span> <%=bb.getLng() %></div>
			</div>
		</div>
		<!-- 위치 칼럼 끝 -->
		
		<!-- 난이도 칼럼 시작 -->
		<div class="col-6 text-center">
		</div>
		<div class="col-2">
			<div class="row text-center px-4 m-2">
					<span class="badge bg-light text-dark p-3">
							캠핑지 난이도
								<br>
							 <%if(bb.getLevel().equals("상")){ %>
								★★★
					     	 <%}else if(bb.getLevel().equals("중")){ %>
					       		★★
					      	 <%}else{ %>
					     		★
					      	 <%} %>
					 </span>
			</div>
		</div>
		<!-- 난이도 칼럼 끝 -->
		
	</div>
	<!-- 위치 및 난이도 줄 끝 -->
	
	
	<!-- 주변환경 줄 시작 -->
	<div class="row text-center mt-3 mx-3">
	
	<div class="card">
		<div class="card-header">
	    주변 환경
	  	</div>
	  <div class="card-body">
	    <blockquote class="blockquote mb-0">
	      <div class="row">
		      <div class="col">
		      		필드<br>
					<%=bb.getField() %>
				</div>
				<div class="col">
					바닥<br>
					<%=bb.getLand() %>
					
				</div>
				<div class="col">
					화장실<br>
					<%if(bb.getFishing().equals("y")){%>
						있음
						<%}else{%>
						없음
					<%} %>
				</div>
				<div class="col">
					주차장<br>
					<%if(bb.getFishing().equals("y")){%>
						있음
						<%}else{%>
						없음
					<%} %>
				</div>
				<div class="col">
					물놀이<br>
					<%if(bb.getFishing().equals("y")){%>
						가능
					<%}else{%>
						불가능
					<%} %>
				</div>
				<div class="col">
					낚시<br>
				<%if(bb.getFishing().equals("y")){%>
						가능
					<%}else{%>
						불가능
				<%} %>
			 </div>
	      </div>
	      
	    </blockquote>
	  </div>
	</div>
	</div>
	<!-- 주변환경 줄 끝 -->
	
	
	<!-- 알림글 제목 줄 시작 -->
	<div class="row">
		<div class="col-4"></div>
		<div class="col-4 pt-4 m-2 text-center">
			<h4>알립니다 !</h4>
		</div>
		<div class="col-4"></div>		
	</div>
	<!-- 알림글 제목 줄 끝 -->
	
	<!-- 알림글 내용 시작 -->		
	<div class="row text-center">
		<div class="col-2"></div>
		<div class="col-8 p-4 m-2 text-center">
			자연을 빌려 쓴 댓가로 해당 장소를 청소하는 미덕을 가집시다. 남이 버린 쓰레기까지 되가져오는 캠퍼가 됩시다.<br>
			바닥에 불피우는 행위 금지!, 쓰레기는 집으로!, 머문 자리는 아니온 듯!
		</div>
		<div class="col-2"></div>	
	</div>
	<!-- 알림글 내용 끝 -->		
	
	
	<!-- 갤러리 제목 시작 -->			
	<div class="row">
		<div class="col-4"></div>
		<div class="col-4 pt-4 m-2 text-center">
			<h4>갤러리</h4>
		</div>
	</div>
	<!-- 갤러리 제목 끝 -->			
	
	<!-- 갤러리 내용 시작 -->				
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8 p-4 m-2 text-center">
			<img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="rounded" width="550px" height="380px" alt="...">
		</div>
		<div class="col-2"></div>
	</div>
	<!-- 갤러리 내용 끝 -->			

	<!-- 날씨 제목 시작 -->				
	<div class="row">
		<div class="col-4"></div>
		<div class="col-4 pt-4 m-2 text-center">
			<h4>날씨</h4>
		</div>
	</div>
	<!-- 날씨 제목 시작 -->				

	<!-- 날씨 내용 시작 -->					
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8 p-4 m-2 text-center">
			날씨 api 넣기
		</div>
		<div class="col-2"></div>
	</div>
	<!-- 날씨 내용 끝 -->					

	<!-- 댓글 제목 시작 -->						
	<div class="row">
		<div class="col-4"></div>
		<div class="col-4 pt-4 m-2 text-center">
			<h4>댓글</h4>
		</div>
	</div>
	<!-- 댓글 제목 끝 -->						
	
	
	<!-- 댓글 내용 시작 -->							
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8 p-4 m-2 text-center">
			<div id="disqus_thread"></div>
			<script>
			    /**
			    *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
			    *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables    */
			    /*
			    var disqus_config = function () {
			    this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
			    this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
			    };
			    */
			    (function() { // DON'T EDIT BELOW THIS LINE
			    var d = document, s = d.createElement('script');
			    s.src = 'https://campmap-1.disqus.com/embed.js';
			    s.setAttribute('data-timestamp', +new Date());
			    (d.head || d.body).appendChild(s);
			    })();
			</script>
			<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
		</div>
		<div class="col-2"></div>
	</div>
	<!-- 댓글 제목 끝 -->						




<%=bb.getNum() %>
<%=bb.getName() %>
<%=bb.getAddress() %>
<%=bb.getLat() %>
<%=bb.getLng() %>
<%=bb.getToilet() %>
<%=bb.getPark() %>
<%=bb.getWater() %>
<%=bb.getFishing() %>
<%=bb.getField() %>
<%=bb.getLand() %>
<%=bb.getLand() %>
<%=bb.getFilename() %>
<%=bb.getLevel() %>
<%=bb.getReadcount() %>
<%=bb.getComent() %>
<%=bb.getDate() %>






</div>
<!-- container 끝 -->	

<!-- footer 시작 -->
<div class="row">
 <jsp:include page="/footer/footer.jsp" />
</div>
<!-- footer 끝 -->
</body>
</html>