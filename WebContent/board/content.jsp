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

	<%
		// 페이지 이동 시 전달정보가 있으면 항상 먼저 저장
		// num, pageNum
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		// BoardDAO 객체 생성
		
		BoardDAO bdao = new BoardDAO();
		
		// 글 조회수 1증가 (DB 처리)
 		bdao.updateMarketReadcount(num);
		
 		//DB에서 글 번호(null)에 해당하는 글 정보를 모두 가져와서 출력
 		BoardBean bb = bdao.getMarket(num);
	
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
	            location.href="/Portpolio_camp/board/deletePro.jsp?pageNum=<%=pageNum%>&num=<%=num%>";
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

			$("#back").click(function(){
				var prePage = document.referrer;
				
				if(prePage == "http://localhost:8088/Portpolio_camp/main/main.jsp"){
	 				location.href="/Portpolio_camp/board/marketForm.jsp";
				}else{
				history.back();
				}
			});
			
			$("#tsuccess").click(function() {
				location.href="/Portpolio_camp/board/statePro.jsp?pageNum=<%=pageNum%>&num=<%=num%>"
			});
			
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
		<%if(bb.getState().equals("거래중")){ %>
			<button class="btn btn-light btn-sm" type="button"  data-bs-toggle="modal" data-bs-target="#exampleModal" >수정</button>
			 / 
		<%}else{ %>
		<%} %>	 
			 <button class="btn btn-light btn-sm" type="button" onclick="con()">삭제</button>
		</div>
		<div class="col-10">
		<%if(bb.getState().equals("거래중")){ %>
					<button type="button" class="btn btn-success" id="tsuccess">거래 완료</button>
		<%}else{ %>
		<%} %>
		</div>
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
	
	<!-- 위치 및 삽니다,팝니다 row 시작 -->
	<div class="row">
		<!-- 위치 col 시작 -->
		<div class="col-4 px-3">
			<div class="row">
				<div class="px-4 m-3"><h4><%=bb.getId()%> | <%=bb.getAddress() %></h4></div>
			</div>
		</div>
		<!-- 위치 col 끝 -->
		
		<!-- 삽니다 col 시작 -->
		<div class="col-4 text-center"></div>
		<div class="col-4">
			<div class="row text-center px-4 m-1">
			
			
			<%if(bb.getState().equals("거래중")){ %>
					<div class="col-4"></div>	
			<%}else{ %> 		
			 		<div class="col-4">
			 			<h5><span class="badge bg-success p-3 mx-3">거래완료</span></h5>
			 		</div>			
			<%} %>
			
			<%if(bb.getTrade().equals("택배")){ %>
			 		<div class="col-2">
			 			<h5><span class="badge bg-warning p-3 mx-3">택배</span></h5>
			 		</div>
			<%}else{ %>
			 		<div class="col-2">
			 			<h5><span class="badge bg-warning p-3">직거래</span></h5>
			 		</div>			
			<%} %> 	
			
			
			<%if(bb.getKind().equals("삽니다")){ %>	
			 		 <div class="col-3">
						<h5><span class="badge bg-danger p-3">삽니다</span></h5>
					 </div>
			<%}else{ %>
					 <div class="col-3">
						<h5><span class="badge bg-primary p-3">팝니다</span></h5>
					 </div>			
			<%} %>		 
			
			
					 <div class="col-3 mt-1">
					 	<h3>₩<fmt:formatNumber value="<%=bb.getPrice() %>" pattern="#,###"/></h3>
					 </div>
			 
			</div>
		</div>
		<!-- 삽니다,팝니다 col 끝 -->
		
	</div>
	<!-- 위치 및 삽니다,팝니다 row 끝 -->
	
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
	        <h2 class="modal-title" id="exampleModalLabel">캠핑장터 - 글수정 </h2>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
	      <!-- 캠핑 장터 글 수정 폼 작성 시작 -->
		  <form action="/Portpolio_camp/board/fileupdateUploadPro.jsp" method="post" enctype="multipart/form-data">
		  	<input type="hidden" name="num" value="<%=bb.getNum()%>">
		  	<input type="hidden" name="pageNum" value="<%=pageNum%>">
		  	
	      	  <!-- 글수정 본문 시작 -->
		      <div class="modal-body mx-5">
		      
		      
		      	   <input type="hidden" name="state" value="거래중">
			       <div class="form-floating mb-3">
					  <input type="text" class="form-control" id="floatingInput" placeholder="캠핑지명" name="name" value="<%=bb.getName()%>">
					  <label for="floatingInput">제목</label>
					</div>
					
					<!-- 구분 시작 -->
					<div class="row my-2">
						<div class="col-4">
							<b>구분</b>
							<%if(bb.getKind().equals("삽니다")){ %>
						 		<input type="radio" class="btn-check" name="kind" id="option1" autocomplete="off" value="삽니다" checked >
								<label class="btn btn-outline-danger btn-sm" for="option1">삽니다</label>
								
								<input type="radio" class="btn-check" name="kind" id="option2" autocomplete="off" value="팝니다" >
								<label class="btn btn-outline-danger btn-sm" for="option2" >팝니다</label>
							<%}else{ %>
						 		<input type="radio" class="btn-check" name="kind" id="option1" autocomplete="off" value="삽니다"  >
								<label class="btn btn-outline-danger btn-sm" for="option1">삽니다</label>
								
								<input type="radio" class="btn-check" name="kind" id="option2" autocomplete="off" value="팝니다" checked>
								<label class="btn btn-outline-danger btn-sm" for="option2" >팝니다</label>								
							<%} %>			
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
							<%if(bb.getTrade().equals("직거래")){ %>
						 		<input type="radio" class="btn-check" name="trade" id="option3" autocomplete="off" value="직거래" checked>
								<label class="btn btn-outline-warning btn-sm" for="option3" value="직거래">직거래</label>
								
								<input type="radio" class="btn-check" name="trade" id="option4" autocomplete="off" value="택배">
								<label class="btn btn-outline-warning btn-sm" for="option4" value="택배">택배</label>
							<%}else{ %>
						 		<input type="radio" class="btn-check" name="trade" id="option3" autocomplete="off" value="직거래">
								<label class="btn btn-outline-warning btn-sm" for="option3" value="직거래">직거래</label>
								
								<input type="radio" class="btn-check" name="trade" id="option4" autocomplete="off" value="택배" checked>
								<label class="btn btn-outline-warning btn-sm" for="option4" value="택배">택배</label>							
							<%} %>			
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
						  <input type="text" class="form-control" id="floatingInput" placeholder="가격" name="price" value="<%=bb.getPrice()%>">
						  <label for="floatingInput">&nbsp;가격</label>
						</div>	
					</div>
					<!-- 금액 시작 -->					
					
			       	<!-- 우편번호 시작 -->
						<input type="text" id="sample6_address" placeholder="주소" name="address" class="form-control" value="<%=bb.getAddress()%>"><br>
						<input type="button" class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
						
						<input type="hidden" id="sample6_postcode" placeholder="우편번호">
						<input type="hidden" id="sample6_detailAddress" placeholder="상세주소">
						<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
					<!-- 우편번호 끝 -->
			       	
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
 	<!-- 목록으로 row 시작 -->
	<div class="row text-center m-5">
		<div><button id="back" type="button" class="btn btn-secondary">목록으로</button></div>
	</div>

 	<!-- 목록으로 row 끝 -->
</body>
</html>