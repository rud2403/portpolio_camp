<%@page import="com.camp.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camp.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>캠핑 List</title>
	
<!-- 부트스트랩 준비 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
<!-- 부트스트랩 준비 끝 -->

<!-- 파비콘 시작 -->
<link rel="shortcut icon" href="../favicon.ico">
<!-- 파비콘 끝 -->
	
<!-- jquery 준비 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- jquery 준비 끝 -->

<!-- 우편번호 시작 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 우편번호 끝 -->

<!-- id 값 받아오기 시작 -->
<script type="text/javascript">
	<%
	String id = (String)session.getAttribute("id");
	String search = request.getParameter("search");
	System.out.println("받아온 search 값은 : " + search);
	
	%>
</script>
<!-- id 값 받아오기 끝 -->
	

	
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
	                
	                
	                Promise.resolve(data).then(o => {
	                    const { address } = data;

	                    return new Promise((resolve, reject) => {
	                        const geocoder = new daum.maps.services.Geocoder();

	                        geocoder.addressSearch(address, (result, status) =>{
	                            if(status === daum.maps.services.Status.OK){
	                                const { x, y } = result[0];

	                                resolve({ lat: y, lon: x })
	                            }else{
	                                reject();
	                            }
	                        });
	                    })
	                }).then(result => {
	                	
	                	
	                	
// 	                	JSON.stringify(result)
	             	   //{"lat":"37.5132284781619","lon":"127.033437226842"}
	             	   var sp = JSON.stringify(result).split(',');
	             	   var x=sp[0].substring(8).replace('"','');
	             	   var y=sp[1].substring(7).replace('"','').replace('}','');
	             	   
	             	   document.getElementById('lat').value = x;
	             	   document.getElementById('lng').value = y;
	                    
	                    
	                    
	                });
	            },


	        }).open();
	    }
	    
	</script>	
	<!-- 우편번호 스크립트 끝 -->
	
</head>


<body>

	<!-- DB글 정보 연동 시작 -->
	<%
	// 디비에 저장된 글의 개수를 알기
	
	// BoardDAO 객체 생성
	BoardDAO bdao = new BoardDAO();
	
	// 디비에 있는 글의 수를 계산하는 메소드 생성 -> 호출
	// getBoardCount();
	int cnt = bdao.getBoardCount(search);
	
	//////////////////////////////////////////////////////////////////////////////////
	// 게시판 페이징 처리 : DB에서 원하는 만큼만 글 가져오기
	
	// 한페이지당 보여줄 글의 개수
	int pageSize = 5;
	
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
	ArrayList boardList = bdao.getBoardList(search, startRow, pageSize);
	ArrayList campList = bdao.getCampList(search);
	
	
	
	%>
	<!-- DB글 정보 연동 끝 -->



<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
<!-- navbar 끝 -->

<!-- container 시작 -->
<div class="container-fluid">

<!-- row 시작 -->	
<div class="row mt-4">

