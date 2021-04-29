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
		<div class="col">
		게시글 총 x개
		</div>
	</div>
	
	<!-- table 시작 -->
	<table class="table mt-5">
	  <tbody>
	    <tr>
	      <th class="pt-5 col-2" scope="row">1</th>	      
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
	    <tr>
	      <th class="pt-5 col-2" scope="row">2</th>	      
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
		var markerPosition1  = new kakao.maps.LatLng(33.450750, 126.570100); 
		var markerPosition2  = new kakao.maps.LatLng(33.450300, 126.570300); 
		var markerPosition3  = new kakao.maps.LatLng(33.450500, 126.570500); 
		var markerPosition4  = new kakao.maps.LatLng(33.451000, 126.571000); 
		
		// 마커를 생성합니다
		var marker1 = new kakao.maps.Marker({
		    position: markerPosition1
		});
		
		var marker2 = new kakao.maps.Marker({
		    position: markerPosition2
		});
		
		var marker3 = new kakao.maps.Marker({
		    position: markerPosition3
		});		
		
		var marker4 = new kakao.maps.Marker({
		    position: markerPosition4
		});			
		// 마커가 지도 위에 표시되도록 설정합니다
		marker1.setMap(map);
		marker2.setMap(map);
		marker3.setMap(map);
		marker4.setMap(map);
		
		
		//-- 마커 클릭 이벤트 시작 --//
		// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
		
		//-- iwContent1 시작--//
		var iwContent1 = 
			'<div class="container">'+
			' <div class="row"">'+
			'  <div class="col-2 pt-2">'+
			'   <img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="d-block rounded mb-2" alt="..." width="50px" height="50px">'+
			'  </div>'+
			' <div class="text-center pl-3 col-10">'+
			'  <div class="row-4"><h5>부산 오랑대 공원</h5></div>'+
			'  <div class="row-4">주소 xxxxxxx</div>'+
			'  <div class="row-4"><input class="btn btn-primary" type="submit" value="상세보기"></div>'+
			' </div>'+
			' </div>'+
			'</div>'
			, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
		//-- iwContent1 끝--//
		    
		 // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
		var iwContent2 = '<div style="padding:5px;">안녕하세요</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
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

		</script>
		</div>
		<!-- 오른쪽 col 끝 -->
		<!-- 지도 api 끝 -->
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