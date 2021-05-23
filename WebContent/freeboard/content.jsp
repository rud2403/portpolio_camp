<%@page import="com.camp.board.BoardBean"%>
<%@page import="com.camp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>content</title>

<!-- jquery 준비 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- jquery 준비 끝 -->

<!-- 파비콘 시작 -->
<link rel="shortcut icon" href="../favicon.ico">
<!-- 파비콘 끝 -->

<!-- 우편번호 시작 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 우편번호 끝 -->

<!-- 부트 스트랩 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
<!-- 부트 스트랩 끝 -->

</head>
<body>


	<%
		// 페이지 이동 시 전달정보가 있으면 항상 먼저 저장
		// num, pageNum
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		int re_ref = Integer.parseInt(request.getParameter("re_ref"));
		int re_lev = Integer.parseInt(request.getParameter("re_lev"));
		int re_seq = Integer.parseInt(request.getParameter("re_seq"));


		
		// BoardDAO 객체 생성
		
		BoardDAO bdao = new BoardDAO();
		
		
		
		// 글 조회수 1증가 (DB 처리)
 		bdao.updatefreeBoardReadcount(num);
		
		
 		//DB에서 글 번호(null)에 해당하는 글 정보를 모두 가져와서 출력
 		BoardBean bb = bdao.getfreeBoard(num);
	
	%>

	<!-- 자바 스크립트 시작 -->
	<script type="text/javascript">
		<!-- id 값 받아오기 시작 -->
		<%
		String id = (String)session.getAttribute("id");
		%>
		<!-- id 값 받아오기 끝 -->
		
	    function con() {
	        if (!confirm("정말 삭제하시겠습니까?")) {
	        	// 아니오 버튼 누를 시 창 닫음.
	        } else {
	            location.href="/Portpolio_camp/freeboard/deletePro.jsp?pageNum=${param.pageNum}&num=${param.num}&re_ref=${param.re_ref}";
	  	    }
	    }
	</script>
	<!-- 자바 스크립트 끝 -->
	
	<!-- jquery 시작 -->
	<script type="text/javascript">
		$(function() {
			$("#cc2").hide();
			
			$("#cc1").click(function(){
				$("#cc2").click();
			});
			
			$("#cc4").hide();
			
			$("#cc3").click(function(){
				$("#cc4").click();
			});

			$("#back").click(function(){
				var prePage = document.referrer;
				
				if(prePage == "http://localhost:8088/Portpolio_camp/main/main.jsp"){
	 				location.href="/Portpolio_camp/freeboard/freeboardForm.jsp";
				}else{
					location.href="/Portpolio_camp/freeboard/freeboardForm.jsp?pageNum=<%=pageNum %>";
				}
			});

			
			
			
			// 디비에 있는 pw값(bb.getPw)와 input으로 받아오는 pw값이 다를 경우 다르다 하기
// 			$("#correct").click(function() {
// 				var pw1 = $("#pw").val();
// 				var pw2;
// 				if(pw1 != pw2){
// 					alert("비밀번호가 다릅니다.");
// 				}
// 			});
	
			
		});
	</script>
	<!-- jquery 끝 -->


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
	<%if(bb.getId().equals(id)){ %>
	<div class="row">
		<div class="col-1 text-center">
			<button class="btn btn-light btn-sm" type="button"  data-bs-toggle="modal" data-bs-target="#exampleModal" >수정</button>
			 / 
			 <button class="btn btn-light btn-sm" type="button" onclick="con()">삭제</button>
		</div>
		<div class="col-10"></div>
		<div class="col-1">
			조회수 <%=bb.getReadcount() %>
		</div>
	</div>
	<%}else{ %>
	<div class="row">
		<div class="col-1 text-center">
		</div>
		<div class="col-10">
		</div>	
		<div class="col-1">
			조회수 <%=bb.getReadcount() %>
		</div>
	</div>
	<%} %>
	<!-- 조회수 및 수정 삭제 줄 끝 -->	
	
	
	<hr>
	
	<!-- 위치 row 시작 -->
	<div class="row">
		<!-- 위치 col 시작 -->
		<div class="col-4 px-3">
			<div class="row">
				<div class="px-4 m-3"><h4><%=bb.getId()%></h4></div>
			</div>
		</div>
		<!-- 위치 col 끝 -->
		<div class="col-4 text-center"></div>
		<div class="col-4"></div>
	</div>
	<!-- 위치 row 끝 -->
	
	<hr>
	
	<!-- coment row 시작 -->
	<div class="row m-5">
		<%=bb.getComent() %>

		
	</div>
	<!-- coment row 끝 -->
	
	<!-- 사진 파일 row 시작 -->
	<div class="row m-5">
		<div class="col-2"></div>
		<%if(!bb.getFilename().equals("null")){ %>
			<div class="col-8 p-4 m-2 text-center">
			<%if(bb.getFilename2().equals("null")){ %>
			
			<div id="carouselExampleIndicators" class="carousel slide m-3" data-bs-ride="carousel">
			  <div class="carousel-inner">
			    <div class="carousel-item active">
			      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="250" height="300">
			    </div>
			  </div>		
			
			
				<%}else if(bb.getFilename3().equals("null")){ %>
				
				<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
				  <div class="carousel-inner">
				    <div class="carousel-item active">
				      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="250" height="300">
				    </div>
				    <div class="carousel-item">
				      <img src="/Portpolio_camp/upload/<%=bb.getFilename2() %>" class="d-block w-100" alt="..." width="250" height="300">
				    </div>
					<div class="carousel-item">
				      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="250" height="300">
				    </div>
				  </div>
				  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </a>
				  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </a>
				</div>
		
		
				
				<%}else{ %>
				
				<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
				  <div class="carousel-inner">
				    <div class="carousel-item active">
				      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="300" height="300">
				    </div>
				    <div class="carousel-item">
				      <img src="/Portpolio_camp/upload/<%=bb.getFilename2() %>" class="d-block w-100" alt="..." width="300" height="300">
				    </div>
				    <div class="carousel-item">
				      <img src="/Portpolio_camp/upload/<%=bb.getFilename3() %>" class="d-block w-100" alt="..." width="300" height="300">
				    </div>
				  </div>
				  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </a>
				  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </a>
				</div>
				
				
				<%} %>
			<%} %>

				<div class="col-2"></div>
			</div>	
		</div>
	</div>
	<!-- 사진 파일 row 끝 -->
	
	<!-- 페이지 수정 모달 시작 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title" id="exampleModalLabel">자유게시판 - 글수정 </h2>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
	      <!-- 캠핑 장터 글 수정 폼 작성 시작 -->
		  <form action="/Portpolio_camp/freeboard/fileupdateUploadPro.jsp" method="post" enctype="multipart/form-data">
		  	<input type="hidden" name="num" value="<%=bb.getNum()%>">
		  	<input type="hidden" name="pageNum" value="<%=pageNum%>">	  	
		  	
	      	  <!-- 글수정 본문 시작 -->
		      <div class="modal-body mx-5">
			       <div class="form-floating mb-3">
					  <input type="text" class="form-control" id="floatingInput" placeholder="캠핑지명" name="name" value="<%=bb.getName()%>">
					  <label for="floatingInput">제목</label>
					</div>					
			       	
			       	<!-- 글내용 시작 --><hr>
					<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>글내용</h4></div>
			       		<div class="col-4"></div>
					</div>			 
					      	
			       	<div class="row">
						<div class="form-floating">
						  <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 200px" name="coment"><%=bb.getComent() %></textarea>
						  <label for="floatingTextarea2"></label>
						</div>
			       	</div>
			       	<!-- 글내용 끝 -->
			       	
			       	<hr>
			       	
					<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>사진 첨부</h4></div>
			       		<div class="col-4"></div>			       		
			       	</div>
			       	
			       	<!-- row3 시작 -->
			       	<div class="row mt-2 mb-3">
						<input class="form-control m-1" type="file" id="formFile" name="filename" >
						<input class="form-control m-1" type="file" id="formFile" name="filename2">
						<input class="form-control m-1" type="file" id="formFile" name="filename3">
			       	</div>
			       	<!-- row3 끝 -->
			  </div>
			  <!-- 글수정 본문 끝 -->
			      

		      <div class="modal-footer">
		      	<button type="submit" class="btn btn-primary" id="correct">수정</button>
			  	<button type="reset" class="btn btn-secondary" data-bs-dismiss="modal" id="cc1">취소</button>
			  	<button type="reset" id="cc2">취소2</button>
		      </div>
	      </form>
	     <!-- 캠핑장터 글 수정 폼 작성 끝 -->
	      
	    </div>
	  </div>
	</div>
	<!-- 페이지 수정 모달 끝 -->	
	
