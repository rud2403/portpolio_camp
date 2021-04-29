<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CampMap</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>

<style>
#menu { text-decoration-line: none; color: black;}

</style>



        
</head>
<body class="pb-1" style="background-color: #F2F2F2;">

<!-- navbar 시작 -->
 <jsp:include page="/navbar/navbar.jsp" />
 
<!-- navbar 끝 -->


<!-- container 시작 -->
<div class="container pt-3 mb-5 "> 

<!-- 메인 텍스트 시작 -->
  <div class="col-md-12 text-center p-5 row" id="con">
   <a href="main.jsp" id="menu">
    <h1>CampMap</h1>
   </a>
  </div>
<!-- 메인 텍스트 끝 -->  
  
<!-- 이미지 슬라이드 시작 -->  
<div class="row">
 <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
  <ol class="carousel-indicators">
    <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active"></li>
    <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"></li>
    <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
  
    <div class="carousel-item active">
      <img src="https://allways.smotor.com/wp-content/uploads/2020/04/0429_%EC%BA%A0%ED%95%91_12.jpg" class="d-block w-100 rounded" alt="..." width="300" height="500">
      <div class="carousel-caption d-none d-md-block">
      	<h1>추천 캠핑장 </h1>
        <h5>양산 @@계곡</h5>
        <p>거리 00km / 난이도 ㅁㅁ</p>
      </div>
    </div>
    
    <div class="carousel-item">
      <img src="http://img.etoday.co.kr/pto_db/2019/10/600/20191001173327_1372185_787_590.jpg" class="d-block w-100 rounded" alt="..." width="300" height="500">
      <div class="carousel-caption d-none d-md-block">
      	<h1>추천 캠핑장2 </h1>
        <h5>Second slide label</h5>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      </div>
    </div>
    
    <div class="carousel-item">
      <img src="https://img.hankyung.com/photo/202007/AA.23325586.1.jpg" class="d-block w-100 rounded" alt="..." onclick="location.href='insertForm.jsp'"  style='cursor:pointer;'  width="300" height="500">
      <div class="carousel-caption d-none d-md-block">
        <h5>Third slide label</h5>
        <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
      </div>
    </div>
    
  </div>
  <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </a>
 </div>
</div>
<!-- 이미지 슬라이드 끝 -->  
  
<!-- 테이블 테스트 시작 -->
<div class="row">
 <table class="table my-5">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">First</th>
      <th scope="col">Last</th>
      <th scope="col">Handle</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>Mark</td>
      <td>Otto</td>
      <td>@mdo</td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td>Jacob</td>
      <td>Thornton</td>
      <td>@fat</td>
    </tr>
    <tr>
      <th scope="row">3</th>
      <td colspan="2">Larry the Bird</td>
      <td>@twitter</td>
    </tr>
  </tbody>
 </table>
</div>
<!-- 테이블 테스트 끝 -->
  
</div>
<!-- container 끝 -->

<!-- footer 시작 -->
<div class="row">
 <jsp:include page="/footer/footer.jsp" />
</div>
<!-- footer 끝 -->

</body>
</html>