<%@page import="com.camp.board.BoardBean"%>
<%@page import="com.camp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>content</title>

<!-- jquery 준비 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- jquery 준비 끝 -->

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

	<script type="text/javascript">
		<!-- jquery 시작 -->
		$(function() {
			$("#cc2").hide();
			
			$("#cc1").click(function(){
				$("#cc2").click();
			});

		});
	</script>
		<!-- jquery 끝 -->




	<!-- id 값 받아오기 시작 -->
	<script type="text/javascript">
		<%
		String id = (String)session.getAttribute("id");
		%>
		
	    function con() {
	        if (!confirm("정말 삭제하시겠습니까?")) {
	        	// 아니오 버튼 누를 시 창 닫음.
	        } else {
	            location.href="/Portpolio_camp/freecamp/deletePro.jsp?pageNum=<%=pageNum%>&num=<%=num%>";
	  	    }
	    }
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

		<div class="col-1 text-center">
			<button class="btn btn-light btn-sm" type="button"  data-bs-toggle="modal" data-bs-target="#exampleModal" >수정</button>
			 / <button class="btn btn-light btn-sm" type="button" onclick="con()">삭제</button>
		</div>
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
		</div>
		<!-- 위치 칼럼 끝 -->
		
		<!-- 난이도 칼럼 시작 -->
		<div class="col-7 text-center"></div>
		<div class="col-1">
			<div class="row text-center px-4 m-1">
			<%if(bb.getKind().equals("삽니다")){ %>
					<div>
						<span class="badge bg-danger p-3">
								삽니다
					 	</span>
					 </div>
			 <%}else{ %>
					<div>
						<span class="badge bg-primary p-3">
								팝니다
					 	</span>
					 </div>			 
			 <%} %>
			</div>
		</div>
		<!-- 난이도 칼럼 끝 -->
		
<!-- 	</div> -->
<!-- 	<!-- 위치 및 난이도 줄 끝 -->
	
	
<!-- 	<!-- 알림글 제목 줄 시작 -->
<!-- 	<div class="row"> -->
<!-- 		<div class="col-4"></div> -->
<!-- 		<div class="col-4 pt-4 m-2 text-center"> -->
<!-- 			<h2>알립니다 !</h2> -->
<!-- 		</div> -->
<!-- 		<div class="col-4"></div>		 -->
<!-- 	</div> -->
<!-- 	<!-- 알림글 제목 줄 끝 -->


<!-- 	<!-- 알림글 내용 시작 -->
<!-- 	<div class="row text-center"> -->
<!-- 		<div class="col-2"></div> -->
<!-- 		<div class="col-8 p-4 m-2 text-center"> -->
<!-- 			자연을 빌려 쓴 댓가로 해당 장소를 청소하는 미덕을 가집시다. 남이 버린 쓰레기까지 되가져오는 캠퍼가 됩시다.<br> -->
<!-- 			바닥에 불피우는 행위 금지!, 쓰레기는 집으로!, 머문 자리는 아니온 듯! -->
<!-- 		</div> -->
<!-- 		<div class="col-2"></div>	 -->
<!-- 	</div> -->
<!-- 	<!-- 알림글 내용 끝 -->
	
	
<!-- 	<!-- 주변환경 줄 시작 -->
<!-- 	<div class="row text-center mt-5 mx-3"> -->
	
<!-- 	<div class="card mb-3"> -->
<!-- 		<div class="card-header"> -->
<%-- 	    	<%=bb.getName() %> 주변 환경 --%>
<!-- 	  	</div> -->
<!-- 	  <div class="card-body"> -->
<!-- 	    <blockquote class="blockquote mb-0"> -->
<!-- 	      <div class="row"> -->
<!-- 		      <div class="col"> -->
<!-- 		      		필드<br> -->
<%-- 					<%=bb.getField() %> --%>
<!-- 				</div> -->
<!-- 				<div class="col"> -->
<!-- 					바닥<br> -->
<%-- 					<%=bb.getLand() %> --%>
					
