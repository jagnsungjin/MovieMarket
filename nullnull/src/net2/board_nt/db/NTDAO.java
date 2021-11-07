package net2.board_nt.db;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;

import javax.sql.DataSource;

public class NTDAO {
	private DataSource ds;
	
	public NTDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		}catch (Exception ex) {
			System.out.println("DB ���� ����: " + ex);
			return;
		}
	}
	//�� ��� �����Ϳ� ����
	public boolean boardInsert(NTBean boarddata) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result=0;
		try {
			con = ds.getConnection();
			
			String max_sql = "(select nvl(max(nt_no),0)+1 from bbs_nt)" ;
			
			//���� ���� BOARD_RE_REF �ʵ�� �ڽ��� �� ��ȣ�Դϴ�.
			String sql = "insert into bbs_nt"
						+ "(nt_no, nt_pass, nt_subject, user_id,"
						+ " nt_date, nt_read, nt_content, "
						+ " nt_file, nt_fix)" 
						+ "values(" + max_sql + ",?,?,?,sysdate,"
						+ "		   ?,?,?,?)";
			//���ο� ���� ����ϴ� �κ��Դϴ�.
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boarddata.getNt_pass());
			pstmt.setString(2, boarddata.getNt_subject());
			pstmt.setString(3, boarddata.getUser_id());
			pstmt.setInt(4, boarddata.getNt_read());
			pstmt.setString(5, boarddata.getNt_content());
			pstmt.setString(6, boarddata.getNt_file());
			pstmt.setInt(7, boarddata.getNt_fix());
			
			result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("������ ������ ��� �Ϸ�Ǿ����ϴ�.");
				return true;
			}
		}catch (Exception ex) {
			System.out.println("boardInsert() ����: " + ex);
			ex.printStackTrace();
		}finally {
			if(pstmt != null)
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(con!=null)
				try {
				con.close();// 4�ܰ�:DB������ ���´�
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
	}
		return false;
}
	//�� ��� ����
	public List<NTBean> getBoardList(int page, int limit) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		//page : ������
		//limit : ������ �� ��� ��
		//board_re_ref desc, board_re_seq asc�� ���� ������ ���� 
		//�������� �´� rnum�� ���� ��ŭ �������� �������Դϴ�.
		
		String board_list_sql = "select * from " 
								+ "		(select rownum rnum, nt_no, nt_subject ,"
								+ "		 user_id, nt_content, nt_date, nt_file,"
								+ "		 nt_read, nt_fix "
								+ "		 from bbs_nt "
								+ " 	 order by nt_fix desc, "
								+ "      nt_date desc "
								+ "		 )"
				                + "where rnum>=? and rnum<=?";

		
		List<NTBean> list = new ArrayList<NTBean>();
		// �� ������ �� 10���� ����� ��� 1������ 2������ 3������ 4������...
		int startrow = (page - 1) * limit + 1;// �б� ������ row ��ȣ(1 11 21 31...)
		int endrow = startrow + limit - 1; // ���� ������ row ��ȣ(10 20 30 40)
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				NTBean board = new NTBean();
				rs.getInt("rnum");
				board.setNt_no(rs.getInt("nt_no"));
				board.setNt_subject(rs.getString("nt_subject"));
				board.setUser_id(rs.getString("user_id"));
				board.setNt_content(rs.getString("nt_content"));
				board.setNt_file(rs.getString("nt_file"));
				board.setNt_read(rs.getInt("nt_read"));
				board.setNt_date(rs.getString("nt_date"));
				board.setNt_fix(rs.getInt("nt_fix"));
				list.add(board);// ���� ���� ��ü�� ����Ʈ�� �����մϴ�.
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getBoardList() ����: " + ex);
		} finally {
				if (rs != null)
					try {
					rs.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			try {
				if (con != null)
					con.close();// 4�ܰ�:DB������ ���´�
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
		return list;
	}
	//�� ���� ���ϱ�
	public int getListCount() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int x = 0;
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement("select count(*) from bbs_nt");
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					x = rs.getInt(1);
				}
			}catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getListCount() ����:" + ex);
			}finally {
				if(rs != null)
					try {
						rs.close();
					}catch (SQLException ex) {
						ex.printStackTrace();
	    			}
	    		if(con != null)
	    			try {
	    				con.close();
	    			}catch (SQLException ex) {
	    				ex.printStackTrace();
					}
			}
			return x;
	}
	//��ȸ�� ������Ʈ - �۹�ȣ�� �ش��ϴ� ��ȸ���� 1 �����մϴ�.
	public void setReadCountUpdate(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "update bbs_nt "
				   + "set nt_read = nt_read + 1 "
				   + "where nt_no = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch (SQLException ex) {
			System.out.println("setReadCountUpdate()����:" + ex);
		}finally {
			if(pstmt != null)
				try {
					pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
			if(con!=null)
				try {
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
		}
	}
	//�� ���� ����
	public NTBean getDetail(int num) {
		NTBean board = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement("select * from bbs_nt where nt_no = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				board = new NTBean();
				board.setNt_no(rs.getInt("nt_no"));
				board.setNt_subject(rs.getString("nt_subject"));
				board.setUser_id(rs.getString("user_id"));
				board.setNt_date(rs.getString("nt_date"));
				board.setNt_read(rs.getInt("nt_read"));
				board.setNt_content(rs.getString("nt_content"));
				board.setNt_file(rs.getString("nt_file"));
			}
		}catch(Exception ex) {
			System.out.println("getDetail()����: " + ex);
		}finally {
			if(rs !=null)
				try {
					rs.close();
				}catch(SQLException e) {
					System.out.println(e.getMessage());
				}
				try {
					if(pstmt!=null)
						pstmt.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
				try {
					if(con!=null)
						con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
		}
		return board;
	}
	//�۾������� Ȯ�� - ��й�ȣ�� Ȯ���մϴ�.
	public boolean isNTWriter(int num, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		String nt_sql = "select nt_pass from bbs_nt where nt_no =?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(nt_sql);
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pass.equals(rs.getString("nt_pass")));
				result = true;
			}
		}catch (SQLException ex) {
			System.out.println("isNTWriter() ���� : " + ex);
		}finally {
			if(rs != null)
			try {
				rs.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		if (pstmt != null)
			try {
				pstmt.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		if (con != null)
			try {
				con.close();// 4�ܰ�:DB������ ���´�
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	  }
		return result;
	}
	public boolean boardModify(NTBean modifynt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "update bbs_nt "
				   + "set nt_subject=?, nt_content=?, nt_file=? "
				   + "where nt_no=? ";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,modifynt.getNt_subject());
			pstmt.setString(2, modifynt.getNt_content());
			pstmt.setString(3, modifynt.getNt_file());
			pstmt.setInt(4, modifynt.getNt_no());
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("���� ������Ʈ");
				return true;
			}
		}catch(Exception ex) {
			System.out.println("boardmodiy() ����:" + ex);
		}finally {
			if(pstmt !=null)
				try {
				pstmt.close();
				}catch (SQLException ex) {
					ex.printStackTrace();
				}	
			if(con!=null)
				try {
					con.close();
				}catch(SQLException ex) {
					ex.printStackTrace();
				}
		}
		return false;
	}//boardModify()�޼��� end
	
	//�� ���� 
	public boolean NTDelete(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String nt_delete_sql = "delete from bbs_nt "
				     		 + "where nt_no = ?";
		
		boolean result_check = false;
		try {
			con=ds.getConnection();
				pstmt = con.prepareStatement(nt_delete_sql);
				pstmt.setInt(1, num);
			
				int count = pstmt.executeUpdate();
				
				if(count>=1)
					result_check = true; //������ �� �� ��쿡�� false
		}catch(Exception ex) {
			System.out.println("NTDelete()���� :" + ex);
			ex.printStackTrace();
		}finally {
				if(pstmt !=null)
					try {
						pstmt.close();
					}catch(SQLException ex) {
						ex.printStackTrace();
					}
				if (con != null)
					try {
						con.close();// 4�ܰ�:DB������ ���´�
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			return result_check;
		}
	
	public List<NTBean> getBoardList(int page, int limit, String view) {
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;				
		String board_list_sql ="";
		
		if (view == null || view.equals("1")) {
			board_list_sql =  "select * from " 
					+ "		(select rownum rnum, nt_no, nt_subject ,"
					+ "		 user_id, nt_date, nt_read,"
					+ "		 nt_content, nt_file, nt_fix "
					+ "		 from (select * from bbs_nt "
					+ " 	 		order by nt_fix desc, "
					+ "				nt_date desc) "
					+ "		 )"
					+ "where rnum>=? and rnum<=?";
		} else if (view.equals("2"))  {//�з� ��ü ��ϼ�
			board_list_sql =  "select * from "
					+ " (select rownum rnum, nt_no, nt_subject, "
					+ "      user_id, nt_date, nt_read, "
					+ "      nt_content, nt_file, nt_fix "
					+ "      from (select * from bbs_nt "
					+ "            order by nt_fix desc, "
					+ "			   nt_date asc)"
					+ " ) "
					+ "where rnum>=? and rnum<=? ";
		} else if (view.equals("3") ) {//�з� ��ü ��ȸ��
			
			board_list_sql = "select * from "
					+ " (select rownum rnum, nt_no, nt_subject, "
					+ "      user_id, nt_date, nt_read, "
					+ "      nt_content, nt_file, nt_fix "
					+ "      from (select * from bbs_nt "
					+ "            order by nt_fix desc, "
					+ "			   nt_read desc, "
					+ "			   nt_date desc)"
					+ "  ) "
					+ "where rnum>=? and rnum<=? ";
		}
		System.out.println("������="+board_list_sql);
		List<NTBean> list = new ArrayList<NTBean>();
		// �� �������� 10���� ����� ���                                                       1������, 2������, 3������ ... 10������
		int startrow = (page -1) * limit + 1; // �б� ������ row ��ȣ (1 11 21 31 ...
		int endrow = startrow + limit - 1;    // ���� ������ row ��ȣ (10 20 30 40 ...		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(board_list_sql);
			pstmt.setInt(1, startrow);
			pstmt.setInt(2, endrow);
			rs = pstmt.executeQuery();
			
			// DB���� ������ �����͸� VO��ü�� ����ϴ�.
			while (rs.next()) {
				NTBean board = new NTBean();
				board.setNt_no(rs.getInt("nt_no"));
				board.setNt_subject(rs.getString("nt_subject"));
				board.setUser_id(rs.getString("user_id"));
				board.setNt_date(rs.getString("nt_date"));
				board.setNt_read(rs.getInt("nt_read"));
				board.setNt_content(rs.getString("nt_content"));
				board.setNt_file(rs.getString("nt_file"));
				board.setNt_fix(rs.getInt("nt_fix"));
				list.add(board);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getNTList() ����: " + ex);
		} finally {
			if (rs !=null)
				try {
					rs.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
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
		return list;
	}
	//�˻�
	public int getSearchListCount(String searchType , String search) {
		Connection con= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String searchs="";
		int x = 0;
		
		try {
			con = ds.getConnection();
			if(searchType.equals("subject")) {
				searchs = "nt_subject like '%"+search+"%' ";			
			}else if(searchType.equals("content")) {
				searchs = "nt_content like '%"+search+"%' ";
			}
			
			String sql = "select count(*) from bbs_nt where "+searchs+"";
			System.out.println(sql);
			pstmt = con.prepareStatement(sql);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			System.out.println("getSearchListCount() ���� :" +ex);
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
			if(con !=null)
				try {
					con.close();
				} catch (Exception ex) {
					ex.printStackTrace();
				}
		}
		return x;
	}//bbs_bkSearchListCount end

	//�Խ��� �˻�
	public List<NTBean> getBoardSearchList(int page, int limit, String searchType, String search, String view) {
			Connection con= null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String board_search_list_sql= "";
			String searchs ="";
			
			List<NTBean> list = new ArrayList<NTBean>();
			int startrow = (page -1) *limit +1; //�б� ������ row ��ȣ(1 11 21 31 ...)
			int endrow = startrow + limit -1 ;  //���� ������ row ��ȣ(10 20 30 40 ...)

			try {
				con = ds.getConnection();
				if(searchType.equals("subject")) {
					searchs = "nt_subject like '%"+ search +"%' ";			
				}else if(searchType.equals("content")) {
					searchs = "nt_content like '%"+search+"%' ";
				}
				
			   if (view == null || view.equals("1")) {
					board_search_list_sql=
							"select * "
									+ "from "
									+ "		(select rownum rnum, nt_no ,"
									+ " 	nt_subject, user_id, "
									+ " 	nt_date, nt_pass, nt_read,"
									+ " 	nt_content, nt_file, nt_fix from "
									+ " 							(select * from bbs_nt "
									+ "								where "+ searchs 
									+ "								order by nt_fix desc, "
									+ "								nt_date desc) "
									+ ") "
									+ " where rnum >= ? and rnum<= ? ";
			   } else if (view.equals("2")) { //�з� ��ü ��ϼ�
					board_search_list_sql=
							"select * "
									+ "from "
									+ "		(select rownum rnum, nt_no ,"
									+ " 	nt_subject, user_id, "
									+ " 	nt_date, nt_pass, nt_read,"
									+ " 	nt_content, nt_file, nt_fix from "
									+ " 							(select * from bbs_nt "
									+ "								where "+ searchs 
									+ "								order by nt_fix desc, "
									+ "								nt_date asc) "
									+ ") "
									+ " where rnum >= ? and rnum<= ? ";   
			   } else if (view.equals("3") ) {
					board_search_list_sql=
							"select * "
									+ "from "
									+ "		(select rownum rnum, nt_no ,"
									+ " 	nt_subject, user_id, "
									+ " 	nt_date, nt_pass, nt_read,"
									+ " 	nt_content, nt_file, nt_fix from "
									+ " 							(select * from bbs_nt "
									+ "								where "+ searchs 
									+ "								order by nt_fix desc, "
									+ "							    nt_read desc, "
									+ "								nt_date desc) "
									+ ") "
									+ " where rnum >= ? and rnum<= ? ";
					
			   }
			   
				System.out.println("�̰� ��� ����" + board_search_list_sql);

				pstmt = con.prepareStatement(board_search_list_sql);
				pstmt.setInt(1, startrow);
				pstmt.setInt(2, endrow);
				rs= pstmt.executeQuery();
				
				//DB���� ������ �����͸� VO��ü�� ����ϴ�.
				while (rs.next()) {
					NTBean board = new NTBean();
					board.setNt_no(rs.getInt(2));
					board.setNt_subject(rs.getString(3));
					board.setUser_id(rs.getString(4));
					board.setNt_date(rs.getString(5));
					board.setNt_pass(rs.getString(6));
					board.setNt_read(rs.getInt(7));
					board.setNt_content(rs.getString(8));
					board.setNt_file(rs.getString(9));
					board.setNt_fix(rs.getInt(10));
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
				if(con!=null)
					try {
						con.close();
					} catch (Exception ex) {
						ex.printStackTrace();
					}
			}
			return list;
		}//getFrBoardSearchList end
	
}

