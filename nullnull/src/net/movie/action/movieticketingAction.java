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
			//�� ��� �������� �̵��ϱ� ���� ��θ� �����մϴ�.
			forward.setPath("Movie/ticket.jsp");
			return forward; //BoardFontController.java�� ���ϵ˴ϴ�.
	}

}