</div>
<!-- container 끝 -->	
<hr>
 	<!-- 목록으로, 답글쓰기 row 시작 -->
	<div class="row text-center m-5">
		<div>
			<button class="btn btn-secondary" type="button"  data-bs-toggle="modal" data-bs-target="#exampleModal2">답글쓰기</button>
			<button id="back" type="button" class="btn btn-secondary">목록으로</button>
		</div>
	</div>
 	<!-- 목록으로, 답글쓰기  row 끝 -->
 	
 	
 	
 	
	<!-- 답글쓰기 모달 시작 -->
	<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title" id="exampleModalLabel">자유게시판 - 답글쓰기 </h2>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
	      <!-- 자유게시판 답글 쓰기 폼 작성 시작 -->
		  <form action="/Portpolio_camp/freeboard/reWriteUploadPro.jsp" method="post" enctype="multipart/form-data">
		  	<input type="hidden" name="num" value="<%=bb.getNum()%>">
		  	<input type="hidden" name="pageNum" value="<%=pageNum%>">	  	
			<input type="hidden" name="re_ref" value="<%=re_ref%>">
			<input type="hidden" name="re_lev" value="<%=re_lev%>">
			<input type="hidden" name="re_seq" value="<%=re_seq%>">
		  	
	      	  <!-- 답글 쓰기 본문 시작 -->
		      <div class="modal-body mx-5">
		      
		      
			       <div class="form-floating mb-3">
					  <input type="text" class="form-control" id="floatingInput" placeholder="답글 제목" name="name">
					  <label for="floatingInput">답글 제목</label>
					</div>					
			       	
			       	<!-- 글내용 시작 --><hr>
					<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>답글 내용</h4></div>
			       		<div class="col-4"></div>
					</div>			 
					      	
			       	<div class="row">
						<div class="form-floating">
						  <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 400px" name="coment"></textarea>
						  <label for="floatingTextarea2"></label>
						</div>
			       	</div>
			       	<!-- 글내용 끝 -->
			       	
			       	<hr>
			       	
					<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>사진 첨부</h4></div>
			       		<div class="col-4"></div>			       		
			       	</div>
			       	
			       	<!-- row3 시작 -->
			       	<div class="row mt-2 mb-3">
						<input class="form-control m-1" type="file" id="formFile" name="filename" >
						<input class="form-control m-1" type="file" id="formFile" name="filename2">
						<input class="form-control m-1" type="file" id="formFile" name="filename3">
			       	</div>
			       	<!-- row3 끝 -->
			  </div>
			  <!-- 답글 쓰기 본문 끝 -->
			      

		      <div class="modal-footer">
		      	<button type="submit" class="btn btn-primary" id="correct">답글 쓰기</button>
			  	<button type="reset" class="btn btn-secondary" data-bs-dismiss="modal" id="cc3">취소</button>
			  	<button type="reset" id="cc4">취소2</button>
		      </div>
	      </form>
	     <!-- 자유게시판 답글 쓰기 폼 작성 끝 -->
	      
	    </div>
	  </div>
	</div>
	<!-- 답글쓰기 모달 끝 -->
 	
 	
</body>
</html>