<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jspstudy.ch06.vo.Board"%>
<%@page import="com.jspstudy.ch06.dao.BoardDao"%>

<%
	// post로 들어오는 데이터의 문자셋 처리
	request.setCharacterEncoding("utf-8");
	
	// 게시글 쓰기에서 들어온 요청을 처리하는 모듈
	String writer = request.getParameter("writer");
	String pass = request.getParameter("pass");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Board b = new Board();
	b.setWriter(writer);
	b.setPass(pass);
	b.setTitle(title);
	b.setContent(content);
	
	// BoardDao를 이용해서 DB에 게시글 저장
	BoardDao dao = new BoardDao();
	dao.insertBoard(b);
	
	response.sendRedirect("boardList.jsp");
	
	
%>