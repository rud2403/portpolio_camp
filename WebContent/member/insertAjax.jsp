<%@page import="com.camp.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
System.out.println("전달된 값 : " +id);
String pw = request.getParameter("pw");
System.out.println("전달된 값 : " +pw);
String name = request.getParameter("name");
System.out.println("전달된 값 : " +name);
String phone = request.getParameter("phone");
System.out.println("전달된 값 : " +phone);
String email = request.getParameter("email");
System.out.println("전달된 값 : " +email);
// 회원가입 정보를 전달 받아서 저장 -> DB저장 (회원)
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mb" class="com.camp.member.MemberBean" />
<jsp:setProperty property="*" name="mb"/>
<%
System.out.println("회원 정보 : " + mb.toString());
// DB에 대한 처리를 하는 객체를 생성
MemberDAO bdao = new MemberDAO();
// 회원가입 기능 사용
int check = bdao.insertMember(mb);
%><%=check%>