<!-- 				</div> -->
<!-- 				<div class="col"> -->
<!-- 					화장실<br> -->
<%-- 					<%if(bb.getFishing().equals("y")){%> --%>
<!-- 						있음 -->
<%-- 						<%}else{%> --%>
<!-- 						없음 -->
<%-- 					<%} %> --%>
<!-- 				</div> -->
<!-- 				<div class="col"> -->
<!-- 					주차장<br> -->
<%-- 					<%if(bb.getFishing().equals("y")){%> --%>
<!-- 						있음 -->
<%-- 						<%}else{%> --%>
<!-- 						없음 -->
<%-- 					<%} %> --%>
<!-- 				</div> -->
<!-- 				<div class="col"> -->
<!-- 					물놀이<br> -->
<%-- 					<%if(bb.getFishing().equals("y")){%> --%>
<!-- 						가능 -->
<%-- 					<%}else{%> --%>
<!-- 						불가능 -->
<%-- 					<%} %> --%>
<!-- 				</div> -->
<!-- 				<div class="col"> -->
<!-- 					낚시<br> -->
<%-- 				<%if(bb.getFishing().equals("y")){%> --%>
<!-- 						가능 -->
<%-- 					<%}else{%> --%>
<!-- 						불가능 -->
<%-- 				<%} %> --%>
<!-- 			 </div> -->
<!-- 	      </div> -->
	      
<!-- 	    </blockquote> -->
<!-- 	  </div> -->
<!-- 	</div> -->
<!-- 	</div> -->
<!-- 	<!-- 주변환경 줄 끝 -->
	
	
<!-- 	<!-- 갤러리 제목 시작 -->
<!-- 	<div class="row"> -->
<!-- 		<div class="col-4"></div> -->
<!-- 		<div class="col-4 pt-4 m-2 text-center"> -->
<!-- 			<h4>갤러리</h4> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<!-- 갤러리 제목 끝 -->	

<!-- 	<!-- 갤러리 내용 시작 -->
<!-- 	<div class="row"> -->
<!-- 		<div class="col-2"></div> -->
<!-- 		<div class="col-8 p-4 m-2 text-center"> -->
		
		
<%-- 		<%if(bb.getFilename2().equals("null")){ %> --%>
		
<!-- 		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel"> -->
<!-- 		  <div class="carousel-inner"> -->
<!-- 		    <div class="carousel-item active"> -->
<%-- 		      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="300" height="400"> --%>
<!-- 		    </div> -->
<!-- 		</div>		 -->
		
		
<%-- 		<%}else if(bb.getFilename3().equals("null")){ %> --%>
		
<!-- 		<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel"> -->
<!-- 		  <div class="carousel-inner"> -->
<!-- 		    <div class="carousel-item active"> -->
<%-- 		      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="300" height="400"> --%>
<!-- 		    </div> -->
<!-- 		    <div class="carousel-item"> -->
<%-- 		      <img src="/Portpolio_camp/upload/<%=bb.getFilename2() %>" class="d-block w-100" alt="..." width="300" height="400"> --%>
<!-- 		    </div> -->
<!-- 			<div class="carousel-item"> -->
<%-- 		      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="300" height="400"> --%>
<!-- 		    </div> -->
<!-- 		  </div> -->
<!-- 		  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-bs-slide="prev"> -->
<!-- 		    <span class="carousel-control-prev-icon" aria-hidden="true"></span> -->
<!-- 		    <span class="visually-hidden">Previous</span> -->
<!-- 		  </a> -->
<!-- 		  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-bs-slide="next"> -->
<!-- 		    <span class="carousel-control-next-icon" aria-hidden="true"></span> -->
<!-- 		    <span class="visually-hidden">Next</span> -->
<!-- 		  </a> -->
<!-- 		</div> -->


		
<%-- 		<%}else{ %> --%>
		
<!-- 		<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel"> -->
<!-- 		  <div class="carousel-inner"> -->
<!-- 		    <div class="carousel-item active"> -->
<%-- 		      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="300" height="400"> --%>
<!-- 		    </div> -->
<!-- 		    <div class="carousel-item"> -->
<%-- 		      <img src="/Portpolio_camp/upload/<%=bb.getFilename2() %>" class="d-block w-100" alt="..." width="300" height="400"> --%>
<!-- 		    </div> -->
<!-- 		    <div class="carousel-item"> -->
<%-- 		      <img src="/Portpolio_camp/upload/<%=bb.getFilename3() %>" class="d-block w-100" alt="..." width="300" height="400"> --%>
<!-- 		    </div> -->
<!-- 		  </div> -->
<!-- 		  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-bs-slide="prev"> -->
<!-- 		    <span class="carousel-control-prev-icon" aria-hidden="true"></span> -->
<!-- 		    <span class="visually-hidden">Previous</span> -->
<!-- 		  </a> -->
<!-- 		  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-bs-slide="next"> -->
<!-- 		    <span class="carousel-control-next-icon" aria-hidden="true"></span> -->
<!-- 		    <span class="visually-hidden">Next</span> -->
<!-- 		  </a> -->
<!-- 		</div> -->
		
		
<%-- 		<%} %> --%>
		

