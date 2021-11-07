package net.movie.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.movie.db.Movie_DAO;
import net.movie.db.movie;

public class paymentlistAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Movie_DAO dao = new Movie_DAO();
		movie moviebean = new movie();
		ActionForward forward =new ActionForward();
		

		int result=0;
		
			moviebean.setUSER_ID(request.getParameter("user_id"));
			moviebean.setPAY_NAME(request.getParameter("name"));
			moviebean.setCINEMA_PLACE(request.getParameter("place"));
			moviebean.setPAY_DATE(request.getParameter("date"));
			moviebean.setPAY_TIME(request.getParameter("time"));
			moviebean.setPAY_COUNT(request.getParameter("count"));
			moviebean.setPAY_SEAT(request.getParameter("seat"));
			
			//글 등록 폼에서 입력한 정보가 저장되어 있는 boarddata객체를 전달합니다.
			result= dao.paymentInsert(moviebean);
			//글 등록에 실패할 경우 false를 반환합니다.
			if(result != 1) {
				System.out.println("결제 등록 실패");
				forward.setPath("error/error.jsp");
				request.setAttribute("message", "결제 등록 실패입니다.");
				forward.setRedirect(false);
				return forward;
			}
			System.out.println("결제 등록 완료");
			
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('결제 성공');");
			out.println("location.href='http://localhost:8088/nullnull/'");
			out.println("</script>");
			out.close();
			return null;
	}

}