<!-- 왼쪽 col 시작 -->
    <div class="col-4 text-center">
		<h3>캠핑 LIST</h3>
		<hr>
	<div class="row">
		<div class="col-4" >
			<!-- 사용자 현재위치 버튼 시작 -->
			<button type="button" class="btn btn-outline-secondary btn-sm" id="place">현재위치</button>
			<!-- 사용자 현재위치 버튼 끝 -->
		</div>
		<div class="col-4">
		게시글 총 <%=cnt %>개
		</div>
		
		<!-- id가 'admin'일때만 나타나는 글쓰기 버튼 시작 -->
		<%
		try {
			if("admin".equals(id)){ %>
			<div class="col-4">
				<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">글쓰기</button>
			</div>
		<%
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		%>
		<!-- id가 'admin'일때만 나타나는 글쓰기 버튼 끝 -->
		
	</div>
	
<!-- 검색 기능 시작 -->
	<div class="row mt-3">
	<div class="col-2"></div>
	
	<div class="col-8">
	<form action="freeFormSearch.jsp"  method="get">
		<div class="input-group mb-3">
		<p class="m-2"> 캠핑지 찾기</p>
		  <input type="text" class="form-control" placeholder="ex) 서울, 부산" aria-label="Recipient's username" aria-describedby="button-addon2" id="search" name="search">
		  <button class="btn btn-outline-secondary" type="submit" id="sbutton">검색</button>
		</div>
	</form>	
	</div>
	
	<div class="col-2"></div>
	</div>
	<!-- 검색 기능 끝 -->	
		
	<!-- table 시작 -->
	<table class="table mt-5">
	  <tbody>
	  	<%for(int i = 0; i < boardList.size(); i++){ 
			BoardBean bb = (BoardBean)boardList.get(i);
			
		%>
	    <tr>
	      <th class="col-2" scope="row"></th>	      
	      <%if(bb.getFilename().equals("null")){ %>
	      	<td class="col-4 pt-4"><img src="https://allways.smotor.com/wp-content/uploads/2020/04/0429_%EC%BA%A0%ED%95%91_12.jpg" class="d-block rounded" alt="..." width="100px" height="110px"></td>
	      <%}else{ %>	      
	      	<td class="col-4 pt-4"><img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block rounded" alt="..." width="100px" height="110px"></td>
	      <%} %>
	      
	      <td class="pt-2 ml-3 col-6">
	      	<div class="row" style='cursor:pointer;'>
	      		<a id="ck<%=bb.getNum() %>"><h5><%=bb.getName() %></h5></a>
	     	</div>
	      	<div class="row py-3">
	      		<%=bb.getAddress() %>
	     	</div>
	      	<div class="row">
	      	난이도 <%if(bb.getLevel().equals("상")){ %>
						★★★
			      <%}else if(bb.getLevel().equals("중")){ %>
			       	★★
			       <%}else{ %>
			     	  ★
			       <%} %>
	     	</div>
	     	
	     	<div class="row" >
		     	<div class="col-1"></div>
		     	<div class="col-4">
	     			<input class="btn btn-light btn-sm m-2" type="button" value="상세보기" onclick="location.href='content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>&name=<%=bb.getName()%>'">
	     		</div>
	     		<div class="col-7"></div>
	     	</div>	     		     	
	      </td>
	    </tr>
	    <%} %>

	  </tbody>
	</table>
	<!-- table 끝 -->	

	<!-- page네비 시작 -->

	<div class="row">
		<div class="col-4"></div>
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
			    
			     href="/Portpolio_camp/freecamp/freeFormSearch.jsp?pageNum=<%=startPage-pageBlock%>"
			    
			    <%} %>
			    >&laquo;</a></li>
			    
			<%
			
			// 숫자 1...5
			for(int i = startPage; i <= endPage; i++){
			%>
			    <li class="page-item"><a class="page-link" href="/Portpolio_camp/freecamp/freeFormSearch.jsp?search=<%=search %>&?pageNum=<%=i %>"><%=i %></a></li>
			<%
			}
			// 다음(기존의 페이지 블럭보다 페이지의 수가 많을 때)

				%>
			    <li class="page-item"><a class="page-link"
			    
			    <%if(endPage < pageCount){ %>
			     href="/Portpolio_camp/freecamp/freeFormSearch.jsp?pageNum=<%=startPage + pageBlock%>"
			     <%} %>
			     
			     >&raquo;</a></li>
			    <%
		}
	
	%>
		  	</ul>
		</nav>
		</div>
		<div class="col-5"></div>
	</div>
	
	<!-- page네비 끝 -->
	
	</div>
	<!-- 왼쪽 col 끝 -->
	
	
	<!-- /////////////////////////////게시판 글쓰기 Modal 시작/////////////////////////////-->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title" id="exampleModalLabel">무료 캠핑장 - 글쓰기 </h2>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
	      <!-- 게시판 글 쓰기 폼 작성 시작 -->
		  <form action="/Portpolio_camp/freecamp/fileUploadPro.jsp" method="post" enctype="multipart/form-data">
	      	  <!-- 글쓰기 본문 시작 -->
		      <div class="modal-body mx-5">
   					<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>위치</h4></div>
			       		<div class="col-4"></div>
					</div>
		      
			       <div class="form-floating mb-3">
					  <input type="text" class="form-control" id="floatingInput" placeholder="캠핑지명" name="name">
					  <label for="floatingInput">캠핑지명</label>
					</div>
					
			       	<!-- 우편번호 시작 -->
						<input type="text" id="sample6_address" placeholder="주소" name="address" class="form-control"><br>
						<input type="button" class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
						
						<input type="hidden" id="sample6_postcode" placeholder="우편번호">
						<input type="hidden" id="sample6_detailAddress" placeholder="상세주소">
						<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
					<!-- 우편번호 끝 -->
					
					<!-- 위도 경도 시작 -->
					<div class="row my-3">
						<div class="col">
							<input type="text" class="form-control" id="lat" placeholder="위도" name="lat">
						</div>
						<div class="col">
							<input type="text" class="form-control" id="lng" placeholder="경도" name="lng">
						</div>
					</div>
			       	<!-- 위도 경도 끝 -->
			       	
			       	<!-- 난이도 시작 -->
					<hr>
					<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>난이도</h4></div>
			       		<div class="col-4"></div>
					</div>			       	
			       	<div class="row">
			       		
					<select class="form-select" aria-label="Default select example" name="level">
					  <option value="상" selected>상</option>
					  <option value="중">중</option>
					  <option value="하">하</option>
					</select>
			       		
			       	</div>
			       	<!-- 난이도 끝 -->
			       	
			       	
			       	<hr>
			       	<!-- 주변환경 텍스트 시작 -->
			       	<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>주변 환경</h4></div>
			       		<div class="col-4"></div>			       		
			       	</div>
			       	<!-- 주변환경 텍스트 끝 -->
			       	
			       	<!-- CheckBox 시작 -->
			       	<!-- row 시작 -->
			       	<div class="row m-3">
			       	<div class="col m-2">
			       		<h5>화장실</h5>
			       		 <div class="form-check">
						  <input class="form-check-input" type="radio" name="toilet" id="exampleRadios1" value="y" checked>
						  <label class="form-check-label" for="exampleRadios1">
						    있음
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="toilet" id="exampleRadios2" value="n">
						  <label class="form-check-label" for="exampleRadios2">
						    없음
						  </label>
						</div>
					</div>	
			       	<div class="col m-2">
			       		<h5>주차장</h5>
			        	<div class="form-check">
						  <input class="form-check-input" type="radio" name="park" id="exampleRadios1" value="y" checked>
						  <label class="form-check-label" for="exampleRadios1">
						    있음
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="park" id="exampleRadios2" value="n">
						  <label class="form-check-label" for="exampleRadios2">
						    없음
						  </label>
						</div>
					</div>
			       	<div class="col m-2">
			       		<h5>물놀이</h5>
			       		 <div class="form-check">
						  <input class="form-check-input" type="radio" name="water" id="exampleRadios1" value="y" checked>
						  <label class="form-check-label" for="exampleRadios1">
						    있음
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="water" id="exampleRadios2" value="n">
						  <label class="form-check-label" for="exampleRadios2">
						    없음
						  </label>
						</div>
					</div>
			       	<div class="col m-2">
			       		<h5>낚시</h5>
			       		 <div class="form-check">
						  <input class="form-check-input" type="radio" name="fishing" id="exampleRadios1" value="y" checked>
						  <label class="form-check-label" for="exampleRadios1">
						    있음
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="fishing" id="exampleRadios2" value="n">
						  <label class="form-check-label" for="exampleRadios2">
						    없음
						  </label>
						</div>
					</div>																			
			       </div>
			      	<!-- row1 끝 -->
			      	<!-- row2 시작 -->
			      	<div class="row text-center">
			      		<div class="col-1">
			      			<h5>필드</h5>
			      		</div>
			      		<div class="col-5">
			      			<select class="form-select" aria-label="Default select example" name="field">
							  <option value="바다">바다</option>
							  <option value="산">산</option>
							  <option value="계곡">계곡</option>
							  <option value="기타">기타</option>
							</select>
			      		</div>
			      		<div class="col-1">
			      			<h5>바닥</h5>
			      		</div>
			      		<div class="col-5">
			      			<select class="form-select" aria-label="Default select example" name="land">
							  <option value="흙">흙</option>
							  <option value="진흙">진흙</option>
							  <option value="잔디">잔디</option>
							  <option value="모래">모래</option>
							  <option value="기타">기타</option>							  
							</select>
			      		</div>			      		
			      	</div>
			       	<!-- row2 끝 -->
			       	
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
	<!-- /////////////////////////////게시판 글쓰기 Modal 끝/////////////////////////////-->
	
	
	
	
	<!-- 오른쪽 col 시작 -->
	<div class="col-8 text-center mt-5">
	
	
	<!-- ////////////////////////////////////////////////////////지도 api 시작 ////////////////////////////////////////////////////////////////-->
	<div id="map" style="width:100%; height:940px;"></div>
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8cf6d2a5b75cdde0c3700860a547a92e&libraries=services"></script>
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		
		$(function() {
			
			// 캠핑지 추가 로직 = 게시판 num가 id이다.
			// id에 맞게 #ck(게시글 num)으로 설정
			// 지도 위치 이동 시작

			
			<%for(int i = 0; i < campList.size(); i++){ %>		
				
			$("#ck"+(<%=i+1%>)).click(function(){
			 	infowindow[<%=i%>].content.open(map, marker[<%=i%>].content);
			 	map.setCenter(markerPosition[<%=i%>].content);						
			});
			
			<%}%>
			
//  			$("#ck2").click(function(){
//  				infowindow[1].content.open(map, marker[1].content);
//  			 	map.setCenter(markerPosition[1].content);						
//  			});
 			
//  			$("#ck3").click(function(){
//  				infowindow[2].content.open(map, marker[2].content);
//  			 	map.setCenter(markerPosition[2].content);						
//  			});
 			
//  			$("#ck4").click(function(){
//  				infowindow[3].content.open(map, marker[3].content);
//  			 	map.setCenter(markerPosition[3].content);						
//  			});			
//  			$("#ck5").click(function(){
//  				infowindow[4].content.open(map, marker[4].content);
//  			 	map.setCenter(markerPosition[4].content);						
//  			});				
 			
//  			$("#ck6").click(function(){
//  				infowindow[5].content.open(map, marker[5].content);
//  			 	map.setCenter(markerPosition[5].content);						
//  			});			
			
			
		});
		
		//----------------------------------------마커가 표시될 위치입니다 
		var markerPosition = [
		<%						
		for(int i = 0; i < campList.size(); i++){ 
			BoardBean bb = (BoardBean)campList.get(i);%>	
		<%
			if(i<campList.size()){
			%>
			{ content : new kakao.maps.LatLng(<%=bb.getLat()%>, <%=bb.getLng()%>) },
			<%}else{%>
			{ content : new kakao.maps.LatLng(<%=bb.getLat()%>, <%=bb.getLng()%>) }			
			<%
			}

		}
		%>
];
		
	/* 	var markerPosition = [
			
			{ content : new kakao.maps.LatLng(35.2058957, 129.2247213) },
			{ content : new kakao.maps.LatLng(35.00526907336864, 128.82406688230586) },
			{ content : new kakao.maps.LatLng(35.57272898700915, 129.45231298970947) },
			{ content : new kakao.maps.LatLng(35.61056648191471, 129.40827935517790) },
			{ content : new kakao.maps.LatLng(34.79978876044260, 128.61183711832933) },
			{ content : new kakao.maps.LatLng(35.10286041704596, 128.50036722911120) }
			
		];
		 */

		//---------------------------------------- 마커를 생성합니다

			
			
			var marker = [
				<%						
				for(int i = 0; i < campList.size(); i++){ 
					BoardBean bb = (BoardBean)campList.get(i);%>	
					<%
					if(i<campList.size()){
					%>
					{ content : new kakao.maps.Marker({position: markerPosition[<%=i%>].content}) },
					<%}else{%>
					{ content : new kakao.maps.Marker({position: markerPosition[<%=i%>].content}) }	
					<%
					}

				}
				%>
		];
			
			
			
