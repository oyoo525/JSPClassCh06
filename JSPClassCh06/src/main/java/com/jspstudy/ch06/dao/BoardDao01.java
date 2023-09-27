package com.jspstudy.ch06.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jspstudy.ch06.vo.Board;

// 데이터베이스 작업을 전담하는 객체(DAO)
public class BoardDao01 {

	private static final String USER = "hr";
	private static final String PASS = "hr";
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521";
	
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public BoardDao01() {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	// 게시글 리스트를 읽어오는 메소드
	public ArrayList<Board> boardList() {
		String select = "SELECT * FROM jspbbs ORDER BY no DESC";
		
		ArrayList<Board> bList = null;
		
		try {
			// 데이터 베이스 접속하기 : Connection 객체 얻기
			conn = DriverManager.getConnection(URL, USER, PASS);
			
			// 활성화된 Connection으로 부터 쿼리를 발행해주는 객체 : Statement, PreparedStatement
			pstmt = conn.prepareStatement(select);
			
			// Statement를 이용해서 DB에 쿼리 발행하기
			// ** Select쿼리면 결과집합을 받는다 : ResultSet 객체사용
			rs = pstmt.executeQuery(select); 
			
			bList = new ArrayList<>();
			
			while(rs.next()) {
				Board b = new Board();
				
				b.setNo(rs.getInt("no"));
				b.setTitle(rs.getString("title"));
				b.setWriter(rs.getString("writer"));
				b.setContent(rs.getString("content"));
				b.setRegDate(rs.getTimestamp("reg_date"));
				b.setReadCount(rs.getInt("read_count"));
				
				bList.add(b);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
		return bList;
	}
}
