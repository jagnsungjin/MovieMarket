package Rv.Action;

//SQL과 관련된 객체와 List객체, JNDI, 관련 객체를 사용하기 위해 import 합니다.

import javax.naming.Context;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.*;

import Rv.db.RvBean;








public class RvDAO {
	private DataSource ds;
	
	//생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public RvDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}
	//글의 갯수 구하기
	public int getListCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		int x = 0 ; 
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement("select count(*) from BBS_RV");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x=rs.getInt(1);
			}
		} catch (Exception ex) {
			System.out.println("getListCount() 에러 : " + ex );
		} finally {
			if(rs !=null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
		}
		return x;
	}
	// 글 목록 보기
	public List<RvBean> getBoardList(int page, int limit){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		// page : 페이지 
		// limit : 페이지 당 목록의 수 
		// board_re_Ref desc, board_re_seq asc에 의해 정렬한 것을
		// 조건절에 맞는 rnum의 범위 만큼 가져오는 쿼리문입니다.
		
		String board_list_sql = "select * from "
							+ " (select rownum rnum, RV_NO, USER_ID, "
							+ "		RV_SUBJECT, RV_CONTENT, RV_FILE, "
							+ "		RV_RE_REF, RV_RE_LEV, RV_RE_SEQ ,"
							+ "		RV_READ, RV_DATE , RV_CSFC , RV_GRADE"
							+ "		from (select * from BBS_RV "
							+ "				order by RV_RE_REF desc, "
							+ "				RV_RE_SEQ asc)"
							+ "  ) "
							+ "where rnum>=? and rnum<=?";
		List<RvBean> list = new ArrayList<RvBean>();
		// 한 페이지당 10개씩 목록인 경우 				1페이지 ,2페이지 , 3페이지ㄴ, 4페이지 ,
		int startrow = (page-1) * limit +1;	//읽기 시작할 row번호 (1 11 21 31 .... 
		int endrow = startrow + limit -1 ;	//읽을 마지막 row 번호 (10 20 30 40 ... .
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			
			// DB에서 가져온 데이터를 VO 객체에 담습니다. 
			while(rs.next()) {
				RvBean board = new RvBean();
				board.setRV_NO(rs.getInt("RV_NO"));
				board.setUSER_ID(rs.getString("USER_ID"));
				board.setRV_SUBJECT(rs.getString("RV_SUBJECT"));
				board.setRV_CONTENT(rs.getString("RV_CONTENT"));
				board.setRV_FILE(rs.getString("RV_FILE"));
				board.setRV_RE_REF(rs.getInt("RV_RE_REF"));
				board.setRV_RE_LEV(rs.getInt("RV_RE_LEV"));
				board.setRV_RE_SEQ(rs.getInt("RV_RE_SEQ"));
				board.setRV_READ(rs.getInt("RV_READ"));
				board.setRV_DATE(rs.getString("RV_DATE"));
				board.setRV_CSFC(rs.getString("RV_CSFC"));
				board.setRV_GRADE(rs.getString("RV_GRADE"));
				list.add(board);	//값을 담은 객체를 리시트에 저장합니다.
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getBoardList() 에러 : " + ex);
		}finally {
			if(rs !=null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
		}
		return list;
		
	}
	public boolean boardInsert(RvBean board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0 ;
		try {
			con = ds.getConnection();
			
			String max_sql = "(select nvl(max(RV_NO),0)+1 from BBS_RV)";

			// 원문글의 BOARD_RE_REF 필드는 자신의 글번호 입니다.
			String sql = "insert into BBS_RV " 
			            + "(RV_NO,     USER_ID,  RV_PASS, RV_CSFC,  RV_SUBJECT,"
					    + " RV_CONTENT, RV_FILE,  RV_RE_REF," 
			            + " RV_RE_LEV,  RV_RE_SEQ, RV_READ , RV_GRADE)"
					    + " values(" + max_sql + ",?,?,?,?," 
			            + "        ?,?," +   max_sql  + "," 
					    + "        ?,?,?,?)";

			// 새로운 글을 등록하는 부분입니다.
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,board.getUSER_ID());
			pstmt.setString(2, board.getRV_PASS());
			pstmt.setString(3, board.getRV_CSFC());
			pstmt.setString(4, board.getRV_SUBJECT());
			pstmt.setString(5, board.getRV_CONTENT());
			pstmt.setString(6, board.getRV_FILE());
			
			// 원문의 경우 BOARD_RE_LEV, BOARD_RE_SEQ 필드 값은 0입니다.
			pstmt.setInt(7, 0);	//	BOARD_RE_LEV 필드
			pstmt.setInt(8,0);	//	BOARD_RE_SEQ 필드
			pstmt.setInt(9, 0);	//	BOARD READCOUNT 필드
			pstmt.setString(10, board.getRV_GRADE());
			
			result = pstmt.executeUpdate();
			if(result == 1 ) {
				System.out.println("데이터 삽입이 모두 완료되었습니다.");
				return true;
			}
			
		}catch (Exception  ex) {
			System.out.println("boardInsert() 에러 :" + ex);
			ex.printStackTrace();
		}finally {
			if (pstmt !=null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if (con !=null)
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}

		}
		return false;
	}
	public void setReadCountUpdate(int num) {
		Connection con =null;
		PreparedStatement pstmt = null;
		
		String sql = "update BBS_RV "
				+ "		set RV_READ=RV_READ+1 "
				+ "		where RV_NO = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch(SQLException ex) {
			System.out.println("setReadCountUpdate() 에러 : " + ex);
		}finally {
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
		}
		
	}
	public RvBean getDetail(int num) {
		RvBean board = null;
		Connection con = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement("select * from BBS_RV where RV_NO = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				board = new RvBean();
				board.setRV_NO(rs.getInt("RV_NO"));
				board.setUSER_ID(rs.getString("USER_ID"));
				board.setRV_SUBJECT(rs.getString("RV_SUBJECT"));
				board.setRV_CONTENT(rs.getString("RV_CONTENT"));
				board.setRV_FILE(rs.getString("RV_FILE"));
				board.setRV_RE_REF(rs.getInt("RV_RE_REF"));
				board.setRV_RE_LEV(rs.getInt("RV_RE_LEV"));
				board.setRV_RE_SEQ(rs.getInt("RV_RE_SEQ"));
				board.setRV_READ(rs.getInt("RV_READ"));
				board.setRV_DATE(rs.getString("RV_DATE"));
				board.setRV_CSFC(rs.getString("RV_CSFC"));
				board.setRV_GRADE(rs.getString("RV_GRADE"));
				
			}
		}catch (Exception ex) {
			System.out.println("getDetail() 에러:" + ex );
		}finally {
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(rs !=null)
				try {
					rs.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
		}
		return board;
	}
	public int boardReply(RvBean board) {	//답변 등록
		Connection con =null; 
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		int num = 0 ;
		
		//board 테이블의 글번호를 구하기 위해 board_num 필드의 최대값을 구해옵니다.
		String board_max_sql = "select max(RV_NO)+1 from BBS_RV";
		/*
		 * 답변을 달 원문 글 그룹 번호입니다.
		 * 답변을 달게 되면 답변 글은 이 번호와 같은 관련글 번호를 갖게 처리되면서 같은 그룹에 속하게 됩니다.
		 * 글 목록에서 보여줄때 하나의 그룹으로 묶여서 출력됩니다.
		 */
		int re_ref = board.getRV_RE_REF();
		/*
		 * 답급의 깊이를 의미합니다.
		 * 원문에 대한 답글이 출력될 때 한번 들여쓰기 처리가 되고 답글에 대한 답글은 들여쓰기가 두 번 처리되게 합니다.
		 * 원문인 경우에는 이 값이 0이고 원문의 답글은 1, 답글의 답글은 2가됩니다.
		 */
		int re_lev = board.getRV_RE_LEV();
		
		// 같은 관련 글 중에서 해당 글이 출력되는 순서입니다.
		int re_seq = board.getRV_RE_SEQ();
		
		try {
			con = ds.getConnection();
			
			//트랜잭션을 이용하기위해서 setAutoCommit을 false로 설정합니다.
			con.setAutoCommit(false);
			pstmt=con.prepareStatement(board_max_sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			pstmt.close();
			
			// BOARD_RE_REF, BOARD_RE_SEQ 값을 확인하여 원문 글에 다른 답글이 있으면
			// 다른 답글들의 BOARD_RE_SEQ값을 1씩 증가시킵니다.
			// 현재 글을 다른 답글보다 앞에 출력되게 하기 위해서 입니다.
			String sql = "update BBS_RV "
					+ "		set RV_RE_SEQ=RV_RE_SEQ + 1 "
					+ "		where RV_RE_REF = ? "
					+ "		and RV_RE_SEQ > ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setInt(2, re_seq);
			pstmt.executeUpdate();
			pstmt.close();
			
			// 등록할 답변 글의 BOARD_RE_LEV, BOARD_RE_SEQ 값을 원문 글보다 1씩
			// 증가 시킵니다.
			re_seq = re_seq +1;
			re_lev = re_lev +1;
			
			sql = "insert into BBS_RV "
					+ "(RV_NO,USER_ID,RV_PASS,RV_SUBJECT,"
					+ " RV_CONTENT,RV_FILE,RV_RE_REF,"
					+ " RV_RE_LEV, RV_RE_SEQ, RV_READ , RV_CSFC)  "
					+ "	values(" + num +","
					+ "		?,?,?,"
					+ "		?,?,?,"
					+ "		?,?,?,?)";
			
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getUSER_ID());
			pstmt.setString(2, board.getRV_PASS());
			pstmt.setString(3, board.getRV_SUBJECT());
			pstmt.setString(4, board.getRV_CONTENT());
			pstmt.setString(5, "");	//답변에는 파일을 업로드하지 않습니다.
			pstmt.setInt(6,re_ref);
			pstmt.setInt(7, re_lev);
			pstmt.setInt(8, re_seq);
			pstmt.setInt(9, 0);//BOARD_READCOUNT(조회수)는 0
			pstmt.setString(10, board.getRV_CSFC());
			if (pstmt.executeUpdate()==1) {
				con.commit();//commit 합니다.
			}else {
				con.rollback();
			}	
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("boardReply() 에러: " + ex);
			if (con !=null) {
				try {
					con.rollback(); 	//rollback합니다.
					
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}finally {
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.setAutoCommit(true);
					con.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(rs !=null)
				try {
					rs.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
		}
		return num;
	}
	public boolean isBoardWriter(int num, String pass) {
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs= null;
		boolean result = false;
		String board_sql = "select RV_PASS from BBS_RV where RV_NO=?";
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(board_sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(pass.equals(rs.getString("RV_PASS"))){
					result = true;
				}
			}
		} catch (SQLException ex) {
			System.out.println("isBoardWriter() 에러:" + ex);
		}finally {
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(rs !=null)
				try {
					rs.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
		}
		return result;
		
	}
	//글 수정
	public boolean boardModify(RvBean modifyboard) {
		Connection con =null;
		PreparedStatement pstmt =null;
		String sql = "update BBS_RV "
				+ "		set RV_SUBJECT=?, RV_CONTENT=?, RV_FILE=? , RV_GRADE=? "
				+ "		where RV_NO=? ";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,modifyboard.getRV_SUBJECT());
			pstmt.setString(2,modifyboard.getRV_CONTENT());
			pstmt.setString(3,modifyboard.getRV_FILE());
			pstmt.setString(4,modifyboard.getRV_GRADE());
			pstmt.setInt(5, modifyboard.getRV_NO());
			int result = pstmt.executeUpdate();
			if (result ==1) {
				System.out.println("성공 업데이트");
				return true;
			}
		}catch (Exception ex) {
			System.out.println("boardModify() 에러: " + ex);
		}finally {
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}

		}
		return false;

	}// boardModify()메서드 end
	public boolean boardDelete(int num) {	//삭제
		Connection con =null;
		PreparedStatement pstmt =null,pstmt2 = null;
		ResultSet rs = null;
		String select_sql = "select RV_RE_REF, RV_RE_LEV, RV_RE_SEQ "
				+ "			from BBS_RV "
				+ "			where RV_NO=?";
		String board_delete_sql = 
				"delete from BBS_RV "
				+ "			where RV_RE_REF = ?"
				+ "			and	RV_RE_LEV >= ?"
				+ "			and RV_RE_SEQ >= ?"
				+ "			and RV_RE_SEQ <= ("
				+ "								nvl((SELECT min(RV_re_seq ) -1 "
				+ "										from BBS_RV	"
				+ "										WHERE RV_RE_REF = ?"
				+ "										AND		RV_RE_LEV = ?"
				+ "										AND		RV_RE_SEQ > ?) ,"
				+ "										(SELECT max(RV_re_seq) "
				+ "										from	BBS_RV "
				+ "										WHERE RV_RE_REF = ? ))"
				+ "									)";
		boolean result_check = false ;
		try {
			con =ds.getConnection();
			pstmt = con.prepareStatement(select_sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pstmt2 = con.prepareStatement(board_delete_sql);
				pstmt2.setInt(1, rs.getInt("RV_RE_REF"));
				pstmt2.setInt(2, rs.getInt("RV_RE_LEV"));
				pstmt2.setInt(3, rs.getInt("RV_RE_SEQ"));
				pstmt2.setInt(4, rs.getInt("RV_RE_REF"));
				pstmt2.setInt(5, rs.getInt("RV_RE_LEV"));
				pstmt2.setInt(6, rs.getInt("RV_RE_SEQ"));
				pstmt2.setInt(7, rs.getInt("RV_RE_REF"));
				
				int count = pstmt2.executeUpdate();
				
				if(count>=1)
					result_check =true;	//삭제가 안된경우에는 false를 반환합니다.
				
			}
		}catch (Exception ex) {
			System.out.println("boardDelete() 에러:" + ex);
			ex.printStackTrace();
		}finally {
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(rs !=null)
				try {
					rs.close();
				} catch(SQLException ex) {
					ex.printStackTrace();
				}
		}
		return result_check;
		
	}
	public List<RvBean> BoardSearchList(int page, int limit, String searchType, String search) {
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String board_search_list_sql= "";
		String searchs ="";
		
		
		List<RvBean> list = new ArrayList<RvBean>();
		int startrow = (page -1) *limit +1; //읽기 시작할 row 번호(1 11 21 31 ...)
		int endrow = startrow + limit -1 ;  //읽을 마지막 row 번호(10 20 30 40 ...)

		try {
			conn = ds.getConnection();
			if(searchType.equals("subAcon")) {
				searchs = "RV_SUBJECT like '%"+search+"%' or RV_CONTENT like '%"+search +"%' ";			
			}else if(searchType.equals("subject")) {
				searchs = "RV_SUBJECT like '%"+search+"%' ";
			}else if(searchType.equals("content")) {
				searchs = "RV_CONTENT like '%"+search+"%' ";
			}else if(searchType.equals("writer")) {
				searchs = "USER_ID like '%"+search+"%' ";
			}else if(searchType.equals("submov")) {
				searchs = "RV_CSFC like '%"+search+"%' ";
			}
			board_search_list_sql=
					"select * "
					+ "from "
					+ "		(select rownum rnum, RV_NO , RV_PASS,"
					+ " 	RV_CSFC, RV_SUBJECT, "
					+ " 	USER_ID, RV_DATE, RV_READ,"
					+ " 	RV_CONTENT, RV_FILE, RV_RE_REF,"
					+ "		RV_RE_LEV, RV_RE_SEQ ,RV_GRADE FROM "
					+ " 							(select * from BBS_RV "
					+ "								where "+ searchs 
					+ "								order by RV_RE_REF desc, "
					+ "								RV_RE_SEQ asc)"
					+ ") "
					+ " where rnum >= ? and rnum<= ? ";
			pstmt = conn.prepareStatement(board_search_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs= pstmt.executeQuery();
			
			//DB에서 가져온 데이터를 VO객체에 담습니다.
			while (rs.next()) {
				RvBean board = new RvBean();
				board.setRV_NO(rs.getInt(2));
				board.setRV_PASS(rs.getString(3));
				board.setRV_CSFC(rs.getString(4));
				board.setRV_SUBJECT(rs.getString(5));
				board.setUSER_ID(rs.getString(6));
				board.setRV_DATE(rs.getString(7));
				board.setRV_READ(rs.getInt(8));
				board.setRV_CONTENT(rs.getString(9));
				board.setRV_FILE(rs.getString(10));
				board.setRV_RE_REF(rs.getInt(11));
				board.setRV_RE_LEV(rs.getInt(12));
				board.setRV_RE_SEQ(rs.getInt(13));
				board.setRV_GRADE(rs.getString(14));
				list.add(board); //값을 담은 객체를 리스트에 저장합니다.
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("board_search_list_sql() 에러 : " +ex);
		}finally {
			if(rs!=null)
				try {
					rs.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(conn!=null)
				try {
					conn.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
		}
		return list;
	}
	public int SearchListCount(String searchType, String search) {
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String searchs="";
		int x = 0;
		
		try {
			conn = ds.getConnection();
			if(searchType.equals("subAcon")) {
				searchs = "RV_SUBJECT like '%"+search+"%' or RV_CONTENT like '%"+search +"%' ";			
			}else if(searchType.equals("subject")) {
				searchs = "RV_SUBJECT like '%"+search+"%' ";
			}else if(searchType.equals("content")) {
				searchs = "RV_CONTENT like '%"+search+"%' ";
			}else if(searchType.equals("writer")) {
				searchs = "USER_ID like '%"+search+"%' ";
			}else if(searchType.equals("submov")) {
				searchs = "RV_CSFC like '%"+search+"%' ";
			}
			
			String sql = "select count(*) from BBS_RV where "+searchs+"";
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			System.out.println("RVSearchListCount() 에러 :" +ex);
		}finally {
			if(rs !=null)
				try {
					rs.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(conn !=null)
				try {
					conn.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
		}
		return x;
	}

	public List<RvBean> getBoardEnrList(int page, int limit) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		// page : 페이지 
		// limit : 페이지 당 목록의 수 
		// board_re_Ref desc, board_re_seq asc에 의해 정렬한 것을
		// 조건절에 맞는 rnum의 범위 만큼 가져오는 쿼리문입니다.
		
		String board_list_sql = "select * from "
							+ " (select rownum rnum, RV_NO, USER_ID, "
							+ "		RV_SUBJECT, RV_CONTENT, RV_FILE, "
							+ "		RV_RE_REF, RV_RE_LEV, RV_RE_SEQ ,"
							+ "		RV_READ, RV_DATE , RV_CSFC"
							+ "		from (select * from BBS_RV "
							+ "				order by"
							+ "				rv_date asc, "
							+ "				RV_RE_REF desc, "
							+ "				RV_RE_SEQ asc)"
							+ "  ) "
							+ "where rnum>=? and rnum<=? ";
		List<RvBean> list = new ArrayList<RvBean>();
		// 한 페이지당 10개씩 목록인 경우 				1페이지 ,2페이지 , 3페이지, 4페이지 ,
		int startrow = (page-1) * limit +1;	//읽기 시작할 row번호 (1 11 21 31 .... 
		int endrow = startrow + limit -1 ;	//읽을 마지막 row 번호 (10 20 30 40 ... .
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			
			// DB에서 가져온 데이터를 VO 객체에 담습니다. 
			while(rs.next()) {
				RvBean board = new RvBean();
				board.setRV_NO(rs.getInt("RV_NO"));
				board.setUSER_ID(rs.getString("USER_ID"));
				board.setRV_SUBJECT(rs.getString("RV_SUBJECT"));
				board.setRV_CONTENT(rs.getString("RV_CONTENT"));
				board.setRV_FILE(rs.getString("RV_FILE"));
				board.setRV_RE_REF(rs.getInt("RV_RE_REF"));
				board.setRV_RE_LEV(rs.getInt("RV_RE_LEV"));
				board.setRV_RE_SEQ(rs.getInt("RV_RE_SEQ"));
				board.setRV_READ(rs.getInt("RV_READ"));
				board.setRV_DATE(rs.getString("RV_DATE"));
				board.setRV_CSFC(rs.getString("RV_CSFC"));
				list.add(board);	//값을 담은 객체를 리시트에 저장합니다.
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getBoardList() 에러 : " + ex);
		}finally {
			if(rs !=null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
		}
		return list;
	}
	public List<RvBean> getBoardReaList(int page, int limit) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		// page : 페이지 
		// limit : 페이지 당 목록의 수 
		// board_re_Ref desc, board_re_seq asc에 의해 정렬한 것을
		// 조건절에 맞는 rnum의 범위 만큼 가져오는 쿼리문입니다.
		
		String board_list_sql = "select * from "
							+ " (select rownum rnum, RV_NO, USER_ID, "
							+ "		RV_SUBJECT, RV_CONTENT, RV_FILE, "
							+ "		RV_RE_REF, RV_RE_LEV, RV_RE_SEQ ,"
							+ "		RV_READ, RV_DATE , RV_CSFC"
							+ "		from (select * from BBS_RV "
							+ "				order by"
							+ "				rv_read desc, "
							+ "				RV_RE_REF desc, "
							+ "				RV_RE_SEQ asc)"
							+ "  ) "
							+ "where rnum>=? and rnum<=? ";
		List<RvBean> list = new ArrayList<RvBean>();
		// 한 페이지당 10개씩 목록인 경우 				1페이지 ,2페이지 , 3페이지, 4페이지 ,
		int startrow = (page-1) * limit +1;	//읽기 시작할 row번호 (1 11 21 31 .... 
		int endrow = startrow + limit -1 ;	//읽을 마지막 row 번호 (10 20 30 40 ... .
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			
			// DB에서 가져온 데이터를 VO 객체에 담습니다. 
			while(rs.next()) {
				RvBean board = new RvBean();
				board.setRV_NO(rs.getInt("RV_NO"));
				board.setUSER_ID(rs.getString("USER_ID"));
				board.setRV_SUBJECT(rs.getString("RV_SUBJECT"));
				board.setRV_CONTENT(rs.getString("RV_CONTENT"));
				board.setRV_FILE(rs.getString("RV_FILE"));
				board.setRV_RE_REF(rs.getInt("RV_RE_REF"));
				board.setRV_RE_LEV(rs.getInt("RV_RE_LEV"));
				board.setRV_RE_SEQ(rs.getInt("RV_RE_SEQ"));
				board.setRV_READ(rs.getInt("RV_READ"));
				board.setRV_DATE(rs.getString("RV_DATE"));
				board.setRV_CSFC(rs.getString("RV_CSFC"));
				list.add(board);	//값을 담은 객체를 리시트에 저장합니다.
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getBoardList() 에러 : " + ex);
		}finally {
			if(rs !=null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if(con !=null)
				try {
					con.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			if(pstmt !=null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
		}
		return list;
	}
	public List<RvBean> BoardSearchEnrList(int page, int limit, String searchType, String search) {
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String board_search_list_sql= "";
		String searchs ="";
		
		
		List<RvBean> list = new ArrayList<RvBean>();
		int startrow = (page -1) *limit +1; //읽기 시작할 row 번호(1 11 21 31 ...)
		int endrow = startrow + limit -1 ;  //읽을 마지막 row 번호(10 20 30 40 ...)

		try {
			conn = ds.getConnection();
			if(searchType.equals("subAcon")) {
				searchs = "RV_SUBJECT like '%"+search+"%' or RV_CONTENT like '%"+search +"%' ";			
			}else if(searchType.equals("subject")) {
				searchs = "RV_SUBJECT like '%"+search+"%' ";
			}else if(searchType.equals("content")) {
				searchs = "RV_CONTENT like '%"+search+"%' ";
			}else if(searchType.equals("writer")) {
				searchs = "USER_ID like '%"+search+"%' ";
			}else if(searchType.equals("submov")) {
				searchs = "RV_CSFC like '%"+search+"%' ";
			}
			board_search_list_sql=
					"select * "
					+ "from "
					+ "		(select rownum rnum, RV_NO , RV_PASS,"
					+ " 	RV_CSFC, RV_SUBJECT, "
					+ " 	USER_ID, RV_DATE, RV_READ,"
					+ " 	RV_CONTENT, RV_FILE, RV_RE_REF,"
					+ "		RV_RE_LEV, RV_RE_SEQ FROM "
					+ " 							(select * from BBS_RV "						
					+ "								order by rv_date asc, RV_RE_REF desc, "
					+ "								RV_RE_SEQ asc)"
					+ ") "
					+ " where rnum >= ? and rnum<= ?"
					+ " and "+ searchs ;
			pstmt = conn.prepareStatement(board_search_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs= pstmt.executeQuery();
			
			//DB에서 가져온 데이터를 VO객체에 담습니다.
			while (rs.next()) {
				RvBean board = new RvBean();
				board.setRV_NO(rs.getInt(2));
				board.setRV_PASS(rs.getString(3));
				board.setRV_CSFC(rs.getString(4));
				board.setRV_SUBJECT(rs.getString(5));
				board.setUSER_ID(rs.getString(6));
				board.setRV_DATE(rs.getString(7));
				board.setRV_READ(rs.getInt(8));
				board.setRV_CONTENT(rs.getString(9));
				board.setRV_FILE(rs.getString(10));
				board.setRV_RE_REF(rs.getInt(11));
				board.setRV_RE_LEV(rs.getInt(12));
				board.setRV_RE_SEQ(rs.getInt(13));
				list.add(board); //값을 담은 객체를 리스트에 저장합니다.
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("board_search_list_sql() 에러 : " +ex);
		}finally {
			if(rs!=null)
				try {
					rs.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(conn!=null)
				try {
					conn.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
		}
		return list;
	}
	public List<RvBean> BoardSearchReaList(int page, int limit,String searchType, String search) {
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String board_search_list_sql= "";
		String searchs ="";
		
		
		List<RvBean> list = new ArrayList<RvBean>();
		int startrow = (page -1) *limit +1; //읽기 시작할 row 번호(1 11 21 31 ...)
		int endrow = startrow + limit -1 ;  //읽을 마지막 row 번호(10 20 30 40 ...)

		try {
			conn = ds.getConnection();
			if(searchType.equals("subAcon")) {
				searchs = "RV_SUBJECT like '%"+search+"%' or RV_CONTENT like '%"+search +"%' ";			
			}else if(searchType.equals("subject")) {
				searchs = "RV_SUBJECT like '%"+search+"%' ";
			}else if(searchType.equals("content")) {
				searchs = "RV_CONTENT like '%"+search+"%' ";
			}else if(searchType.equals("writer")) {
				searchs = "USER_ID like '%"+search+"%' ";
			}else if(searchType.equals("submov")) {
				searchs = "RV_CSFC like '%"+search+"%' ";
			}
			board_search_list_sql=
					"select * "
					+ "from "
					+ "		(select rownum rnum, RV_NO , RV_PASS,"
					+ " 	RV_CSFC, RV_SUBJECT, "
					+ " 	USER_ID, RV_DATE, RV_READ,"
					+ " 	RV_CONTENT, RV_FILE, RV_RE_REF,"
					+ "		RV_RE_LEV, RV_RE_SEQ FROM "
					+ " 							(select * from BBS_RV "						
					+ "								order by rv_read desc, RV_RE_REF desc, "
					+ "								RV_RE_SEQ asc)"
					+ ") "
					+ " where rnum >= ? and rnum<= ?"
					+ " and "+ searchs ;
			pstmt = conn.prepareStatement(board_search_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs= pstmt.executeQuery();
			
			//DB에서 가져온 데이터를 VO객체에 담습니다.
			while (rs.next()) {
				RvBean board = new RvBean();
				board.setRV_NO(rs.getInt(2));
				board.setRV_PASS(rs.getString(3));
				board.setRV_CSFC(rs.getString(4));
				board.setRV_SUBJECT(rs.getString(5));
				board.setUSER_ID(rs.getString(6));
				board.setRV_DATE(rs.getString(7));
				board.setRV_READ(rs.getInt(8));
				board.setRV_CONTENT(rs.getString(9));
				board.setRV_FILE(rs.getString(10));
				board.setRV_RE_REF(rs.getInt(11));
				board.setRV_RE_LEV(rs.getInt(12));
				board.setRV_RE_SEQ(rs.getInt(13));
				list.add(board); //값을 담은 객체를 리스트에 저장합니다.
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("board_search_list_sql() 에러 : " +ex);
		}finally {
			if(rs!=null)
				try {
					rs.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(conn!=null)
				try {
					conn.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
		}
		return list;
	}






}
