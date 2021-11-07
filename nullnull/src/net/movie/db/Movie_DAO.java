package net.movie.db;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Movie_DAO {
private DataSource ds;
	
	// �����ڿ��� JNDI ���ҽ��� �����Ͽ� Connection ��ü�� ���ɴϴ�.
	public Movie_DAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB ���� ���� : " + ex);
			return;
		}
	}
	
	public int paymentInsert(movie m) {
		Connection conn =null;
		PreparedStatement pstmt =null;
		int result =0;
		try {
			conn = ds.getConnection();
			
			
			String sql="insert into PAYMENT "
					+ " values(PAYMENT_SEQ.NEXTVAL,?,?,?,?,?,?,?)";
			
			//���ο� ���� ����ϴ� �κ��Դϴ�.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getUSER_ID());
			pstmt.setString(2, m.getPAY_NAME());
			pstmt.setString(3, m.getCINEMA_PLACE());
			pstmt.setString(4, m.getPAY_DATE());
			pstmt.setString(5, m.getPAY_TIME());
			pstmt.setString(6, m.getPAY_COUNT());
			pstmt.setString(7, m.getPAY_SEAT());
			
			result = pstmt.executeUpdate();
			if(result ==1 ) {
				System.out.println("���� ��� �Ϸ�");
			}
		} catch (Exception ex) {
			System.out.println("paymentInsert() ���� : " +ex);
			ex.printStackTrace();
		} finally {
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
		return result;
	}

}
