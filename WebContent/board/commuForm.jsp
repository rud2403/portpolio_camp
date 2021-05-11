<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>캠핑 장터</title>
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
<div class="container-lg">	

<!-- row 시작 -->
<div class="row">
	<h3 class="text-center mt-5">캠핑 장터</h3>
</div>

<div class="row mt-5">

<!-- table 시작 -->
	<table class="table pl-3 pr-3">
	  <thead>
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col">구분</th>	      
	      <th scope="col">제목</th>
	      <th scope="col">글쓴이</th>
	      <th scope="col">작성일</th>
	      <th scope="col">조회수</th>
	    </tr>
	  </thead>
	  <tbody>
	    <tr>
	      <th scope="row">1</th>
	      <td>Mark</td>
	      <td>Otto</td>
	      <td>@mdo</td>
	      <td>@mdo</td>
	      <td>@fat</td>	      
	      
	    </tr>
	    <tr>
	      <th scope="row">2</th>
	      <td>Jacob</td>
	      <td>Thornton</td>
	      <td>@fat</td>
	      <td>@fat</td>
	      <td>@fat</td>	      
	      
	    </tr>
	    <tr>
	      <th scope="row">3</th>
	      <td>Larry the Bird</td>
	      <td>@twitter</td>
	      <td>@fat</td>
	      <td>@fat</td>
	      <td>@fat</td>	      
	      	      	      	      
	    </tr>
	    <tr>
	      <th scope="row">4</th>
	      <td>Larry the Bird</td>
	      <td>@twitter</td>
	      <td>@fat</td>
	      <td>@fat</td>	 
	      <td>@fat</td>	      
	           
	    </tr>	    
	  </tbody>
	</table>
<!-- table 끝 -->

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