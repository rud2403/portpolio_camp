package com.camp.reply;

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

public class ReplyDAO {

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
	
/////////////////////////////////////////// 댓글 DAO ////////////////////////////////////////////////////////////////////
	
	// insertReply(ReplyBean rb) 시작 ( 자유 게시판 글쓰기 기능 )
	public int insertReply(ReplyBean rb) {
		int check = 0;
		int num = 0;

		try {
			// 1 드라이버 로드
			// 2 디비 연결
			// => 한번에 처리하는 메소드로 변경
			conn = getConnection();

			// 3 sql (글 번호를 계산하는 구문)
			sql = "select max(rnum) from camp_reply";

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
			sql = "insert into camp_reply values(?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);
			pstmt.setString(2, rb.getMid());
			pstmt.setString(3, rb.getBname());
			pstmt.setString(4, rb.getComent());		
			pstmt.setInt(5, num);
			pstmt.setInt(6, rb.getRe_lev());
			pstmt.setInt(7, rb.getRe_seq());

			// 4 sql 실행
			pstmt.executeUpdate();

			System.out.println("sql구문 실행 완료 : 댓글쓰기 완료");

		} catch (SQLException e) {
			System.out.println("디비 연결 실패 !!");
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return check;
	}
	// insertReply(ReplyBean rb) 끝		
	

	// getReplyCount() 시작 (댓글 개수 기능)
	public int getReplyCount() {

		int cnt = 0;

		try {
			// 1, 2 드라이버로드, 디비연결
			conn = getConnection();

			// 3 sql 작성(select) & pstmt 객체 생성
			sql = "select count(*) from camp_reply";

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
	// getReplyCount() 끝	
	
	// getfreeBoardCount() 끝		

	// getReplyList() 시작
	public ArrayList getReplyList() {
		// DB데이터 1행의 정보를 BoardBean에 저장 -> ArrayList 한칸에 저장

		// 게시판의 글 정보를 원하는 만큼 저장하는 가변길이 배열
		ArrayList ReplyList = new ArrayList();

		// 게시판 글 1개의 정보를 저장하는 객체
		ReplyBean rb = null;

		try {
			// 1, 2 드라이버 로드, 디비 열결
			conn = getConnection();

			// 3sql 구문 & pstmtm객체
			// 글 정보 정렬 - re_ref 값을 최신글 위쪽으로 정렬(내림차순)
			//				- re_seq 값을 사용 (오름 차순)
			//				- limit a, b (a 시작, b 개수)
			//				ex) 1번글 -> 0번 인덱스
			
			
			sql = "select * from camp_reply order by re_ref asc, re_seq asc";			

			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();

			// 5 데이터 처리
			while (rs.next()) {
				// 데이터 있을 때 bb 객체 생성
				rb = new ReplyBean();

				// DB정보를 Bean에 저장하기
				rb.setRnum(rs.getInt("rnum"));
				rb.setMid(rs.getString("mid"));
				rb.setBname(rs.getString("bname"));
				rb.setComent(rs.getString("coment"));
				
				// Bean -> ArrayList 한칸에 저장
				ReplyList.add(rb);

			} // while
			
			System.out.println(" 게시판 모든 정보 저장완료 ");
			System.out.println(" 총 " + ReplyList.size() + " 개");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return ReplyList;
	}
	// getReplyList() 끝		

	// correctReply(ReplyBean rb) 시작 ( 자유게시판 게시글 글 정보 수정 기능 )
	public int correctReply(ReplyBean rb){
		
		int check = -1;
		
		try {
			// 1, 2 디비 연결
			conn = getConnection();

			// 3 sql 작성(select - 본인확인) & pstmt 객체
			sql = "select * from camp_reply where rnum=?";
			
			
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setInt(1, rb.getRnum());

			//4 sql 실행
			rs = pstmt.executeQuery();

			//5 데이터 처리
			if(rs.next()){
				// 글이 있음
				
				// sql (update-글 수정) & pstmtm 객체
				sql = "update camp_reply set coment=? where rnum=?";
				
				pstmt = conn.prepareStatement(sql);
				
				// ? 채우기

				pstmt.setString(1, rb.getComent());
				pstmt.setInt(2, rb.getRnum());

				// 4 sql 실행
				pstmt.executeUpdate();
				
				
				check = 0;
				
				//check = 1;
										
			}else{
				// 글이 없음
				check = -1;
			}
			
			System.out.println(" 댓글 수정 완료 !" + check);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}			
		return check;

	}
	// correctReply(ReplyBean rb) 끝	

	// deleteReply(ReplyBean rb) 시작 ( 캠핑장터 게시판 글 삭제 기능 )
	public int deleteReply(ReplyBean rb){
		int check = -1;
		
		try {
			// 1, 2 디비 연결
			conn = getConnection();
			// 3 sql 생성 &pstmt 객체 생성
			sql="select * from camp_reply where rnum=?";
			
			pstmt = conn.prepareStatement(sql);
			
			System.out.println("@@@@@@@#######가져온 넘버의 값은 : " + rb.getRnum());
			
			pstmt.setInt(1, rb.getRnum());
			
			rs = pstmt.executeQuery();
			
			// 삭제할 글이 있다.
			if(rs.next()){
				
				// 본문글이다.
				if(rb.getRnum() == rb.getRe_ref()){
				System.out.println("본문 댓글이다 @@@@@@@@@@@@@@@@@@@@@@@");
					
				sql = "delete from camp_reply where rnum=? or re_ref=?";
				pstmt = conn.prepareStatement(sql);
				
				
				pstmt.setInt(1, rb.getRnum());
				pstmt.setInt(2, rb.getRe_ref());
				
				pstmt.executeUpdate();
				
				check = 0;

				
				// 댓글글 또는 대댓글 글이다.
				}else if(rb.getRnum() != rb.getRe_ref()){
					
				System.out.println("댓글 또는 대댓글이다 @@@@@@@@@@@@@@@@@@@@@@@");
				
				 sql="select * from camp_reply where re_lev > (select re_lev from camp_reply where rnum = ?) && re_ref = ?";

				 pstmt = conn.prepareStatement(sql);
				 
				 
				 pstmt.setInt(1, rb.getRnum());
				 pstmt.setInt(2, rs.getInt("re_ref"));

				 
				 rs = pstmt.executeQuery();

					 while(rs.next()){

						sql = "delete from camp_reply where rnum=?";
						pstmt = conn.prepareStatement(sql);

						pstmt.setInt(1, rs.getInt("rnum"));
						
						pstmt.executeUpdate();
						 
					 }
					 
					 sql="delete from camp_reply where rnum = ?";
					 pstmt = conn.prepareStatement(sql);
					 
					 pstmt.setInt(1, rb.getRnum());

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
	// deleteReply(ReplyBean rb) 끝	

	
	// insertReReply(rb) 시작
	public ReplyBean insertReReply(ReplyBean rb){
		int check = -1;
		int num = 0;

		
		try {
			// 1) 답글 작성 번호 (num)계산
			
			// 1,2 디비연결
			conn = getConnection();
			
			// 3 sql 구문 & pstmt 객체
			sql = "select max(rnum) from camp_reply";

			pstmt = conn.prepareStatement(sql);
			
			// 4 sql 실행
			rs = pstmt.executeQuery();
			
			// 5 데이터 처리
			if(rs.next()){
				num = rs.getInt(1) + 1; // 인덱스 번호로 접근
				
			}
			
			System.out.println(" 답글 번호 계산 완료 : " + num);
			
			
			sql ="select * from camp_reply where rnum =?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, rb.getRnum());
			
			rs = pstmt.executeQuery();

			if(rs.next()){

			// 2) 답글의 순서 재배치 (정렬)
			// -> re_ref(같은 그룹)안에서 re_seq(순서)를 정렬
			//				"			  기존의 순서 값 보다 큰 값이 있으면 순서를 1 증가
			sql = "update camp_reply set re_seq = re_seq+1 where re_ref=? and re_seq>?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, rs.getInt("re_ref"));
			pstmt.setInt(2, rs.getInt("re_seq"));
			
			// sql 실행
			
			pstmt.executeUpdate();
			
			System.out.println(" 답글 정렬 완료 ");
			
			// 3) 답글 쓰기 
			sql = "insert into camp_reply(rnum,mid,bname,coment,re_ref,re_lev,re_seq) "
					+ "values(?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, rb.getMid());
			pstmt.setString(3, rs.getString("bname"));
			pstmt.setString(4, rb.getComent());
			pstmt.setInt(5, rs.getInt("re_ref"));
			pstmt.setInt(6, rs.getInt("re_lev")+1); // re_lev + 1
			pstmt.setInt(7, rs.getInt("re_seq")+1); // re_seq + 1
			
			// sql 실행
			pstmt.executeUpdate();
			

			System.out.println(" 답글 작성완료! ");
			
			sql = "select * from camp_reply where num = ?";

			pstmt = conn.prepareStatement(sql);

			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
					
			if(rs.next()){
	
				
			rb.setRe_ref(rs.getInt("re_ref"));
			rb.setRe_lev(rs.getInt("re_lev"));
			rb.setRe_seq(rs.getInt("re_seq"));
			
			}
			
			check = 0;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return rb;
	}	
	// insertReReply(rb) 시작
	
}
// ReplyDAO 끝