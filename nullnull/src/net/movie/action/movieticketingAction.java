package net.movie.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class movieticketingAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
			ActionForward forward =new ActionForward();
			forward.setRedirect(false);
			//글 목록 페이지로 이동하기 위해 경로를 설정합니다.
			forward.setPath("Movie/ticket.jsp");
			return forward; //BoardFontController.java로 리턴됩니다.
	}

}
