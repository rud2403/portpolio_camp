<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>무료 캠핑장</title>
	<!-- 부트스트랩 시작 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
	<!-- 부트스트랩 끝 -->
	
	<!-- jquery 시작 -->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<!-- jquery 끝 -->
	
	<!-- 우편번호 시작 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!-- 우편번호 끝 -->
	
	<!-- id 값 받아오기 시작 -->
	<script type="text/javascript">
		<%
		String id = (String)session.getAttribute("id");
		%>
	</script>
	<!-- id 값 받아오기 끝 -->
	
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


<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
<!-- navbar 끝 -->

<!-- container 시작 -->
<div class="container-fluid">

<!-- row 시작 -->	
<div class="row mt-4">

<!-- 왼쪽 col 시작 -->
    <div class="col-4 text-center">
		<h3>무료 캠핑장 LIST</h3>
		<hr>
	<div class="row">
		<div class="col-4" >
			<!-- 사용자 현재위치 버튼 시작 -->
			<button type="button" class="btn btn-outline-info btn-sm" id="place">현재위치</button>
			<!-- 사용자 현재위치 버튼 끝 -->
		</div>
		<div class="col-4">
		게시글 총 x개
		</div>
		
		<!-- id가 'admin'일때만 나타나는 글쓰기 버튼 시작 -->
		<%
		try {
			if(id.equals("admin")){ %>
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
	
	<!-- table 시작 -->
	<table class="table mt-5">
	  <tbody>
	    <tr>
	      <th class="pt-5 col-2" scope="row">1</th>	      
	      <td class="col-4"><img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="d-block rounded" alt="..." width="120px" height="100px"></td>
	      <td class="pt-2 ml-3 col-6">
	      	<div class="row" id="ck1"  style='cursor:pointer;'>
	      	<a>부산 오랑대공원</a>
	     	</div>
	      	<div class="row py-3">
	      	거리 "xxx"km
	     	</div>
	      	<div class="row">
	      	난이도 "별별별"
	     	</div>	     		     	
	      </td>
	    </tr>
	    <tr>
	      <th class="pt-5 col-2" scope="row">2</th>	      
	      <td class="col-4"><img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="d-block rounded" alt="..." width="120px" height="100px"></td>
	      <td class="pt-2 ml-3 col-6">
	      	<div class="row" id="ck2"  style='cursor:pointer;'>
	      	<a>부산 이기대공원</a>
	     	</div> 
	      	<div class="row py-3">
	      	거리 "xxx"km
	     	</div>
	      	<div class="row">
	      	난이도 "별별별"
	     	</div>	     		     	
	      </td>
	    </tr>
	    <tr>
	      <th class="pt-5 col-2" scope="row">3</th>	      
	      <td class="col-4"><img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="d-block rounded" alt="..." width="120px" height="100px"></td>
	      <td class="pt-2 ml-3 col-6">
	      	<div class="row">
	      	부산 오랑대공원
	     	</div> 
	      	<div class="row py-3">
	      	거리 "xxx"km
	     	</div>
	      	<div class="row">
	      	난이도 "별별별"
	     	</div>	     		     	
	      </td>
	    </tr>
	  </tbody>
	</table>
	<!-- table 끝 -->	
	
	<!-- page네비 시작 -->
	<div class="row">
		<div class="col-3"></div>
		<div class="col-lg-3">
		<nav aria-label="Page navigation example">
		  	<ul class="pagination">
			    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			    <li class="page-item"><a class="page-link" href="#">2</a></li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
			    <li class="page-item"><a class="page-link" href="#">Next</a></li>
		  	</ul>
		</nav>
		</div>
		<div class="col-6"></div>
	</div>
	<!-- page네비 끝 -->
	
	</div>
	<!-- 왼쪽 col 끝 -->
	
	
	<!-- 게시판 글쓰기 Modal 시작-->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title" id="exampleModalLabel">무료 캠핑장 - 글쓰기 </h2>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
	      <!-- 게시판 글 쓰기 폼 작성 시작 -->
	      <form action="/Portpolio_camp/freecamp/writecampPro.jsp" method="get">
	      	  <!-- 글쓰기 본문 시작 -->
		      <div class="modal-body mx-5">
			       <div class="form-floating mb-3">
					  <input type="text" class="form-control" id="floatingInput" placeholder="캠핑지명" name="test">
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
							<input type="text" class="form-control" id="floatingInput" placeholder="위도" name="lat">
						</div>
						<div class="col">
							<input type="text" class="form-control" id="floatingInput" placeholder="경도" name="lng">
						</div>
					</div>
			       	<!-- 위도 경도 끝 -->
			       	<hr>
			       	<!-- 주변환경 텍스트 시작 -->
			       	<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4">주변 환경</div>
			       		<div class="col-4"></div>			       		
			       	</div>
			       	<!-- 주변환경 텍스트 끝 -->
			       	
			       	<!-- CheckBox 시작 -->
			       	<!-- row 시작 -->
			       	<div class="row m-3">
			       	<div class="col m-2">
			       	<h5>화장실</h5> <div class="form-check">
							  <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="yes" checked>
							  <label class="form-check-label" for="exampleRadios1">
							    있음
							  </label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios2" value="no">
							  <label class="form-check-label" for="exampleRadios2">
							    없음
							  </label>
							</div>
					</div>	
			       	<div class="col m-2">
			       <h5>주차장</h5> <div class="form-check">
							  <input class="form-check-input" type="radio" name="park" id="exampleRadios1" value="yes" checked>
							  <label class="form-check-label" for="exampleRadios1">
							    있음
							  </label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="park" id="exampleRadios2" value="no">
							  <label class="form-check-label" for="exampleRadios2">
							    없음
							  </label>
							</div>
					</div>
			       	<div class="col m-2">
			       	<h5>물놀이</h5> <div class="form-check">
							  <input class="form-check-input" type="radio" name="water" id="exampleRadios1" value="yes" checked>
							  <label class="form-check-label" for="exampleRadios1">
							    있음
							  </label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="water" id="exampleRadios2" value="no">
							  <label class="form-check-label" for="exampleRadios2">
							    없음
							  </label>
							</div>
					</div>
			       	<div class="col m-2">
			       	<h5>낚시</h5> <div class="form-check">
							  <input class="form-check-input" type="radio" name="fishing" id="exampleRadios1" value="yes" checked>
							  <label class="form-check-label" for="exampleRadios1">
							    있음
							  </label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="fishing" id="exampleRadios2" value="no">
							  <label class="form-check-label" for="exampleRadios2">
							    없음
							  </label>
							</div>
					</div>																			
			       </div>
			      	<!-- row1 끝 -->
			      	
			       
			       	
			  </div>
			  <!-- 글쓰기 본문 끝 -->
			      

		      <div class="modal-footer">
		      	<button type="submit" class="btn btn-primary">작성</button>
			  	<button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			  	<button type="reset">취소2</button>
		      </div>
	      </form>
	     <!-- 게시판 글 쓰기 폼 작성 끝 -->
	      
	    </div>
	  </div>
	</div>
	<!-- 게시판 글쓰기 Modal 끝-->
	
	
	
	
	
	
	
	
	
	
	
	
	<!-- 오른쪽 col 시작 -->
	<div class="col-8 text-center">
	
	
	<!-- 지도 api 시작 -->
	<div id="map" style="width:100%; height:900px;"></div>
		
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8cf6d2a5b75cdde0c3700860a547a92e"></script>
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		//마커가 표시될 위치입니다 
		var markerPosition1  = new kakao.maps.LatLng(35.2058957, 129.2247213); 
		var markerPosition2  = new kakao.maps.LatLng(33.450300, 126.570300); 
		
		// 마커를 생성합니다
		var marker1 = new kakao.maps.Marker({
		    position: markerPosition1
		});
		
		var marker2 = new kakao.maps.Marker({
		    position: markerPosition2
		});
		

		// 마커가 지도 위에 표시되도록 설정합니다
		marker1.setMap(map);
		marker2.setMap(map);

				
		/////////////////// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다 시작 ////////////////////
		
		//-- iwContent1 시작--//
		var iwContent1 = 
			'<div class="container">'+
			' <div class="row"">'+
			'  <div class="col-2 pt-2">'+
			'   <img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="d-block rounded my-2" alt="..." width="60px" height="80px">'+
			'  </div>'+
			' <div class="text-center pl-3 col-10">'+
			'  <div class="row-4 mt-3"><h5>부산 오랑대 공원</h5></div>'+
			'  <div class="row-4">주소 xxxxxxx</div>'+
			'  <div class="row-4"><input class="btn btn-primary btn-sm m-2" type="submit" value="상세보기"></div>'+
			' </div>'+
			' </div>'+
			'</div>'
			, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
		//-- iwContent1 끝--//
		    
		 // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
		var iwContent2 =
			'<div class="container">'+
			' <div class="row"">'+
			'  <div class="col-2 pt-2">'+
			'   <img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="d-block rounded my-2" alt="..." width="60px" height="80px">'+
			'  </div>'+
			' <div class="text-center pl-3 col-10">'+
			'  <div class="row-4 mt-3"><h5>부산 이기대 공원</h5></div>'+
			'  <div class="row-4">주소 xxxxxxx</div>'+
			'  <div class="row-4"><input class="btn btn-primary btn-sm m-2" type="submit" value="상세보기"></div>'+
			' </div>'+
			' </div>'+
			'</div>'
			, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다    
		    
		    
		    
		// 인포윈도우1을 생성합니다
		var infowindow1 = new kakao.maps.InfoWindow({
		    content : iwContent1,
		    removable : iwRemoveable
		});
		    
		// 인포윈도우2를 생성합니다
		var infowindow2 = new kakao.maps.InfoWindow({
		    content : iwContent2,
		    removable : iwRemoveable
		});

		/////////////////// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다 끝 ////////////////////

		
		////////////////// 마커 클릭 이벤트 등록 시작 ////////////////////////
		
		// 마커1 에 클릭이벤트를 등록합니다
		kakao.maps.event.addListener(marker1, 'click', function() {
		      // 마커1 위에 인포윈도우1를 표시합니다
		      infowindow1.open(map, marker1);  
		});
		
		// 마커2 에 클릭이벤트를 등록합니다
		kakao.maps.event.addListener(marker2, 'click', function() {
		      // 마커2 위에 인포윈도우2를 표시합니다
		      infowindow2.open(map, marker2);  
		});
		//-- 마커 클릭 이벤트 끝 --//
		
		
		////////////////// 마커 클릭 이벤트 등록 끝 ////////////////////////

		
		
		////////////////// 마커 클릭 선택 동작 시작 //////////////////////////////
		
		//  첫번 째 게시글 눌렸을 때 마커가 선택되는 기능 시작
		var txt = document.getElementById('ck1');
		
		txt.addEventListener('click', function(){			 
			 
			 $(function() {
					
			 		infowindow1.open(map, marker1);
			 		map.setCenter(markerPosition1);					
				});
 			 
		});
		//  첫번 째 게시글 눌렸을 때 마커가 선택되는 끝
		
		
		//  두번 째 게시글 눌렸을 때 마커가 선택되는 기능 시작
		var txt = document.getElementById('ck2');
		
		txt.addEventListener('click', function(){			 
			 
			 $(function() {
					
			 		infowindow2.open(map, marker2);
			 		map.setCenter(markerPosition2);						
				});
 			 
		});
		//  두번 째 게시글 눌렸을 때 마커가 선택되는 끝

		////////////////// 마커 클릭 선택 동작 끝 //////////////////////////////
		
		
		////////////////////////////////// 사용자 현재위치 표시 시작/////////////////////////////////
		
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
		    pc.addEventListener('click', function(){			 
				 
				 $(function() {
					 displayMarker(locPosition, message) 
					});
	 			 
			});
			//  현재위치 눌렸을 때 마커가 선택되는 기능 끝


			
			
		}
		
		
		
		
		////////////////////////////////// 사용자 현재위치 표시 끝/////////////////////////////////
		
		</script>
		<!-- 지도 api 끝 -->
		
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