// 			{ content : new kakao.maps.Marker({position: markerPosition[1].content}) },
// 			{ content : new kakao.maps.Marker({position: markerPosition[2].content}) },
// 			{ content : new kakao.maps.Marker({position: markerPosition[3].content}) },
// 			{ content : new kakao.maps.Marker({position: markerPosition[4].content}) },
// 			{ content : new kakao.maps.Marker({position: markerPosition[5].content}) }
			
// 			];
		
		
		//------------------------------------------ 마커가 지도 위에 표시되도록 설정합니다
		
		// 캠핑지 늘릴 때 마다 i 숫자범위 늘리기
		for(var i = 0; i < markerPosition.length; i++ ){
			//marker1...6
		marker[i].content.setMap(map);
		}
		/////////////////// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다 시작 ////////////////////
		
		<% String test = "test"; %>
		//------------------------------------------- iwContent 시작--//

		<%						
		for(int i = 0; i < campList.size(); i++){ 
			BoardBean bb = (BoardBean)campList.get(i);%>
			
		var iwContent<%=(i+1)%> =
			
			'<div class="container">'+
			' <div class="row"">'+
			'  <div class="col-2 pt-2">'+
			'   <img src="../upload/'+'<%=bb.getFilename()%>'+'" class="d-block rounded my-2" alt="..." width="60px" height="80px">'+
			'  </div>'+
			' <div class="text-center pl-3 col-10">'+
			'  <div class="row-4 mt-3"><h5>'+'<%=bb.getName()%>'+'</h5></div>'+
			'  <div class="row-4">'+'<%=bb.getAddress()%>'+'</div>'+
			' </div>'+
			' </div>'+
			'</div>'
			,
			// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
		 <%}%>
		    
		    /************************/
		    
		 // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
