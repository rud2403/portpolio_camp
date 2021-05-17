package com.camp.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.websocket.Session;

import com.camp.member.MemberBean;

public class MemberDAO {

	// Data Access Object : DB 데이터 처리 객체
	// => DB에 관련된 모든 동작을 수행하는 객체
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private DataSource ds = null;
	private String sql = "";
	
	// 디비에 필요한 정보
	// getConnection() 시작
	private Connection getConnection() {

		// Context 객체를 생성
		try {
			// Context 객체를 생성 ( 프로젝트 정보를 가지고 있는 객체 )
			Context initCTX = new InitialContext();

			// DB연동 정보를 불러오기(context.xml)
			ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");

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
	} // getConnection() 끝

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

	
	// insertMember 메소드 시작
	public void insertMember(MemberBean mb) {

		int num = 0;

		try {
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리하는 메소드로 변경
			conn = getConnection();

			// 3 sql (회원 번호를 계산하는 구문)
			sql = "select max(num) from camp_member";

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

			System.out.println(" 회원 번호 : " + num);

			// 3 sql 작성 (insert) & pstmt 객체 생성
			sql = "insert into camp_member values(?, ?, ?, ?, ?, ?, now())";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, mb.getId());
			pstmt.setString(3, mb.getPw());
			pstmt.setString(4, mb.getName());
			pstmt.setString(5, mb.getPhone());
			pstmt.setString(6, mb.getEmail());
			// 4 sql 실행

			pstmt.executeUpdate();

			System.out.println("sql구문 실행 완료 : 회원가입 완료");

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

	} // insertMember 메소드 끝


	// deleteBoard(BoardBean bb) 시작
	public int deleteMember(MemberBean mb) {
		int check = -1;

		try {
			// DB접속 후
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리하는 메소드로 변경
			conn = getConnection();

			// 3. sql작성 & pstmt 객체생성
			sql = "select pw from camp_member where id = ? ";

			pstmt = conn.prepareStatement(sql);
			// ? 채우기

			pstmt.setString(1, mb.getId());
			// 4. sql 실행
			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 아이디가 있는 경우
				if (mb.getPw().equals(rs.getString("pw"))) {
					// 비밀번호 같음

					// sql 구문 작성 & pstmt 객체
					// sql문 하나당 pstmt하나 따라와야함
					sql = "delete from camp_member where id = ? ";
					pstmt = conn.prepareStatement(sql);

					// ? 채우기
					pstmt.setString(1, mb.getId());

					// sql 실행
					pstmt.executeUpdate(); // 정상적으로 실행 됐다면 check = 1;
					
					check = 1; 
				}
				
				System.out.println("회원 탈퇴 완료" + check);

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
			
		} finally{
			closeDB();
		}

		return check;
		
	}
	// deleteMember(MemberBean mb) 끝

	
	/////////// 로그인 멤버 ////////////////////////////////////
	
	// loginMemeber(MemberBean mb) 시작
	public int loginMember(MemberBean mb){
		int check = -1;

		try {
			// DB접속 후
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리하는 메소드로 변경
			conn = getConnection();

			// 3. sql작성 & pstmt 객체생성
			sql = "select pw from camp_member where id = ? ";

			pstmt = conn.prepareStatement(sql);
			// ? 채우기

			
			pstmt.setString(1, mb.getId());
			// 4. sql 실행
			rs = pstmt.executeQuery();

			if(rs.next()){
				// 회원이다
				// 비밀번호를 사용해서 본인 확인
				if(mb.getPw().equals(rs.getString("pw")) ){
					// 비밀번호가 같다 ( + 회원이다 ) => 본인 => 로그인성공
					System.out.println("로그인성공");
					
					check = 1; 
				}
				
				else{
					
					check = 0;
					
				}
				
			}
			
			System.out.println("로그인 완료" + check);


		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace(); 
			
		} finally{
			closeDB();
		}

		return check;
		
	}
		
	
	// infoMemeber() 시작
	public void infoMember(MemberBean mb){
			
		
			try {
				
				
				// 디비 연결 후 필요한 데이터 조회 -> 출력
				
				conn = getConnection();
				
				
				// 3 쿼리 작성(select) & pstmt 작성
				sql = "select * from camp_member where id = ?";
				
				pstmt = conn.prepareStatement(sql);
				
				System.out.println("mb.getId() = " +mb.getId());

				// 4 sql 객체 실행 -> rs에 저장
				
				
				pstmt.setString(1, mb.getId());
				
				rs = pstmt.executeQuery();
				// 5 데이터 처리

				System.out.println("sql 실행완료 ");

				
				if(rs.next()) { 
					// rs에 저장된 정보를 꺼내서 화면에 출력
					
					mb.setId(rs.getString("id"));
					mb.setPw(rs.getString("pw"));
					mb.setName(rs.getString("name"));
					mb.setPhone(rs.getString("phone"));
					mb.setEmail(rs.getString("email"));
					mb.setRegdate(rs.getTimestamp("regdate"));
					
					System.out.println("sql 구문 실행 완료");
					System.out.println("저장된 회원 정보" + mb);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("예외 발생");
			}
			

	}
	// infoMemeber() 끝

	
	// infopreMember(MemberBean mb) 시작
		public int infopreMember(MemberBean mb) {
			int check = -1;

			try {
				// DB접속 후
				// 1 드라이버 로드
				// 2 디비 연결
				// => 한번에 처리하는 메소드로 변경
				conn = getConnection();

				// 3. sql작성 & pstmt 객체생성
				sql = "select pw from camp_member where id = ? ";

				pstmt = conn.prepareStatement(sql);
				// ? 채우기

				pstmt.setString(1, mb.getId());
				// 4. sql 실행
				rs = pstmt.executeQuery();

				if (rs.next()) {
					// 아이디가 있는 경우
					if (mb.getPw().equals(rs.getString("pw"))) {
						// 비밀번호 같음
						
						check = 1; 
					}
					
					System.out.println("회원 비밀번호 확인 완료" + check);

				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace(); 
				
			} finally{
				closeDB();
			}

			return check;
			
		}
		// infopreMember(MemberBean mb) 끝
	

	// updateEmail() 시작
	public int updateEmail(MemberBean mb){		
		int check = -1;
		
		try{
			
			// DB접속 후
			final String DRIVER = "com.mysql.jdbc.Driver";
			final String DBURL = "jdbc:mysql://localhost:3306/portpolio_camp";
			final String DBID = "root";
		 	final String DBPW = "1234";
		 	
		 	// 1. 드라이버 로드
		 	
		 	Class.forName(DRIVER);
		 	
		 	// 2. 디비연결
		 	Connection conn = DriverManager.getConnection(DBURL, DBID, DBPW);
			
		 	// 3. sql작성 & pstmt 객체생성
		 	String sql = "select email from camp_member where id = ? ";

		 	PreparedStatement pstmt = conn.prepareStatement(sql);
		 	
		 	// ? 채우기
		 	pstmt.setString(1, mb.getId());
		 	
		 	// 4. sql 실행
		 	ResultSet rs = pstmt.executeQuery();
		 	

		 	// 5. 데이터 처리
	 		// 아이디가 있는 경우
		 	if(rs.next()){
		 		
		 			
	 			// sql 구문 작성 & pstmt 객체
	 			sql = "update camp_member set email = ? where id = ? ";
	 			
	 			pstmt = conn.prepareStatement(sql);
	 				// sql문 하나당 pstmt하나 따라와야함
	 			
	 			// ? 채우기
	 			pstmt.setString(1, mb.getEmail());
	 			pstmt.setString(2, mb.getId());
	
	 			// sql 실행
	 			
	 			pstmt.executeUpdate();
	 			
	 			check = 0;

				System.out.println("이메일 변경 완료" + check);

		 		}
			}catch (Exception e) {
				e.printStackTrace(); 
				
			}finally{
				closeDB();
			}
			
			
			return check;
		}
		// updateEmail() 끝

	
	// updateName() 시작
		public int updateName(MemberBean mb){		
			int check = -1;
			
			try{
				
				// DB접속 후
				final String DRIVER = "com.mysql.jdbc.Driver";
				final String DBURL = "jdbc:mysql://localhost:3306/portpolio_camp";
				final String DBID = "root";
			 	final String DBPW = "1234";
			 	
			 	// 1. 드라이버 로드
			 	
			 	Class.forName(DRIVER);
			 	
			 	// 2. 디비연결
			 	Connection conn = DriverManager.getConnection(DBURL, DBID, DBPW);
				
			 	// 3. sql작성 & pstmt 객체생성
			 	String sql = "select name from camp_member where id = ? ";

			 	PreparedStatement pstmt = conn.prepareStatement(sql);
			 	
			 	// ? 채우기
			 	pstmt.setString(1, mb.getId());
			 	
			 	// 4. sql 실행
			 	ResultSet rs = pstmt.executeQuery();
			 	

			 // 5. 데이터 처리
		 		// 아이디가 있는 경우
			 	if(rs.next()){
			 		
			 			
			 			// sql 구문 작성 & pstmt 객체
			 			sql = "update camp_member set name = ? where id = ? ";
			 			
			 			pstmt = conn.prepareStatement(sql);
			 				// sql문 하나당 pstmt하나 따라와야함
			 			
			 			// ? 채우기
			 			pstmt.setString(1, mb.getName());
			 			pstmt.setString(2, mb.getId());
			
			 			// sql 실행
			 			
			 			pstmt.executeUpdate();
		 			
		 			check = 0;

					System.out.println("이름 변경 완료" + check);

			 		}
				}catch (Exception e) {
					e.printStackTrace(); 
					
				}finally{
					closeDB();
				}
				
				
				return check;
			}	
		// updateName() 끝


		// updatePhone() 시작
		public int updatePhone(MemberBean mb){		
			int check = -1;
			
			try{
				
				// DB접속 후
				final String DRIVER = "com.mysql.jdbc.Driver";
				final String DBURL = "jdbc:mysql://localhost:3306/portpolio_camp";
				final String DBID = "root";
			 	final String DBPW = "1234";
			 	
			 	// 1. 드라이버 로드
			 	
			 	Class.forName(DRIVER);
			 	
			 	// 2. 디비연결
			 	Connection conn = DriverManager.getConnection(DBURL, DBID, DBPW);
				
			 // 3. sql작성 & pstmt 객체생성
			 	String sql = "select phone from camp_member where id = ? ";

			 	PreparedStatement pstmt = conn.prepareStatement(sql);
			 	
			 	// ? 채우기
			 	pstmt.setString(1, mb.getId());
			 	
			 	// 4. sql 실행
			 	ResultSet rs = pstmt.executeQuery();
			 	

			 	// 5. 데이터 처리
			 		// 아이디가 있는 경우
				 	if(rs.next()){
				 						 			
			 			// sql 구문 작성 & pstmt 객체
			 			sql = "update camp_member set phone = ? where id = ? ";
			 			
			 			pstmt = conn.prepareStatement(sql);
			 				// sql문 하나당 pstmt하나 따라와야함
			 			
			 			// ? 채우기
			 			pstmt.setString(1, mb.getPhone());
			 			pstmt.setString(2, mb.getId());
			
			 			// sql 실행
			 			
			 			pstmt.executeUpdate();
		 			
			 			check = 0;

			 			System.out.println("전화번호 변경 완료" + check);

			 		}
				}catch (Exception e) {
					e.printStackTrace(); 
					
				}finally{
					closeDB();
				}
				
				
				return check;
			}	
		// updatePhone() 끝	
		
		
		
		// updatePw() 시작
//				public int updatePw(MemberBean mb){		
//					int check = -1;
//					
//
//
//					
//					//String pw1 = request.getParameter("pw1");
//					//String pw2 = request.getParameter("pw2");
//					
//					try{
//						
//						// DB접속 후
//						final String DRIVER = "com.mysql.jdbc.Driver";
//						final String DBURL = "jdbc:mysql://localhost:3306/portpolio_camp";
//						final String DBID = "root";
//					 	final String DBPW = "1234";
//					 	
//					 	// 1. 드라이버 로드
//					 	
//					 	Class.forName(DRIVER);
//					 	
//					 	// 2. 디비연결
//					 	Connection conn = DriverManager.getConnection(DBURL, DBID, DBPW);
//						
//					 // 3. sql작성 & pstmt 객체생성
//					 	String sql = "select pw from camp_member where id = ? ";
//
//					 	PreparedStatement pstmt = conn.prepareStatement(sql);
//					 	
//					 	// ? 채우기
//					 	pstmt.setString(1, mb.getId());
//					 	
//					 	// 4. sql 실행
//					 	ResultSet rs = pstmt.executeQuery();
//					 	
//
//					 	// 5. 데이터 처리
//						 	if(rs.next()){
//						 		// 아이디가 있는 경우
//						 		
//						 		
//						 		if(mb.getPw().equals(rs.getString("pw"))){
//						 			// 비밀번호 같음
//						 			
//						 			
//						 			// 새 비밀번호 일치 확인
//						 			if(pw1.equals(pw2)){
//						 				
//						 			// sql 구문 작성 & pstmt 객체
//						 			sql = "update camp_member set pw = ? where id = ? ";
//						 			
//						 			pstmt = conn.prepareStatement(sql);
//						 				// sql문 하나당 pstmt하나 따라와야함
//						 			
//						 			// ? 채우기
//						 			pstmt.setString(1, pw1);
//						 			pstmt.setString(2, mb.getId());
//						
//						 			// sql 실행
//						 			
//						 			pstmt.executeUpdate();
//				 			
//						 			check = 0;
//	
//						 			System.out.println("전화번호 변경 완료" + check);
//
//							 		}else{
//							 			check = -1;
//							 			// 새 비밀번호가 다르다.
//							 		}
//						 		
//						 		}else{
//						 			check = -2;
//						 			//현재 비밀번호가 다르다.
//						 		}
//						 		
//						 	}else{
//						 		check = -3;
//						 		// 아이디가 없다.
//						 	}
//						}catch (Exception e) {
//							e.printStackTrace(); 
//							
//						}finally{
//							closeDB();
//						}
//						
//						
//						return check;
//					}	
				// updatePw() 끝		
	
		
		
		
}
// class MemberDAO 끝