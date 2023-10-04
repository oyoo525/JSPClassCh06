<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jspstudy.ch06.dao.BoardDao"%>
<%@page import="com.jspstudy.ch06.vo.Board"%>
<%
	// 요청 파라미터 먼저 읽기
	String no = request.getParameter("no");
	String pass = request.getParameter("pass");

	// 비밀번호가 맞는지  확인
	BoardDao dao = new BoardDao();
	boolean isPassCheck = dao.isPassCheck(Integer.parseInt(no), pass);
	
	// 비밀번호가 맞으면 no에 해당하는 게시글을 DB에서 읽어와서 화면에 출력
	if (isPassCheck) {
		Board b = dao.getBoard(Integer.parseInt(no));
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../bootstrap/bootstrap.min.css" rel="stylesheet">
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/formcheck.js"></script> <!-- form 유효성 검사 -->
</head>
<body>
	<div class="container">
		<!-- Header -->
		<%@ include file="../pages/header.jsp" %>
		
		<!-- Content -->
		<div class="row" id="global-content">
			<div class="col">
				<div class="row text-center my-5">
					<div class="col">
						<h2 class="fw-bold fs-3">게시 글 수정하기</h2>
					</div>
				</div>
				<form name="updateForm" action="updateProcess.jsp" id="updateForm" class="row g-3" method="post">
					<input type="hidden" name="no" value="<%= b.getNo() %>">
					<div class="col-4 offset-md-2">
						<label class="form-label" for="writer">글쓴이</label>
						<input type="text" class="form-control" name="writer" id="writer"
							placeholder="작성자를 입력해 주세요" value="<%= b.getWriter() %>">
					</div>
					<div class="col-4">
						<label class="form-label" for="pass">비밀번호</label>
						<input type="password" class="form-control" name="pass" id="pass">
					</div>
					<div class="col-8 offset-md-2">
						<label class="form-label" for="title">제 목</label>
						<input type="text" class="form-control" name="title" id="title" value="<%= b.getTitle() %>">
					</div>
					<div class="col-8 offset-md-2">
						<label class="form-label" for="content">내 용</label>
						<textarea class="form-control" name="content" id="content" rows="10"><%= b.getContent() %></textarea>
					</div>
					<div class="col-8 offset-md-2 text-center mt-5">
						<input type="submit" value="등록하기" class="btn btn-primary">&nbsp;&nbsp;
						<input type="button" value="목록보기" class="btn btn-primary" onclick="location.href='boardList.jsp'">
					</div>
				</form>
			</div>
		</div>
		
		<!-- Footer -->
		<%@ include file="../pages/footer.jsp" %>
		
		<script src="../bootstrap/bootstrap.bundle.min.js"></script>
	</div>
</body>
<% } else { %>
	<script>
			alert("비밀번호가 틀립니다");
			history.back();
	</script>
<% } %>
</html>