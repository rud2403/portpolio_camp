package com.camp.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.camp.board.BoardBean;

public class BoardDAO {

	// Data Access Object : DB 데이터 처리 객체
	// => DB에 관련된 모든 동작을 수행하는 객체
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	// 디비에 필요한 정보
	private Connection getConnection() {
		// // 1, 2단계
		//
		// // 디비 연결 지역변수
		// final String DRIVER = "com.mysql.jdbc.Driver";
		// final String DBURL = "jdbc:mysql://localhost:3306/jspdb";
		// final String DBID = "root";
		// final String DBPW = "1234";
		//
		// try {
		//
		// Class.forName(DRIVER);
		// conn = DriverManager.getConnection(DBURL,DBID, DBPW);
		//
		// } catch (ClassNotFoundException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// } catch (SQLException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }

		// Context 객체를 생성
		try {
			// Context 객체를 생성 ( 프로젝트 정보를 가지고 있는 객체 )
			Context initCTX = new InitialContext();

			// DB연동 정보를 불러오기(context.xml)
			DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");

			conn = ds.getConnection();

			System.out.println(" 드라이버로드, 디비연결 성공! ");
			System.out.println(conn);

		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	} 
	// getConnection() 끝

	// 자원 해제 코드 - finally 구문에서 쓰인다.
	public void closeDB() {
		// 자원 해제
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	// closeDB() 끝
	
	public void insertBoard(BoardBean bb) {

		int num = 0;

		try {
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리하는 메소드로 변경
			conn = getConnection();

			// 3 sql (글 번호를 계산하는 구문)
			sql = "select max(num) from camp_camp";

			pstmt = conn.prepareStatement(sql);

			// 4 sql 실행
			rs = pstmt.executeQuery();

			// 5 데이터 처리
			// max(num) - sql 함수를 실행했을 경우 커서 이동 가능(데이터 여부 상관없음)
			// num - sql 칼럼의 경우 커서 이동 불가능
			if (rs.next()) {
				// num = rs.getInt("mxa(num)") + 1;
				num = rs.getInt(1) + 1;
			}

			System.out.println(" 글 번호 : " + num);

			// 3 sql 작성 (insert) & pstmt 객체 생성
			sql = "insert into camp_camp values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ? ,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getAddress());
			pstmt.setString(4, bb.getLat());
			pstmt.setString(5, bb.getLng());
			pstmt.setString(6, bb.getToilet());
			pstmt.setString(7, bb.getPark());
			pstmt.setString(8, bb.getWater());
			pstmt.setString(9, bb.getFishing());
			pstmt.setString(10, bb.getField());
			pstmt.setString(11, bb.getLand());
			pstmt.setString(12, bb.getFilename());
			pstmt.setString(13, bb.getLevel());
			pstmt.setInt(14, bb.getReadcount());
			pstmt.setString(15, bb.getComent());
			

			// 4 sql 실행

			pstmt.executeUpdate();

			System.out.println("sql구문 실행 완료 : 글쓰기 완료");

		} catch (SQLException e) {
			System.out.println("디비 연결 실패 !!");
			e.printStackTrace();
		} finally {
			// 자원해제
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

	}
	// insertBoard() 끝
	
	// getBoardCount() 시작
		public int getBoardCount() {

			int cnt = 0;

			try {
				// 1, 2 드라이버로드, 디비연결
				conn = getConnection();

				// 3 sql 작성(select) & pstmt 객체 생성
				sql = "select count(*) from camp_camp";

				pstmt = conn.prepareStatement(sql);

				// 4 sql 실행
				rs = pstmt.executeQuery();

				// 5 데이터 처리
				if (rs.next()) {
					cnt = rs.getInt(1);
				} // try

				System.out.println("SQL 구문 실행 완료!");
				System.out.println(" 글 개수 : " + cnt + "개");

			} catch (Exception e) {
				System.out.println(" 게시판 글 개수 에러 발생 !!");
				e.printStackTrace();
			} finally {

				closeDB();

			}

			return cnt;

		}
		// getBoardCount() 끝
	
		// getBoardList() 시작
		public ArrayList getBoardList() {
			// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장

			// 게시판의 글 정보를 모두 저장하는 가변길이 배열
			ArrayList BoardListAll = new ArrayList();

			// 게시판 글 1개의 정보를 저장하는 객체
			BoardBean bb = null;

			try {
				// 1, 2 드라이버 로드, 디비 열결
				conn = getConnection();

				// 3sql 구문 & pstmtm객체
				sql = "select * from camp_camp";

				//
				pstmt = conn.prepareStatement(sql);

				rs = pstmt.executeQuery();

				// 5 데이터 처리
				while (rs.next()) {
					// 데이터 있을 때 bb 객체 생성
					bb = new BoardBean();

					// DB정보를 Bean에 저장하기
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setAddress(rs.getString("address"));
					bb.setLat(rs.getString("lat"));
					bb.setLng(rs.getString("lng"));
					bb.setToilet(rs.getString("toilet"));
					bb.setPark(rs.getString("park"));
					bb.setWater(rs.getString("water"));
					bb.setFishing(rs.getString("fishing"));
					bb.setField(rs.getString("field"));
					bb.setLand(rs.getString("land"));
					bb.setFilename(rs.getString("filename"));
					bb.setDate(rs.getDate("date"));
					bb.setLevel(rs.getString("level"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setComent(rs.getString("coment"));
					

					// Bean -> ArrayList 한칸에 저장
					BoardListAll.add(bb);

				} // while
				
				System.out.println(" 게시판 모든 정보 저장완료 ");
				System.out.println(" 총 " + BoardListAll.size() + " 개");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return BoardListAll;
		 }
		// getBoardList() 끝
		
		
		// getBoardList(int startRow, int pageSize) 시작
		public ArrayList getBoardList(int startRow, int pageSize) {
			// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장

			// 게시판의 글 정보를 원하는 만큼 저장하는 가변길이 배열
			ArrayList BoardList = new ArrayList();

			// 게시판 글 1개의 정보를 저장하는 객체
			BoardBean bb = null;

			try {
				// 1, 2 드라이버 로드, 디비 열결
				conn = getConnection();

				// 3sql 구문 & pstmtm객체
				// 글 정보 정렬 - re_ref 값을 최신글 위쪽으로 정렬(내림차순)
				//				- re_seq 값을 사용 (오름 차순)
				//				- limit a, b (a 시작, b 개수)
				//				ex) 1번글 -> 0번 인덱스
				
				
				sql = "select * from camp_camp "
						+ "order by num desc"
						+ " limit ?,?";
				

				//
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				
				rs = pstmt.executeQuery();

				// 5 데이터 처리
				while (rs.next()) {
					// 데이터 있을 때 bb 객체 생성
					bb = new BoardBean();

					// DB정보를 Bean에 저장하기
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setAddress(rs.getString("address"));
					bb.setLat(rs.getString("lat"));
					bb.setLng(rs.getString("lng"));
					bb.setToilet(rs.getString("toilet"));
					bb.setPark(rs.getString("park"));
					bb.setWater(rs.getString("water"));
					bb.setFishing(rs.getString("fishing"));
					bb.setField(rs.getString("field"));
					bb.setLand(rs.getString("land"));
					bb.setFilename(rs.getString("filename"));
					bb.setDate(rs.getDate("date"));
					bb.setLevel(rs.getString("level"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setComent(rs.getString("coment"));

					// Bean -> ArrayList 한칸에 저장
					BoardList.add(bb);

				} // while
				
				System.out.println(" 게시판 모든 정보 저장완료 ");
				System.out.println(" 총 " + BoardList.size() + " 개");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return BoardList;
		}
		// getBoardList(int startRow, int pageSize) 끝
		
		
		
		// updateReadcount(int num) 시작
		public void updateReadcount(int num){
			
			try {
			// 1,2 디비 연결
			conn = getConnection();
			
			
			// 3 sql 구문 작성(update) & pstmt 객체
			sql = "update camp_camp set readcount = readcount + 1 where num=?";
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			//4 sql 실행
			
			pstmt.execute();
			
			System.out.println("글 조회수 증가 완료");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				closeDB();
			}
			
			
			// 4 sql 실행
			
			
		}
		// updateReadcount(int num) 끝
		
		
		
		// getBoard(int num) 시작
		public BoardBean getBoard(int num){

			BoardBean bb = null;
			
			try {
				
				// 1, 2 디비 연결
				conn = getConnection();
				
				// 3 sql 작성(select) & pstmt 객체
				sql = "select * from camp_camp where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				// 4 sql 실행
				
				rs = pstmt.executeQuery();
				
				// 5 데이터 처리
				if(rs.next()){
					
					bb = new BoardBean();
					
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setAddress(rs.getString("address"));
					bb.setLat(rs.getString("lat"));
					bb.setLng(rs.getString("lng"));
					bb.setToilet(rs.getString("toilet"));
					bb.setPark(rs.getString("park"));
					bb.setWater(rs.getString("water"));
					bb.setFishing(rs.getString("fishing"));
					bb.setField(rs.getString("field"));
					bb.setLand(rs.getString("land"));
					bb.setFilename(rs.getString("filename"));
					bb.setDate(rs.getDate("date"));
					bb.setLevel(rs.getString("level"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setComent(rs.getString("coment"));
				}
				
				System.out.println(" 글 번호에 해당하는 글정보 저장 완료");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				closeDB();
			}
			
			return bb;
			

		}
		// getBoard(int num) 끝
		
		
		// updateBoard(BoardBean bb) 시작
		public int updateBoard(BoardBean bb){
			
			int check = -1;
			
			try {
				// 1, 2 디비 연결
				conn = getConnection();
				
				// 3 sql 작성(select - 본인확인) & pstmt 객체
				sql = "select * from camp_camp where num=?";
				
				
				pstmt = conn.prepareStatement(sql);
								
				pstmt.setInt(1, bb.getNum());

				//4 sql 실행

				rs = pstmt.executeQuery();
				
				//5 데이터 처리
				if(rs.next()){
					// 글이 있음
					
					// sql (update-글 수정) & pstmtm 객체
					sql = "update camp_camp set name=?, address=?, lat=?, lng=?, toilet=?, park=?, water=?, fishing=?, field=?, land=?, filename=?, level=? where num=?";
					
					pstmt = conn.prepareStatement(sql);
					
					// ? 채우기

					pstmt.setString(1, bb.getName());
					pstmt.setString(2, bb.getAddress());
					pstmt.setString(3, bb.getLat());
					pstmt.setString(4, bb.getLng());
					pstmt.setString(5, bb.getToilet());
					pstmt.setString(6, bb.getPark());
					pstmt.setString(7, bb.getWater());
					pstmt.setString(8, bb.getFishing());
					pstmt.setString(9, bb.getField());
					pstmt.setString(10, bb.getLand());
					pstmt.setString(11, bb.getFilename());
					pstmt.setString(12, bb.getLevel());
					pstmt.setInt(13, bb.getNum());
					
					
					// 4 sql 실행
					pstmt.executeUpdate();
					
					
					check = 0;
					
					//check = 1;
											
				}else{
					// 글이 없음
					check = -1;
				}
				
				System.out.println(" 글 수정 완료 !" + check);
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				closeDB();
			}			
			return check;

		}
		// updateBoard(BoardBean bb) 끝		
		
		
		// deleteBoard(BoardBean bb) 시작
		public int deleteBoard(BoardBean bb){
			int check = -1;
			
			
			try {
				// 1, 2 디비 연결
				conn = getConnection();
				// 3 sql 생성 &pstmt 객체 생성
				sql="select * from camp_camp where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				System.out.println("@@@@@@@##########################가져온 넘버의 값은 : " + bb.getNum());
				
				pstmt.setInt(1, bb.getNum());
				
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					sql = "delete from camp_camp where num=?";
					pstmt = conn.prepareStatement(sql);
					
					
					pstmt.setInt(1, bb.getNum());
					
					pstmt.executeUpdate();

					
					check = 0;
						
					System.out.println("중간점검22222222222222" + check);
				}else{
					check = -1;
				}
				
				System.out.println("글 삭제 완료" + check);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeDB();
			}

			
			return check;
		}
		// deleteBoard(BoardBean bb) 끝		
		
}
// BoardDAO 끝
