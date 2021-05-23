<%@page import="com.camp.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>캠핑 장터</title>

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
		$("#cc2").hide();
		
		$("#cc1").click(function(){
			$("#cc2").click();
		});
	
	});
</script>
<!-- jquery 끝 -->

<!-- 우편번호 시작 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 우편번호 끝 -->

<!-- 우편번호 스크립트 시작 -->
	<script>

	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	    	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	    
	</script>	
	<!-- 우편번호 스크립트 끝 -->	
	
</head>
<body>

	<!-- camp_sell 데이터 가져오기 시작 -->
	<%
	// 디비에 저장된 글의 개수를 알기
	
	// BoardDAO 객체 생성
	BoardDAO bdao = new BoardDAO();
	
	// 디비에 있는 글의 수를 계산하는 메소드 생성 -> 호출
	// getBoardCount();
	int cnt = bdao.getMarketCount();
	
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
	
	// 삽니다의 경우
	 ArrayList buyList = bdao.getBuyList(startRow, pageSize);
	
	
	%>
	<!-- camp_sell 데이터 가져오기 시작 -->



<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
<!-- navbar 끝 -->

<!-- container 시작 -->	
<div class="container-lg">	

<!-- 제목 row 시작 -->
<div class="row">
	<h3 class="text-center mt-5">캠핑 장터</h3>
</div>
<!-- 제목 row 끝 -->

<!-- 글쓰기 버튼 row 시작 -->
<div class="row">
	<div class="col-4"></div>
	<div class="col-7"></div>
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
	        <h2 class="modal-title" id="exampleModalLabel">캠핑장터 - 글쓰기 </h2>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
	      <!-- 게시판 글 쓰기 폼 작성 시작 -->
		  <form action="/Portpolio_camp/board/marketUploadPro.jsp" method="post" enctype="multipart/form-data">
	      	  <!-- 글쓰기 본문 시작 -->
		      <div class="modal-body mx-5">
		      
		      	   <input type="hidden" name="state" value="거래중"> <!-- 기본값으로 "거래중"전달 추후 페이지 수정에서 "거래완료"변경 가능 -->
			       <div class="form-floating mb-3">
					  <input type="text" class="form-control" id="floatingInput" placeholder="캠핑지명" name="name">
					  <label for="floatingInput">제목</label>
					</div>
					
					<!-- 구분 시작 -->
					<div class="row my-2">
						<div class="col-4">
								<b>구분</b>
						 		<input type="radio" class="btn-check" name="kind" id="option1" autocomplete="off" value="삽니다" checked>
								<label class="btn btn-outline-danger btn-sm" for="option1" >삽니다</label>
								
								<input type="radio" class="btn-check" name="kind" id="option2" value="팝니다" autocomplete="off">
								<label class="btn btn-outline-danger btn-sm" for="option2" >팝니다</label>			
						<div class="col-4">
						</div>
						<div class="col-4">
						</div>
						</div>
					</div>
					<!-- 구분 끝 -->

					<!-- 거래방식 시작 -->
					<div class="row my-2">
						<div class="col-4">
							<b>거래 방식</b>
						 		<input type="radio" class="btn-check" name="trade" id="option3" autocomplete="off" value="직거래" checked>
								<label class="btn btn-outline-warning btn-sm" for="option3" value="직거래">직거래</label>
								
								<input type="radio" class="btn-check" name="trade" id="option4" autocomplete="off" value="택배">
								<label class="btn btn-outline-warning btn-sm" for="option4" value="택배">택배</label>			
						<div class="col-4">
						</div>
						<div class="col-4">
						</div>
						</div>
					</div>
					<!-- 거래방식 끝 -->
					
					<!-- 금액 시작 -->
					<div class="row">
						<div class="form-floating mb-3">
						  <input type="text" class="form-control" id="floatingInput" placeholder="가격" name="price">
						  <label for="floatingInput">&nbsp;가격</label>
						</div>	
					</div>
					<!-- 금액 시작 -->					
					
			       	<!-- 우편번호 시작 -->
						<input type="text" id="sample6_address" placeholder="주소" name="address" class="form-control"><br>
						<input type="button" class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
						
						<input type="hidden" id="sample6_postcode" placeholder="우편번호">
						<input type="hidden" id="sample6_detailAddress" placeholder="상세주소">
						<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
					<!-- 우편번호 끝 -->
			       	
			       	<!-- 글내용 시작 -->
			       	
					<hr>
					
					<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>글내용</h4></div>
			       		<div class="col-4"></div>
					</div>			 
					      	
			       	<div class="row">
						<div class="form-floating">
						  <textarea class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 200px" name="coment"></textarea>
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


	<!-- 테이블 row 시작 -->
	<div class="row mt-5">
	<!-- table 시작 -->
		<table class="table pl-3 pr-3 text-center">
		  <thead>
		    <tr>
		      <th scope="col">구분</th>	      
		      <th scope="col">제목</th>
		      <th scope="col">작성자</th>
		      <th scope="col">작성일</th>
		      <th scope="col">조회수</th>
		    </tr>
		  </thead>
		  <tbody>
		  
		<%for(int i = 0;i < buyList.size(); i++){ 
			BoardBean bb = (BoardBean)buyList.get(i);
		%>
		    <tr>
		      <td>
		      	 <%if(bb.getKind().equals("팝니다")){ %>
		     	 <span class="badge bg-primary">팝니다</span>
		     	 <%}else{%>
		     	 <span class="badge bg-danger">삽니다</span>
		     	 <%} %>
		      </td>
		      <td>
		      	<%if(bb.getState().equals("거래중")){ %>
			    	<a href="/Portpolio_camp/board/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>" style="text-decoration-line: none; color: black;"><%=bb.getName() %></a>		      	
			    <%}else{ %>
			    	<div class="text-decoration-line-through"><a  href="/Portpolio_camp/board/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>" style="text-decoration-line: none; color: black;"><%=bb.getName() %></a><span class="badge bg-success">거래완료</span></div>
			    <%} %> 
		      </td>
		      <td><%=bb.getId() %></td>
		      <td><%=bb.getDate() %></td>
		      <td><%=bb.getReadcount() %></td>	      
		    </tr>
		 <%} %>   
		  </tbody>
		</table>
	<!-- table 끝 -->
	</div>
	<!-- 테이블 row 끝 -->


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
			    
			     href="/Portpolio_camp/board/BuyForm.jsp?pageNum=<%=startPage-pageBlock%>"
			    
			    <%} %>
			    >&laquo;</a></li>
			<%
			
			// 숫자 1...5
			for(int i = startPage; i <= endPage; i++){
			%>
			    <li class="page-item"><a class="page-link" href="/Portpolio_camp/board/BuyForm.jsp?pageNum=<%=i %>"><%=i %></a></li>
			<%
			}
			// 다음(기존의 페이지 블럭보다 페이지의 수가 많을 때)
				%>
			    <li class="page-item"><a class="page-link"
			    
			    <%if(endPage < pageCount){ %>
			     href="/Portpolio_camp/board/BuyForm.jsp?pageNum=<%=startPage + pageBlock%>"
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