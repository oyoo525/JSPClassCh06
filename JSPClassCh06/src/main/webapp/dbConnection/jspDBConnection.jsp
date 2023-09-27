<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import ="com.jspstudy.ch06.vo.*, com.jspstudy.ch06.dao.*" %>
<%-- 
	DAO 생성으로 주석처리함
<%
	String user = "hr";
	String pass = "hr";
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521";
	String select = "SELECT * FROM jspbbs ORDER BY no DESC";
	String title = "게시글 리스트";
	
	// DB 관련 객체
	// Connection(접속관리), PreparedStatement(쿼리발행), ResultSet(결과집합)
	
	// 드라이버 로딩
	Class.forName(driver);
	
	// 데이터 베이스 접속하기 : Connection 객체 얻기
	Connection conn = DriverManager.getConnection(url, user, pass);
	
	// 활성화된 Connection으로 부터 쿼리를 발행해주는 객체
	// Statement, PreparedStatement
	Statement stmt = conn.createStatement();
	
	// Statement를 이용해서 DB에 쿼리 발행하기
	// ** Select쿼리면 결과집합을 받는다 : ResultSet 객체사용
	ResultSet rs = stmt.executeQuery(select); 
	// executeQuery() : 쿼리 조회하기 
	// executeUpdate() : 쿼리 insert/update/delete
	
	// 결과집합에서 데이터 추출하기 : 자바객체로 변환
	ArrayList<Board> bList = new ArrayList<>();
	
	while(rs.next()) {
		// 한 행의 데이터 추출하기 > Board 객체로 만들기 > 리스트에 저장하기
		Board b = new Board();
		
		b.setNo(rs.getInt("no"));
		b.setTitle(rs.getString("title"));
		b.setWriter(rs.getString("writer"));
		b.setContent(rs.getString("content"));
		b.setRegDate(rs.getTimestamp("reg_date"));
		b.setReadCount(rs.getInt("read_count"));
		
		bList.add(b);
	}
	
	// DB를 사용한 후에 자원을 해제 : 접속순서의 역순으로 해제
	if(rs != null) rs.close();
	if(stmt != null) stmt.close();
	if(conn != null) conn.close();
	
	// pageContext.setAttribute("title", title);
	// 아래 c:set 과 같은 의미
%> 
--%>
<%
	BoardDao01 dao = new BoardDao01();
	ArrayList<Board> bList = dao.boardList();

	String title = "게시글 리스트";


%>

<c:set var="title" value="<%= title %>" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		border: 1px solid orange;
		border-collapse: collapse;
	}
	td {
		border: 1px solid orange;
		padding : 5px 10px;
	}
	table tr:first-child td {
		text-align: center;	
		font-weight: bold;
	}
</style>
</head>
<body>
	<h2>${title }</h2>
	<table>
		<tr>
			<td>no</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		<c:forEach var="b" items="<%= bList %>">
			<tr>
				<td>${b.no }</td>
				<td>${b.title }</td>
				<td>${b.writer }</td>
				<td>${b.regDate }</td>
				<td>${b.readCount }</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>