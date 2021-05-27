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
		
///////////////////////////////////////// 메인페이지 DAO ///////////////////////////////////////////////////////////////////

	// getRecommendList() 시작 ( 메인페이지 추천 캠핑장 기능 )
	public ArrayList getRecommendList() {
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
			
			
			sql = "select num, name, address, filename, level, field, count from camp_camp order by count desc";
			
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
				bb.setField(rs.getString("field"));
				bb.setFilename(rs.getString("filename"));
				bb.setLevel(rs.getString("level"));
				bb.setCount(rs.getInt("count"));

				// Bean -> ArrayList 한칸에 저장
				BoardList.add(bb);

			} // while
			
			System.out.println(" 추천 게시판 정보 저장완료 ");
			System.out.println(" 총 " + BoardList.size() + " 개");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return BoardList;
	}
	//getRecommendList() 끝	
	
	// getMainMarketList() 시작 ( 메인페이지 캠핑 장터 기능 )
		public ArrayList getMainMarketList() {
			// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장

			// 게시판의 글 정보를 원하는 만큼 저장하는 가변길이 배열
			ArrayList marketList = new ArrayList();

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
				
				
				sql = "select num, name, kind, id from camp_sell order by num desc";
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();

				// 5 데이터 처리
				while (rs.next()) {
					// 데이터 있을 때 bb 객체 생성
					bb = new BoardBean();

					// DB정보를 Bean에 저장하기
					bb.setNum(rs.getInt("num"));				
					bb.setName(rs.getString("name"));
					bb.setKind(rs.getString("kind"));
					bb.setId(rs.getString("id"));

					// Bean -> ArrayList 한칸에 저장
					marketList.add(bb);

				} // while
				
				System.out.println(" 캠핑 장터 정보 저장완료 ");
				System.out.println(" 총 " + marketList.size() + " 개");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return marketList;
		}
		//getMainMarketList() 끝		
	
		// getFreeList() 시작 ( 메인페이지 자유게시판 기능 )
				public ArrayList getFreeList() {
					// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장

					// 게시판의 글 정보를 원하는 만큼 저장하는 가변길이 배열
					ArrayList freeList = new ArrayList();

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
						
						
						sql = "select * from camp_freeboard "
								+ "order by re_ref desc, re_seq asc";
						
						pstmt = conn.prepareStatement(sql);
						
						rs = pstmt.executeQuery();

						// 5 데이터 처리
						while (rs.next()) {
							// 데이터 있을 때 bb 객체 생성
							bb = new BoardBean();

							// DB정보를 Bean에 저장하기
							bb.setNum(rs.getInt("num"));				
							bb.setName(rs.getString("name"));
							bb.setId(rs.getString("id"));
							bb.setRe_lev(rs.getInt("re_lev"));
							bb.setRe_seq(rs.getInt("re_seq"));
							bb.setRe_ref(rs.getInt("re_ref"));

							// Bean -> ArrayList 한칸에 저장
							freeList.add(bb);

						} // while
						
						System.out.println(" 캠핑 장터 정보 저장완료 ");
						System.out.println(" 총 " + freeList.size() + " 개");

					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} finally {
						closeDB();
					}

					return freeList;
				}
				//getMainMarketList() 끝	
	
	
	
