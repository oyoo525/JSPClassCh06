<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch06.dao.*, com.jspstudy.ch06.vo.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 
	boardDetail.jsp가 클라이언트 요청을 받아서 원하는 걸 해결함
	1. DB에서 게시글 하나를 읽어오기
	2. 출력해서 클라이언트 응답하기
 -->
 <%
 	String sNo = request.getParameter("no");
 	
 	// DAO 이용해서 DB 읽어오기
 	BoardDao dao = new BoardDao();
 	
 	Board b = dao.getBoard(Integer.parseInt(sNo));
 	// 결과 데이터를 모델이라고 부름
 
 %>
 <c:set var = "b" value="<%= b %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<div class="row"><!-- Header -->
			<div class="col">Header</div>
		</div>
		<div class="row text-center my-5"><!-- Content -->
			<div class="col">
				<h2 class="fw-bold fs-3">게시 글 상세보기</h2>
			</div>
		</div>
		<div class="row my-3">
			<div class="col">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<th class="table-secondary">제 목</th>
							<td colspan="3">${b.title }</td>
						</tr>
						<tr>
							<th class="table-secondary">글쓴이</th>
							<td>${b.writer }</td>
							<th class="table-secondary">작성일</th>
							<td>${b.regDate }</td>
						</tr>
						<tr>
							<th class="table-secondary">비밀번호</th>
							<td>
								<input type="password" name="pass" id="pass" class="form-control">
							</td>
							<th class="table-secondary">조회수</th>
							<td>${b.readCount }</td>
						</tr>
						<tr>
							<th class="table-secondary">파 일</th>
							<td colspan="3">
								<c:if test="${empty b.file1 }">
									첨부파일없음
								</c:if>
								<c:if test="${not empty b.file1 }">
									<a href="../upload/${b.file1 }">파일 다운로드</a>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="4"><pre>${b.content }</pre></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col text-center">
				<input type="button" value="수정하기" id="detailUpdate" class="btn btn-warning">&nbsp;&nbsp;
				<input type="button" value="삭제하기" id="detailDelete" class="btn btn-danger">&nbsp;&nbsp;
				<input type="button" value="목록보기" class="btn btn-primary" 
					onclick="location.href='boardList.jsp'">
			</div>
		</div>
		<div class="row"><!-- Footer -->
			<div class="col">Footer</div>
		</div>
		<script src="../bootstrap/bootstrap.bundle.min.js"></script>
	</div>
</body>
</html>