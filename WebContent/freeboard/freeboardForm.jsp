<%@page import="com.camp.board.BoardBean"%>
<%@page import="com.camp.board.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유게시판</title>

<!-- 부트스트랩 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
<!-- 부트스트랩 끝 -->

<!-- 파비콘 시작 -->
<link rel="shortcut icon" href="../favicon.ico">
<!-- 파비콘 끝 -->

<!-- jquery 준비 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- jquery 준비 끝 -->


	<!-- jquery 시작 -->
	<script type="text/javascript">
		$(function() {
			//취소버튼 2 숨기기
			$("#cc2").hide();
			
			//취소버튼 1 눌렸을때 2도 함께 클릭
			$("#cc1").click(function(){
				$("#cc2").click();
			});		
			
		});
	</script>
	<!-- jquery 끝 -->


</head>
<body>

	<!-- DB 데이터 가져오기 시작 -->
	<%
	// 디비에 저장된 글의 개수를 알기
	
	// BoardDAO 객체 생성
	BoardDAO bdao = new BoardDAO();
	
	// 디비에 있는 글의 수를 계산하는 메소드 생성 -> 호출
	// getBoardCount();
	int cnt = bdao.getfreeBoardCount();
	
	//////////////////////////////////////////////////////////////////////////////////
	// 게시판 페이징 처리 : DB에서 원하는 만큼만 글 가져오기
	
	// 한페이지당 보여줄 글의 개수
	int pageSize = 10;
	
	// 지금 페이지가 몇 페이지인지 확인
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	// 페이지별 시작 행 계산하기
	// 1p -> 1번 글부터, 2p -> 11번 글부터 3p -> 21번 글 부터 ... -> 일반화
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	
	// 끝 행 계산하기
	// 1p -> 10번, 2p -> 20번 ...
	int endRow = currentPage*pageSize;
	
	//////////////////////////////////////////////////////////////////////////////////

	// 디비에 저장된 모든 글 정보를 가져오기
	//ArrayList boardList = bdao.getBoardList();
	
	// 디비에 저장된 모든 글 중에서 원하는 만큼만 가져오기.(페이지 사이즈만큼)
	ArrayList boardList = bdao.getfreeBoardList(startRow, pageSize);
	
		
	%>
	<!-- DB 데이터 가져오기 끝 -->
	
<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
 
<!-- navbar 끝 -->

<!-- container 시작 -->	
<div class="container-lg">	

<!-- 제목 row 시작 -->
<div class="row">
	<h3 class="text-center mt-5">자유게시판</h3>
</div>
<!-- 제목 row 끝 -->

<!-- 글쓰기 버튼 row 시작 -->
<div class="row text-center">
	<div class="col-1"></div>
	<div class="col-10">게시글 총 <%=cnt %>개</div>
	<div class="col-1">
		<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">글쓰기</button>
	</div>
</div>
<!-- 글쓰기 버튼 row 끝 -->


<!-- 글쓰기 모달 시작 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title" id="exampleModalLabel">자유게시판 - 글쓰기 </h2>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
	      <!-- 게시판 글 쓰기 폼 작성 시작 -->
		  <form action="/Portpolio_camp/freeboard/fileUploadPro.jsp" method="post" enctype="multipart/form-data">
		
	      	  <!-- 글쓰기 본문 시작 -->
		      <div class="modal-body mx-5">
		      
			       <div class="form-floating mb-3">
					  <input type="text" class="form-control" id="floatingInput" placeholder="캠핑지명" name="name">
					  <label for="floatingInput">제목</label>
					</div>				
			       	
			       	<!-- 글내용 시작 -->
			       	
					<hr>
					
					<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>글내용</h4></div>
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
						<input class="form-control m-1" type="file" id="formFile" name="filename">
						<input class="form-control m-1" type="file" id="formFile" name="filename2">
						<input class="form-control m-1" type="file" id="formFile" name="filename3">
			       	</div>
			       	<!-- row3 끝 -->
			  </div>
			  <!-- 글쓰기 본문 끝 -->
			      

		      <div class="modal-footer">
		      	<button type="submit" class="btn btn-primary">작성</button>
			  	<button type="reset" class="btn btn-secondary" data-bs-dismiss="modal" id="cc1">취소</button>
			  	<button type="reset" id="cc2">취소2</button>
		      </div>
	      </form>
	     <!-- 게시판 글 쓰기 폼 작성 끝 -->
	      
	    </div>
	  </div>
	</div>