// 		var iwContent2 =
// 			'<div class="container">'+
// 			' <div class="row"">'+
// 			'  <div class="col-2 pt-2">'+
// 			'   <img src="../upload/부산외양포항주차장1.jpg" class="d-block rounded my-2" alt="..." width="60px" height="80px">'+
// 			'  </div>'+
// 			' <div class="text-center pl-3 col-10">'+
// 			'  <div class="row-4 mt-3"><h5>부산 외양포항주차장</h5></div>'+
// 			'  <div class="row-4">부산 강서구 대항동 산 13-23</div>'+
// 			' </div>'+
// 			' </div>'+
// 			'</div>'
// 			, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
// 		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다    
		    
// 		 // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
// 		var iwContent3 =
// 			'<div class="container">'+
// 			' <div class="row"">'+
// 			'  <div class="col-2 pt-2">'+
// 			'   <img src="../upload/울산구암마을주전해변1.jpg" class="d-block rounded my-2" alt="..." width="60px" height="80px">'+
// 			'  </div>'+
// 			' <div class="text-center pl-3 col-10">'+
// 			'  <div class="row-4 mt-3"><h5>울산 구암마을주전해변</h5></div>'+
// 			'  <div class="row-4">울산 북구 어물동 273</div>'+
// 			' </div>'+
// 			' </div>'+
// 			'</div>'
// 			, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
// 		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다 		    

