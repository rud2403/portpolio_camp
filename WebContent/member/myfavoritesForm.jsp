<%@page import="com.camp.like.LikeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.camp.like.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>캠핑장 즐겨찾기</title>
	<!-- 부트스트랩 시작 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
	<!-- 부트스트랩 끝 -->

	<!-- jquery 준비 시작 -->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<!-- jquery 준비 끝 -->
	
	<!-- id 값 받아오기 시작 -->
		<%
		String mid = (String)session.getAttribute("id");
		%>
	<jsp:useBean id="lb" class="com.camp.like.LikeBean"></jsp:useBean>
	<jsp:setProperty property="*" name="lb"/>	
	<!-- id 값 받아오기 끝 -->
	

<!-- DB글 정보 연동 시작 -->
	<%
	System.out.println("전달 정보 : " + lb);
	
	// 디비에 저장된 글의 개수를 알기
	// BoardDAO 객체 생성
	LikeDAO ldao = new LikeDAO();
	
	// 디비에 있는 글의 수를 계산하는 메소드 생성 -> 호출
	// getBoardCount();
	int cnt = ldao.getLikeCount();
	
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
	
	
 	ArrayList boardList = ldao.getLikeList(startRow, pageSize, mid);
	
	
	%>
	<!-- DB글 정보 연동 끝 -->
	
</head>
<body>
<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
 
<!-- navbar 끝 -->

<!-- container 시작 -->	
<div class="container-fluid">	
<div class="row">

	<!-- 왼쪽 col 시작 -->
	<div class="col-2 text-center mt-5"  style=" border-right: 1px solid black; height: 600px;">
		<!-- 페이지 목록 시작 -->
		<jsp:include page="/pagelist/pagelistForm.jsp" />
		<!-- 페이지 목록 끝 -->
	</div>
	<!-- 왼쪽 col 끝 -->

	<!-- 오른쪽 col 시작 -->	
	<div class="col-10 text-center mt-5">
		<div class="row">
			<h3>캠핑장 즐겨찾기</h3>
			즐겨찾기 총 <%=cnt %>개
		</div>
		<div class="row">

	  	<%for(int i = 0;i < boardList.size(); i++){ 
			LikeBean lbn = (LikeBean)boardList.get(i);
		%>		
		
			<div class="card m-3" style="width: 18rem; cursor:pointer;" onclick="location.href='/Portpolio_camp/freecamp/content.jsp?num=2'">
			  <img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="card-img-top" alt="...">
			  <div class="card-body">
			    <h5 class="card-title"><%=lbn.getBname() %></h5>
			    <p class="card-text">부산</p>
			    <a href="/Portpolio_camp/main/main.jsp" class="btn btn-danger btn-sm">삭제하기</a>
			  </div>
			</div>

		<%} %>			
												
		</div>
	</div>
	<!-- 오른쪽 col 시작 -->
	
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