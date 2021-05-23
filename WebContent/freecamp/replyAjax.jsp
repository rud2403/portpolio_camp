<%@page import="com.camp.reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String mid = request.getParameter("mid");
System.out.println("전달된 세션 아이디 : " + mid);
String bname = request.getParameter("bname");
System.out.println("전달된 캠핑지 이름 : " + bname); 
String coment = request.getParameter("coment");
System.out.println("전달된 캠핑지 이름 : " + bname);
%>
<jsp:useBean id="rb" class="com.camp.reply.ReplyBean"></jsp:useBean>
<jsp:setProperty property="*" name="rb"/>
<%
System.out.println("전달 정보 : " + rb);
ReplyDAO rdao = new ReplyDAO();
// 해당 글 정보를 사용해서 회원 정보 삭제
int check = rdao.insertReply(rb);		
%><%=check %>