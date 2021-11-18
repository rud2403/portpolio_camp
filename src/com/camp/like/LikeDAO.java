package com.camp.like;

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
import com.camp.like.LikeBean;


public class LikeDAO {

		// Data Access Object : DB 데이터 처리 객체
		// => DB에 관련된 모든 동작을 수행하는 객체
		private Connection conn = null;
		private PreparedStatement pstmt = null;
		private ResultSet rs = null;
		private String sql = "";
		
		// 디비에 필요한 정보
		private Connection getConnection() {
			// // 1, 2단계

			// Context 객체를 생성
			try {
				// Context 객체를 생성 ( 프로젝트 정보를 가지고 있는 객체 )
				Context initCTX = new InitialContext();

				// DB연동 정보를 불러오기(context.xml)
				DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");

				conn = ds.getConnection();

			} catch (NamingException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return conn;
		} 
		// getConnection() 끝

		
		// closeDB() 시작
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
		
		
		// insertLike(LikeBean bb) 시작 ( 캠핑 게시판 글쓰기 기능)
		public int insertLike(LikeBean lb) {
			int check = 0;
			int num = 0;

			try {
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리하는 메소드로 변경
				conn = getConnection();
				
				sql = "select * from camp_like where mid=?";
				
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, lb.getMid());
								
				rs = pstmt.executeQuery();
				
				
				while(rs.next()){
					
					// 현재 캠핑지 이름이 DB안의 캠핑지 이름중에 존재할 때
					if(rs.getString("bname").equals(lb.getBname())){
						// 이미 존재하는 즐겨찾기 목록이다.
						check = -1;
					}else{
					}
					}
				
					if(check == 0){
						sql = "select max(lnum) from camp_like";

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
						sql = "insert into camp_like values(?, ?, ?)";

						pstmt = conn.prepareStatement(sql);

						pstmt.setInt(1, num);
						pstmt.setString(2, lb.getMid());
						pstmt.setString(3, lb.getBname());

						// 4 sql 실행

						pstmt.executeUpdate();

						System.out.println("sql구문 실행 완료 : 즐겨찾기 추가 완료");
						
						
						// camp_camp 테이블의 count 1올리는 sql
						
						sql = "update camp_camp set count = count + 1 where name= ?";
						
						pstmt = conn.prepareStatement(sql);
						
						pstmt.setString(1, lb.getBname());						
											
						pstmt.execute();
					}
	
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				// 자원해제
				closeDB();
			}
				return check;
			}
		// insertLike(LikeBean lb) 끝	

		// getLikeCount() 시작 ( 캠핑장 즐겨찾기 수 기능 )
		public int getLikeCount() {

			int cnt = 0;

			try {
				// 1, 2 드라이버로드, 디비연결
				conn = getConnection();

				// 3 sql 작성(select) & pstmt 객체 생성
				sql = "select count(*) from camp_like";

				pstmt = conn.prepareStatement(sql);

				// 4 sql 실행
				rs = pstmt.executeQuery();

				// 5 데이터 처리
				if (rs.next()) {
					cnt = rs.getInt(1);
				} // try

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return cnt;

		}
		// getLikeCount() 끝		
		
		
		// getLikeList(int startRow, int pageSize) 시작 ( 캠핑지 즐겨찾기 시작 끝 기능 )
		public ArrayList getLikeList(int startRow, int pageSize, String mid) {
			
			// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장
			// 게시판의 글 정보를 원하는 만큼 저장하는 가변길이 배열
			ArrayList BoardList = new ArrayList();

			// 게시판 글 1개의 정보를 저장하는 객체
			BoardBean bb = null;

			try {
				// 1, 2 드라이버 로드, 디비 열결
				conn = getConnection();

				sql = "select * from camp_like left join camp_camp on camp_like.bname = camp_camp.name where mid=? "
						+ "order by camp_like.lnum desc"
						+ " limit ?,?";
				
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, mid);				
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				
				rs = pstmt.executeQuery();

				// 5 데이터 처리
				while (rs.next()) {
					// 데이터 있을 때 lb 객체 생성
					bb = new BoardBean();

					// DB정보를 Bean에 저장하기
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("bname"));
					bb.setAddress(rs.getString("address"));
					bb.setLevel(rs.getString("level"));
					bb.setFilename(rs.getString("filename"));
					
					// Bean -> ArrayList 한칸에 저장
					BoardList.add(bb);

				} // while
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return BoardList;
		}
		// getLikeList(int startRow, int pageSize) 끝
		

		public int deleteLike(LikeBean lb, String mid) {

			int check = -1;
			
			try {
				// 1, 2 디비 연결
				conn = getConnection();
				// 3 sql 생성 &pstmt 객체 생성
				sql="select * from camp_like where bname=? && mid=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, lb.getBname());
				pstmt.setString(2, mid);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					sql = "delete from camp_like where bname=? && mid=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, lb.getBname());
					pstmt.setString(2, mid);					
										
					pstmt.executeUpdate();
					

					// camp_camp 테이블의 count 1내리는 sql
					
					sql = "update camp_camp set count = count - 1 where name= ?";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, lb.getBname());						
										
					pstmt.execute();

					check = 0;
						
				}else{
					check = -1;
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
			closeDB();
			}
			
			return check;
		}

	}