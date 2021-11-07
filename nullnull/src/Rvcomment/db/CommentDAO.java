package Rvcomment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;







public class CommentDAO {
	private DataSource ds;
	public CommentDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}
	//댓글 등록하기
	public int commentsInsert(Comment c) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0 ;
		try {
			con = ds.getConnection();
			

			String sql="insert into BBS_RCM "
					+ "(RCM_NO, RCM_ID, RCM_CONTENT, RCM_REG_DATE,"
					+ " RCM_COMMENT_BOARD_NUM,	RCM_COMMENT_RE_REF, RCM_COMMENT_RE_LEV,"
					+ " RCM_COMMENT_RE_SEQ)" //(num..부터 여기까지 짤라도됨
					+ " values(RCM_SEQ.NEXTVAL,?,?,SYSDATE,"
					+ "			?,RCM_SEQ.NEXTVAL,?,"
					+ "			?)";
			// 새로운 글을 등록하는 부분입니다.
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,c.getRCM_ID());
			pstmt.setString(2,c.getRCM_CONTENT());
			pstmt.setInt(3,c.getRCM_COMMENT_BOARD_NUM());
			pstmt.setInt(4,c.getRCM_COMMENT_RE_LEV());
			pstmt.setInt(5,c.getRCM_COMMENT_RE_SEQ());
	
			result = pstmt.executeUpdate();
			if(result == 1 ) {
				System.out.println("데이터 삽입 완료되었습니다.");
			}
			
		}catch (Exception  ex) {
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
		return result;
		
	}
	public int getListCount(int RCM_COMMENT_BOARD_NUM) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		int x = 0; 

		
		try {
			con = ds.getConnection();
			String sql = "select count(*) "
					+ "		from BBS_RCM where RCM_COMMENT_BOARD_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, RCM_COMMENT_BOARD_NUM);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch (Exception ex){
			ex.printStackTrace();
			System.out.println("getListCount() 에러:" + ex);
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
			if(rs !=null)
				try {
					rs.close();
				}catch (SQLException ex) {
					ex.printStackTrace();
				}

		}
		return x ;
	}
	public JsonArray getCommentList(int comment_board_num, int state) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String sort = "asc";
		if(state == 2) {
			sort="desc";
		}
		
		String sql = "select RCM_NO, BBS_RCM.RCM_ID , RCM_CONTENT , RCM_REG_DATE, RCM_COMMENT_RE_LEV, "
				+ "		RCM_COMMENT_RE_SEQ, "
				+ "		RCM_COMMENT_RE_REF, member.USER_FILE "
				+ "		from BBS_RCM join member "
				+ "		on BBS_RCM.RCM_ID=member.USER_ID "
				+ "		where RCM_COMMENT_BOARD_NUM = ? "
				+ "		order by RCM_COMMENT_RE_REF " + sort + ", "
				+ "		RCM_COMMENT_RE_SEQ asc";
		JsonArray array = new JsonArray();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, comment_board_num);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				JsonObject object = new JsonObject();
				object.addProperty("RCM_NO", rs.getInt(1));
				object.addProperty("RCM_ID",rs.getString(2));
				object.addProperty("RCM_CONTENT",rs.getString(3));
				object.addProperty("RCM_REG_DATE",rs.getString(4));
				object.addProperty("RCM_COMMENT_RE_LEV",rs.getInt(5));
				object.addProperty("RCM_COMMENT_RE_SEQ",rs.getInt(6));
				object.addProperty("RCM_COMMENT_RE_REF",rs.getInt(7));
				object.addProperty("USER_FILE",rs.getString(8));
				array.add(object);
	
			}
		} catch(Exception ex) {
			ex.printStackTrace();
			System.out.println("getCommentList() 에러 : " + ex);
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
			if(rs !=null)
				try {
					rs.close();
				}catch (SQLException ex) {
					ex.printStackTrace();
				}

		}
		return array;
	}
	public int commentsUpdate(Comment co) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0 ;
		
		try {
			con=ds.getConnection();
			String sql = "update BBS_RCM set RCM_CONTENT=? "
					+ "		where RCM_NO= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, co.getRCM_CONTENT());
			pstmt.setInt(2, co.getRCM_NO());
			
			result = pstmt.executeUpdate();
			if(result == 1)
				System.out.println("데이터 수정 되었습니다.");
		}catch (Exception e) {
			e.printStackTrace();
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
		return result;
	}
	public int commentsReply(Comment c) {
		Connection con =null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			StringBuilder update_sql = new StringBuilder();
			update_sql.append("update BBS_RCM ");
			update_sql.append( "set    RCM_COMMENT_RE_SEQ=RCM_COMMENT_RE_SEQ +1 ");
			update_sql.append("where   RCM_COMMENT_RE_REF = ? ");
			update_sql.append("and     RCM_COMMENT_RE_SEQ > ? ");
			pstmt = con.prepareStatement(update_sql.toString());
			pstmt.setInt(1, c.getRCM_COMMENT_RE_REF());
			pstmt.setInt(2, c.getRCM_COMMENT_RE_SEQ());
			pstmt.executeUpdate();
			pstmt.close();
			
			String sql = "insert into BBS_RCM  "
					 + "values(RCM_SEQ.nextval, ? , ? ,sysdate, ?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, c.getRCM_ID());
			pstmt.setString(2, c.getRCM_CONTENT());
			pstmt.setInt(3, c.getRCM_COMMENT_BOARD_NUM());
			pstmt.setInt(4, c.getRCM_COMMENT_RE_LEV()+1);
			pstmt.setInt(5, c.getRCM_COMMENT_RE_SEQ()+1);
			pstmt.setInt(6, c.getRCM_COMMENT_RE_REF());
			result = pstmt.executeUpdate();
			if(result ==1) {
				System.out.println("reply 삽입 완료되었습니다.");
				con.commit();
			}else {
				con.rollback();
			}
		}catch (Exception e) {
			e.printStackTrace();
			try {
				con.rollback();
			} catch(SQLException e1) {
				e1.printStackTrace();
			}
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
		return result;
		
	}
	public boolean commentsDelete(int bCM_NO) {
		Connection conn = null;
		PreparedStatement pstmt =null, pstmt2=null;
		ResultSet rs =null;
		String select_sql = "select RCM_COMMENT_RE_REF, RCM_COMMENT_RE_LEV, RCM_COMMENT_RE_SEQ "
						+ " from BBS_RCM"
						+ " where RCM_NO=?";
		
		String board_delete_sql = "delete from BBS_RCM"
				+ " 		where	RCM_COMMENT_RE_REF = ?"
				+ "			and		RCM_COMMENT_RE_LEV >=?"
				+ "			and		RCM_COMMENT_RE_SEQ >=?"
				+ "			and		RCM_COMMENT_RE_SEQ <=("
				+ "								nvl((SELECT min(RCM_COMMENT_RE_SEQ )-1"
				+ "									FROM	BBS_RCM	"
				+ "									WHERE	RCM_COMMENT_RE_REF=? "
				+ "									AND		RCM_COMMENT_RE_LEV=?"
				+ "									AND		RCM_COMMENT_RE_SEQ>?) , "
				+ "									(SELECT max(RCM_COMMENT_RE_SEQ) "
				+ "									 FROM BBS_RCM "
				+ "									 WHERE RCM_COMMENT_RE_REF=? ))"
				+ "									)";
		boolean result_check = false;
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(select_sql);
			pstmt.setInt(1, bCM_NO);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pstmt2 = conn.prepareStatement(board_delete_sql);
				pstmt2.setInt(1, rs.getInt("RCM_COMMENT_RE_REF"));
				pstmt2.setInt(2, rs.getInt("RCM_COMMENT_RE_LEV"));
				pstmt2.setInt(3, rs.getInt("RCM_COMMENT_RE_SEQ"));
				pstmt2.setInt(4, rs.getInt("RCM_COMMENT_RE_REF"));
				pstmt2.setInt(5, rs.getInt("RCM_COMMENT_RE_LEV"));
				pstmt2.setInt(6, rs.getInt("RCM_COMMENT_RE_SEQ"));
				pstmt2.setInt(7, rs.getInt("RCM_COMMENT_RE_REF"));
				
				int count=pstmt2.executeUpdate();
				
				if(count >=1)
					result_check=true;//삭제가 안된 경우에는 false를 반환합니다.
			}
		} catch (Exception ex) {
			System.out.println("BBS_BCMDelete() 에러 : " + ex);
		}finally {
			if(rs != null)
				try {
					rs.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(pstmt != null)
				try {
					pstmt.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			if(conn != null)
				try {
					conn.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
		}
		return result_check;
	}
		



}
