<%@page import="com.camp.member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String pw = request.getParameter("pw");
String pw2 = request.getParameter("pw2");
System.out.println("전달된 비밀번호 : " +pw);
System.out.println("전달된 비밀번호 확인 : " +pw2);
int check = -1;
if(pw.equals(pw2)){
	check = 0;
}else{
	check = -1;
}
%><%=check %>