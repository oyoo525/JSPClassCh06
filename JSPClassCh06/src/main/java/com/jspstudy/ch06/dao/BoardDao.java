package com.jspstudy.ch06.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.jspstudy.ch06.vo.Board;

// 데이터베이스 작업을 전담하는 객체(DAO)
public class BoardDao {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public BoardDao() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env"); 
			// "java:/comp/env" : base가 정해져있음(JNDI)

			ds = (DataSource)envContext.lookup("jdbc/bbsDBPool");
			
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	// 테이블에서 게시글 하나 읽어오기
	public Board getBoard(int no) {
		
		String sqlBoard = "SELECT * FROM jspbbs WHERE no = ?";
		
		Board b = null;
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sqlBoard);
			pstmt.setInt(1, no); // 첫번째 ? 의 값을 no로 설정
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				b = new Board();
				b.setNo(rs.getInt("no"));
				b.setTitle(rs.getString("title"));
				b.setWriter(rs.getString("writer"));
				b.setContent(rs.getString("content"));
				b.setRegDate(rs.getTimestamp("reg_date"));
				b.setReadCount(rs.getInt("read_count"));
				b.setPass(rs.getString("pass"));
				b.setFile1(rs.getString("file1"));
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
		return b;
	}
	
	
	// 게시글 리스트를 읽어오는 메소드
	public ArrayList<Board> boardList() {
		String select = "SELECT * FROM jspbbs ORDER BY no DESC";
		
		ArrayList<Board> bList = null;
		
		try {
			// 데이터 베이스 접속하기 : Connection 객체 얻기
			conn = ds.getConnection();
			
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
	
	// 게시글 하나의 정보를 DB테이블에 저장하는 메소드
	public void insertBoard(Board b) {
		
		String insertBoard = "INSERT INTO jspbbs(no, title, writer, content, reg_date, read_count, pass, file1) "
										+ "VALUES(jspbbs_seq.NEXTVAL, ?, ?, ?, SYSDATE, ?, ?, ?)";
		
		try {
			conn = ds.getConnection();
			
			pstmt = conn.prepareStatement(insertBoard);
			pstmt.setString(1, b.getTitle()); // 첫번째 ? 의 값을 title로 설정
			pstmt.setString(2, b.getWriter());
			pstmt.setString(3, b.getContent());
			pstmt.setInt(4, b.getReadCount());
			pstmt.setString(5, b.getPass());
			pstmt.setString(6, b.getFile1());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	// 게시글 수정, 삭제 시 비밀번호가 맞는지 확인
	public boolean isPassCheck(int no, String pass) {
		
		String sqlBoard = "SELECT pass FROM jspbbs WHERE no = ?";
		boolean isPass = false;
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sqlBoard);
			pstmt.setInt(1, no); // 첫번째 ? 의 값을 no로 설정
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isPass = rs.getString("pass").equals(pass);
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
		return isPass;
	}
	
	
	// DB에서 기존게시글의 내용을 수정하는 메소드
		public void updateBoard(Board b) {
			
			String updateBoard = "UPDATE jspbbs SET title=?, writer=?, content=? WHERE no=?";
			
			try {
				conn = ds.getConnection();
				
				pstmt = conn.prepareStatement(updateBoard);
				pstmt.setString(1, b.getTitle()); // 첫번째 ? 의 값을 title로 설정
				pstmt.setString(2, b.getWriter());
				pstmt.setString(3, b.getContent());
				pstmt.setInt(4, b.getNo());
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
				
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
}
