<%@page import="com.camp.reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String mid = request.getParameter("mid");
String bname = request.getParameter("bname");
String coment = request.getParameter("coment");
%>
<jsp:useBean id="rb" class="com.camp.reply.ReplyBean"></jsp:useBean>
<jsp:setProperty property="*" name="rb"/>
<%
ReplyDAO rdao = new ReplyDAO();
// 해당 글 정보를 사용해서 회원 정보 삭제
int check = rdao.insertReply(rb);		
%><%=check %>