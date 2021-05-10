<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>무료 캠핑장</title>


<!-- 지도 부분 배열을 위한 파일 -->


<!-- jquery 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- jquery 끝 -->


<!-- 카카오 map api 시작 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8cf6d2a5b75cdde0c3700860a547a92e"></script>
<!-- 카카오 map api 끝 -->


<!-- 부트스트랩 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

<!-- 부트스트랩 끝-->


</head>



<body>

	<%
	String id = (String)session.getAttribute("id");
	%>


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
		<div class="col-4"></div>
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
	      	<div class="row" id="ck">
	      	<a style='cursor:pointer;'>부산 오랑대공원</a>
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
	<input type="button" value="jquery 테스트" id="bt" onclick="func1()">
	
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
		
		<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		
		var positions = [
		    {
		        content:
		        	'<div class="container">'+
					' <div class="row"">'+
					'  <div class="col-2 pt-2">'+
					'   <img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="d-block rounded mb-2" alt="..." width="50px" height="50px">'+
					'  </div>'+
					' <div class="text-center pl-3 col-10">'+
					'  <div class="row-4"><h5>부산 오랑대 공원</h5></div>'+
					'  <div class="row-4">주소 xxxxxxx</div>'+
					'  <div class="row-4"><input class="btn btn-primary btn-sm" type="submit" value="상세보기"></div>'+
					' </div>'+
					' </div>'+
					'</div>', 
		        latlng: new kakao.maps.LatLng(33.450705, 126.570677)

		    },
		    {
		        content: '<div>생태연못</div>', 
		        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
		        
		    },
		    {
		        content: '<div>텃밭</div>', 
		        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
		    },
		    {
		        content: '<div>근린공원</div>',
		        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
		    }
		];
		
		
		for (var i = 0; i < positions.length; i ++) {
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng // 마커의 위치
		    });
		
		    var infowindow = new kakao.maps.InfoWindow({
		        content: positions[i].content,
			    	// 인포윈도우에 표시할 내용
		    });
		    
		    kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, infowindow));
		   
		    //kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		    
		    
		}
		    
		    
		// 인포윈도우를 표시하는 클릭을 만드는 함수입니다 
		function makeClickListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}
		
		
		// 게시글 제목 클릭시 마커가 선택되는 기능 시작
		var txt = document.getElementById('ck');
		var bt = document.getElementById('bt');
		var mc = makeClickListener(map, marker, infowindow);
		
		txt.addEventListener('click', function(){
			 alert("클릭 됐습니다.");
			 
			 $(document).ready(function() {
					alert("JQUERY 준비-시작");

					$(mc).trigger('click');
					
					alert("JQUERY 준비-끝");
				});
 			 
			
		});
		
		
		//게시글 제목 클릭시 마커가 선택되는 기능 종료

		
		// Jquery 테스트 시작
		function func1() {
			 alert(" jquery 테스트 버튼도 함께 클릭 됐습니다.");
		}
		
		// Jquery 테스트 끝
		
		
// 		//마커가 표시될 위치입니다 
// 		var markerPosition1  = new kakao.maps.LatLng(33.450750, 126.570100); 
// 		var markerPosition2  = new kakao.maps.LatLng(33.450300, 126.570300); 

		
// 		// 마커를 생성합니다
// 		var marker1 = new kakao.maps.Marker({
// 		    position: markerPosition1
// 		});
		
// 		var marker2 = new kakao.maps.Marker({
// 		    position: markerPosition2
// 		});
		

// 		// 마커가 지도 위에 표시되도록 설정합니다
// 		marker1.setMap(map);
// 		marker2.setMap(map);

		
		
// 		//-- 마커 클릭 이벤트 시작 --//
// 		// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
		
		
		
// 		//-- iwContent1 시작--//
// 		var iwContent1 = 
// 			'<div class="container">'+
// 			' <div class="row"">'+
// 			'  <div class="col-2 pt-2">'+
// 			'   <img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="d-block rounded mb-2" alt="..." width="50px" height="50px">'+
// 			'  </div>'+
// 			' <div class="text-center pl-3 col-10">'+
// 			'  <div class="row-4"><h5>부산 오랑대 공원</h5></div>'+
// 			'  <div class="row-4">주소 xxxxxxx</div>'+
// 			'  <div class="row-4"><input class="btn btn-primary btn-sm" type="submit" value="상세보기"></div>'+
// 			' </div>'+
// 			' </div>'+
// 			'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
// 		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
// 		//-- iwContent1 끝--//
		    
// 		 // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
// 		var iwContent2 = '<div style="padding:5px;">안녕하세요</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
// 		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다    
		    
		    
		    
// 		// 인포윈도우1을 생성합니다
// 		var infowindow1 = new kakao.maps.InfoWindow({
// 		    content : iwContent1,
// 		    removable : iwRemoveable
// 		});
		    
// 		// 인포윈도우2를 생성합니다
// 		var infowindow2 = new kakao.maps.InfoWindow({
// 		    content : iwContent2,
// 		    removable : iwRemoveable
// 		});

// 		// 마커1 에 클릭이벤트를 등록합니다
// 		kakao.maps.event.addListener(marker1, 'click', function() {
// 		      // 마커1 위에 인포윈도우1를 표시합니다
// 		      infowindow1.open(map, marker1);  
// 		});
		
// 		// 마커2 에 클릭이벤트를 등록합니다
// 		kakao.maps.event.addListener(marker2, 'click', function() {
// 		      // 마커2 위에 인포윈도우2를 표시합니다
// 		      infowindow2.open(map, marker2);  
// 		});
		//-- 마커 클릭 이벤트 끝 --//

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