// 		var iwContent4 =
// 			'<div class="container">'+
// 			' <div class="row"">'+
// 			'  <div class="col-2 pt-2">'+
// 			'   <img src="../upload/울산큰골저수지부근1.jpg" class="d-block rounded my-2" alt="..." width="60px" height="80px">'+
// 			'  </div>'+
// 			' <div class="text-center pl-3 col-10">'+
// 			'  <div class="row-4 mt-3"><h5>울산 큰골 저수지 부근</h5></div>'+
// 			'  <div class="row-4">울산 북구 무룡동 978</div>'+
// 			' </div>'+
// 			' </div>'+
// 			'</div>'
// 			, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
// 		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다 			    
	    
// 		var iwContent5 =
// 			'<div class="container">'+
// 			' <div class="row"">'+
// 			'  <div class="col-2 pt-2">'+
// 			'   <img src="../upload/거제만다라화시공원1.jpg" class="d-block rounded my-2" alt="..." width="60px" height="80px">'+
// 			'  </div>'+
// 			' <div class="text-center pl-3 col-10">'+
// 			'  <div class="row-4 mt-3"><h5>거제 만다라화 시 공원</h5></div>'+
// 			'  <div class="row-4">경남 거제시 동부면 부춘리 산 56-2</div>'+
// 			' </div>'+
// 			' </div>'+
// 			'</div>'
// 			, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
// 		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다 	
					    
