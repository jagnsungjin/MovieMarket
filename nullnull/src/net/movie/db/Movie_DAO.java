package net.movie.db;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Movie_DAO {
private DataSource ds;
	
	// 생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public Movie_DAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
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
			
			//새로운 글을 등록하는 부분입니다.
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
				System.out.println("결제 등록 완료");
			}
		} catch (Exception ex) {
			System.out.println("paymentInsert() 에러 : " +ex);
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
