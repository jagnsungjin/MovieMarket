package Rvcomment.Action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Rv.Action.Action;
import Rv.Action.ActionForward;
import Rvcomment.db.Comment;
import Rvcomment.db.CommentDAO;



public class RvCommentUpdate implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		Comment co = new Comment();
		co.setRCM_CONTENT(request.getParameter("RCM_CONTENT"));
		System.out.println("content=" + co.getRCM_CONTENT());
		
		co.setRCM_NO(Integer.parseInt(request.getParameter("RCM_NO")));
		
		int ok = dao.commentsUpdate(co);
		response.getWriter().print(ok);
		return null;
	}
}
