<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>무료 캠핑장</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
	
	<!-- jquery 시작 -->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<!-- jquery 끝 -->
	
	<script type="text/javascript">
		<%
		String id = (String)session.getAttribute("id");
		%>
	</script>
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
				<button type="button" class="btn btn-outline-primary" onclick="location.href='/Portpolio_camp/freecamp/freewriteForm.jsp'">글쓰기</button>
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

		
		
		//-- 마커 클릭 이벤트 시작 --//
		// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
		
		
		
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


		//  첫번 째 목록 눌렸을 때 마커가 선택되는 끝
		
		
		//  첫번 째 목록 눌렸을 때 마커가 선택되는 기능 시작
		var txt = document.getElementById('ck1');
		
		txt.addEventListener('click', function(){			 
			 
			 $(document).ready(function() {
					
			 		infowindow1.open(map, marker1);
			 		map.setCenter(markerPosition1);					
				});
 			 
		});
		//  첫번 째 목록 눌렸을 때 마커가 선택되는 끝
		
		
		//  두번 째 목록 눌렸을 때 마커가 선택되는 기능 시작
		var txt = document.getElementById('ck2');
		
		txt.addEventListener('click', function(){			 
			 
			 $(document).ready(function() {
					
			 		infowindow2.open(map, marker2);
			 		map.setCenter(markerPosition2);						
				});
 			 
		});
		//  두번 째 목록 눌렸을 때 마커가 선택되는 끝

		
		
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
				 
				 $(document).ready(function() {
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