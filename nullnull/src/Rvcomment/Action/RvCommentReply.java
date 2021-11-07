package Rvcomment.Action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Rv.Action.Action;
import Rv.Action.ActionForward;
import Rvcomment.db.Comment;
import Rvcomment.db.CommentDAO;



public class RvCommentReply implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		Comment co = new Comment();
		
		co.setRCM_ID(request.getParameter("RCM_ID"));
		co.setRCM_CONTENT(request.getParameter("RCM_CONTENT"));
		co.setRCM_COMMENT_RE_LEV(Integer.parseInt(request.getParameter("RCM_COMMENT_RE_LEV")));
		co.setRCM_COMMENT_BOARD_NUM(Integer.parseInt(request.getParameter("RCM_COMMENT_BOARD_NUM")));
		co.setRCM_COMMENT_RE_SEQ(Integer.parseInt(request.getParameter("RCM_COMMENT_RE_SEQ")));
		co.setRCM_COMMENT_RE_REF(Integer.parseInt(request.getParameter("RCM_COMMENT_RE_REF")));
		int ok = dao.commentsReply(co);
		response.getWriter().print(ok);
		return null;
	}	
}
