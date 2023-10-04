<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jspstudy.ch06.vo.Board"%>
<%@page import="com.jspstudy.ch06.dao.BoardDao"%>

<%
	// post로 들어오는 데이터의 문자셋 처리
	request.setCharacterEncoding("utf-8");

	// 비밀번호 체크
	String no = request.getParameter("no");
	String pass = request.getParameter("pass");
	
	BoardDao dao = new BoardDao();
	boolean isPass = dao.isPassCheck(Integer.parseInt(no), pass);
	
	// 비밀번호가 틀리다면 - 자바스크립트로 응답
	if(!isPass) {
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("	alert('비밀번호가 틀립니다.');");
		sb.append("	history.back();");
		sb.append("</script>");
		
		out.println(sb.toString());
		System.out.println("비밀번호가 틀림");
		return;
	}
	
	// 게시글 쓰기에서 들어온 요청을 처리하는 모듈
	String writer = request.getParameter("writer");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Board b = new Board();
	b.setNo(Integer.parseInt(no));
	b.setWriter(writer);
	b.setPass(pass);
	b.setTitle(title);
	b.setContent(content);
	
	// BoardDao를 이용해서 DB에 기존 게시글 수정
	dao.updateBoard(b);
	
	response.sendRedirect("boardList.jsp");
	
	
%>