<!-- 		<div class="col-2"></div> -->
<!-- 	</div> -->
<!-- 	<!-- 갤러리 내용 끝 -->			 

<!-- 	<!-- 날씨 제목 시작 -->				 
<!-- 	<div class="row"> -->
<!-- 		<div class="col-4"></div> -->
<!-- 		<div class="col-4 pt-4 m-2 text-center"> -->
<!-- 			<h4>날씨 정보</h4> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<!-- 날씨 제목 시작 -->				 

<!-- 	<!-- 날씨 내용 시작 -->					 
<!-- 	<div class="row"> -->
<!-- 		<div class="col-2"></div> -->
<!-- 		<div class="col-8 p-4 m-2 text-center"> -->
<!-- 			날씨 api 넣기 -->
<!-- 		</div> -->
<!-- 		<div class="col-2"></div> -->
<!-- 	</div> -->
<!-- 	<!-- 날씨 내용 끝 -->					 -->

<!-- 	<!-- 댓글 제목 시작 -->						 -->
<!-- <!-- 	<div class="row"> --> -->
<!-- <!-- 		<div class="col-4"></div> --> -->
<!-- <!-- 		<div class="col-4 pt-4 m-2 text-center"> --> -->
<!-- <!-- 			<h4>댓글</h4> --> -->
<!-- <!-- 		</div> --> -->
<!-- <!-- 	</div> --> -->
<!-- 	<!-- 댓글 제목 끝 -->						 -->
	
	
<!-- 	<!-- 댓글 내용 시작 -->							 -->
<!-- 	<div class="row"> -->
<!-- 		<div class="col-2"></div> -->
<!-- 		<div class="col-8 p-4 m-2 text-center"> -->
<!-- 			<div id="disqus_thread"></div> -->
<!-- 			<script> -->

<!-- 			</script> -->
<!-- 			<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript> -->
<!-- 		</div> -->
<!-- 		<div class="col-2"></div> -->
<!-- 	</div> -->
<!-- 	<!-- 댓글 제목 끝 -->						 -->
	
<!-- 	<div class="row text-center"> -->
<%-- 		<div><button type="button" class="btn btn-secondary" onclick="location.href='/Portpolio_camp/freecamp/freeForm.jsp?pageNum=<%=pageNum %>'">목록으로</button></div> --%>
	</div>






</div>
<!-- container 끝 -->	

<!-- footer 시작 -->
<div class="row">
 <jsp:include page="/footer/footer.jsp" />
</div>
<!-- footer 끝 -->
</body>
</html>