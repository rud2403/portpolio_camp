<%@page import="com.camp.like.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String mid = request.getParameter("mid");
System.out.println("전달된 세션 아이디 : " + mid);
String bname = request.getParameter("bname");
System.out.println("전달된 캠핑지 이름 : " + bname);    
%>
<jsp:useBean id="lb" class="com.camp.like.LikeBean"></jsp:useBean>
<jsp:setProperty property="*" name="lb"/>
<%
System.out.println("전달 정보 : " + lb);
LikeDAO ldao = new LikeDAO();
// 해당 글 정보를 사용해서 회원 정보 삭제
int check = ldao.insertLike(lb);		
%><%=check %>