<!-- 글쓰기 모달 끝 -->



<!-- 게시글 목록 row 시작 -->
<div class="row mt-5">

<!-- table 시작 -->
	<table class="table pl-3 pr-3">
	  <thead>
	    <tr class="text-center">
	      <th scope="col">제목</th>
	      <th scope="col">작성자</th>
	      <th scope="col">작성일</th>
	      <th scope="col">조회수</th>
	    </tr>
	  </thead>
	  
	  
	  <tbody>
	  
		<%for(int i = 0;i < boardList.size(); i++){ 
			BoardBean bb = (BoardBean)boardList.get(i);
		%>
	    <tr>
		  <td>
			<%
			int wid = 0;
			if(bb.getRe_lev() > 0){
			wid = 10 * bb.getRe_lev(); 
			%>
			  <img alt="" src="level.gif" height="15" width="<%=wid%>">
 			  ┕
			<%
			}
			%>
	      <a  href="/Portpolio_camp/freeboard/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>&re_ref=<%=bb.getRe_ref() %>&re_lev=<%=bb.getRe_lev() %>&re_seq=<%=bb.getRe_seq() %>" style="text-decoration-line: none; color: black;"><%=bb.getName() %></a>		      	
		  </td>
			
	      <td class="text-center"><%=bb.getId() %></td>
	      <td class="text-center"><%=bb.getDate() %></td>
	      <td class="text-center"><%=bb.getReadcount() %></td>
	    </tr>
	    <%} %>
	    
	  </tbody>
	  
	  
	</table>
<!-- table 끝 -->

</div>
<!-- 게시글 목록 row 끝 -->


<!-- page네비 시작 -->

	<div class="row">
		<div class="col-5"></div>
		<div class="col-lg-3">
		<nav aria-label="Page navigation example">
		  	<ul class="pagination">
		<%
		///////////////////////////////////////////////////
		// 페이징 처리 - 하단부 링크
		if(cnt != 0){
			// 글이 있을 때 표시
			// 전체 페이지 수 계산
			// ex) 50개 -> 한 페이지당 10개씩 출력, 필요한 페이지 개수 = 5개
			//     57개 -> 필요한 페이지 개수 = 6개
			
			int pageCount = cnt/pageSize+(cnt % pageSize == 0? 0:1);
			
			// 한 화면에 보여줄 페이지 번호의 개수 (페이지 블록)
			int pageBlock = 3;
			
			// 페이지 블록의 시작페이지 번호
			// ex) 1~5페이지 : 1~10 페이지 : 1, 11~20페이지 : 11
			int startPage = ((currentPage-1)/pageBlock) * pageBlock +1;
			
			// 페이지 블록의 끝 페이지 번호
			int endPage = startPage+pageBlock-1;
			
			if(endPage > pageCount){
				endPage = pageCount;
			}
			
			// 이전
			
			%>
			    <li class="page-item"><a class="page-link"
			    
			    <%if(startPage > pageBlock){ %>
			    
			     href="/Portpolio_camp/freeboard/freeboardForm.jsp?pageNum=<%=startPage-pageBlock%>"
			    
			    <%} %>
			    >&laquo;</a></li>
			<%
			
			// 숫자 1...5
			for(int i = startPage; i <= endPage; i++){
			%>
			    <li class="page-item"><a class="page-link" href="/Portpolio_camp/freeboard/freeboardForm.jsp?pageNum=<%=i %>"><%=i %></a></li>
			<%
			}
			// 다음(기존의 페이지 블럭보다 페이지의 수가 많을 때)
				%>
			    <li class="page-item"><a class="page-link"
			    
			    <%if(endPage < pageCount){ %>
			     href="/Portpolio_camp/freeboard/freeboardForm.jsp?pageNum=<%=startPage + pageBlock%>"
			     <%} %>
			     
			     >&raquo;</a></li>
			    <%
		}
	
	%>
		  	</ul>
		</nav>
		</div>
		<div class="col-4"></div>
	</div>
	
	<!-- page네비 끝 -->

</div>
<!-- container 끝 -->	

<!-- footer 시작 -->
<div class="row">
 <jsp:include page="/footer/footer.jsp" />
</div>
<!-- footer 끝 -->
</body>
</html>