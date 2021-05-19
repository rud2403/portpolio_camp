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
						System.out.println("디비에 있는 캠핑지 이름은 @@@@@@@@@@ : " + rs.getString("bname"));			
						System.out.println("현재 게시글 캠핑지 이름은 ########## : " + lb.getBname());
						check = -1;
					}else{
						// 겹치는 목록 없음
						System.out.println("밑으로 빠졌다 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ");
						System.out.println("디비에 있는 캠핑지 이름은 @@@@@@@@@@ : " + rs.getString("bname"));			
						System.out.println("현재 게시글 캠핑지 이름은 ########## : " + lb.getBname());						
						// 3 sql (글 번호를 계산하는 구문)
						}
					}
				
					if(check == 0){
						sql = "select max(num) from camp_like";

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
					}
	
			} catch (SQLException e) {
				System.out.println("디비 연결 실패 !!");
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
		// getLikeCount() 끝		
		
		
		// getLikeList(int startRow, int pageSize) 시작 ( 캠핑지 즐겨찾기 시작 끝 기능 )
		public ArrayList getLikeList(int startRow, int pageSize, String mid) {
			
			System.out.println("DAO로 넘어온 아이디 값 @@@@@@@@@: " + mid);
			// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장

			// 게시판의 글 정보를 원하는 만큼 저장하는 가변길이 배열
			ArrayList BoardList = new ArrayList();

			// 게시판 글 1개의 정보를 저장하는 객체
			LikeBean lb = null;

			try {
				// 1, 2 드라이버 로드, 디비 열결
				conn = getConnection();

				// 3sql 구문 & pstmtm객체
				// 글 정보 정렬 - re_ref 값을 최신글 위쪽으로 정렬(내림차순)
				//				- re_seq 값을 사용 (오름 차순)
				//				- limit a, b (a 시작, b 개수)
				//				ex) 1번글 -> 0번 인덱스
				
				
				sql = "select * from camp_like where mid=? "
						+ "order by num desc"
						+ " limit ?,?";
				

				//
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, mid);				
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				
				rs = pstmt.executeQuery();

				
				
				// 5 데이터 처리
				while (rs.next()) {
					// 데이터 있을 때 lb 객체 생성
					lb = new LikeBean();

					// DB정보를 Bean에 저장하기
					lb.setNum(rs.getInt("num"));
					lb.setMid(rs.getString("mid"));
					lb.setBname(rs.getString("bname"));

					
					// Bean -> ArrayList 한칸에 저장
					BoardList.add(lb);

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
		// getLikeList(int startRow, int pageSize) 끝
		
		

		}