// 		    var iwContent6 =
// 				'<div class="container">'+
// 				' <div class="row"">'+
// 				'  <div class="col-2 pt-2">'+
// 				'   <img src="../upload/창원광암해수욕장노지1.jpg" class="d-block rounded my-2" alt="..." width="60px" height="80px">'+
// 				'  </div>'+
// 				' <div class="text-center pl-3 col-10">'+
// 				'  <div class="row-4 mt-3"><h5>창원 광암해수욕장 노지</h5></div>'+
// 				'  <div class="row-4">경남 창원시 마산합포구 진동면 요장리 230</div>'+
// 				' </div>'+
// 				' </div>'+
// 				'</div>'
// 				, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
// 			    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다 						    
					    
					    
					    					    
		//------------------------------------------------ 인포윈도우1을 생성합니다
		var infowindow =[
			
			<%for(int i = 0; i < campList.size(); i++){ %>	
			
			
			{
				content : new kakao.maps.InfoWindow({ content : iwContent<%=(i+1)%>, removable : iwRemoveable })
			},
			
			<%}%>
			
			
// 			{
// 				content : new kakao.maps.InfoWindow({ content : iwContent2, removable : iwRemoveable })
// 			},
			
// 			{
// 				content : new kakao.maps.InfoWindow({ content : iwContent3, removable : iwRemoveable })
// 			},
			
// 			{
// 				content : new kakao.maps.InfoWindow({ content : iwContent4, removable : iwRemoveable })
// 			},
			
// 			{
// 				content : new kakao.maps.InfoWindow({ content : iwContent5, removable : iwRemoveable })
// 			},
			
// 			{
// 				content : new kakao.maps.InfoWindow({ content : iwContent6, removable : iwRemoveable })
// 			},
			
 			];
		    
		
		/////////////////// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다 끝 ////////////////////

		
		////////////////// 마커 클릭 이벤트 등록 시작 ////////////////////////
		
		//--------------------------------------------- 마커 에 클릭이벤트를 등록합니다
		// 캠핑지 추가시 안걸들여도 됨 시작//
		
		
		for(var i = 0; i < markerPosition.length; i++){
			
			kakao.maps.event.addListener(marker[i].content, 'click', function() {
			      // 마커1 위에 인포윈도우1를 표시합니다
			      eval('infowindow'+i+1).open(map, marker[i].content);  
			});
			
		}
		// 캠핑지 추가시 안걸들여도 됨 끝//
		
		//-- 마커 클릭 이벤트 끝 --//
		
		////////////////// 마커 클릭 이벤트 등록 끝 ////////////////////////

	
		//////////////////////////////////////////////////// 사용자 현재위치 표시 시작////////////////////////////////////////////////////////////////
		var pc = document.getElementById('place');

		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat = position.coords.latitude, // 위도
		            lon = position.coords.longitude; // 경도
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		            message = '<div style="padding:5px;">사용자 현재위치</div>'; // 인포윈도우에 표시될 내용입니다
		        
		        // 마커와 인포윈도우를 표시합니다
		        displayMarker(locPosition, message);
		            
		      });
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		    
		    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
		        message = 'geolocation을 사용할수 없어요..'
		        
		    displayMarker(locPosition, message);
		}
		
		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition, message) {
		
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({  
		        map: map, 
		        position: locPosition
		    }); 
		    
		    var iwContent = message, // 인포윈도우에 표시할 내용
		        iwRemoveable = true;
		
		    // 인포윈도우를 생성합니다
		    var infowindow = new kakao.maps.InfoWindow({
		        content : iwContent,
		        removable : iwRemoveable
		    });
		    
		    // 인포윈도우를 마커위에 표시합니다 
		    infowindow.open(map, marker);
		    
		    // 지도 중심좌표를 접속위치로 변경합니다
		    map.setCenter(locPosition);      
		    
		    
			//  현재위치 눌렸을 때 마커가 선택되는 기능 시작
			 $("#place").click(function(){
				 displayMarker(locPosition, message) 
	 		});
			//  현재위치 눌렸을 때 마커가 선택되는 기능 끝
		}
	///////////////////////////////////////////////////// 사용자 현재위치 표시 끝/////////////////////////////////////////////////////////////////////
		
		</script>
	<!-- /////////////////////////////////지도 api 끝 /////////////////////////////////-->
		
		</div>
		<!-- 오른쪽 col 끝 -->
		
	</div>
	<!-- row 끝 -->
	
</div>	
<!-- container 끝 -->

<!-- footer 시작 -->
<div class="row">
 <jsp:include page="/footer/footer.jsp" />
</div>
<!-- footer 끝 -->
	
	

	
</body>
</html>