////////////////////////////////////////// 캠핑 List 개시판 DAO ////////////////////////////////////////////////////////////	
	
	// insertBoard(BoardBean bb) 시작 ( 캠핑 게시판 글쓰기 기능)
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
			sql = "insert into camp_camp values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ? ,?, ?, ?, ?)";

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
			pstmt.setString(16, bb.getFilename2());
			pstmt.setString(17, bb.getFilename3());
			pstmt.setInt(18, bb.getCount());

			

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
	// insertBoard(BoardBean bb) 끝

	
	// getBoardCount() 시작 ( 캠핑장 게시판 게시글 수 기능 )
	public int getBoardCount(String search) {

		search = "%"+search+"%";
		int cnt = 0;

		try {
			// 1, 2 드라이버로드, 디비연결
			conn = getConnection();

			// 3 sql 작성(select) & pstmt 객체 생성
			sql = "select count(*) from camp_camp where name like ?";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, search);
			

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
	
	
	// getBoardCount() 시작 ( 캠핑장 게시판 게시글 수 기능 )
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
	

	// getBoardList() 시작 ( 캠핑장 게시판 게시글 가져오기 기능 )
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
				bb.setFilename2(rs.getString("filename2"));
				bb.setFilename3(rs.getString("filename3"));
				bb.setCount(rs.getInt("count"));
				

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
												
				
	// getBoardList(int startRow, int pageSize) 시작 ( 캠핑지 게시판 게시글 시작 끝 기능 )
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
				bb.setCount(rs.getInt("count"));

				
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
	

	// getBoardList(String search, int startRow, int pageSize) 시작 ( 캠핑지 게시판 게시글 시작 끝 기능 )
	public ArrayList getBoardList(String search, int startRow, int pageSize) {
		// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장

		search = "%"+search+"%";
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
			
			
			sql = "select * from camp_camp where name like ? order by num desc limit ?,?";
			

			//
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, search);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
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
				bb.setCount(rs.getInt("count"));

				
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
	// getBoardList(String search, int startRow, int pageSize) 끝	
	
	
	// getCampList
	public ArrayList getCampList() {
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
			
			
			sql = "select * from camp_camp ";
			

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
				bb.setCount(rs.getInt("count"));

				
				// Bean -> ArrayList 한칸에 저장
				BoardList.add(bb);

			} // while
			
			System.out.println(" 캐프 모든 정보 저장완료 ");
			System.out.println(" 총 " + BoardList.size() + " 개");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return BoardList;
	}
	// getCampList() 끝
	
	
	// getCampList (검색용) 시작
		public ArrayList getCampList(String search) {
			// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장

			search = "%"+search+"%";
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
				
				
				sql = "select * from camp_camp where name like ?";
				

				//
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, search);

				
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
					bb.setCount(rs.getInt("count"));

					
					// Bean -> ArrayList 한칸에 저장
					BoardList.add(bb);

				} // while
				
				System.out.println(" 캐프 모든 정보 저장완료 ");
				System.out.println(" 총 " + BoardList.size() + " 개");

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return BoardList;
		}
		// getCampList (검색용) 끝
	
	
	// updateReadcount(int num) 시작 ( 캠핑장 게시글 조회수 증가 기능)
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
	
	// getBoard(int num) 시작 ( 캠핑지 게시판 번호에 맞는 게시글 정보 가져오기 )
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
				bb.setFilename2(rs.getString("filename2"));
				bb.setFilename3(rs.getString("filename3"));
				bb.setCount(rs.getInt("count"));
				
				
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
	
	
	// updateBoard(BoardBean bb) 시작 ( 캠핑지 게시판 글 수정 기능 )
	public int updateBoard(BoardBean bb){
		
		int check = -1;
		
		try {
			// 1, 2 디비 연결
			conn = getConnection();
			System.out.println("넘버 숫자는 #################: " +bb.getNum());
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
				sql = "update camp_camp set name=?, address=?, lat=?, lng=?, toilet=?, park=?, water=?, fishing=?, field=?, land=?, filename=?, level=?, filename2=?, filename3=? where num=?";
				
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
				pstmt.setString(13, bb.getFilename2());
				pstmt.setString(14, bb.getFilename3());
				pstmt.setInt(15, bb.getNum());
				
		
				
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

	
	// deleteBoard(BoardBean bb) 시작 ( 캠핑지 게시글 삭제 기능 )
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
		
//////////////////////////////////////////////////////////// 캠핑 장터 게시판 DAO 시작///////////////////////////////////////////////////////////////
	
	// insertmarketBoard(BoardBean bb) 시작 ( 캠핑 장터 게시판 글쓰기 기능 )
	public void insertmarketBoard(BoardBean bb) {

		int num = 0;

		try {
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리하는 메소드로 변경
			conn = getConnection();

			// 3 sql (글 번호를 계산하는 구문)
			sql = "select max(num) from camp_sell";

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
			sql = "insert into camp_sell values(?, ?, ?, ?, ?, ?, now(), ?, ? ,?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getId());
			pstmt.setString(4, bb.getPw());		
			pstmt.setString(5, bb.getComent());	
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setString(7, bb.getIp());
			pstmt.setString(8, bb.getAddress());
			pstmt.setString(9, bb.getKind());
			pstmt.setInt(10, bb.getPrice());
			pstmt.setString(11, bb.getTrade());
			pstmt.setString(12, bb.getState());
			pstmt.setString(13, bb.getFilename());
			pstmt.setString(14, bb.getFilename2());
			pstmt.setString(15, bb.getFilename3());
	
			

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
	// insertmarketBoard(BoardBean bb) 끝	
			
		
	// getMarketCount() 시작 ( 캠핑장터 게시판 게시글 수 기능)
	public int getMarketCount() {

		int cnt = 0;

		try {
			// 1, 2 드라이버로드, 디비연결
			conn = getConnection();

			// 3 sql 작성(select) & pstmt 객체 생성
			sql = "select count(*) from camp_sell";

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
	// getMarketCount() 끝		
		
		
	// getMarketList() 시작 ( 캠핑장터 게시판 게시글 가져오기 기능 )
	public ArrayList getMarketList() { 
		// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장

		// 게시판의 글 정보를 모두 저장하는 가변길이 배열
		ArrayList BoardListAll = new ArrayList();

		// 게시판 글 1개의 정보를 저장하는 객체
		BoardBean bb = null;

		try {
			// 1, 2 드라이버 로드, 디비 열결
			conn = getConnection();

			// 3sql 구문 & pstmtm객체
			sql = "select * from camp_sell";

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
				bb.setId(rs.getString("id"));
				bb.setPw(rs.getString("pw"));
				bb.setComent(rs.getString("coment"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				bb.setAddress(rs.getString("address"));
				bb.setKind(rs.getString("kind"));
				bb.setPrice(rs.getInt("price"));
				bb.setTrade(rs.getString("trade"));
				bb.setState(rs.getString("state"));
				bb.setFilename(rs.getString("filename"));
				bb.setFilename2(rs.getString("filename2"));
				bb.setFilename3(rs.getString("filename3"));

				

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
	// getMarketList() 끝		
		

		
	// getMarketList(int startRow, int pageSize) 시작 ( 캠핑장터 게시글 시작 끝 기능 )
	public ArrayList getMarketList(int startRow, int pageSize) {
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
			
			
			sql = "select * from camp_sell "
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
				bb.setId(rs.getString("id"));
				bb.setPw(rs.getString("pw"));
				bb.setComent(rs.getString("coment"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				bb.setAddress(rs.getString("address"));
				bb.setKind(rs.getString("kind"));
				bb.setPrice(rs.getInt("price"));
				bb.setTrade(rs.getString("trade"));
				bb.setState(rs.getString("state"));
				bb.setFilename(rs.getString("filename"));
				bb.setFilename2(rs.getString("filename2"));
				bb.setFilename3(rs.getString("filename3"));

				
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
	// getMarketList(int startRow, int pageSize) 끝

		
	///////////////// 삽니다의 경우만 띄우기 시작
	// getBuyList(int startRow, int pageSize) 시작
	public ArrayList getBuyList(int startRow, int pageSize) {
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
			
			
			sql = "select * from camp_sell where kind ='삽니다' "
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
				bb.setId(rs.getString("id"));
				bb.setPw(rs.getString("pw"));
				bb.setComent(rs.getString("coment"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				bb.setAddress(rs.getString("address"));
				bb.setKind(rs.getString("kind"));
				bb.setPrice(rs.getInt("price"));
				bb.setTrade(rs.getString("trade"));
				bb.setState(rs.getString("state"));
				bb.setFilename(rs.getString("filename"));
				bb.setFilename2(rs.getString("filename2"));
				bb.setFilename3(rs.getString("filename3"));

				
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
	// getBuyList(int startRow, int pageSize) 끝
	///////////// 삽니다의 경우만 띄우기 끝
	
	
	///////////////// 팝니다의 경우만 띄우기 시작
	// getSellList(int startRow, int pageSize) 시작
	public ArrayList getSellList(int startRow, int pageSize) {
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
			
			
			sql = "select * from camp_sell where kind ='팝니다' "
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
				bb.setId(rs.getString("id"));
				bb.setPw(rs.getString("pw"));
				bb.setComent(rs.getString("coment"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				bb.setAddress(rs.getString("address"));
				bb.setKind(rs.getString("kind"));
				bb.setPrice(rs.getInt("price"));
				bb.setTrade(rs.getString("trade"));
				bb.setState(rs.getString("state"));
				bb.setFilename(rs.getString("filename"));
				bb.setFilename2(rs.getString("filename2"));
				bb.setFilename3(rs.getString("filename3"));

				
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
	// getSellList(int startRow, int pageSize) 끝
	///////////// 팝니다의 경우만 띄우기
	
				
	// updateMarketReadcount(int num) 시작 ( 캠핑장터 게시글 조회수 증가 기능 )
	public void updateMarketReadcount(int num){
		
		try {
		// 1,2 디비 연결
		conn = getConnection();
		
		
		// 3 sql 구문 작성(update) & pstmt 객체
		sql = "update camp_sell set readcount = readcount + 1 where num=?";
		
		
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
	// updateMarketReadcount(int num) 끝
		

		
	// getMarket(int num) 시작 ( 캠핑장터 게시판 번호에 맞는 게시글 정보 가져오기 )
	public BoardBean getMarket(int num){

		BoardBean bb = null;
		
		try {
			
			// 1, 2 디비 연결
			conn = getConnection();
			
			// 3 sql 작성(select) & pstmt 객체
			sql = "select * from camp_sell where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			// 4 sql 실행
			
			rs = pstmt.executeQuery();
			
			// 5 데이터 처리
			if(rs.next()){
				
				bb = new BoardBean();
				
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setId(rs.getString("id"));
				bb.setPw(rs.getString("pw"));
				bb.setComent(rs.getString("coment"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				bb.setAddress(rs.getString("address"));
				bb.setKind(rs.getString("kind"));
				bb.setPrice(rs.getInt("price"));
				bb.setTrade(rs.getString("trade"));
				bb.setState(rs.getString("state"));
				bb.setFilename(rs.getString("filename"));
				bb.setFilename2(rs.getString("filename2"));
				bb.setFilename3(rs.getString("filename3"));
				
				
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
	// getMarket(int num) 끝		
		
	
		
	// stateBoard(BoardBean bb) 시작 ( 캠핑장터 게시글 거래완료 기능 )
	public int stateBoard(BoardBean bb){
		
		int check = -1;
		
		try {
			// 1, 2 디비 연결
			conn = getConnection();
			System.out.println("stateBoard의 넘버 숫자는 !@!@!@!@!@!@!@!@: " +bb.getNum());
			// 3 sql 작성(select - 본인확인) & pstmt 객체
			sql = "select * from camp_sell where num=?";
			
			
			pstmt = conn.prepareStatement(sql);
							
			pstmt.setInt(1, bb.getNum());

			//4 sql 실행

			rs = pstmt.executeQuery();
			
			//5 데이터 처리
			if(rs.next()){
				// 글이 있음
				
				// sql (update-글 수정) & pstmtm 객체
				sql = "update camp_sell set state='거래완료' where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, bb.getNum());
				
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
	// stateBoard(BoardBean bb) 끝			
		

	// updateMarketBoard(BoardBean bb) 시작 ( 캠핑장터 게시글 글 정보 수정 기능 )
	public int updateMarketBoard(BoardBean bb){
		
		int check = -1;
		
		try {
			// 1, 2 디비 연결
			conn = getConnection();
			System.out.println("넘버 숫자는 @@@@@@@@@@@@@@@@@@@: " + bb.getNum());

			// 3 sql 작성(select - 본인확인) & pstmt 객체
			sql = "select * from camp_sell where num=?";
			
			
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setInt(1, bb.getNum());

			//4 sql 실행
			rs = pstmt.executeQuery();

			//5 데이터 처리
			if(rs.next()){
				// 글이 있음
				
				// sql (update-글 수정) & pstmtm 객체
				sql = "update camp_sell set name=?, kind=?, trade=?, price=?, address=?, coment=?, filename=?, filename2=?, filename3=? where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				// ? 채우기

				pstmt.setString(1, bb.getName());
				pstmt.setString(2, bb.getKind());
				pstmt.setString(3, bb.getTrade());
				pstmt.setInt(4, bb.getPrice());
				pstmt.setString(5, bb.getAddress());
				pstmt.setString(6, bb.getComent());
				pstmt.setString(7, bb.getFilename());
				pstmt.setString(8, bb.getFilename2());
				pstmt.setString(9, bb.getFilename3());
				pstmt.setInt(10, bb.getNum());


				
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
	// updateMarketBoard(BoardBean bb) 끝				
		
		
	// deleteMarket(BoardBean bb) 시작 ( 캠핑장터 게시판 글 삭제 기능 )
	public int deleteMarket(BoardBean bb){
		int check = -1;
		
		try {
			// 1, 2 디비 연결
			conn = getConnection();
			// 3 sql 생성 &pstmt 객체 생성
			sql="select * from camp_sell where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			System.out.println("@@@@@@@##########################가져온 넘버의 값은 : " + bb.getNum());
			
			pstmt.setInt(1, bb.getNum());
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				sql = "delete from camp_sell where num=?";
				pstmt = conn.prepareStatement(sql);
				
				
				pstmt.setInt(1, bb.getNum());
				
				pstmt.executeUpdate();

				
				check = 0;
					
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
	// deleteMarket(BoardBean bb) 끝
		
		
/////////////////////////////////////////////////////////// 자유게시판 DAO ////////////////////////////////////////////////////////////////////////
		
	// insertfreeBoard(BoardBean bb) 시작 ( 자유 게시판 글쓰기 기능 )
		public void insertfreeBoard(BoardBean bb) {

			int num = 0;

			try {
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리하는 메소드로 변경
				conn = getConnection();

				// 3 sql (글 번호를 계산하는 구문)
				sql = "select max(num) from camp_freeboard";

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
				sql = "insert into camp_freeboard values(?, ?, ?, ?, ?, ?, now(), ?, ? ,?, ?, ?, ?, ?)";

				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, num);
				pstmt.setString(2, bb.getName());
				pstmt.setString(3, bb.getId());
				pstmt.setString(4, bb.getPw());		
				pstmt.setString(5, bb.getComent());	
				pstmt.setInt(6, bb.getReadcount());
				pstmt.setString(7, bb.getIp());
				pstmt.setString(8, bb.getFilename());
				pstmt.setString(9, bb.getFilename2());
				pstmt.setString(10, bb.getFilename3());				
				pstmt.setInt(11, num); //re_ref에 글 번호 num 저장
				pstmt.setInt(12, bb.getRe_lev());
				pstmt.setInt(13, bb.getRe_seq());


				// 4 sql 실행

				pstmt.executeUpdate();

				System.out.println("sql구문 실행 완료 : 글쓰기 완료");

			} catch (SQLException e) {
				System.out.println("디비 연결 실패 !!");
				e.printStackTrace();
			} finally {
				closeDB();
			}

		}
		// insertfreeBoard(BoardBean bb) 끝	
	
		// getfreeBoardCount() 시작 ( 캠핑장터 게시판 게시글 수 기능)
		public int getfreeBoardCount() {

			int cnt = 0;

			try {
				// 1, 2 드라이버로드, 디비연결
				conn = getConnection();

				// 3 sql 작성(select) & pstmt 객체 생성
				sql = "select count(*) from camp_freeboard";

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
		// getfreeBoardCount() 끝		

		// getfreeBoardList(int startRow, int pageSize) 시작 ( 캠핑장터 게시글 시작 끝 기능 )
		public ArrayList getfreeBoardList(int startRow, int pageSize) {
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
				
				
				sql = "select * from camp_freeboard "
						+ "order by re_ref desc, re_seq asc"
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
					bb.setId(rs.getString("id"));
					bb.setPw(rs.getString("pw"));
					bb.setComent(rs.getString("coment"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setDate(rs.getDate("date"));
					bb.setIp(rs.getString("ip"));
					bb.setFilename(rs.getString("filename"));
					bb.setFilename2(rs.getString("filename2"));
					bb.setFilename3(rs.getString("filename3"));
					bb.setRe_ref(rs.getInt("re_ref"));
					bb.setRe_lev(rs.getInt("re_lev"));
					bb.setRe_seq(rs.getInt("re_seq"));
					
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
		// getfreeBoardList(int startRow, int pageSize) 끝		

		
		// updatefreeBoardReadcount(int num) 시작 ( 자유게시판 게시글 조회수 증가 기능 )
		public void updatefreeBoardReadcount(int num){
			
			try {
			// 1,2 디비 연결
			conn = getConnection();
			
			
			// 3 sql 구문 작성(update) & pstmt 객체
			sql = "update camp_freeboard set readcount = readcount + 1 where num=?";
			
			
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
		// updatefreeBoardReadcount(int num) 끝		

		
		// getfreeBoard(int num) 시작 ( 캠핑장터 게시판 번호에 맞는 게시글 정보 가져오기 )
		public BoardBean getfreeBoard(int num){

			BoardBean bb = null;
			
			try {
				
				// 1, 2 디비 연결
				conn = getConnection();
				
				// 3 sql 작성(select) & pstmt 객체
				sql = "select * from camp_freeboard where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				// 4 sql 실행
				
				rs = pstmt.executeQuery();
				
				// 5 데이터 처리
				if(rs.next()){
					
					bb = new BoardBean();
					
					bb.setNum(rs.getInt("num"));
					bb.setName(rs.getString("name"));
					bb.setId(rs.getString("id"));
					bb.setPw(rs.getString("pw"));
					bb.setComent(rs.getString("coment"));
					bb.setReadcount(rs.getInt("readcount"));
					bb.setDate(rs.getDate("date"));
					bb.setIp(rs.getString("ip"));
					bb.setFilename(rs.getString("filename"));
					bb.setFilename2(rs.getString("filename2"));
					bb.setFilename3(rs.getString("filename3"));
					bb.setRe_ref(rs.getInt("re_ref"));
					bb.setRe_lev(rs.getInt("re_lev"));
					bb.setRe_seq(rs.getInt("re_seq"));
					
					
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
		// getfreeBoard(int num) 끝		

		
		// updatefreeBoard(BoardBean bb) 시작 ( 자유게시판 게시글 글 정보 수정 기능 )
		public int updatefreeBoard(BoardBean bb){
			
			int check = -1;
			
			try {
				// 1, 2 디비 연결
				conn = getConnection();
//				System.out.println("넘버 숫자는 @@@@@@@@@@@@@@@@@@@: " + bb.getNum());

				// 3 sql 작성(select - 본인확인) & pstmt 객체
				sql = "select * from camp_freeboard where num=?";
				
				
				pstmt = conn.prepareStatement(sql);
				
				
				pstmt.setInt(1, bb.getNum());

				//4 sql 실행
				rs = pstmt.executeQuery();
//				System.out.println("넘버 숫자는 ####################: " + bb.getNum());

				//5 데이터 처리
				if(rs.next()){
					// 글이 있음
					
					// sql (update-글 수정) & pstmtm 객체
					sql = "update camp_freeboard set name=?, coment=?, filename=?, filename2=?, filename3=? where num=?";
					
					pstmt = conn.prepareStatement(sql);
					
					// ? 채우기

					pstmt.setString(1, bb.getName());
					pstmt.setString(2, bb.getComent());
					pstmt.setString(3, bb.getFilename());
					pstmt.setString(4, bb.getFilename2());
					pstmt.setString(5, bb.getFilename3());
					pstmt.setInt(6, bb.getNum());


					
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
		// updatefreeBoard(BoardBean bb) 끝		

		
		// deletefreeBoard(BoardBean bb) 시작 ( 캠핑장터 게시판 글 삭제 기능 )
		public int deletefreeBoard(BoardBean bb){
			int check = -1;
			
			try {
				// 1, 2 디비 연결
				conn = getConnection();
				// 3 sql 생성 &pstmt 객체 생성
				sql="select * from camp_freeboard where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				System.out.println("@@@@@@@#######가져온 넘버의 값은 : " + bb.getNum());
				
				pstmt.setInt(1, bb.getNum());
				
				
				rs = pstmt.executeQuery();
				
				// 삭제할 글이 있다.
				if(rs.next()){
					
					// 본문글이다.
					if(bb.getNum() == bb.getRe_ref()){
					System.out.println("본문글이다 @@@@@@@@@@@@@@@@@@@@@@@");
						
					sql = "delete from camp_freeboard where num=? or re_ref=?";
					pstmt = conn.prepareStatement(sql);
					
					
					pstmt.setInt(1, bb.getNum());
					pstmt.setInt(2, bb.getRe_ref());
					
					pstmt.executeUpdate();
					
					check = 0;

					
					// 댓글글 또는 대댓글 글이다.
					}else if(bb.getNum() != bb.getRe_ref()){
						
					System.out.println("댓글 또는 대댓글이다 @@@@@@@@@@@@@@@@@@@@@@@");
					
					 sql="select * from camp_freeboard where re_lev > (select re_lev from camp_freeboard where num = ?) && re_ref = ?";

					 pstmt = conn.prepareStatement(sql);
					 
					 
					 pstmt.setInt(1, bb.getNum());
					 pstmt.setInt(2, rs.getInt("re_ref"));

					 
					 rs = pstmt.executeQuery();
						 

						 while(rs.next()){

							sql = "delete from camp_freeboard where num=?";
							pstmt = conn.prepareStatement(sql);

							pstmt.setInt(1, rs.getInt("num"));
							
							pstmt.executeUpdate();
							 
						 }
						 
						 sql="delete from camp_freeboard where num = ?";
						 pstmt = conn.prepareStatement(sql);
						 
						 pstmt.setInt(1, bb.getNum());

						 pstmt.executeUpdate();

					 
						check = 0;

					 }
					

					
						
				// 삭제할 글이 없다.	
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
		// deletefreeBoard(BoardBean bb) 끝		

		
		
		// deletefreeBoard(BoardBean bb) 시작 ( 캠핑장터 게시판 글 삭제 기능 ) 백업
//		public int deletefreeBoard(BoardBean bb){
//			int check = -1;
//			
//			try {
//				// 1, 2 디비 연결
//				conn = getConnection();
//				// 3 sql 생성 &pstmt 객체 생성
//				sql="select * from camp_freeboard where num=?";
//				
//				pstmt = conn.prepareStatement(sql);
//				
//				System.out.println("@@@@@@@#######가져온 넘버의 값은 : " + bb.getNum());
//				
//				pstmt.setInt(1, bb.getNum());
//				
//				
//				rs = pstmt.executeQuery();
//				
//				if(rs.next()){
//					sql = "delete from camp_freeboard where num=?";
//					pstmt = conn.prepareStatement(sql);
//					
//					
//					pstmt.setInt(1, bb.getNum());
//					
//					pstmt.executeUpdate();
//
//					
//					
//					
//					
//					check = 0;
//						
//				}else{
//					check = -1;
//				}
//				
//				System.out.println("글 삭제 완료" + check);
//				
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}finally {
//				closeDB();
//			}
//
//			
//			return check;
//		}
		// deletefreeBoard(BoardBean bb) 끝 백업
		

/////////////////////////////////////////////////////////////// 답글쓰기 시작 ///////////////////////////////////////////////////////////////////////////////////////

	public void reInsertBoard(BoardBean bb){
		int num = 0;

		
		try {
			// 1) 답글 작성 번호 (num)계산
			
			// 1,2 디비연결
			conn = getConnection();
			
			// 3 sql 구문 & pstmt 객체
			sql = "select max(num) from camp_freeboard";

			pstmt = conn.prepareStatement(sql);
			
			// 4 sql 실행
			rs = pstmt.executeQuery();
			
			// 5 데이터 처리
			if(rs.next()){
				num = rs.getInt(1) + 1; // 인덱스 번호로 접근
				
			}
			
			System.out.println(" 답글 번호 계산 완료 : " + num);
			
			// 2) 답글의 순서 재배치 (정렬)
			// -> re_ref(같은 그룹)안에서 re_seq(순서)를 정렬
			//				"			  기존의 순서 값 보다 큰 값이 있으면 순서를 1 증가
			sql = "update camp_freeboard set re_seq = re_seq+1 where re_ref=? and re_seq>?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			
			// sql 실행
			
			pstmt.executeUpdate();
			
			System.out.println(" 답글 정렬 완료 ");
			
			// 3) 답글 쓰기 
			sql = "insert into camp_freeboard(num,name,id,pw,coment,readcount,date,ip,filename,filename2,filename3,re_ref,re_lev,re_seq) "
					+ "values(?,?,?,?,?,?,now(),?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getId());
			pstmt.setString(4, bb.getPw());
			pstmt.setString(5, bb.getComent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setString(7, bb.getIp());
			pstmt.setString(8, bb.getFilename());
			pstmt.setString(9, bb.getFilename2());
			pstmt.setString(10, bb.getFilename3());
			pstmt.setInt(11, bb.getRe_ref()); // re_ref 원글의 그룹번호 사용
			pstmt.setInt(12, bb.getRe_lev()+1); // re_lev + 1
			pstmt.setInt(13, bb.getRe_seq()+1); // re_seq + 1
			
			// sql 실행
			pstmt.executeUpdate();
			System.out.println(" 답글 작성완료! ");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		

	}		
		
		
		
}
// BoardDAO 끝
