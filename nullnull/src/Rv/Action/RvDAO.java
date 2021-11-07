package Rv.Action;

//SQL�� ���õ� ��ü�� List��ü, JNDI, ���� ��ü�� ����ϱ� ���� import �մϴ�.

import javax.naming.Context;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.*;

import Rv.db.RvBean;








public class RvDAO {
	private DataSource ds;
	
	//�����ڿ��� JNDI ���ҽ��� �����Ͽ� Connection ��ü�� ���ɴϴ�.
	public RvDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
			System.out.println("DB ���� ���� : " + ex);
			return;
		}
	}
	//���� ���� ���ϱ�
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
			System.out.println("getListCount() ���� : " + ex );
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
	// �� ��� ����
	public List<RvBean> getBoardList(int page, int limit){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		
		// page : ������ 
		// limit : ������ �� ����� �� 
		// board_re_Ref desc, board_re_seq asc�� ���� ������ ����
		// �������� �´� rnum�� ���� ��ŭ �������� �������Դϴ�.
		
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
		// �� �������� 10���� ����� ��� 				1������ ,2������ , 3��������, 4������ ,
		int startrow = (page-1) * limit +1;	//�б� ������ row��ȣ (1 11 21 31 .... 
		int endrow = startrow + limit -1 ;	//���� ������ row ��ȣ (10 20 30 40 ... .
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			
			// DB���� ������ �����͸� VO ��ü�� ����ϴ�. 
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
				list.add(board);	//���� ���� ��ü�� ����Ʈ�� �����մϴ�.
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getBoardList() ���� : " + ex);
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

			// �������� BOARD_RE_REF �ʵ�� �ڽ��� �۹�ȣ �Դϴ�.
			String sql = "insert into BBS_RV " 
			            + "(RV_NO,     USER_ID,  RV_PASS, RV_CSFC,  RV_SUBJECT,"
					    + " RV_CONTENT, RV_FILE,  RV_RE_REF," 
			            + " RV_RE_LEV,  RV_RE_SEQ, RV_READ , RV_GRADE)"
					    + " values(" + max_sql + ",?,?,?,?," 
			            + "        ?,?," +   max_sql  + "," 
					    + "        ?,?,?,?)";

			// ���ο� ���� ����ϴ� �κ��Դϴ�.
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,board.getUSER_ID());
			pstmt.setString(2, board.getRV_PASS());
			pstmt.setString(3, board.getRV_CSFC());
			pstmt.setString(4, board.getRV_SUBJECT());
			pstmt.setString(5, board.getRV_CONTENT());
			pstmt.setString(6, board.getRV_FILE());
			
			// ������ ��� BOARD_RE_LEV, BOARD_RE_SEQ �ʵ� ���� 0�Դϴ�.
			pstmt.setInt(7, 0);	//	BOARD_RE_LEV �ʵ�
			pstmt.setInt(8,0);	//	BOARD_RE_SEQ �ʵ�
			pstmt.setInt(9, 0);	//	BOARD READCOUNT �ʵ�
			pstmt.setString(10, board.getRV_GRADE());
			
			result = pstmt.executeUpdate();
			if(result == 1 ) {
				System.out.println("������ ������ ��� �Ϸ�Ǿ����ϴ�.");
				return true;
			}
			
		}catch (Exception  ex) {
			System.out.println("boardInsert() ���� :" + ex);
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
			System.out.println("setReadCountUpdate() ���� : " + ex);
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
			System.out.println("getDetail() ����:" + ex );
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
	public int boardReply(RvBean board) {	//�亯 ���
		Connection con =null; 
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		int num = 0 ;
		
		//board ���̺��� �۹�ȣ�� ���ϱ� ���� board_num �ʵ��� �ִ밪�� ���ؿɴϴ�.
		String board_max_sql = "select max(RV_NO)+1 from BBS_RV";
		/*
		 * �亯�� �� ���� �� �׷� ��ȣ�Դϴ�.
		 * �亯�� �ް� �Ǹ� �亯 ���� �� ��ȣ�� ���� ���ñ� ��ȣ�� ���� ó���Ǹ鼭 ���� �׷쿡 ���ϰ� �˴ϴ�.
		 * �� ��Ͽ��� �����ٶ� �ϳ��� �׷����� ������ ��µ˴ϴ�.
		 */
		int re_ref = board.getRV_RE_REF();
		/*
		 * ����� ���̸� �ǹ��մϴ�.
		 * ������ ���� ����� ��µ� �� �ѹ� �鿩���� ó���� �ǰ� ��ۿ� ���� ����� �鿩���Ⱑ �� �� ó���ǰ� �մϴ�.
		 * ������ ��쿡�� �� ���� 0�̰� ������ ����� 1, ����� ����� 2���˴ϴ�.
		 */
		int re_lev = board.getRV_RE_LEV();
		
		// ���� ���� �� �߿��� �ش� ���� ��µǴ� �����Դϴ�.
		int re_seq = board.getRV_RE_SEQ();
		
		try {
			con = ds.getConnection();
			
			//Ʈ������� �̿��ϱ����ؼ� setAutoCommit�� false�� �����մϴ�.
			con.setAutoCommit(false);
			pstmt=con.prepareStatement(board_max_sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1);
			}
			pstmt.close();
			
			// BOARD_RE_REF, BOARD_RE_SEQ ���� Ȯ���Ͽ� ���� �ۿ� �ٸ� ����� ������
			// �ٸ� ��۵��� BOARD_RE_SEQ���� 1�� ������ŵ�ϴ�.
			// ���� ���� �ٸ� ��ۺ��� �տ� ��µǰ� �ϱ� ���ؼ� �Դϴ�.
			String sql = "update BBS_RV "
					+ "		set RV_RE_SEQ=RV_RE_SEQ + 1 "
					+ "		where RV_RE_REF = ? "
					+ "		and RV_RE_SEQ > ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setInt(2, re_seq);
			pstmt.executeUpdate();
			pstmt.close();
			
			// ����� �亯 ���� BOARD_RE_LEV, BOARD_RE_SEQ ���� ���� �ۺ��� 1��
			// ���� ��ŵ�ϴ�.
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
			pstmt.setString(5, "");	//�亯���� ������ ���ε����� �ʽ��ϴ�.
			pstmt.setInt(6,re_ref);
			pstmt.setInt(7, re_lev);
			pstmt.setInt(8, re_seq);
			pstmt.setInt(9, 0);//BOARD_READCOUNT(��ȸ��)�� 0
			pstmt.setString(10, board.getRV_CSFC());
			if (pstmt.executeUpdate()==1) {
				con.commit();//commit �մϴ�.
			}else {
				con.rollback();
			}	
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("boardReply() ����: " + ex);
			if (con !=null) {
				try {
					con.rollback(); 	//rollback�մϴ�.
					
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
			System.out.println("isBoardWriter() ����:" + ex);
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
	//�� ����
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
				System.out.println("���� ������Ʈ");
				return true;
			}
		}catch (Exception ex) {
			System.out.println("boardModify() ����: " + ex);
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

	}// boardModify()�޼��� end
	public boolean boardDelete(int num) {	//����
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
					result_check =true;	//������ �ȵȰ�쿡�� false�� ��ȯ�մϴ�.
				
			}
		}catch (Exception ex) {
			System.out.println("boardDelete() ����:" + ex);
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
		int startrow = (page -1) *limit +1; //�б� ������ row ��ȣ(1 11 21 31 ...)
		int endrow = startrow + limit -1 ;  //���� ������ row ��ȣ(10 20 30 40 ...)

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
			
			//DB���� ������ �����͸� VO��ü�� ����ϴ�.
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
				list.add(board); //���� ���� ��ü�� ����Ʈ�� �����մϴ�.
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("board_search_list_sql() ���� : " +ex);
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
			System.out.println("RVSearchListCount() ���� :" +ex);
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
		
		// page : ������ 
		// limit : ������ �� ����� �� 
		// board_re_Ref desc, board_re_seq asc�� ���� ������ ����
		// �������� �´� rnum�� ���� ��ŭ �������� �������Դϴ�.
		
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
		// �� �������� 10���� ����� ��� 				1������ ,2������ , 3������, 4������ ,
		int startrow = (page-1) * limit +1;	//�б� ������ row��ȣ (1 11 21 31 .... 
		int endrow = startrow + limit -1 ;	//���� ������ row ��ȣ (10 20 30 40 ... .
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			
			// DB���� ������ �����͸� VO ��ü�� ����ϴ�. 
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
				list.add(board);	//���� ���� ��ü�� ����Ʈ�� �����մϴ�.
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getBoardList() ���� : " + ex);
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
		
		// page : ������ 
		// limit : ������ �� ����� �� 
		// board_re_Ref desc, board_re_seq asc�� ���� ������ ����
		// �������� �´� rnum�� ���� ��ŭ �������� �������Դϴ�.
		
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
		// �� �������� 10���� ����� ��� 				1������ ,2������ , 3������, 4������ ,
		int startrow = (page-1) * limit +1;	//�б� ������ row��ȣ (1 11 21 31 .... 
		int endrow = startrow + limit -1 ;	//���� ������ row ��ȣ (10 20 30 40 ... .
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			
			// DB���� ������ �����͸� VO ��ü�� ����ϴ�. 
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
				list.add(board);	//���� ���� ��ü�� ����Ʈ�� �����մϴ�.
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getBoardList() ���� : " + ex);
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
		int startrow = (page -1) *limit +1; //�б� ������ row ��ȣ(1 11 21 31 ...)
		int endrow = startrow + limit -1 ;  //���� ������ row ��ȣ(10 20 30 40 ...)

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
			
			//DB���� ������ �����͸� VO��ü�� ����ϴ�.
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
				list.add(board); //���� ���� ��ü�� ����Ʈ�� �����մϴ�.
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("board_search_list_sql() ���� : " +ex);
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
		int startrow = (page -1) *limit +1; //�б� ������ row ��ȣ(1 11 21 31 ...)
		int endrow = startrow + limit -1 ;  //���� ������ row ��ȣ(10 20 30 40 ...)

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
			
			//DB���� ������ �����͸� VO��ü�� ����ϴ�.
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
				list.add(board); //���� ���� ��ü�� ����Ʈ�� �����մϴ�.
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println("board_search_list_sql() ���� : " +ex);
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
