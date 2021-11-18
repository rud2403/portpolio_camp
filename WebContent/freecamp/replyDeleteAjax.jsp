<%@page import="com.camp.reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int rnum = Integer.parseInt(request.getParameter("rnum"));
%>
<jsp:useBean id="rb" class="com.camp.reply.ReplyBean"></jsp:useBean>
<jsp:setProperty property="*" name="rb"/>
<%
ReplyDAO rdao = new ReplyDAO();
 //해당 글 정보를 사용해서 회원 정보 삭제
 int check = rdao.deleteReply(rb);
%><%=check%>