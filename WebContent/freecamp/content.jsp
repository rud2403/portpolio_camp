<%@page import="com.camp.reply.ReplyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camp.reply.ReplyDAO"%>
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

<!-- 파비콘 시작 -->
<link rel="shortcut icon" href="../favicon.ico">
<!-- 파비콘 끝 -->

<!-- jquery 준비 시작 -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- jquery 준비 끝 -->

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
		String name = request.getParameter("name");
		// BoardDAO 객체 생성
		
		BoardDAO bdao = new BoardDAO();
		
		// 글 조회수 1증가 (DB 처리)
 		bdao.updateReadcount(num);
		
 		//DB에서 글 번호(null)에 해당하는 글 정보를 모두 가져와서 출력
 		BoardBean bb = bdao.getBoard(num);
	%>
	<!-- DB 데이터 가져오기 시작 -->
	<%
	// 디비에 저장된 글의 개수를 알기
	
	// BoardDAO 객체 생성
	ReplyDAO rdao = new ReplyDAO();
	
	// 디비에 있는 글의 수를 계산하는 메소드 생성 -> 호출
	// getBoardCount();
	int cnt = rdao.getReplyCount(name);

	// 디비에 저장된 모든 글 정보를 가져오기
	//ArrayList replyList = rdao.getfreeBoardList();
	ArrayList replyList = rdao.getReplyList();
	
	%>
	<!-- DB 데이터 가져오기 끝 -->

	<script type="text/javascript">
	
		<%String id = (String)session.getAttribute("id");%>	
	
		// 삭제버튼 기능 시작
	    function con() {
	        if (!confirm("정말 삭제하시겠습니까?")) {
	        	// 아니오 버튼 누를 시 창 닫음.
	        } else {
	            location.href="/Portpolio_camp/freecamp/deletePro.jsp?pageNum=<%=pageNum%>&num=<%=num%>";
	  	    }
	    }	
		// 삭제버튼 기능 끝
	    
		// jquery 코드 시작
		$(function() {
			
			// 글수정 모달 취소 기능 시작
			$("#cc2").hide();
			
			$("#cc1").click(function(){
				$("#cc2").click();
			});			
			// 글수정 모달 취소 기능 끝		
			
			// 댓글 수정 모달 취소 기능 시작
			$("#rc2").hide();
			
			$("#rc1").click(function(){
				$("#rc2").click();
			});				
			// 댓글 수정 모달 취소 기능 끝
			
			// 즐겨찾기 버튼 기능 시작			
			$('#like').click(function() {
				var bname = '<%=bb.getName()%>'
				var mid = '<%=(String)session.getAttribute("id")%>';
				if(mid == "null"){
					// 로그인이 안됐을 경우
					alert("로그인 후 이용해 주세요.");
				}else{
					$.ajax({
						url : "likecampAjax.jsp",
						type : "post",
						data : {mid:mid, bname:bname},
						success:function(data){
							if(data == -1){
		 						alert('이미 존재하는 즐겨찾기입니다.');
							}else{
								alert('즐겨찾기 완료 ★');
							}
						}
					});					
					
				}			
			});
			// 즐겨찾기 버튼 기능 끝			
			
			// 댓글 기능 시작
			// 댓글 눌렸을 때 수정 폼 나오기 시작
			$('a').click(function() {
				
				var mid = '<%=(String)session.getAttribute("id")%>';
				
				var rnum = $(this).attr('id');
				// alert(rnum);
				
				var con = document.getElementById(rnum + "_rereply");
				con.style.display = (con.style.display != 'none') ? "none" : "block";
				
				var reresub = document.getElementById(rnum + "_reresub");
				var recoment = document.getElementById(rnum + "_recoment");

				// 대댓글 작성 버튼 시작
				$(reresub).click(function() {
					
 					var coment = $(recoment).val();
					// alert(rnum); // 대댓글 번호
					// alert(coment); // 대댓글 내용
					// alert(mid); // 누가
					
					if(mid == "null"){
						// 로그인이 안됐을 경우
						alert("로그인 후 이용해 주세요.");
					}else{
						$.ajax({
							url : "rereplyAjax.jsp",
							type : "post",
							data : {rnum:rnum, mid:mid, coment:coment},
							success:function(data){
								
								// alert(data);
								location.reload();
							}
						});					
					};					
				});
				// 대댓글 작성 버튼 끝
				
			});
			// 댓글 눌렸을 때 수정 폼 나오기 끝

			// 댓글 작성 버튼 시작
			$('#resub').click(function() {
				var bname = '<%=bb.getName()%>'
				var mid = '<%=(String)session.getAttribute("id")%>';
				var coment = $('#coment').val();
				
				if(mid == "null"){
					// 로그인이 안됐을 경우
					alert("로그인 후 이용해 주세요.");
				}else{
					$.ajax({
						url : "replyAjax.jsp",
						type : "post",
						data : {mid:mid, bname:bname, coment:coment},
						success:function(data){
							
							$('#coment').val("");
							location.reload();
						}
					});					
				};
			});
			// 댓글 작성버튼 끝
			
			$('span').click(function() {
				var rnum = $(this).attr('id');
				
				// 댓글 수정 시작
 				$('#csubmit').click(function() {
 					var coment = $('#ccoment').val();
 					 					
					$.ajax({
						url : "replyCorrectAjax.jsp",
						type : "post",
						data : {coment:coment, rnum:rnum},
						success:function(data){
							location.reload();
						}
					});
				});
 				// 댓글 수정 끝
 				
 				// 댓글 삭제 시작
 				$('#dsubmit').click(function() { 					 					
					$.ajax({
						url : "replyDeleteAjax.jsp",
						type : "post",
						data : {rnum:rnum},
						success:function(data){
							location.reload();
						}
					});
				}); 				
 				// 댓글 삭제 끝
 				
			});			
			// 댓글 기능 끝
			
		});
		// jquery 코드 끝

	</script>
	
	<!-- 날씨 api 가져오기 시작 -->	
	<script>
		// 위도 경도 변수 설정
		var lat = <%=bb.getLat() %>;
		var lng = <%=bb.getLng()%>;

		$(function() {
			$.getJSON('https://api.openweathermap.org/data/2.5/onecall?lat='+lat+'&lon='+lng+'&appid=70931aa0594e66e3093a428260edb010&units=metric',function(result){

				// 밀리세컨을 월 일 요일로 변환해주는 함수 시작
				function convertTime(t) {
					
					var ot = new Date(t*1000);
					
					var mon = ot.getMonth() + 1;
					var date = ot.getDate();
					var day = ot.getDay();				
				
					// 숫자를 요일로 바꿔주는 switch 시작
					switch(day){
						case 1:
							day = '월';
						break;
						case 2:
							day = '화';
						break;
						case 3:
							day = '수';
						break;
						case 4:
							day = '목';
						break;
						case 5:
							day = '금';
						break;
						case 6:
							day = '토';
						break;
						case 0:
							day = '일';
						break;						
					}
					// 숫자를 요일로 바꿔주는 switch 끝

					return mon + '/' + date + '(' + day + ')';
				}
				// 밀리세컨을 월 일 요일로 변환해주는 함수 끝
					
				// 날짜 설정 시작
				var ct0 = result.daily[0].dt;
				var ct1 = result.daily[1].dt;
				var ct2 = result.daily[2].dt;
				var ct3 = result.daily[3].dt;
				
				// 날짜
				var day0 = convertTime(ct0);
				var day1 = convertTime(ct1);
				var day2 = convertTime(ct2);
				var day3 = convertTime(ct3);
				
				// 온도
				var temp0 = result.daily[0].temp.day;
				var temp1 = result.daily[1].temp.day;
				var temp2 = result.daily[2].temp.day;
				var temp3 = result.daily[3].temp.day;
				
				// 날씨 
				var weather0 = result.daily[0].weather[0].main;
				var weather1 = result.daily[1].weather[0].main;
				var weather2 = result.daily[2].weather[0].main;
				var weather3 = result.daily[3].weather[0].main;
				
				// 영어 날씨를 한글로 바꿔주는 switch 시작
				switch(weather0){
					case 'Thunderstorm':
						weather0 = '천둥 번개';
					break;
					case 'Drizzle':
						weather0 = '흐리고 비';
					break;
					case 'Rain':
						weather0 = '비';
					break;
					case 'Snow':
						weather0 = '눈';
					break;
					case 'Atmosphere':
						weather0 = '안개';
					break;
					case 'Clear':
						weather0 = '맑음';
					break;
					case 'Clouds':
						weather0 = '구름';
					break;						
					}
					
					switch(weather1){
					case 'Thunderstorm':
						weather1 = '천둥 번개';
					break;
					case 'Drizzle':
						weather1 = '흐리고 비';
					break;
					case 'Rain':
						weather1 = '비';
					break;
					case 'Snow':
						weather1 = '눈';
					break;
					case 'Atmosphere':
						weather1 = '안개';
					break;
					case 'Clear':
						weather1 = '맑음';
					break;
					case 'Clouds':
						weather1 = '구름';
					break;						
				}
					
					switch(weather2){
					case 'Thunderstorm':
						weather2 = '천둥 번개';
					break;
					case 'Drizzle':
						weather2 = '흐리고 비';
					break;
					case 'Rain':
						weather2 = '비';
					break;
					case 'Snow':
						weather2 = '눈';
					break;
					case 'Atmosphere':
						weather2 = '안개';
					break;
					case 'Clear':
						weather2 = '맑음';
					break;
					case 'Clouds':
						weather2 = '구름';
					break;						
				}
					
					switch(weather3){
					case 'Thunderstorm':
						weather3 = '천둥 번개';
					break;
					case 'Drizzle':
						weather3 = '흐리고 비';
					break;
					case 'Rain':
						weather3 = '비';
					break;
					case 'Snow':
						weather3 = '눈';
					break;
					case 'Atmosphere':
						weather3 = '안개';
					break;
					case 'Clear':
						weather3 = '맑음';
					break;
					case 'Clouds':
						weather3 = '구름';
					break;						
				}
				// 영어 날씨를 한글로 바꿔주는 switch 끝
				
				// 날씨 아이콘
				var weatherIcon0 = result.daily[0].weather[0].icon;
				var weatherUrl0 = '<img alt="'+result.daily[0].weather[0].description+'" src="http://openweathermap.org/img/wn/'+weatherIcon0+'.png">';
				
				var weatherIcon1 = result.daily[1].weather[0].icon;
				var weatherUrl1 = '<img alt="'+result.daily[1].weather[0].description+'" src="http://openweathermap.org/img/wn/'+weatherIcon1+'.png">';

				var weatherIcon2 = result.daily[2].weather[0].icon;
				var weatherUrl2 = '<img alt="'+result.daily[2].weather[0].description+'" src="http://openweathermap.org/img/wn/'+weatherIcon2+'.png">';

				var weatherIcon3 = result.daily[3].weather[0].icon;
				var weatherUrl3 = '<img alt="'+result.daily[3].weather[0].description+'" src="http://openweathermap.org/img/wn/'+weatherIcon3+'.png">';

				// 풍속
				var wind0 = result.daily[0].wind_speed;
				var wind1 = result.daily[1].wind_speed;
				var wind2 = result.daily[2].wind_speed;
				var wind3 = result.daily[3].wind_speed;
				
				// jsp 페이지에 넣는 코드
				$('#day0').append(day0);				
				$('#temp0').append(temp0);
				$('#weather0').append(weather0);
				$('#weatherUrl0').append(weatherUrl0);						
				$('#wind0').append(wind0);
				
				$('#day1').append(day1);				
				$('#temp1').append(temp1);
				$('#weather1').append(weather1);
				$('#weatherUrl1').append(weatherUrl1);						
				$('#wind1').append(wind1);
				
				$('#day2').append(day2);				
				$('#temp2').append(temp2);
				$('#weather2').append(weather2);
				$('#weatherUrl2').append(weatherUrl2);						
				$('#wind2').append(wind2);
				
				$('#day3').append(day3);				
				$('#temp3').append(temp3);
				$('#weather3').append(weather3);
				$('#weatherUrl3').append(weatherUrl3);						
				$('#wind3').append(wind3);
			});
		});
	</script>
	<!-- 날씨 api 가져오기 끝 -->	

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
		<%
		// 아이디 어드민일 때
		try {
			if(id.equals("admin")){ %>
				<div class="col-1 text-center">
					<button class="btn btn-light btn-sm" type="button"  data-bs-toggle="modal" data-bs-target="#exampleModal" >수정</button> / <button class="btn btn-light btn-sm" type="button" onclick="con()">삭제</button>
				</div>
				<div class="col-9"></div>
				<div class="col-1">
					<button type="button" class="btn btn-outline-danger" id="like">♥ 즐겨찾기</button>
				</div>			
				<div class="col-1 mt-1">
					<b>조회수 <%=bb.getReadcount() %></b>
				</div>
			<%
			
			}else{
				// 아이디 어드민이 아닐 때
				%>
				<div class="col-1 text-center"></div>
				<div class="col-9"></div>
				<div class="col-1">
					<button type="button" class="btn btn-outline-danger" id="like">♥ 즐겨찾기</button>
				</div>			
				<div class="col-1 mt-1">
					<b>조회수 <%=bb.getReadcount() %></b>
				</div>
			<%
			}
		}catch (Exception e) {
			// 로그인 안했을 때
			%>
				<div class="col-1 text-center"></div>
				<div class="col-9"></div>
				<div class="col-1">
					<button type="button" class="btn btn-outline-danger" id="like">♥ 즐겨찾기</button>
				</div>			
				<div class="col-1 mt-1">
					<b>조회수 <%=bb.getReadcount() %></b>
				</div>
			<%
		} %>
	</div>
	<!-- 조회수 및 수정 삭제 줄 끝 -->	
	
	<!-- 페이지 수정 모달 시작 -->
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-xl">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">무료캠핑장 - 글수정</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
		  <!-- 게시판 글 수정 폼 작성 시작 -->
		  <form action="/Portpolio_camp/freecamp/fileupdateUploadPro.jsp" method="post" enctype="multipart/form-data">
		  	<input type="hidden" name="num" value="<%=bb.getNum()%>">
		  	<input type="hidden" name="pageNum" value="<%=pageNum%>">
		  	
	      	  <!-- 글수정 본문 시작 -->
		      <div class="modal-body mx-5">
   					<div class="row text-center">
			       		<div class="col-4"></div>
			       		<div class="col-4"><h4>위치</h4></div>
			       		<div class="col-4"></div>
					</div>
		      
			       <div class="form-floating mb-3">
					  <input type="text" class="form-control" id="floatingInput" placeholder="캠핑지명" name="name" value="<%=bb.getName()%>">
					  <label for="floatingInput">캠핑지명</label>
					</div>
					
			       	<!-- 우편번호 시작 -->
						<input type="text" id="sample6_address" placeholder="주소" name="address" class="form-control"  value="<%=bb.getAddress()%>"><br>
						<input type="button" class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
						
						<input type="hidden" id="sample6_postcode" placeholder="우편번호">
						<input type="hidden" id="sample6_detailAddress" placeholder="상세주소">
						<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
					<!-- 우편번호 끝 -->
					
					<!-- 위도 경도 시작 -->
					<div class="row my-3">
						<div class="col">
							<input type="text" class="form-control" id="floatingInput" placeholder="위도" name="lat"  value="<%=bb.getLat()%>">
						</div>
						<div class="col">
							<input type="text" class="form-control" id="floatingInput" placeholder="경도" name="lng"  value="<%=bb.getLng()%>">
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
			       	<select class="form-select" aria-label="Default select example" name="level" >
			       	<%if(bb.getLevel().equals("상")){ %>
					  <option value="상" selected>상</option>
					  <option value="중">중</option>
					  <option value="하">하</option>
			       	<%}else if(bb.getLevel().equals("중")){ %>
					  <option value="상">상</option>
					  <option value="중" selected>중</option>
					  <option value="하">하</option>
			       	<%}else{ %>
					  <option value="상">상</option>
					  <option value="중">중</option>
					  <option value="하" selected>하</option>
			       	<%} %>
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
			       		 <%if(bb.getToilet().equals("y")){ %>
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
						<%}else{ %>
			       		 <div class="form-check">
						  <input class="form-check-input" type="radio" name="toilet" id="exampleRadios1" value="y">
						  <label class="form-check-label" for="exampleRadios1">
						    있음
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="toilet" id="exampleRadios2" value="n" checked>
						  <label class="form-check-label" for="exampleRadios2">
						    없음
						  </label>
						</div>						
						<%} %>
					</div>
						
			       	<div class="col m-2">
			       		<h5>주차장</h5>
			       		 <%if(bb.getPark().equals("y")){ %>
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
						<%}else{ %>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="park" id="exampleRadios1" value="y">
						  <label class="form-check-label" for="exampleRadios1">
						    있음
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="park" id="exampleRadios2" value="n" checked>
						  <label class="form-check-label" for="exampleRadios2">
						    없음
						  </label>
						</div>
						<%} %>
					</div>
			       	<div class="col m-2">
			       		<h5>물놀이</h5>
			       		<%if(bb.getWater().equals("y")){ %>
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
						<%}else{ %>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="water" id="exampleRadios1" value="y">
						  <label class="form-check-label" for="exampleRadios1">
						    있음
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="water" id="exampleRadios2" value="n" checked>
						  <label class="form-check-label" for="exampleRadios2">
						    없음
						  </label>
						</div>
						<%} %>
					</div>
			       	<div class="col m-2">
			       		<h5>낚시</h5>
			       		<%if(bb.getFishing().equals("y")){ %>
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
						<%}else{ %>
			       		 <div class="form-check">
						  <input class="form-check-input" type="radio" name="fishing" id="exampleRadios1" value="y">
						  <label class="form-check-label" for="exampleRadios1">
						    있음
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="radio" name="fishing" id="exampleRadios2" value="n" checked>
						  <label class="form-check-label" for="exampleRadios2">
						    없음
						  </label>
						</div>
						<%} %>						
					</div>																			
			       </div>
			      	<!-- row1 끝 -->
			      	<!-- row2 시작 -->
			      	<div class="row text-center">
			      		<div class="col-1">
			      			<h5>필드</h5>
			      		</div>
			      		<div class="col-5">
			      			<%if(bb.getField().equals("바다")){ %>
			      			<select class="form-select" aria-label="Default select example" name="field">
							  <option value="바다" selected>바다</option>
							  <option value="산" >산</option>
							  <option value="계곡">계곡</option>
							  <option value="기타">기타</option>
							</select>
							<%}else if(bb.getField().equals("산")){ %>
			      			<select class="form-select" aria-label="Default select example" name="field">
							  <option value="바다">바다</option>
							  <option value="산" selected>산</option>
							  <option value="계곡">계곡</option>
							  <option value="기타">기타</option>
							</select>
							<%}else if(bb.getField().equals("계곡")){ %>
			      			<select class="form-select" aria-label="Default select example" name="field">
							  <option value="바다">바다</option>
							  <option value="산">산</option>
							  <option value="계곡" selected>계곡</option>
							  <option value="기타">기타</option>
							</select>												
							<%}else{ %>					
			      			<select class="form-select" aria-label="Default select example" name="field">
							  <option value="바다">바다</option>
							  <option value="산">산</option>
							  <option value="계곡">계곡</option>
							  <option value="기타" selected>기타</option>
							</select>												
							<%} %>							
			      		</div>
			      		<div class="col-1">
			      			<h5>바닥</h5>
			      		</div>
			      		<div class="col-5">
			      		
			      			<%if(bb.getLand().equals("흙")){ %>			      		
			      			<select class="form-select" aria-label="Default select example" name="land">
							  <option value="흙" selected>흙</option>
							  <option value="진흙">진흙</option>
							  <option value="잔디">잔디</option>
							  <option value="모래">모래</option>
							  <option value="기타">기타</option>							  
							</select>
							<%}else if(bb.getLand().equals("진흙")){ %>
			      			<select class="form-select" aria-label="Default select example" name="land">
							  <option value="흙">흙</option>
							  <option value="진흙" selected>진흙</option>
							  <option value="잔디">잔디</option>
							  <option value="모래">모래</option>
							  <option value="기타">기타</option>							  
							</select>							
							<%}else if(bb.getLand().equals("잔디")){ %>
			      			<select class="form-select" aria-label="Default select example" name="land">
							  <option value="흙">흙</option>
							  <option value="진흙">진흙</option>
							  <option value="잔디" selected>잔디</option>
							  <option value="모래">모래</option>
							  <option value="기타">기타</option>							  
							</select>							
							<%}else if(bb.getLand().equals("모래")){ %>
			      			<select class="form-select" aria-label="Default select example" name="land">
							  <option value="흙">흙</option>
							  <option value="진흙">진흙</option>
							  <option value="잔디">잔디</option>
							  <option value="모래" selected>모래</option>
							  <option value="기타">기타</option>							  
							</select>	
							<%}else{ %>					
			      			<select class="form-select" aria-label="Default select example" name="land">
							  <option value="흙">흙</option>
							  <option value="진흙">진흙</option>
							  <option value="잔디">잔디</option>
							  <option value="모래">모래</option>
							  <option value="기타" selected>기타</option>							  
							</select>
							<%} %>
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
			  <!-- 글수정 본문 끝 -->
	      
		      <div class="modal-footer">
		      	<button type="submit" class="btn btn-primary">수정</button>
			  	<button type="reset" class="btn btn-secondary" data-bs-dismiss="modal" id="cc1">취소</button>
			  	<button type="reset" id="cc2">취소2</button>
		      </div>
	      </form>
	      <!-- 게시판 글수정 폼 작성 끝 -->
	      
	    </div>
	  </div>
	</div>
	
	<!-- 페이지 수정 모달 끝 -->
	
	<hr>
	
	<!-- 위치 및 난이도 줄 시작 -->
	<div class="row">
		<!-- 위치 칼럼 시작 -->
		<div class="col-4 px-3">
			<div class="row">
				<div class="px-4 m-2"><%=bb.getAddress() %></div>
			</div>
			<div class="row m-1">
				<div class="col-4"><span class="badge rounded-pill bg-primary">위도</span> <%=bb.getLng() %></div>
				<div class="col-8"><span class="badge rounded-pill bg-danger">경도</span> <%=bb.getLat() %> </div>
			</div>
		</div>
		<!-- 위치 칼럼 끝 -->
		
		<!-- 난이도 칼럼 시작 -->
		<div class="col-6 text-center">
		</div>
		<div class="col-2">
			<div class="row text-center px-4 m-2">
				<span class="badge bg-light text-dark p-3">
					캠핑지 난이도
						<br>
					 <%if(bb.getLevel().equals("상")){ %>
						★★★
			     	 <%}else if(bb.getLevel().equals("중")){ %>
			       		★★
			      	 <%}else{ %>
			     		★
			      	 <%} %>
				 </span>
			</div>
		</div>
		<!-- 난이도 칼럼 끝 -->
		
	</div>
	<!-- 위치 및 난이도 줄 끝 -->
	
	<!-- 알림글 제목 줄 시작 -->
	<div class="row">
		<div class="col-4"></div>
		<div class="col-4 pt-4 m-2 text-center">
			<h2>📢 알립니다 ❗︎</h2>
		</div>
		<div class="col-4"></div>		
	</div>
	<!-- 알림글 제목 줄 끝 -->	

	<!-- 알림글 내용 시작 -->		
	<div class="row text-center">
		<div class="col-2"></div>
		<div class="col-8 p-4 m-2 text-center">
			<h4>자연을 빌려 쓴 댓가로 해당 장소를 청소하는 미덕을 가집시다.<br>
			바닥에 불피우는 행위 금지!, 쓰레기는 집으로!, 머문 자리는 아니온 듯!</h4>
		</div>
		<div class="col-2"></div>	
	</div>
	<!-- 알림글 내용 끝 -->	
	
	<!-- 주변환경 줄 시작 -->
	<div class="row text-center mt-5 mx-3">
	
	<div class="card mb-3">
		<div class="card-header">
	    	<%=bb.getName() %> 주변 환경
	  	</div>
	  <div class="card-body">
	    <blockquote class="blockquote mb-0">
	      <div class="row">
		      <div class="col">
	      			<b>필드</b>
		      		<br>
		      		<%if(bb.getField().equals("계곡")){ %>
		      			<img alt="" src="../img/camp/계곡.png" width="80" height="80"> <br>
		      		<%}else if(bb.getField().equals("산")){ %>
		      			<img alt="" src="../img/camp/산.png" width="80" height="80"> <br>
		      		<%}else if(bb.getField().equals("바다")){ %>
		      			<img alt="" src="../img/camp/바다.png" width="80" height="80"> <br>		      		
		      		<%}else{ %>
		      			<img alt="" src="../img/camp/기타.png" width="80" height="80"> <br>		      		
		      		<%} %>
					<%=bb.getField() %>
				</div>
				<div class="col">
					<b>바닥</b>
					<br>
					<%if(bb.getLand().equals("모래")){ %>
		      			<img alt="" src="../img/camp/모래.png" width="80" height="80"> <br>					
					<%}else if(bb.getLand().equals("잔디")){ %>
		      			<img alt="" src="../img/camp/잔디.png" width="80" height="80"> <br>					
					<%}else if(bb.getLand().equals("진흙")){ %>
		      			<img alt="" src="../img/camp/진흙.png" width="80" height="80"> <br>					
					<%}else if(bb.getLand().equals("흙")){ %>
		      			<img alt="" src="../img/camp/흙.png" width="80" height="80"> <br>					
					<%}else{ %>
		      			<img alt="" src="../img/camp/기타.png" width="80" height="80"> <br>										
					<%} %>
					<%=bb.getLand() %>
					
				</div>
				<div class="col">
					<b>화장실</b>
					<br>
					<%if(bb.getToilet().equals("y")){%>
		      			<img alt="" src="../img/camp/화장실있음.png" width="80" height="80"> <br>										
						있음
						<%}else{%>
		      			<img alt="" src="../img/camp/화장실없음.png" width="80" height="80"> <br>										
						없음
					<%} %>
				</div>
				<div class="col">
					<b>주차장</b>
					<br>
					<%if(bb.getPark().equals("y")){%>
		      			<img alt="" src="../img/camp/주차가능.png" width="80" height="80"> <br>															
						있음
						<%}else{%>
		      			<img alt="" src="../img/camp/주차금지.png" width="80" height="80"> <br>																					
						없음
					<%} %>
				</div>
				<div class="col">
					<b>물놀이</b>
					<br>
					<%if(bb.getWater().equals("y")){%>
		      			<img alt="" src="../img/camp/물놀이가능.png" width="80" height="80"> <br>																				
						가능
					<%}else{%>
		      			<img alt="" src="../img/camp/물놀이금지.png" width="80" height="80"> <br>																									
						불가능
					<%} %>
				</div>
				<div class="col">
					<b>낚시</b>
					<br>
				<%if(bb.getFishing().equals("y")){%>
		      			<img alt="" src="../img/camp/낚시가능.png" width="80" height="80"> <br>																								
						가능
					<%}else{%>
		      			<img alt="" src="../img/camp/낚시금지.png" width="80" height="80"> <br>																													
						불가능
				<%} %>
			 </div>
	      </div>
	    </blockquote>
	  </div>
	</div>
	</div>
	<!-- 주변환경 줄 끝 -->	
	
	<!-- 갤러리 제목 시작 -->			
	<div class="row">
		<div class="col-4"></div>
		<div class="col-4 pt-4 m-2 text-center">
			<h4>갤러리</h4>
		</div>
	</div>
	<!-- 갤러리 제목 끝 -->			
	
	<!-- 갤러리 내용 시작 -->				
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8 p-4 m-2 text-center">
		<%
		try{
			 %>
		<%if(bb.getFilename().equals("null")){ %>

		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="https://allways.smotor.com/wp-content/uploads/2020/04/0429_%EC%BA%A0%ED%95%91_12.jpg" class="d-block w-100" alt="..." width="300" height="400">
		    </div>
		</div>		
		</div>
		
		<%}else if(bb.getFilename2().equals("null")){ %>
		
		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="300" height="400">
		    </div>
		</div>		
		</div>
		
		<%}else if(bb.getFilename3().equals("null")){ %>
		
		<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="300" height="400">
		    </div>
		    <div class="carousel-item">
		      <img src="/Portpolio_camp/upload/<%=bb.getFilename2() %>" class="d-block w-100" alt="..." width="300" height="400">
		    </div>
			<div class="carousel-item">
		      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="300" height="400">
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
		      <img src="/Portpolio_camp/upload/<%=bb.getFilename() %>" class="d-block w-100" alt="..." width="300" height="400">
		    </div>
		    <div class="carousel-item">
		      <img src="/Portpolio_camp/upload/<%=bb.getFilename2() %>" class="d-block w-100" alt="..." width="300" height="400">
		    </div>
		    <div class="carousel-item">
		      <img src="/Portpolio_camp/upload/<%=bb.getFilename3() %>" class="d-block w-100" alt="..." width="300" height="400">
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
		<%
		}catch(Exception e){
			
		}
		 %>
		<div class="col-2"></div>
	</div>
	<!-- 갤러리 내용 끝 -->			

	<!-- 날씨 제목 시작 -->				
	<div class="row">
		<div class="col-4"></div>
		<div class="col-4 pt-4 m-2 text-center">
			<h4>날씨</h4>
		</div>
	</div>
	<!-- 날씨 제목 끝 -->				

	<!-- 날씨 내용 시작 -->					
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8 p-4 m-2 text-center">
			<div class="card-group">
			
			  <div class="card">
			    <span id="weatherUrl0"></span>
			    <div class="card-body">
			      <h5 class="card-title" id="day0"></h5>
			      <p class="card-text">
					<span id="weather0"> 날씨 : </span> <br>	
					<span id="temp0"> 온도 : </span> <br>
					<span id="wind0"> 풍속 : </span>
				  </p>
			    </div>
			  </div>
			  
			  <div class="card">
			    <span id="weatherUrl1"></span>
			    <div class="card-body">
			      <h5 class="card-title" id="day1"></h5>
			      <p class="card-text">
					<span id="weather1"> 날씨 : </span> <br>	
					<span id="temp1"> 온도 : </span> <br>
					<span id="wind1"> 풍속 : </span>
				  </p>
			    </div>
			  </div>
			  
			  <div class="card">
			    <span id="weatherUrl2"></span>
			    <div class="card-body">
			      <h5 class="card-title" id="day2"></h5>
			      <p class="card-text">
					<span id="weather2"> 날씨 : </span> <br>	
					<span id="temp2"> 온도 : </span> <br>
					<span id="wind2"> 풍속 : </span>
				  </p>
			    </div>
			  </div>
	
			  <div class="card">
			    <span id="weatherUrl3"></span>
			    <div class="card-body">
			      <h5 class="card-title" id="day3"></h5>
			      <p class="card-text">
					<span id="weather3"> 날씨 : </span> <br>	
					<span id="temp3"> 온도 : </span> <br>
					<span id="wind3"> 풍속 : </span>
				  </p>
			    </div>
			  </div>
			</div>
			<div class="col-2"></div>
		</div>
	</div>	
	<!-- 날씨 내용 끝 -->					
	
	<!-- 댓글 제목 시작 -->

	<div class="row">
		<div class="col-2"></div>
		<div class="col-8">
			<h4>댓글<%=cnt %></h4>
		</div>
		<div class="col-2"></div>
	</div>

	<div class="row">
		<div class="col-2"></div>
		<div class="col-8">
	<hr>
		</div>
		<div class="col-2"></div>
	</div>	
	<!-- 댓글 제목 끝 -->

	<!-- 댓글 리스트 시작 -->							
	<div class="row">
	<div class="col-2"></div>
	<div class="col-8">
		<table class="table">
		  <tbody>
			<%for(int i = 0;i < replyList.size(); i++){
				ReplyBean rb = (ReplyBean)replyList.get(i);
			%>
		    <tr>
		    
		      <%if(bb.getName().equals(rb.getBname())){ %>
		      
		      <th scope="row"><%=rb.getMid() %></th>
		      <td class="col-8">
			    			<%
					int wid = 0;
					if(rb.getRe_lev() > 0){
					wid = 10 * rb.getRe_lev(); 
					%>
					  <img alt="" src="level.gif" height="15" width="<%=wid%>">
		 			  ┕
					<%
					}
					%>
			    
		      	<a style="text-decoration-line: none; color: black; cursor:pointer;" id="<%=rb.getRnum()%>"><%=rb.getComent() %> </a>
		      	<br>

		      	<!-- 댓글 클릭했을 때 뜨는 대댓글 기능 시작 -->
		      	<div style="display: none;" id="<%=rb.getRnum()%>_rereply">
			      	<div class="form-floating mt-3">
					  <textarea class="form-control" placeholder="Leave a comment here" id="<%=rb.getRnum()%>_recoment" name="recoment"></textarea>
					  <label for="floatingTextarea">Comments</label>				  
					</div>
					<button type="button" class="btn btn-success btn-sm mt-2" id="<%=rb.getRnum()%>_reresub">등록하기</button>
				</div>
		      	<!-- 댓글 클릭했을 때 뜨는 대댓글 기능 끝 -->
		      	
		      </td>
		      <%if(rb.getMid().equals(id)){ %>
		      	<td class="col">
		      	<span class="badge bg-light text-dark" data-bs-toggle="modal" data-bs-target="#exampleModal2" style="cursor:pointer;" id="<%=rb.getRnum()%>">수정하기</span> / <span class="badge bg-light text-dark" style="cursor:pointer;"  data-bs-toggle="modal" data-bs-target="#exampleModal3" id="<%=rb.getRnum()%>">삭제하기</span>
		      	</td>
		      <%}else{ %>
		      	<td class="col"></td>
		      <%} %>
		      <%} // if %>
		    </tr>
			<%} // for %>
		    
		  </tbody>
		  
		</table>
	</div>
	<div class="col-2"></div>
	</div>					
	<!-- 댓글 리스트 끝 -->							
	
	
	<!-- 댓글 작성 시작 -->							
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8 p-4 m-2 text-center">
			<div class="form-floating">
			  <textarea class="form-control" placeholder="Leave a comment here" id="coment" name="coment" style="height: 100px"></textarea>
			  <label for="floatingTextarea2">Comments</label>
			</div>
				<button type="button" class="btn btn-success btn-sm mt-2" id="resub">등록하기</button>
		</div>
		<div class="col-2"></div>
	</div>
	<!-- 댓글 작성 끝 -->
							
	<!-- 댓글 수정 시작 -->
		<!-- Modal -->
		<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">댓글 - 수정하기</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
				<div class="form-floating">
				  <textarea class="form-control" placeholder="Leave a comment here" id="ccoment"></textarea>
				  <label for="floatingTextarea">Comments</label>
				</div>
		      </div>
		      <div class="modal-footer">
		      	<button type="submit" class="btn btn-primary" id="csubmit">수정</button>
			  	<button type="reset" class="btn btn-secondary" data-bs-dismiss="modal" id="rc1">취소</button>
			  	<button type="reset" id="rc2">취소2</button>
		        
		      </div>
		    </div>
		  </div>
		</div>
	<!-- 댓글 수정 끝 -->

	<!-- 댓글 삭제 시작 -->

	<!-- Modal -->
	<div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">댓글 - 삭제하기</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        	정말로 댓글을 삭제 하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" id="dsubmit">삭제</button>	      
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>	
	<!-- 댓글 삭제 끝 -->

	</div>
	<!-- container 끝 -->
	</div>	
	<hr>
 	<!-- 목록으로 row 시작 -->
	<div class="row text-center">
		<div><button type="button" class="btn btn-secondary" onclick="location.href='/Portpolio_camp/freecamp/freeForm.jsp'">목록으로</button></div>
	</div>
 	<!-- 목록으로 row 끝 -->
</body>
</html>